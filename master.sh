function get_wifi() {
  t=$(date +%s)
  wifi=$(termux-wifi-scaninfo | grep -e "rssi" -e "bssid" | awk '{print $2}' | sed -z "s/\n-/-/g")
  echo "$wifi" | sed -z "s/\n/$t\n/g"
}

function get_geo() {
  t=$(date +%s)
  geo=$(termux-location | grep "tude" | awk '{print $2}' | tr -d "\n")
  echo "$geo$t"
}

t=$(date +%s)
wf="wifi-$t.txt"
gf="geo-$t.txt"
touch $wf $gf

while : do
  get_wifi >> $wf &  
  get_geo >> $gf &
  sleep 2
done

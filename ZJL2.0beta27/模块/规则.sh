echo
if [[ `pgrep tiny` ]]; then
	echo " tiny 已开启 √\n"
elif [[ `pgrep clnc` ]]; then
	echo " clnc 已开启 √\n"
elif [[ `pgrep CProxy` ]]; then
	echo " CProxy 已开启 √\n"
elif [[ `pgrep localproxy` ]]; then
	echo " localproxy 已开启 √\n"
else echo " 什么都没开启 ×\n";fi

[[ `pgrep pdnsd` ]] && echo " pdnsd 已开启 √\n"

[[ `pgrep redsocks2` ]] && echo " redsocks2 已开启 √\n"


echo "━━━━━━━ nat ━━━━━━━"

for ZJL in OUTPUT PREROUTING
do
	echo
	iptables -t nat -S ${ZJL}
	echo "\n━━━━━━━━━━━━━━━"
done

echo "\n\n━━━━━━ mangle ━━━━━━"

for ZJL in OUTPUT FORWARD PREROUTING
do
	echo
	iptables -t mangle -S ${ZJL}
	echo "\n━━━━━━━━━━━━━━━"
done

echo "\n\n━━━━━━ filter ━━━━━━"

for ZJL in OUTPUT FORWARD
do
	echo
	iptables -t filter -S ${ZJL}
	echo "\n━━━━━━━━━━━━━━━"
done


echo "\n\n━━━━━ ipv4 路由表 ━━━━━\n"
	ip rule show
echo "\n━━━━━━━━━━━━━━━"

echo "\n\n━━━━━ ipv6 路由表 ━━━━━\n"
	ip -6 rule show
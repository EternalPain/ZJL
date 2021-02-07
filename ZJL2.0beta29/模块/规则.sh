echo
for ZJL in tiny clnc CProxy localproxy; do
    [[ `pgrep ${ZJL}` ]] && core="${ZJL}" && break
done

[[ ${core} ]] && echo " ${core} 已开启 √\n" || echo " 什么都没开启 ×\n"

[[ ! ${ZJL} ]] && echo 1 && echo 2

[[ `pgrep pdnsd` ]] && echo " pdnsd 已开启 √\n"

[[ `pgrep redsocks2` ]] && echo " redsocks2 已开启 √\n"

echo "━━━━━ iptables ━━━━━━\n"
echo "━━━━━━━ nat ━━━━━━━"
for ZJL in OUTPUT PREROUTING
do
	echo
	iptables -t nat -S ${ZJL}
	echo "\n━━━━━━━━━━━━━━━━━"
done

echo "\n\n━━━━━━ mangle ━━━━━━"
for ZJL in OUTPUT FORWARD PREROUTING
do
	echo
	iptables -t mangle -S ${ZJL}
	echo "\n━━━━━━━━━━━━━━━━━"
done

echo "\n\n━━━━━━ filter ━━━━━━"
for ZJL in OUTPUT FORWARD
do
	echo
	iptables -t filter -S ${ZJL}
	echo "\n━━━━━━━━━━━━━━━━━"
done

echo "\n\n━━━━━ ip6tables ━━━━━\n"
echo "━━━━━━ mangle ━━━━━━\n"
ip6tables -t mangle -S FORWARD
echo "\n━━━━━━━━━━━━━━━━━"

echo "\n\n━━━━━ ipv6 路由表 ━━━━━\n"
	ip -6 rule show
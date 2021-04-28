echo
for ZJL in tiny clnc CProxy localproxy; do
    if [[ `pgrep ${ZJL}` ]]; then
        core="${ZJL}"
        echo " ${core} 已开启 √\n"
    fi
done

[[ ${core} ]] || echo " 什么都没开启 ×\n"

[[ `pgrep pdnsd` ]] && echo " pdnsd 已开启 √\n"

[[ `pgrep redsocks2` ]] && echo " redsocks2 已开启 √\n"

echo "━━━━━━━ iptables nat ━━━━━━━━"
for ZJL in OUTPUT PREROUTING
do
	echo
	iptables -t nat -S ${ZJL}
	echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
done
echo

echo "\n\n━━━━━━ iptables mangle ━━━━━━"
for ZJL in OUTPUT FORWARD PREROUTING
do
	echo
	iptables -t mangle -S ${ZJL}
	echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
done
echo

iptables_filter_output=`iptables -t filter -S OUTPUT | grep 'o wlan+'`
iptables_filter_forword=`iptables -t filter -S FORWARD | grep 'DROP'`
if [[ ${iptables_filter_output} || ${iptables_filter_output} ]]; then
    echo "\n\n━━━━━━ iptables filter ━━━━━━\n"
    
    if [[ ${iptables_filter_output} ]]; then
        echo ${iptables_filter_output}
        echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    fi
    
    if [[ ${iptables_filter_forword} ]]; then
        echo ${iptables_filter_forword}
        echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    fi
fi

ip6tables_mangle=`ip6tables -t mangle -S FORWARD | grep 'DROP'`
if [[ ${ip6tables_mangle} ]]; then
    echo "\n\n━━━━━ ip6tables mangle ━━━━━━\n"
    echo ${ip6tables_mangle}
    echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
fi

ipv6_rule=`ip -6 rule show | grep 'from all unreachable' | grep -v '32000'`
if [[ ${ipv6_rule} ]]; then
    echo "\n\n━━━━━━━━ ipv6 路由表 ━━━━━━━━\n"
    echo ${ipv6_rule}
    echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
fi
echo "\n____________________________________________________\n"
echo "                      ZJL 2.0"
echo "____________________________________________________"

# 检测当前使用的免流核心状态
read_core_state() {
    core_name="`grep -a '.*' /proc/${core_pid}/comm`"
    local core_info="`grep -a '.*' /proc/${core_pid}/cmdline`"
    if [[ "1" == `echo "${core_info}" | grep -c '.*'` ]]; then
        core_mode_path="`echo "${core_info}" | grep -o '\-c.*conf' | sed -r 's/\-c(.*conf)/\1/'`"
    else
        core_mode_path="`echo "${core_info}" | grep -A 1 '\-c' | grep -v '^-c$'`"
    fi
    
    core_mode_name="${core_mode_path##*/}"
}

# 判断是否有缺失 pgrep 命令
if [[ `type pgrep` == *found* ]]; then
    # 判断是否存在busybox
    if [[ `type busybox` != *found* ]] || [ -s ${0%/*}/busybox ]; then
        # 判断系统是否存在 busybox，没有将使用模块文件夹里的
        [[ `type busybox` != *found* ]] || alias busybox="${0%/*}/busybox"
        # 设置命令别名
        alias pgrep="busybox pgrep"
    else
        local pgrep_state="no_pgrep"
    fi
fi

# 判断 pgrep 命令是否可用
if [[ ! ${pgrep_state} ]]; then
    for ZJL in tiny clnc CProxy localproxy; do
        core_pid="`pgrep ^${ZJL}`"
        if [[ ${core_pid} ]]; then
            core="${ZJL}"
            read_core_state 
            echo "\n ${core} 已开启 √    ${core_mode_name}"
            core_pid=""
            core_mode_name=""
        fi
    done
    [[ ${core} ]] || echo "\n 什么都没开启 ×"
    
    [[ `pgrep pdnsd` ]] && echo "\n pdnsd 已开启 √"
    [[ `pgrep redsocks2` ]] && echo "\n redsocks2 已开启 √"
else
    echo "\n 系统没有 pgrep 命令\n"
    echo " 或者找不到 busybox\n"
    echo " 所以无法检测核心或模块是否开启\n"
fi


echo "___________________ iptables nat ___________________"
for ZJL in OUTPUT PREROUTING
do
	echo
	iptables -t nat -S ${ZJL}
	echo "____________________________________________________"
done
echo

echo "\n__________________ iptables mangle _________________"
for ZJL in OUTPUT FORWARD PREROUTING
do
	echo
	iptables -t mangle -S ${ZJL}
	echo "____________________________________________________"
done
echo

iptables_filter_output=`iptables -t filter -S OUTPUT | grep 'o wlan+'`
iptables_filter_forword=`iptables -t filter -S FORWARD | grep 'DROP'`
if [[ ${iptables_filter_output} || ${iptables_filter_output} ]]; then
    echo "\n__________________ iptables filter _________________\n"
    
    if [[ ${iptables_filter_output} ]]; then
        echo "${iptables_filter_output}"
        echo "____________________________________________________\n"
    fi
    
    if [[ ${iptables_filter_forword} ]]; then
        echo "${iptables_filter_forword}"
        echo "____________________________________________________\n"
    fi
fi

ip6tables_mangle_output=`ip6tables -t mangle -S OUTPUT | grep '99999'`
ip6tables_mangle_forword=`ip6tables -t mangle -S FORWARD | grep 'DROP'`
if [[ ${ip6tables_mangle_output} || ${ip6tables_mangle_forword} ]]; then
    echo "\n_________________ ip6tables mangle _________________\n"
    
    if [[ ${ip6tables_mangle_output} ]]; then
        echo "${ip6tables_mangle_output}"
        echo "____________________________________________________\n"
    fi
    
    if [[ ${ip6tables_mangle_forword} ]]; then
        echo "${ip6tables_mangle_forword}"
        echo "____________________________________________________\n"
    fi
fi

ipv4_rule=`ip rule show | grep -E '(lookup 100)|(unreachable)'  | grep -v '32000'`
if [[ ${ipv4_rule} ]]; then
    echo "\n____________________ ipv4 路由表 ___________________\n"
    echo "${ipv4_rule}"
    echo "____________________________________________________\n"
fi

ipv6_rule=`ip -6 rule show | grep -E 'unreachable' | grep -v '32000'`
if [[ ${ipv6_rule} ]]; then
    echo "\n____________________ ipv6 路由表 ___________________\n"
    echo "${ipv6_rule}"
    echo "____________________________________________________\n"
fi
echo ""
if [[ `pgrep tiny` != "" ]]
then echo " tiny 已开启 ✅\n"
elif [[ `pgrep CProxy` != "" ]]
then echo " CProxy 已开启 ✅\n"
elif [[ `pgrep localproxy` != "" ]]
then echo " localproxy 已开启 ✅\n"
else echo " 什么都没开启 ❌\n";fi

if [[ `pgrep pdnsd` != "" ]]
then echo " pdnsd 已开启 ✅\n";fi

if [[ `pgrep redsocks2` != "" ]]
then echo " redsocks2 已开启 ✅\n";fi


echo "━━━━ nat ━━━━"
echo
for ZJL in OUTPUT PREROUTING
do
echo
iptables -t nat -S ${ZJL}
echo "\n━━━━━━━━━━━━"
done

echo "\n\n━━━━ mangle ━━━━"
echo
for ZJL in OUTPUT FORWARD PREROUTING
do
echo
iptables -t mangle -S ${ZJL}
echo "\n━━━━━━━━━━━━"
done

echo "\n\n━━━━ ipv6 mangle ━━━━"
echo
for ZJL in OUTPUT FORWARD PREROUTING
do
echo
ip6tables -t mangle -S ${ZJL}
echo "\n━━━━━━━━━━━━"
done

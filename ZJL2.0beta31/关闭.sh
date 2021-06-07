zjlPath="${0%/*}/*/ZJL"

if [[ `echo "${zjlPath}" | grep ' '` ]]; then
    isNormal="containsSpaces"
elif [ -f ${zjlPath} ]; then
    [ -x ${zjlPath} ] || isNormal="permissionDenied"
else
    isNormal="notFound"
fi

if [[ ! ${isNormal} ]]; then
    ${zjlPath} -c -d
else
    echo "\n      __________________________\n\n"\
          "              ZJL 2.0\n"\
          "     __________________________\n"
          
    if [[ "containsSpaces" == ${isNormal} ]]; then
        echo "           脚本路径存在空格\n\n"\
              "          请重命名后再使用"
    elif [[ "notFound" == ${isNormal} ]]; then
        echo "           找不到ZJL核心文件\n\n"\
              "          请复制回模块文件夹\n\n"\
              "          请修改权限为0777"
    else
        echo "           ZJL核心权限有问题\n\n"\
              "          请修改权限为0777"
    fi
    echo "     __________________________\n"
fi
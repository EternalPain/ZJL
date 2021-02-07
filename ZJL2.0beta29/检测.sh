zjlPath="${0%/*}/*/ZJL"

if [ -f ${zjlPath} ]; then
    if [ ! -x ${zjlPath} ]; then
        isNormal="permissionDenied"
    fi
else
    isNormal="notFound"
fi

if [ ! ${isNormal} ]; then
    ${zjlPath} -d
else
    echo "\n      __________________________\n\n"\
          "              ZJL 2.0\n"\
          "     __________________________\n"
          
    if [ "notFound" == ${isNormal} ]; then
        echo "           找不到ZJL核心文件\n\n"\
              "          请复制回模块文件夹\n\n"\
              "          请修改权限为0777"
    else
        echo "           ZJL核心权限有问题\n\n"\
              "          请修改权限为0777"
    fi
    echo "     __________________________\n"
fi
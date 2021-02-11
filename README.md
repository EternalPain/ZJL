# ZJL 免流防跳脚本
**整合 tiny 和 clnc 的免流防跳**

****
### ZJL核心使用选项（不带参数）:

```txt
-o 或 --open                   开启免流
-c 或 --close                  关闭免流
-d 或 --display                显示界面
-i 或 --info                   显示信息
-h 或 --help                   查看帮助
-v 或 --version                查看版本

最多只支持三个有效选项:
	-o 和 -c 二选一 不可同时选择
	-h 和 -v 只可单独使用 例: ZJL -h
```

### 注意事项:
```txt
1. 不支持纯CNS 但支持纯CNS的那种clnc模式 比如联通手厅直播那种
2. 不支持tiny模式里有一个接口 然后自动获取验证的那种模式
3. 不支持ipv6免流

4. tiny模式的uid写0 3003 3004之一
5. 如果安卓11用tiny的话，uid不要写3004，可能会没网，推荐写0，啥系统版本都有网，换了还是没网就换clnc模式

6. 如果删除了MLbox 将不支持检测HTTP和HTTPS联网 以及检测UDP联网
7. 如果删除了busybox并且手机没有安装busybox的话 将不支持显示运行中的模式名 以及显示已用流量
8. 如果手机不支持iptables的multiport模块 本机和共享的放行端口将会放行不了端口范围

9. 本机成功代理了UDP的话 共享UDP放行将无效

10. 如果装了面具的话 可以直接防跳配置 [开机自启] 填面具 跟刷模块自启效果一样的
```

### 2.0 Beta29 更新日志:
```txt
1. 修复部分系统输出显示APN错误
2. 修复检测网络挂掉的接口

3. 升级免流方式功能，可以根据模式自动识别（原理是读取模式中是否有uid或user这两行，不要手贱删除tiny里的，或者在clnc模式里加）
4. 升级面具版模块的开机自启，避免开启失败

5. 添加开启失败输出log日志，路径是模块文件夹下的start_error_log.txt
6. 添加禁网内核
7. 添加关闭selinux

8. 删除[内网白名单]和[显示内网白名单]功能

9. 更换clnc核心为0.92版本
```

****

[使用教程](https://eternalpain.github.io/ "使用教程")   
[百度云](https://pan.baidu.com/s/1k-GrWbXCVlpLhC7y8IIUog "ZJL")   
[加入QQ群](https://qm.qq.com/cgi-bin/qm/qr?k=E3gr0d4kQnGioQ0CJBx5zS_KcB120aS_&jump_from=webapi "加入龍哥交流群")

echo '=========================='
echo '本脚本为CLNC一键脚本\n已添加CNS转发可打游戏'
echo '=========================='
echo '官方QQ群:643037308'
install_dir='/data/clnc'
rm -rf "$install_dir"
mkdir "$install_dir"
cd "$install_dir"
echo '开始下载CLNC核心文件包'
echo '=========================='
curl -o clnc.zip http://110.40.143.250/clnc.zip || exec echo '下载clnc脚本失败'
curl -O http://110.40.143.250/busybox || exec echo '下载busybox程序失败'
chmod 0777 busybox
./busybox unzip clnc.zip
chmod -R 0777 "$install_dir"
./1.sh

echo "是否设置开机自启[y/n]"
read isAutoStart
[ "$isAutoStart" = 'y' -o "$isAutoStart" = 'Y' ] && {
	curl -O http://110.40.143.250/autoStart.sh || exec echo '下载自启脚本失败'
	sh autoStart.sh | grep -q '添加' || sh autoStart.sh
	echo "$install_dir/1.sh \n\nbusybox telnetd -l /system/bin/sh\n\nnohup tcpsvd -vE 0.0.0.0 21 ftpd -wA / > /dev/null 2>&1 & \n\nstop adbd \nsetprop service.adb.tcp.port 5555 \nstart adbd" >/data/ZQ/ZQJB.sh
echo '=========================='
echo '刷入ADB+Telnet+busybox+FTP完毕'
echo '=========================='
}

rm -rf "$install_dir"/clnc.zip
rm -rf "$install_dir"/busybox
rm -rf "$install_dir"/autoStart.sh

echo '=========================='
echo '开始一键刷入busybox 程序'
echo '=========================='
mount -o remount -w /system/xbin/
cd "/system/xbin/"
curl -O busybox http://110.40.143.250/busybox || exec echo '下载busybox程序失败'
chmod 777 busybox
 ./busybox --install .
echo '=========================='
echo '一键刷入busybox 程序完毕'
echo '=========================='
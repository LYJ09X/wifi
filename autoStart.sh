#!/system/bin/sh
#开机自动执行的文件
file=/etc/init.qcom.post_boot.sh

Add()
{
    mv $file ${file}.ori
    mkdir /data/ZQ
    echo '#!/system/bin/sh
    script()
    {
        sleep 8
        cd /data/ZQ
        rm -f Start.log
        chmod 777 *
        for i in *
        do
            ./$i &>>Start.log
        done
    }
    script &
    '${file}.ori'
    ' >$file
    chmod 777 $file ${file}.ori
    echo "开机自启已添加!"
}

Del()
{
    mv ${file}.ori $file
    echo "开机自启已移除!"
}

Main()
{
    mount -o remount,rw /system
    file=${file// /\\ }
    [ -e ${file}.ori ]&&Del||Add
}
Main 2>/dev/null

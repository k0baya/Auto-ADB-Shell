MODDIR=${0%/*}
PATH=$PATH:${MODDIR}/usr/bin

export PATH

# 判断是否已经解锁
while [ "$(/system/bin/app_process -Djava.class.path=$MODDIR/isKeyguardLocked.dex /system/bin com.rosan.shell.ActiviteJava)" == "true" ];
do
    sleep 2
done

# 启动 adbd 并进行连接
sleep 1
su -c 'setprop service.adb.tcp.port 5555 && stop adbd && start adbd'
sleep 2
echo "-尝试进行ADB连接..."
adb connect 127.0.0.1:5555
echo "--------------------------------"
sleep 2

# 启动 Brevent
if [ -f /data/data/me.piebridge.brevent/brevent.sh ]; then
    echo "-正在启动黑阈..."
    su -c 'output=$(pm path me.piebridge.brevent); export CLASSPATH=${output#*:}; app_process /system/bin me.piebridge.brevent.server.BreventServer bootstrap; /system/bin/sh /data/local/tmp/brevent.sh' && echo "成功启动黑阈"
    else
        echo "未安装黑阈，跳过启动"
fi
echo "--------------------------------"

# 启动 Scene
if [ -f /storage/emulated/0/Android/data/com.omarea.vtools/up.sh ]; then
    echo "-正在启动 Scene..."
    rm -rf /data/local/tmp/toolkit
    adb -s 127.0.0.1:5555 shell sh /storage/emulated/0/Android/data/com.omarea.vtools/up.sh && echo '成功启动 Scene'
    else
        echo "未安装 Scene，跳过启动"
fi
echo "--------------------------------"

# 启动 Shizuku
if [ -f /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh ]; then
    adb -s 127.0.0.1:5555 shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh && echo '成功启动 Shizuku'
    else
        echo "未安装 Shizuku，跳过启动"
fi
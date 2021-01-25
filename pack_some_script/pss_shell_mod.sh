#!/bin/sh
set -e

#sunert 仓库的百度极速版
function initBaidu() {
    mkdir /baidu_speed
    cd /baidu_speed
    git init
    git remote add -f origin https://github.com/Sunert/Scripts.git
    git config core.sparsecheckout true
    echo Task/package.json >>/baidu_speed/.git/info/sparse-checkout
    echo Task/baidu_speed.js >>/baidu_speed/.git/info/sparse-checkout
    echo Task/sendNotify.js >>/baidu_speed/.git/info/sparse-checkout
    git pull origin master
    cd Task
    npm install
}

##判断百度极速版COOKIE配置之后才会更新相关任务脚本
if [ 0"$BAIDU_COOKIE" = "0" ]; then
    echo "没有配置百度Cookie，相关环境变量参数，跳过下载配置定时任务"
else
    if [ ! -d "/baidu_speed/" ]; then
        echo "未检查到baidu_speed脚本相关文件，初始化下载相关脚本"
        initBaidu
    else
        echo "更新baidu_speed脚本相关文件"
        git -C /baidu_speed reset --hard
        git -C /baidu_speed pull origin master
    fi
    cp -r /baidu_speed/Task/baidu_speed.js /baidu_speed/Task/baidu_speed_use.js
    sed -i "s/StartBody/BDCookie/g" /baidu_speed/Task/baidu_speed_use.js
    sed -i "s/.*process.env.BAIDU_COOKIE.indexOf('\\\n')/else&/g" /baidu_speed/Task/baidu_speed_use.js

    if [ 0"$BAIDU_CRON" = "0" ]; then
        BAIDU_CRON="10 7-22 * * *"
    fi
    echo -e >>$defaultListFile
    echo "$BAIDU_CRON sleep \$((RANDOM % 120)); node /baidu_speed/Task/baidu_speed_use.js >> /logs/baidu_speed.log 2>&1" >>$defaultListFile
fi
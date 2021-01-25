#!/bin/sh
set -e

##百度极速版
function initBaidu() {
    mkdir /baidu_speed
    cd /baidu_speed
    git init
    git remote add -f origin https://github.com/Sunert/Scripts
    git config core.sparsecheckout true
    echo package.json >>/baidu_speed/.git/info/sparse-checkout
    echo Task/baidu_speed.js >>/baidu_speed/.git/info/sparse-checkout
    echo Task/sendNotify.js >>/baidu_speed/.git/info/sparse-checkout
    git pull origin master --rebase
    npm install
}


##判断百度极速版相关变量存在，才会更新相关任务脚本
if [ 0"$BAIDU_COOKIE" = "0" ]; then
    echo "没有配置百度极速版，相关环境变量参数，跳过下载配置定时任务"
else
    if [ ! -d "/baidu_speed/" ]; then
        echo "未检查到baidu_speed脚本相关文件，初始化下载相关脚本"
        initBaidu
    else
        echo "更新baidu_speed脚本相关文件"
        git -C /baidu_speed reset --hard
        git -C /baidu_speed pull origin master --rebase
        npm install --prefix /baidu_speed
    fi
    sed -i "s/StartBody/BDCookie/g" /baidu_speed/Task/baidu_speed.js
    sed -i "s/.*process.env.BAIDU_COOKIE.indexOf('\\\n')/else&/g" /baidu_speed/Task/baidu_speed.js
    wget -O /baidu_speed/Task/baidu_speedtx.js https://raw.githubusercontent.com/jake3737/script/master/Task/baidu_tx.js
    if [ 0"$BAIDU_CRON" = "0" ]; then
        BAIDU_CRON="*/20 7-22/1 * * *"
    fi
    if [ 0"$BAIDUTX_CRON" = "0" ]; then
        BAIDUTX_CRON="0 6 * * *"
    fi
    echo "#百度极速版" >>/pss/$DEFAULT_LIST_FILE
    echo "$BAIDU_CRON node /baidu_speed/Task/baidu_speed.js >> /logs/baidu_speed.log 2>&1" >>/pss/$DEFAULT_LIST_FILE
    echo "#百度极速版提现" >>/pss/$DEFAULT_LIST_FILE
    echo "$BAIDUTX_CRON node /baidu_speed/Task/baidu_speedtx.js >> /logs/baidu_speedtx.log 2>&1" >>/pss/$DEFAULT_LIST_FILE
fi

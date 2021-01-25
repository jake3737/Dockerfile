#!/bin/sh
set -e


##定义合并定时任务相关文件路径变量
defaultListFile="/pss/$DEFAULT_LIST_FILE"
customListFile="/pss/$CUSTOM_LIST_FILE"
mergedListFile="/pss/merged_list_file.sh"


##小米运动刷步数
function initxmSports() {
    mkdir /xmSports
    cd /xmSports
    git init
    git remote add -f origin https://gitee.com/lxk0301/jd_scripts
    git config core.sparsecheckout true
    echo package.json >>/xmSports/.git/info/sparse-checkout
    echo backUp/xmSports.js >>/xmSports/.git/info/sparse-checkout
    git pull origin master
    npm install
}

##喜马拉雅极速版
function initxmly() {
    mkdir /xmly_speed
    cd /xmly_speed
    git init
    git remote add -f origin https://github.com/Zero-S1/xmly_speed
    git config core.sparsecheckout true
    echo rsa >>/xmly_speed/.git/info/sparse-checkout
    echo xmly_speed.py >>/xmly_speed/.git/info/sparse-checkout
    echo requirements.txt >>/xmly_speed/.git/info/sparse-checkout
    git pull origin master
    pip3 install --upgrade pip
    pip3 install -r requirements.txt
}

##企鹅读书小程序
function initRead() {
    mkdir /qqread
    cd /qqread
    git init
    git remote add -f origin https://github.com/Aaron-lv/JavaScript
    git config core.sparsecheckout true
    echo package.json >>/qqread/.git/info/sparse-checkout
    echo Task/qqreadnode.js >>/qqread/.git/info/sparse-checkout
    echo Task/qqreadCOOKIE.js >>/qqread/.git/info/sparse-checkout
    echo Task/sendNotify.js >>/qqread/.git/info/sparse-checkout
    git pull origin master
    npm install
}

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

#sunert 仓库的快手极速版
function initkuaishou() {
    mkdir /kuaishou
    cd /kuaishou
    git init
    git remote add -f origin https://github.com/Sunert/Scripts.git
    git config core.sparsecheckout true
    echo Task/package.json >>/kuaishou/.git/info/sparse-checkout
    echo Task/kuaishou.js >>/kuaishou/.git/info/sparse-checkout
    echo Task/sendNotify.js >>/kuaishou/.git/info/sparse-checkout
    git pull origin master
    cd Task
    npm install
}

##汽车之家极速版
function initQCZJSPEED() {
    mkdir /QCZJSPEED
    cd /QCZJSPEED
    git init
    git remote add -f origin https://github.com/ziye12/QCZJSPEED
    git config core.sparsecheckout true
    echo package.json >>/QCZJSPEED/.git/info/sparse-checkout
    echo Task/qczjspeed.js >>/QCZJSPEED/.git/info/sparse-checkout
    echo Task/qczjspeedCOOKIE.js >>/QCZJSPEED/.git/info/sparse-checkout
    echo Task/sendNotify.js >>/QCZJSPEED/.git/info/sparse-checkout
    git pull origin main
    npm install
}

##火山小视频极速版
function inithotsoon() {
    mkdir /hotsoon
    cd /hotsoon
    git init
    git remote add -f origin https://github.com/ZhiYi-N/script
    git config core.sparsecheckout true
    echo package1.json >>/hotsoon/.git/info/sparse-checkout
    echo hotsoon.js >>/hotsoon/.git/info/sparse-checkout
    echo sendNotify.js >>/hotsoon/.git/info/sparse-checkout
    git pull origin master
    mv /hotsoon/package1.json /hotsoon/package.json
    npm install
}

#笑谱视频
function initxp() {
    mkdir /xp
    cd /xp
    git init
    git remote add -f origin https://github.com/jake3737/script
    git config core.sparsecheckout true
    echo package.json >>/xp/.git/info/sparse-checkout
    echo xp.js >>/xp/.git/info/sparse-checkout
    echo sendNotify.js >>/xp/.git/info/sparse-checkout
    git pull origin master
    npm install
}

##步步宝
function initBBB() {
    mkdir /BBB
    cd /BBB
    git init
    git remote add -f origin https://github.com/jake3737/script
    git config core.sparsecheckout true
    echo package.json >>/BBB/.git/info/sparse-checkout
    echo BBB.js >>/BBB/.git/info/sparse-checkout
    echo sendNotify.js >>/BBB/.git/info/sparse-checkout
    git pull origin master
    npm install
}

##判断小米运动相关变量存在，才会更新相关任务脚本
if [ 0"$XM_TOKEN" = "0" ]; then
    echo "没有配置小米运动，相关环境变量参数，跳过配置定时任务"
else
    if [ ! -d "/xmSports/" ]; then
        echo "未检查到xmSports脚本相关文件，初始化下载相关脚本"
        initxmSports
    else
        echo "更新xmSports脚本相关文件"
        git -C /xmSports reset --hard
        git -C /xmSports pull origin master
        npm install --prefix /xmSports
    fi
    sed -i "s/let login_token = '';/let login_token = process.env.XM_TOKEN.split();/g" /xmSports/backUp/xmSports.js
    sed -i "s/19000/20000/g" /xmSports/backUp/xmSports.js
    if [ 0"$XM_CRON" = "0" ]; then
        XM_CRON="10 22 * * *"
    fi
    echo -e >>$defaultListFile
    echo "#小米运动刷步数" >>$defaultListFile
    echo -n "$XM_CRON node /xmSports/backUp/xmSports.js >> /logs/xmSports.log 2>&1" >>$defaultListFile
fi

##判断喜马拉雅极速版相关变量存在，才会更新相关任务脚本
if [ 0"$XMLY_SPEED_COOKIE" = "0" ]; then
    echo "没有配置喜马拉雅极速版，相关环境变量参数，跳过下载配置定时任务"
else
    if [ ! -d "/xmly_speed/" ]; then
        echo "未检查到xmly_speed脚本相关文件，初始化下载相关脚本"
        initxmly
    else
        echo "更新xmly_speed脚本相关文件"
        git -C /xmly_speed reset --hard
        git -C /xmly_speed pull origin master
        cd /xmly_speed
        pip3 install -r requirements.txt
    fi
    echo "Replace some xmly scripts content to be compatible with env configuration ..."
    echo "替换喜马拉雅脚本相关内容以兼容环境变量配置..."
    sed -i 's/BARK/BARK_PUSH/g' /xmly_speed/xmly_speed.py
    sed -i 's/SCKEY/PUSH_KEY/g' /xmly_speed/xmly_speed.py
    sed -i 's/if\ XMLY_ACCUMULATE_TIME.*$/if\ os.environ["XMLY_ACCUMULATE_TIME"]=="1":/g' /xmly_speed/xmly_speed.py
    sed -i "s/\(xmly_speed_cookie\.split('\)\\\n/\1\|/g" /xmly_speed/xmly_speed.py
    sed -i 's/cookiesList.append(line)/cookiesList.append(line.replace(" ",""))/g' /xmly_speed/xmly_speed.py
    sed -i 's/_notify_time.split.*$/_notify_time.split()[0]==os.environ["XMLY_NOTIFY_TIME"]\ and\ int(_notify_time.split()[1])<30:/g' /xmly_speed/xmly_speed.py
    if [ 0"$XMLY_CRON" = "0" ]; then
        XMLY_CRON="*/30 */1 * * *"
    fi
    echo -e >>$defaultListFile
    echo "#喜马拉雅极速版">>$defaultListFile
    echo -n "$XMLY_CRON python3 /xmly_speed/xmly_speed.py >> /logs/xmly_speed.log 2>&1" >>$defaultListFile
fi

##判断企鹅读书小程序相关变量存在，才会更新相关任务脚本
if [ 0"$QQREAD_BODY" = "0" ]; then
    echo "没有配置企鹅读书小程序，相关环境变量参数，跳过下载配置定时任务"
else
    if [ ! -d "/qqread/" ]; then
        echo "未检查到qqreadnode脚本相关文件，初始化下载相关脚本"
        initRead
    else
        echo "更新qqreadnode脚本相关文件"
        git -C /qqread reset --hard
        git -C /qqread pull origin master
        npm install --prefix /qqread
    fi
    echo "Replace some qqread scripts content to be compatible with env configuration ..."
    echo "替换企鹅读书小程序脚本相关内容以兼容环境变量配置..."
    sed -i "s/notifyttt = 1/notifyttt = process.env.QQREAD_NOTIFYTTT || 1/g" /qqread/Task/qqreadnode.js
    sed -i "s/notifyInterval = 2/notifyInterval = process.env.QQREAD_NOTIFY_INTERVAL || 2/g" /qqread/Task/qqreadnode.js

    if [ 0"$QQREAD_CRON" = "0" ]; then
        QQREAD_CRON="*/20 */1 * * *"
    fi
    echo -e >>$defaultListFile
    echo "#企鹅读书小程序" >>$defaultListFile
    echo -n "$QQREAD_CRON sleep \$((RANDOM % 180)) && node /qqread/Task/qqreadnode.js >> /logs/qqreadnode.log 2>&1" >>$defaultListFile
fi

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

if [ 0"$BAIDU_COOKIE2" = "0" ]; then
    echo "没有配置百度Cookie2，相关环境变量参数，跳过下载配置定时任务"
else
    if [ ! -d "/baidu_speed/" ]; then
        echo "未检查到baidu_speed脚本相关文件，初始化下载相关脚本"
        initBaidu
    else
        echo "更新baidu_speed脚本相关文件"
        git -C /baidu_speed reset --hard
        git -C /baidu_speed pull origin master
    fi
    cp -r /baidu_speed/Task/baidu_speed.js /baidu_speed/Task/baidu_speed_use2.js
    sed -i "s/StartBody/BDCookie/g" /baidu_speed/Task/baidu_speed_use2.js
    sed -i "s/.*process.env.BAIDU_COOKIE.indexOf('\\\n')/else&/g" /baidu_speed/Task/baidu_speed_use2.js

    if [ 0"$BAIDU_CRON" = "0" ]; then
        BAIDU_CRON="10 7-22 * * *"
    fi
    echo -e >>$defaultListFile
    echo "$BAIDU_CRON sleep \$((RANDOM % 120)); node /baidu_speed/Task/baidu_speed_use2.js >> /logs/baidu_speed2.log 2>&1" >>$defaultListFile
fi

if [ 0"$BAIDU_COOKIE3" = "0" ]; then
    echo "没有配置百度Cookie3，相关环境变量参数，跳过配置定时任务"
else
    cp -r /baidu_speed/Task/baidu_speed.js /baidu_speed/Task/baidu_speed_use3.js
    sed -i "s/StartBody/BDCookie/g" /baidu_speed/Task/baidu_speed_use3.js
    sed -i "s/.*process.env.BAIDU_COOKIE.indexOf('\\\n')/else&/g" /baidu_speed/Task/baidu_speed_use3.js
    if [ 0"$BAIDU_CRON" = "0" ]; then
        BAIDU_CRON="0 8-23/2 * * *"
    fi
    echo "#百度3" >>$defaultListFile
    echo "$BAIDU_CRON node /baidu_speed/Task/baidu_speed_use3.js >> /logs/baidu_speed3.log 2>&1" >>$defaultListFile
fi




##判断快手极速版COOKIE配置之后才会更新相关任务脚本
if [ 0"$KS_TOKEN" = "0" ]; then
    echo "没有配置快手Cookie，相关环境变量参数，跳过下载配置定时任务"
else
    echo "配置了KS_TOKEN所以使用 @sunert 仓库的脚本执行任务"

    if [ ! -d "/kuaishou/" ]; then
        echo "未检查到kuaishou脚本相关文件，初始化下载相关脚本"
        initkuaishou
    else
        echo "更新kuaishou脚本相关文件"
        git -C /kuaishou reset --hard
        git -C /kuaishou pull origin master
    fi

    if [ 0"$KUAISHOU_CRON" = "0" ]; then
        KUAISHOU_CRON="10 9 * * *"
    fi
    echo -e >>$defaultListFile
    echo "$KUAISHOU_CRON sleep \$((RANDOM % 120)); node /kuaishou/Task/kuaishou.js >> /logs/kuaishou.log 2>&1" >>$defaultListFile
fi

##判断汽车之家极速版相关变量存在，才会更新相关任务脚本
if [ 0"$QCZJ_GetUserInfoHEADER" = "0" ]; then
    echo "没有配置汽车之家，相关环境变量参数，跳过配置定时任务"
else
    if [ ! -d "/QCZJSPEED/" ]; then
        echo "未检查到qczjspeed脚本相关文件，初始化下载相关脚本"
        initQCZJSPEED
    else
        echo "更新qczjspeed脚本相关文件"
        git -C /QCZJSPEED reset --hard
        git -C /QCZJSPEED pull origin main
        npm install --prefix /QCZJSPEED
    fi
    echo "Replace some qczj scripts content to be compatible with env configuration ..."
    echo "替换汽车之间内容修正错误..."
    sed -i "s/= GetUserInfoheaderArr\[i]/= GetUserInfoheaderArr\[i].trim()/g" /QCZJSPEED/Task/qczjspeed.js
    sed -i "s/= taskbodyArr\[i]/= taskbodyArr\[i].trim()/g" /QCZJSPEED/Task/qczjspeed.js
    sed -i "s/= activitybodyArr\[i]/= activitybodyArr\[i].trim()/g" /QCZJSPEED/Task/qczjspeed.js
    sed -i "s/= addCoinbodyArr\[i]/= addCoinbodyArr\[i].trim()/g" /QCZJSPEED/Task/qczjspeed.js
    sed -i "s/= addCoin2bodyArr\[i]/= addCoin2bodyArr\[i].trim()/g" /QCZJSPEED/Task/qczjspeed.js

    sed -i "s/>= 20/>= 10/g" /QCZJSPEED/Task/qczjspeed.js
    sed -i "s/CASH = process.env.QCZJ_CASH || 0;/CASH = process.env.QCZJ_CASH || 0;\n CASHTYPE = process.env.QCZJ_CASHTYPE || 3;/g" /QCZJSPEED/Task/qczjspeed.js
    sed -i "s/cashtype=3/cashtype=\${CASHTYPE}/g" /QCZJSPEED/Task/qczjspeed.js

    if [ 0"$QCZJ_CRON" = "0" ]; then
        QCZJ_CRON="*/20 */1 * * *"
    fi
    echo -e >>$defaultListFile
    echo "#汽车之家极速版" >>$defaultListFile
    echo -n "$QCZJ_CRON node /QCZJSPEED/Task/qczjspeed.js >> /logs/qczjspeed.log 2>&1" >>$defaultListFile
fi

##判断火山小视频相关变量存在，才会更新相关任务脚本
if [ 0"$HOTSOONSIGNHEADER" = "0" ]; then
    echo "没有配置火山小视频，相关环境变量参数，跳过配置定时任务"
else
    if [ ! -d "/hotsoon/" ]; then
        echo "未检查到hotsoon脚本相关文件，初始化下载相关脚本"
        inithotsoon
    else
        echo "更新hotsoon脚本相关文件"
        git -C /hotsoon reset --hard
        git -C /hotsoon pull origin master
        mv /hotsoon/package1.json /hotsoon/package.json
        npm install --prefix /hotsoon
    fi
    if [ 0"$HOTSOON_CRON" = "0" ]; then
        HOTSOON_CRON="*/5 1-23/1 * * *"
    fi
    echo -e >>$defaultListFile
    echo "#火山小视频极速版" >>$defaultListFile
    echo -n "$HOTSOON_CRON node /hotsoon/hotsoon.js >> /logs/hotsoon.log 2>&1" >>$defaultListFile
fi

##判断笑谱视频相关变量存在，才会更新相关任务脚本
if [ 0"$VIDEOHEADER" = "0" ]; then
    echo "没有配置笑谱视频，相关环境变量参数，跳过配置定时任务"
else
    if [ ! -d "/xp/" ]; then
        echo "未检查到xp脚本相关文件，初始化下载相关脚本"
        initxp
    else
        echo "更新xp脚本相关文件"
        git -C /xp reset --hard
        git -C /xp pull origin master
        npm install --prefix /xp
    fi
    if [ 0"$XP_CRON" = "0" ]; then
        XP_CRON="*/5 * * * *"
    fi
    echo -e >>$defaultListFile
    echo "#笑谱视频极速版" >>$defaultListFile
    echo -n "$XP_CRON node /xp/xp.js >> /logs/xp.log 2>&1" >>$defaultListFile
fi


##判断步步宝相关变量存在，才会配置定时任务
if [ 0"$BBB_COOKIE" = "0" ]; then
    echo "没有配置步步宝，相关环境变量参数，跳过配置定时任务"
else
    if [ ! -d "/BBB/" ]; then
        echo "未检查到BBB脚本相关文件，初始化下载相关脚本"
        initBBB
    else
        echo "更新BBB脚本相关文件"
        git -C /BBB reset --hard
        git -C /BBB pull origin master
        npm install --prefix /BBB
        cp /BBB/BBB.js /BBB/BBB_BACKUP.js
        sed -i "s/let CookieVal = \$.getdata('bbb_ck')/let CookieVal = process.env.BBB_COOKIE.split();/g" /BBB/BBB.js
    fi
    if [ 0"$BBB_CRON" = "0" ]; then
        BBB_CRON="0 7-23/2 * * *"
    fi
    echo -e >>$defaultListFile
    echo "#步步宝" >>$defaultListFile
    echo -n "$BBB_CRON node /BBB/BBB.js >> /logs/BBB.log 2>&1" >>$defaultListFile
fi

if [ 0"$BBB_COOKIE2" = "0" ]; then
    echo "没有配置步步宝Cookie2，相关环境变量参数，跳过配置定时任务"
else
    cp /BBB/BBB_BACKUP.js /BBB/BBB2.js
    sed -i "s/let CookieVal = \$.getdata('bbb_ck')/let CookieVal = process.env.BBB_COOKIE2.split();/g" /BBB/BBB2.js
    if [ 0"$BBB_CRON" = "0" ]; then
        BBB_CRON="0 8-23/2 * * *"
    fi
    echo "#步步宝2" >>$defaultListFile
    echo "$BBB_CRON node /BBB/BBB2.js >> /logs/BBB2.log 2>&1" >>$defaultListFile
fi

if [ 0"$BBB_COOKIE3" = "0" ]; then
    echo "没有配置步步宝Cookie3，相关环境变量参数，跳过配置定时任务"
else
    cp /BBB/BBB_BACKUP.js /BBB/BBB3.js
    sed -i "s/let CookieVal = \$.getdata('bbb_ck')/let CookieVal = process.env.BBB_COOKIE3.split();/g" /BBB/BBB3.js
    if [ 0"$BBB_CRON" = "0" ]; then
        BBB_CRON="0 8-23/2 * * *"
    fi
    echo "#步步宝3" >>$defaultListFile
    echo "$BBB_CRON node /BBB/BBB3.js >> /logs/BBB3.log 2>&1" >>$defaultListFile
fi

##追加|ts 任务日志时间戳
if type ts >/dev/null 2>&1; then
    echo 'moreutils tools installed, default task append |ts output'
    echo '系统已安装moreutils工具包，默认定时任务增加｜ts 输出'
    ##复制一个新文件来追加|ts，防止git pull的时候冲突
    cp $defaultListFile /pss/default_list.sh
    defaultListFile="/pss/default_list.sh"

    sed -i '/|ts/!s/>>/|ts >>/g' $defaultListFile
fi

##判断 自定义文件是否存在 是否存在
if [ $CUSTOM_LIST_FILE ]; then
    echo "You have configured a custom list file: $CUSTOM_LIST_FILE, custom list merge type: $CUSTOM_LIST_MERGE_TYPE..."
    echo "您配置了自定义任务文件：$CUSTOM_LIST_FILE，自定义任务类型为：$CUSTOM_LIST_MERGE_TYPE..."
    if [ -f "$customListFile" ]; then
        if [ $CUSTOM_LIST_MERGE_TYPE == "append" ]; then
            echo "merge default list file: $DEFAULT_LIST_FILE and custom list file: $CUSTOM_LIST_FILE"
            echo "合并默认定时任务文件：$DEFAULT_LIST_FILE 和 自定义定时任务文件：$CUSTOM_LIST_FILE"
            cat $defaultListFile >$mergedListFile
            echo -e "" >>$mergedListFile
            cat $customListFile >>$mergedListFile
        elif [ $CUSTOM_LIST_MERGE_TYPE == "overwrite" ]; then
            cat $customListFile >$mergedListFile
            echo "merge custom list file: $CUSTOM_LIST_FILE..."
            echo "合并自定义任务文件：$CUSTOM_LIST_FILE"
            touch "$customListFile"
        else
            echo "配置配置了错误的自定义定时任务类型：$CUSTOM_LIST_MERGE_TYPE，自定义任务类型为只能为append或者overwrite..."
            cat $defaultListFile >$mergedListFile
        fi
    else
        echo "Not found custom list file: $CUSTOM_LIST_FILE ,use default list file: $DEFAULT_LIST_FILE"
        echo "自定义任务文件：$CUSTOM_LIST_FILE 未找到，使用默认配置$DEFAULT_LIST_FILE..."
        cat $defaultListFile >$mergedListFile
    fi
else
    echo "The currently used is the default crontab task file: $DEFAULT_LIST_FILE ..."
    echo "当前使用的为默认定时任务文件 $DEFAULT_LIST_FILE ..."
    cat $defaultListFile >$mergedListFile
fi

##判断最后要加载的定时任务是否包含默认定时任务，不包含的话就加进去
if [ $(grep -c "default_task.sh" $mergedListFile) -eq '0' ]; then
    echo "Merged crontab task file，the required default task is not included, append default task..."
    echo "合并后的定时任务文件，未包含必须的默认定时任务，增加默认定时任务..."
    echo -e >>$mergedListFile
    echo "" >>$mergedListFile
    echo "#默认定时任务" >>$mergedListFile
    echo "52 */1 * * * sh /pss/default_task.sh |ts >> /logs/default_task.log 2>&1" >>$mergedListFile
fi

echo "Load the latest crontab task file..."
echo "加载最新的定时任务文件..."
crontab $mergedListFile

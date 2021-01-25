#!/bin/sh
set -e


##定义合并定时任务相关文件路径变量
defaultListFile="/pss/$DEFAULT_LIST_FILE"
customListFile="/pss/$CUSTOM_LIST_FILE"
mergedListFile="/pss/merged_list_file.sh"


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
    git pull origin master --rebase
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
    git pull origin master --rebase
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
    git pull origin main --rebase
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
    git pull origin master --rebase
    mv /hotsoon/package1.json /hotsoon/package.json
    npm install
}

##克隆ZIYE_JavaScript仓库
if [ ! -d "/ZIYE_JavaScript/" ]; then
    echo "未检查到ZIYE_JavaScript仓库脚本，初始化下载相关脚本"
    mkdir /ZIYE_JavaScript
    cd /ZIYE_JavaScript
    git init
    git remote add -f origin https://github.com/ziye12/JavaScript
    git config core.sparsecheckout true
    echo Task >>/ZIYE_JavaScript/.git/info/sparse-checkout
    git pull origin main --rebase
    wget -O /ZIYE_JavaScript/package.json https://raw.githubusercontent.com/ziye12/QCZJSPEED/main/package.json
    npm install
else
    echo "更新ZIYE_JavaScript脚本相关文件"
    git -C /ZIYE_JavaScript reset --hard
    git -C /ZIYE_JavaScript pull origin main --rebase
    wget -O /ZIYE_JavaScript/package.json https://raw.githubusercontent.com/ziye12/QCZJSPEED/main/package.json
    npm install --prefix /ZIYE_JavaScript
fi

##克隆adwktt仓库
if [ ! -d "/adwktt/" ]; then
    echo "未检查到adwktt仓库脚本，初始化下载相关脚本"
    git clone https://github.com/adwktt/adwktt /adwktt
    wget -O /adwktt/package.json https://raw.githubusercontent.com/ziye12/QCZJSPEED/main/package.json
    npm install /adwktt
else
    echo "更新adwktt脚本相关文件"
    git -C /adwktt reset --hard
    git -C /adwktt pull origin master --rebase
    wget -O /adwktt/package.json https://raw.githubusercontent.com/ziye12/QCZJSPEED/main/package.json
    npm install --prefix /adwktt
fi


##判断小米运动相关变量存在，才会更新相关任务脚本
if [ 0"$XMYD_USER" = "0" ]; then
    echo "没有配置小米运动，相关环境变量参数，跳过配置定时任务"
else
    if [ ! -d "/xmSports/" ]; then
        echo "未检查到xmSports脚本相关文件，初始化下载相关脚本"
        git clone https://github.com/FKPYW/mimotion /xmSports
    else
        echo "更新xmSports脚本相关文件"
        git -C /xmSports reset --hard
        git -C /xmSports pull origin main --rebase
    fi
    if [ 0"$XM_CRON" = "0" ]; then
        XM_CRON="10 22 * * *"
    fi
    echo "#小米运动刷步数" >>$defaultListFile
    echo "$XM_CRON python3 /xmSports/main.py >> /logs/xmSports.log 2>&1" >>$defaultListFile
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
        git -C /xmly_speed pull origin master --rebase
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
    echo "#喜马拉雅极速版">>$defaultListFile
    echo "$XMLY_CRON python3 /xmly_speed/xmly_speed.py >> /logs/xmly_speed.log 2>&1" >>$defaultListFile
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
        git -C /qqread pull origin master --rebase
        npm install --prefix /qqread
    fi
    echo "Replace some qqread scripts content to be compatible with env configuration ..."
    echo "替换企鹅读书小程序脚本相关内容以兼容环境变量配置..."
    sed -i "s/notifyttt = 1/notifyttt = process.env.QQREAD_NOTIFYTTT || 1/g" /qqread/Task/qqreadnode.js
    sed -i "s/notifyInterval = 2/notifyInterval = process.env.QQREAD_NOTIFY_INTERVAL || 2/g" /qqread/Task/qqreadnode.js
    if [ 0"$QQREAD_CRON" = "0" ]; then
        QQREAD_CRON="*/20 */1 * * *"
    fi
    echo "#企鹅读书小程序" >>$defaultListFile
    echo "$QQREAD_CRON sleep \$((RANDOM % 180)) && node /qqread/Task/qqreadnode.js >> /logs/qqreadnode.log 2>&1" >>$defaultListFile
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
        git -C /QCZJSPEED pull origin main --rebase
        npm install --prefix /QCZJSPEED
    fi
    echo "Replace some qczj scripts content to be compatible with env configuration ..."
    echo "替换汽车之间内容修正错误..."
    sed -i "s/= GetUserInfoheaderArr\[i]/= GetUserInfoheaderArr\[i].trim()/g" /QCZJSPEED/Task/qczjspeed.js
    sed -i "s/= taskbodyArr\[i]/= taskbodyArr\[i].trim()/g" /QCZJSPEED/Task/qczjspeed.js
    sed -i "s/= activitybodyArr\[i]/= activitybodyArr\[i].trim()/g" /QCZJSPEED/Task/qczjspeed.js
    sed -i "s/= addCoinbodyArr\[i]/= addCoinbodyArr\[i].trim()/g" /QCZJSPEED/Task/qczjspeed.js
    sed -i "s/= addCoin2bodyArr\[i]/= addCoin2bodyArr\[i].trim()/g" /QCZJSPEED/Task/qczjspeed.js

    sed -i "s/CASH = \'\'/CASH = \'\', CASHTYPE=\'\'/g" /QCZJSPEED/Task/qczjspeed.js
    sed -i "s/CASH = process.env.QCZJ_CASH || 0;/CASH = process.env.QCZJ_CASH || 0;\n CASHTYPE = process.env.QCZJ_CASHTYPE || 3;/g" /QCZJSPEED/Task/qczjspeed.js
    sed -i "s/cashtype=3/cashtype=\${CASHTYPE}/g" /QCZJSPEED/Task/qczjspeed.js
    if [ 0"$QCZJ_CRON" = "0" ]; then
        QCZJ_CRON="*/20 */1 * * *"
    fi
    echo "#汽车之家极速版" >>$defaultListFile
    echo "$QCZJ_CRON node /QCZJSPEED/Task/qczjspeed.js >> /logs/qczjspeed.log 2>&1" >>$defaultListFile
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
        git -C /hotsoon pull origin master --rebase
        mv /hotsoon/package1.json /hotsoon/package.json
        npm install --prefix /hotsoon
    fi
    if [ 0"$HOTSOON_CRON" = "0" ]; then
        HOTSOON_CRON="*/5 1-23/1 * * *"
    fi
    echo "#火山小视频极速版" >>$defaultListFile
    echo "$HOTSOON_CRON node /hotsoon/hotsoon.js >> /logs/hotsoon.log 2>&1" >>$defaultListFile
fi

##判断笑谱相关变量存在，才会更新相关任务脚本
if [ 0"$XP_iboxpayHEADER" = "0" ]; then
    echo "没有配置笑谱，相关环境变量参数，跳过配置定时任务"
else
    if [ 0"$XP_CRON" = "0" ]; then
        XP_CRON="*/10 */1 * * *"
    fi
    echo "#笑谱" >>$defaultListFile
    echo "$XP_CRON node /ZIYE_JavaScript/Task/iboxpay.js >> /logs/iboxpay.log 2>&1" >>$defaultListFile
fi

##判断返利网相关变量存在，才会更新相关任务脚本
if [ 0"$FL_flwHEADER" = "0" ]; then
    echo "没有配置返利网，相关环境变量参数，跳过配置定时任务"
else
    if [ 0"$FL_CRON" = "0" ]; then
        FL_CRON="0 12,23 * * *"
    fi
    echo "#返利网" >>$defaultListFile
    echo "$FL_CRON node /ZIYE_JavaScript/Task/flw.js >> /logs/flw.log 2>&1" >>$defaultListFile
fi

##判断步步宝相关变量存在，才会配置定时任务
if [ 0"$BBB_COOKIE" = "0" ]; then
    echo "没有配置步步宝Cookie，相关环境变量参数，跳过配置定时任务"
else
    cp /adwktt/BBB.js /adwktt/BBB_BACKUP.js
    sed -i "s/let CookieVal = \$.getdata('bbb_ck')/let CookieVal = process.env.BBB_COOKIE.split();/g" /adwktt/BBB.js
    if [ 0"$BBB_CRON" = "0" ]; then
        BBB_CRON="0 8-23/2 * * *"
    fi
    echo "#步步宝" >>$defaultListFile
    echo "$BBB_CRON node /adwktt/BBB.js >> /logs/BBB.log 2>&1" >>$defaultListFile
fi

if [ 0"$BBB_COOKIE2" = "0" ]; then
    echo "没有配置步步宝Cookie2，相关环境变量参数，跳过配置定时任务"
else
    cp /adwktt/BBB_BACKUP.js /adwktt/BBB2.js
    sed -i "s/let CookieVal = \$.getdata('bbb_ck')/let CookieVal = process.env.BBB_COOKIE2.split();/g" /adwktt/BBB2.js
    if [ 0"$BBB_CRON" = "0" ]; then
        BBB_CRON="0 8-23/2 * * *"
    fi
    echo "#步步宝2" >>$defaultListFile
    echo "$BBB_CRON node /adwktt/BBB2.js >> /logs/BBB2.log 2>&1" >>$defaultListFile
fi

if [ 0"$BBB_COOKIE3" = "0" ]; then
    echo "没有配置步步宝Cookie3，相关环境变量参数，跳过配置定时任务"
else
    cp /adwktt/BBB_BACKUP.js /adwktt/BBB3.js
    sed -i "s/let CookieVal = \$.getdata('bbb_ck')/let CookieVal = process.env.BBB_COOKIE3.split();/g" /adwktt/BBB3.js
    if [ 0"$BBB_CRON" = "0" ]; then
        BBB_CRON="0 8-23/2 * * *"
    fi
    echo "#步步宝3" >>$defaultListFile
    echo "$BBB_CRON node /adwktt/BBB3.js >> /logs/BBB3.log 2>&1" >>$defaultListFile
fi


##增加自定义shell脚本
if [ 0"$CUSTOM_SHELL_FILE" = "0" ]; then
    echo "未配置自定shell脚本文件，跳过执行。"
else
    if expr "$CUSTOM_SHELL_FILE" : 'http.*' &>/dev/null; then
        echo "自定义shell脚本为远程脚本，开始下在自定义远程脚本。"
        wget -O /pss/pss_shell_mod.sh $CUSTOM_SHELL_FILE
        echo "下载完成，开始执行..."
        sh -x /pss/pss_shell_mod.sh
        echo "自定义远程shell脚本下载并执行结束。"
    else
        if [ ! -f $CUSTOM_SHELL_FILE ]; then
            echo "自定义shell脚本为docker挂载脚本文件，但是指定挂载文件不存在，跳过执行。"
        else
            echo "docker挂载的自定shell脚本，开始执行..."
            sh -x $CUSTOM_SHELL_FILE
            echo "docker挂载的自定shell脚本，执行结束。"
        fi
    fi
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
    echo "#默认定时任务" >>$mergedListFile
    echo "52 */1 * * * sh /pss/default_task.sh |ts >> /logs/default_task.log 2>&1" >>$mergedListFile
fi

echo "Load the latest crontab task file..."
echo "加载最新的定时任务文件..."
crontab $mergedListFile

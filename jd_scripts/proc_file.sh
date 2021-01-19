#!/bin/sh


if [ $CRZAY_JOY_COIN_ENABLE = "Y" ]; then
   echo "配置启用jd_crazy_joy_coin，杀掉jd_crazy_joy_coin任务，并重启"
   eval $(ps -ef | grep "jd_crazy" | awk '{print "kill "$1}')
   echo '' >/scripts/logs/jd_crazy_joy_coin.log
   node /scripts/jd_crazy_joy_coin.js | ts >>/scripts/logs/jd_crazy_joy_coin.log 2>&1 &
   echo "配置jd_crazy_joy_coin重启完成"
else
   eval $(ps -ef | grep "jd_crazy" | awk '{print "kill "$1}')
   echo "已配置不启用jd_crazy_joy_coin任务，不处理"
fi


# 替换京东汽车旅程赛点兑换金豆cron
sed -i "s/0 0 \* \* \* node \/scripts\/jd_car_exchange.js/59 23 \* \* \* sleep 40 \&\& node \/scripts\/jd_car_exchange.js/g" /scripts/docker/merged_list_file.sh

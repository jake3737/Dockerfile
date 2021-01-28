#!/bin/sh


if [ $CRZAY_JOY_COIN_ENABLE = "N" ]; then
   echo "配置启用jd_crazy_joy_coin，杀掉jd_crazy_joy_coin任务，并重启"
   eval $(ps -ef | grep "jd_crazy" | awk '{print "kill "$1}')
   echo '' >/scripts/logs/jd_crazy_joy_coin.log
   node /scripts/jd_crazy_joy_coin.js | ts >>/scripts/logs/jd_crazy_joy_coin.log 2>&1 &
   echo "配置jd_crazy_joy_coin重启完成"
else
   eval $(ps -ef | grep "jd_crazy" | awk '{print "kill "$1}')
   echo "已配置不启用jd_crazy_joy_coin任务，不处理"
fi

## 修改默认任务定时
sed -i "s/52 \*\/1 \* \* \* docker_entrypoint.sh/51 \*\/1 \* \* \* docker_entrypoint.sh/g" /scripts/docker/merged_list_file.sh
## 修改闪购盲盒定时
sed -i "s/27 8 \* \* \* node \/scripts\/jd_sgmh.js/27 8,23 \* \* \* node \/scripts\/jd_sgmh.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/27 8 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_sgmh.js/27 8,23 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_sgmh.js/g" /scripts/docker/merged_list_file.sh
## 修改签到领现金定时
sed -i "s/27 7 \* \* \* node \/scripts\/jd_cash.js/27 7,23 \* \* \* node \/scripts\/jd_cash.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/27 7 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_cash.js/27 7,23 * * * sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_cash.js/g" /scripts/docker/merged_list_file.sh

## 替换神仙书院助力码
sed -ie "52,53s/^[^\]*/ \`34xIs4YwE5Z7Dd9A30tnF_g5VVlIkonP1KzzAYZxDmQcG0TwOlqk@43xIs4YwE5Z7DsWOzDSP6lIEISWgGCypI95vuk7NoEdft8cZB9wEUFjjwpxNCM8usaJQ@43xIs4YwE5Z7DsWOzDSFfxVRtbrTkqpZM_6Q1cMm4ezuegcZB9wkMG2jyLTmbR1PTTJQ@43xIs4YwE5Z7DsWOzDSPKB7RvPqDyJGKRLCnBaMhNsWom4cZB9wBdW2j36tyUUSOCvCA@40xIs4YwE5Z7DsWOzDPAtJyWm1EK-N-dumROa6VHh3ZcZB9vxopyke03-Eh06nk@28xIs4YwE5Z7DrHgAFs-KjaagYOeSbbd51XjE1ahzY@35xIs4YwE5Z7HhZmFyW6ru5sXgzPNM9YCN_daEKswRxEdVhjuhXCKP@40xIs4YwE5Z7DsWOzDCOuR5WD3HNJSE5BExrVw8JzahcZB9gDEQ0XoZl3V7eZRt@39xIs4YwE5Z7FSXbOm_AjrIu7i42_qWz_JOg7jq1ig8lmzH9nm03YY9jX5KLY\`,/g" /scripts/jd_immortal.js
## 替换炸年兽PK助力码
sed -ie "53,54s/^[^\]*/ 'IgNWdiLGaPaQsl-WS1D37TuSr370qowCEsw4X9J8ELFHYEX1ePs@IgNWdiLGaPaGs0uDAQyh59K4C82oUDFVaj0KSvjCNHc',/g" /scripts/jd_nian.js

# 替换京东汽车旅程赛点兑换金豆cron
sed -i "s/0 0 \* \* \* node \/scripts\/jd_car_exchange.js/59 23 \* \* \* sleep 40 \&\& node \/scripts\/jd_car_exchange.js/g" /scripts/docker/merged_list_file.sh

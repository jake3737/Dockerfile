#!/bin/sh


## 直播间红包雨
echo -e >> /scripts/docker/merged_list_file.sh
echo "#更新直播间红包雨" >> /scripts/docker/merged_list_file.sh
echo "58,59 18-20/1 * * * wget -O /scripts/jd_live_redrain2.js https://raw.githubusercontent.com/shylocks/Loon/main/jd_live_redrain2.js " >> /scripts/docker/merged_list_file.sh
echo "#直播间红包雨" >> /scripts/docker/merged_list_file.sh
echo -n "0,1 19-21/1 * * * node /scripts/jd_live_redrain2.js |ts >> /scripts/logs/jd_live_redrain2.log 2>&1" >> /scripts/docker/merged_list_file.sh

## 盲盒抽京豆
wget -O /scripts/jd_mh.js https://raw.githubusercontent.com/shylocks/Loon/main/jd_mh.js
echo -e >> /scripts/docker/merged_list_file.sh
echo "#盲盒抽京豆" >> /scripts/docker/merged_list_file.sh
echo -n "1 7 * * * node /scripts/jd_mh.js |ts >> /scripts/logs/jd_mh.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 宝洁美发屋
wget -O /scripts/jd_bj.js https://raw.githubusercontent.com/shylocks/Loon/main/jd_bj.js
echo -e >> /scripts/docker/merged_list_file.sh
echo "#宝洁美发屋" >> /scripts/docker/merged_list_file.sh
echo -n "1 8,9 14-31/1 1 * node /scripts/jd_bj.js |ts >> /scripts/logs/jd_bj.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 京东粉丝专享
wget -O /scripts/jd_wechat_sign.js https://raw.githubusercontent.com/shylocks/Loon/main/jd_wechat_sign.js
echo -e >> /scripts/docker/merged_list_file.sh
echo "#京东粉丝专享" >> /scripts/docker/merged_list_file.sh
echo -n "1 7 * * * node /scripts/jd_wechat_sign.js |ts >> /scripts/logs/jd_wechat_sign.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 京东秒秒币
wget -O /scripts/jd_ms.js https://raw.githubusercontent.com/shylocks/Loon/main/jd_ms.js
echo -e >> /scripts/docker/merged_list_file.sh
echo "#京东秒秒币" >> /scripts/docker/merged_list_file.sh
echo -n "1 7 * * * node /scripts/jd_ms.js |ts >> /scripts/logs/jd_ms.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 神券京豆
wget -O /scripts/jd_super_coupon.js https://raw.githubusercontent.com/shylocks/Loon/main/jd_super_coupon.js
echo -e >> /scripts/docker/merged_list_file.sh
echo "#神券京豆" >> /scripts/docker/merged_list_file.sh
echo -n "1 7 13 1 * node /scripts/jd_super_coupon.js |ts >> /scripts/logs/jd_super_coupon.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 工业品爱消除
wget -O /scripts/jd_gyec.js https://raw.githubusercontent.com/shylocks/Loon/main/jd_gyec.js
echo -e >> /scripts/docker/merged_list_file.sh
echo "#工业品爱消除" >> /scripts/docker/merged_list_file.sh
echo -n "30 * * * * node /scripts/jd_gyec.js |ts >> /scripts/logs/jd_gyec.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 京喜财富岛
wget -O /scripts/jx_cfd.js https://raw.githubusercontent.com/moposmall/Script/main/Me/jx_cfd.js
echo -e >> /scripts/docker/merged_list_file.sh
echo "#京喜财富岛" >> /scripts/docker/merged_list_file.sh
echo -n "0 * * * * node /scripts/jx_cfd.js |ts >> /scripts/logs/jx_cfd.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 京喜财富岛提现
wget -O /scripts/jx_cfdtx.js https://raw.githubusercontent.com/Aaron-lv/JavaScript/master/Task/jx_cfdtx.js
echo -e >> /scripts/docker/merged_list_file.sh
echo "#京喜财富岛提现" >> /scripts/docker/merged_list_file.sh
echo "0 0 * * * node /scripts/jx_cfdtx.js |ts >> /scripts/logs/jx_cfdtx.log 2>&1" >> /scripts/docker/merged_list_file.sh



## 替换工业品爱消除助力码
sed -i "s/840266@2583822@2585219@2586018@1556311@2583822@2585256@2586023@2728968/754344@2695073@654824@1398507@2274010/g" /scripts/jd_gyec.js

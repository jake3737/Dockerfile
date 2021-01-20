#!/bin/sh


## 克隆shylocks仓库脚本
if [ ! -d "/shylocks/" ]; then
    echo "未检查到shylocks仓库脚本，初始化下载相关脚本"
    git clone https://github.com/shylocks/Loon /shylocks
else
    echo "更新shylocks脚本相关文件"
    git -C /shylocks reset --hard
    git -C /shylocks pull origin main
    cp -R /shylocks/jd*.js /scripts/
fi

## 红包雨
echo -e >> /scripts/docker/merged_list_file.sh
echo "#更新红包雨" >> /scripts/docker/merged_list_file.sh
echo -n "29,59 */1 * * * git -C /shylocks reset --hard && git -C /shylocks pull origin main && cp -R /shylocks/jd*.js /scripts/" >> /scripts/docker/merged_list_file.sh
##加入shylocks仓库脚本cron
sed -i "s/\n\n/\n/g" /shylocks/docker/crontab_list.sh
sed -i "s/\n//g" /shylocks/docker/crontab_list.sh
cat /shylocks/docker/crontab_list.sh >> /scripts/docker/merged_list_file.sh

## 京喜财富岛
wget -O /scripts/jx_cfd.js https://raw.githubusercontent.com/moposmall/Script/main/Me/jx_cfd.js
echo -e >> /scripts/docker/merged_list_file.sh
echo "#京喜财富岛" >> /scripts/docker/merged_list_file.sh
echo -n "0 * * * * node /scripts/jx_cfd.js |ts >> /scripts/logs/jx_cfd.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 京喜财富岛提现
wget -O /scripts/jx_cfdtx.js https://raw.githubusercontent.com/Aaron-lv/JavaScript/master/Task/jx_cfdtx.js
echo -e >> /scripts/docker/merged_list_file.sh
echo "#京喜财富岛提现" >> /scripts/docker/merged_list_file.sh
echo "59 23 * * * sleep 58 && node /scripts/jx_cfdtx.js |ts >> /scripts/logs/jx_cfdtx.log 2>&1" >> /scripts/docker/merged_list_file.sh



## 替换工业品爱消除助力码
sed -i "s/840266@2583822@2585219@2586018@1556311@2583822@2585256@2586023@2728968/754344@2695073@654824@1398507@2274010@715293@2751795@2796229@2484958/g" /scripts/jd_gyec.js
## 替换东东爱消除助力码
sed -i "s/840266@2585219@2586018@1556311@2583822@2585256/754344@2695073@654824@1398507@2274010@715293@2751795@2796229@2484958/g" /scripts/jd_xxl.js
## 替换个护爱消除助力码
sed -i "s/840266@2585219@2586018@1556311@2583822@2585256/754344@2695073@654824@1398507@2274010@715293@2751795@2796229@2484958/g" /scripts/jd_xxl_gh.js

#!/bin/sh


if [ ! -d "/shylocks/" ]; then
    echo "未检查到shylocks仓库脚本，初始化下载相关脚本"
    git clone https://github.com/lmh77/shylocks-Loon
else
    echo "更新shylocks脚本相关文件"
    git -C /shylocks reset --hard
    git -C /shylocks pull --rebase
fi

## 复制shylocks脚本
cp -rf /shylocks/jd_*.js /scripts


## 超级直播间红包雨
echo "# 超级直播间红包雨" >> /scripts/docker/merged_list_file.sh
echo "30,31 20-23/1 28 1 * node /scripts/jd_live_redrain.js >> /scripts/logs/jd_live_redrain.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 直播间红包雨
echo "# 直播间红包雨" >> /scripts/docker/merged_list_file.sh
echo "0,1 19-21/1 * * * node /scripts/jd_live_redrain2.js >> /scripts/logs/jd_live_redrain2.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 半点红包雨
echo "# 半点红包雨" >> /scripts/docker/merged_list_file.sh
echo "30,31 12-23/1 * * * node /scripts/jd_live_redrain_half.js >> /scripts/logs/jd_live_redrain_half.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 年货直播红包雨
echo "# 年货直播红包雨" >> /scripts/docker/merged_list_file.sh
echo "0 0,9,11,13,15,17,19,20,21,23 3,5,20-30/1 1,2 * node /scripts/jd_live_redrain_nian.js >> /scripts/logs/jd_live_redrain_nian.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 官方号直播红包雨
echo "# 官方号直播红包雨" >> /scripts/docker/merged_list_file.sh
echo "0 0,9,11,13,15,17,19,20,21,22,23 * * * node /scripts/jd_live_redrain_offical.js >> /scripts/logs/jd_live_redrain_offical.log 2>&1" >> /scripts/docker/merged_list_file.sh

## 京喜财富岛
wget -O /scripts/jx_cfd.js https://raw.githubusercontent.com/moposmall/Script/main/Me/jx_cfd.js
echo "# 京喜财富岛" >> /scripts/docker/merged_list_file.sh
echo "1 * * * * node /scripts/jx_cfd.js >> /scripts/logs/jx_cfd.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 京喜财富岛提现
wget -O /scripts/jx_cfdtx.js https://raw.githubusercontent.com/Aaron-lv/JavaScript/master/Task/jx_cfdtx.js
echo "# 京喜财富岛提现" >> /scripts/docker/merged_list_file.sh
echo "0 0 * * * node /scripts/jx_cfdtx.js >> /scripts/logs/jx_cfdtx.log 2>&1" >> /scripts/docker/merged_list_file.sh
echo "59,58 23 * * * sleep 59 && node /scripts/jx_cfdtx.js |ts >> /scripts/logs/jx_cfdtx.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 东东超市
wget -O /scripts/jd_blueCoin.js https://github.com/jake3737/zyjd/blob/master/jd_blueCoin.js
echo -e >> /scripts/docker/merged_list_file.sh
echo "#兑换礼品" >> /scripts/docker/merged_list_file.sh
echo "59,58 23 * * * sleep 59 && node /scripts/jd_blueCoin.js >> /scripts/logs/jd_blueCoin.log 2>&1" >> /scripts/docker/merged_list_file.sh

## 修改默认任务定时
sed -i "s/52 \*\/1 \* \* \* docker_entrypoint.sh/51 \*\/1 \* \* \* docker_entrypoint.sh/g" /scripts/docker/merged_list_file.sh
## 修改闪购盲盒定时
sed -i "s/27 8 \* \* \* node \/scripts\/jd_sgmh.js/27 8,23 \* \* \* node \/scripts\/jd_sgmh.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/27 8 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_sgmh.js/27 8,23 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_sgmh.js/g" /scripts/docker/merged_list_file.sh
## 修改签到领现金定时
sed -i "s/27 7 \* \* \* node \/scripts\/jd_cash.js/27 7,23 \* \* \* node \/scripts\/jd_cash.js/g" /scripts/docker/merged_list_file.sh
sed -i "s/27 7 \* \* \* sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_cash.js/27 7,23 * * * sleep \$((RANDOM % \$RANDOM_DELAY_MAX)); node \/scripts\/jd_cash.js/g" /scripts/docker/merged_list_file.sh



## 替换工业品爱消除助力码
sed -i "s/840266@2583822@2585219@2586018@1556311@2583822@2585256@2586023@2728968/754344@2695073@654824@1398507@2274010@715293@2751795@2796229@2484958/g" /scripts/jd_gyec.js
## 替换东东爱消除助力码
sed -i "s/840266@2585219@2586018@1556311@2583822@2585256/754344@2695073@654824@1398507@2274010@715293@2751795@2796229@2484958/g" /scripts/jd_xxl.js
## 替换个护爱消除助力码
sed -i "s/840266@2585219@2586018@1556311@2583822@2585256/754344@2695073@654824@1398507@2274010@715293@2751795@2796229@2484958/g" /scripts/jd_xxl_gh.js

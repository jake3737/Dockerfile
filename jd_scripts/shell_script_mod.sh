
#!/bin/sh


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
echo "29,59 */1 * * * git -C /shylocks reset --hard && git -C /shylocks pull origin main && cp -R /shylocks/jd*.js /scripts/" >> /scripts/docker/merged_list_file.sh
echo "#直播间红包雨" >> /scripts/docker/merged_list_file.sh
echo "0,1 19-21/1 * * * node /scripts/jd_live_redrain2.js |ts >> /scripts/logs/jd_live_redrain2.log 2>&1" >> /scripts/docker/merged_list_file.sh
echo "#半点红包雨" >> /scripts/docker/merged_list_file.sh
echo "30,31 12-23/1 * * * node /scripts/jd_live_redrain_half.js |ts >> /scripts/logs/jd_live_redrain_half.log 2>&1" >> /scripts/docker/merged_list_file.sh
echo "#年货直播红包雨" >> /scripts/docker/merged_list_file.sh
echo "0 0,9,11,13,15,17,19,20,21,23 3,5,20-30/1 1,2 * node /scripts/jd_live_redrain_nian.js |ts >> /scripts/logs/jd_live_redrain_nian.log 2>&1" >> /scripts/docker/merged_list_file.sh
echo "#官方号直播红包雨" >> /scripts/docker/merged_list_file.sh
echo -n "0 0,9,11,13,15,17,19,20,21,23 * * * node /scripts/jd_live_redrain_offical.js |ts >> /scripts/logs/jd_live_redrain_offical.log 2>&1" >> /scripts/docker/merged_list_file.sh

## 宝洁美发屋
echo -e >> /scripts/docker/merged_list_file.sh
echo "#宝洁美发屋" >> /scripts/docker/merged_list_file.sh
echo -n "1 8,9 14-31/1 1 * node /scripts/jd_bj.js |ts >> /scripts/logs/jd_bj.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 工业品爱消除
echo -e >> /scripts/docker/merged_list_file.sh
echo "#工业品爱消除" >> /scripts/docker/merged_list_file.sh
echo -n "20 * * * * node /scripts/jd_gyec.js |ts >> /scripts/logs/jd_gyec.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 盲盒抽京豆
echo -e >> /scripts/docker/merged_list_file.sh
echo "#盲盒抽京豆" >> /scripts/docker/merged_list_file.sh
echo -n "1 7 * * * node /scripts/jd_mh.js |ts >> /scripts/logs/jd_mh.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 京东秒秒币
echo -e >> /scripts/docker/merged_list_file.sh
echo "#京东秒秒币" >> /scripts/docker/merged_list_file.sh
echo -n "10 7 * * * node /scripts/jd_ms.js |ts >> /scripts/logs/jd_ms.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 神券京豆
echo -e >> /scripts/docker/merged_list_file.sh
echo "#神券京豆" >> /scripts/docker/merged_list_file.sh
echo -n "1 7 13 1 * node /scripts/jd_super_coupon.js |ts >> /scripts/logs/jd_super_coupon.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 京东粉丝专享
echo -e >> /scripts/docker/merged_list_file.sh
echo "#京东粉丝专享" >> /scripts/docker/merged_list_file.sh
echo -n "10 0 * * * node /scripts/jd_wechat_sign.js |ts >> /scripts/logs/jd_wechat_sign.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 小鸽有礼
echo -e >> /scripts/docker/merged_list_file.sh
echo "#小鸽有礼" >> /scripts/docker/merged_list_file.sh
echo -n "5 7 * * * node /scripts/jd_xg.js |ts >> /scripts/logs/jd_xg.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 东东爱消除
echo -e >> /scripts/docker/merged_list_file.sh
echo "#东东爱消除" >> /scripts/docker/merged_list_file.sh
echo -n "0 * * * * node /scripts/jd_xxl.js |ts >> /scripts/logs/jd_xxl.log 2>&1" >> /scripts/docker/merged_list_file.sh
## 个护爱消除
echo -e >> /scripts/docker/merged_list_file.sh
echo "#个护爱消除" >> /scripts/docker/merged_list_file.sh
echo -n "40 * * * * node /scripts/jd_xxl_gh.js |ts >> /scripts/logs/jd_xxl_gh.log 2>&1" >> /scripts/docker/merged_list_file.sh

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

#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改openwrt登陆地址,把下面的 10.0.0.1 修改成你想要的就可以了
# sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate
# 修改 子网掩码
# sed -i 's/255.255.255.0/255.255.0.0/g' package/base-files/files/bin/config_generate

# 修改主机名字，把 iStore OS 修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/OpenWrt/OpenWrt-DDD/g' package/base-files/files/bin/config_generate
# sed -i 's/Authorization Required/wanuse.com/g' feeds/luci/modules/luci-base/ucode/template/sysauth.ut
sed -i 's/Authorization Required/openwrt-23.05.2 wanuse.com/g' feeds/luci/themes/luci-theme-bootstrap/htdocs/luci-static/resources/view/bootstrap/sysauth.js
sed -i 's/需要授权/openwrt-23.05 wanuse.com/g' feeds/luci/modules/luci-base/po/zh_Hans/base.po

# 替换终端为bash
# sed -i 's/\/bin\/ash/\/bin\/bash/' package/base-files/files/etc/passwd

# ttyd 自动登录
# sed -i "s?/bin/login?/usr/libexec/login.sh?g" ${GITHUB_WORKSPACE}/openwrt/package/feeds/packages/ttyd/files/ttyd.config

# 删除默认密码
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

# 取消bootstrap为默认主题
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# 修改 WiFi 名称
# sed -i 's/OpenWrt/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 默认打开 WiFi
# sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Configure pppoe connection
#uci set network.wan.proto=pppoe
#uci set network.wan.username='yougotthisfromyour@isp.su'
#uci set network.wan.password='yourpassword'

# 移除重复软件包
# rm -rf feeds/luci/themes/luci-theme-argon

# 添加第三方应用

mkdir kenzok8
pushd kenzok8
git clone --depth=1 https://github.com/kenzok8/openwrt-packages .
popd

mkdir kiddin9
pushd kiddin9
# git clone --depth=1 https://github.com/kiddin9/openwrt-packages .
git clone --depth=1 https://github.com/kiddin9/kwrt-packages .
popd

mkdir N-wrt
pushd N-wrt
git clone --depth=1 https://github.com/N-wrt/openwrt-ext .
popd

mkdir Banwan1212
pushd Banwan1212
git clone --depth=1 https://github.com/Banwan1212/openwrt-filebrowser .
git clone --depth=1 https://github.com/lisaac/luci-app-diskman/tree/master/applications .
popd

mkdir package/community
pushd package/community

# passwall 和 SSR+
mkdir passwall
pushd passwall
git clone --depth=1 https://github.com/kenzok8/small .
rm -rf v2ray-plugin
popd

#Diskman
mkdir luci-app-diskman
cp -rf ../../Banwan1212/luci-app-diskman/* luci-app-diskman

# 去广告
#ADGuardHome
mkdir luci-app-adguardhome
mkdir adguardhome
cp -rf ../../kenzok8/luci-app-adguardhome/* luci-app-adguardhome
cp -rf ../../kenzok8/adguardhome/* adguardhome

# 文件助手
mkdir filebrowser
mkdir luci-app-filebrowser
mkdir luci-app-fileassistant
mkdir luci-app-filetransfer
mkdir luci-lib-fs
cp -rf ../../ddd/filebrowser/* filebrowser
cp -rf ../../ddd/luci-app-filebrowser/* luci-app-filebrowser
cp -rf ../../kiddin9/luci-app-fileassistant/* luci-app-fileassistant
cp -rf ../../kiddin9/luci-app-filetransfer/* luci-app-filetransfer
cp -rf ../../kiddin9/luci-lib-fs/* luci-lib-fs

# Windows激活KMS激活服务器
mkdir vlmcsd
mkdir luci-app-vlmcsd
cp -rf ../../kiddin9/vlmcsd/* vlmcsd
cp -rf ../../kiddin9/luci-app-vlmcsd/* luci-app-vlmcsd

# 关机
mkdir luci-app-poweroffdevice
cp -rf ../../kiddin9/luci-app-poweroffdevice/* luci-app-poweroffdevice


# 监控CPU性能
mkdir netdata
mkdir luci-app-netdata
cp -rf ../../kiddin9/luci-app-netdata/* luci-app-netdata
cp -rf ../../kiddin9/netdata/* netdata



popd

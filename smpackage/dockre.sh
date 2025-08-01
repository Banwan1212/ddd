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
mkdir kiddin9
pushd kiddin9
git clone --depth=1 https://github.com/kiddin9/openwrt-packages .
popd

mkdir ddd
pushd ddd
git clone --depth=1 https://github.com/Banwan1212/openwrt-packages .
popd

mkdir package/community
pushd package/community

# helloworld
mkdir helloworld
pushd helloworld
git clone --depth=1 https://github.com/Banwan1212/helloworld .
popd

# passwall
mkdir passwall
pushd passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall .
popd

#Diskman
mkdir luci-app-diskman
cp -rf ../../kiddin9/luci-app-diskman/* luci-app-diskman

# 去广告
#ADGuardHome（kiddin9）
mkdir luci-app-adguardhome
mkdir adguardhome
cp -rf ../../kiddin9/luci-app-adguardhome/* luci-app-adguardhome
cp -rf ../../kiddin9/adguardhome/* adguardhome

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

# VPN服务器
mkdir luci-app-pptp-server
mkdir luci-app-openvpn-server
cp -rf ../../kiddin9/luci-app-pptp-server/* luci-app-pptp-server
cp -rf ../../kiddin9/luci-app-openvpn-server/* luci-app-openvpn-server

# Windows激活
mkdir vlmcsd
mkdir luci-app-vlmcsd
cp -rf ../../kiddin9/vlmcsd/* vlmcsd
cp -rf ../../kiddin9/luci-app-vlmcsd/* luci-app-vlmcsd

# 关机
mkdir luci-app-poweroffdevice
cp -rf ../../kiddin9/luci-app-poweroffdevice/* luci-app-poweroffdevice

# 流量图形
mkdir luci-app-vnstat
cp -rf ../../kiddin9/luci-app-vnstat/* luci-app-vnstat

# UPNP
mkdir luci-app-upnp
cp -rf ../../kiddin9/luci-app-upnp/* luci-app-upnp

# 证书ssl
# mkdir luci-app-acme
# cp -rf ../../kiddin9/luci-app-acme/* luci-app-acme

# 自动格式化分区、扩容、自动挂载
# mkdir luci-app-partexp
# cp -rf ../../kiddin9/luci-app-partexp/* luci-app-partexp

# 在线用户
mkdir luci-app-onliner
cp -rf ../../kiddin9/luci-app-onliner/* luci-app-onliner

# 监控CPU性能
mkdir netdata
mkdir luci-app-netdata
cp -rf ../../kiddin9/luci-app-netdata/* luci-app-netdata
cp -rf ../../kiddin9/netdata/* netdata
# git clone https://github.com/sirpdboy/luci-app-netdata luci-app-netdata

# 网络共享（Samba4）
mkdir luci-app-samba4
cp -rf ../../kiddin9/luci-app-samba4/* luci-app-samba4

# aria2下载工具
mkdir luci-app-aria2
mkdir aria2
cp -rf ../../kiddin9/luci-app-aria2/* luci-app-aria2
cp -rf ../../kiddin9/aria2/* aria2

# 内网穿透
mkdir luci-app-frpc
mkdir luci-app-frps
cp -rf ../../kiddin9/luci-app-frpc/* luci-app-frpc
cp -rf ../../kiddin9/luci-app-frps/* luci-app-frps

# 重启计划
mkdir luci-app-autoreboot
cp -rf ../../kiddin9/luci-app-autoreboot/* luci-app-autoreboot

#IP/MAC绑定
mkdir luci-app-arpbind
cp -rf ../../kiddin9/luci-app-arpbind/* luci-app-arpbind

#家长控制 https://github.com/sirpdboy/
mkdir luci-app-parentcontrol
cp -rf ../../kiddin9/luci-app-parentcontrol/* luci-app-parentcontrol

#直播
# mkdir luci-app-nginx-pingos
# cp -rf ../../kiddin9/luci-app-nginx-pingos/* luci-app-nginx-pingos

popd

# .config 添加自定义软件包
echo "

# 固件大小
# CONFIG_GRUB_EFI_IMAGES is not set
# CONFIG_TARGET_ROOTFS_EXT4FS is not set
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_Generic=y
CONFIG_TARGET_IMAGES_GZIP=y
CONFIG_TARGET_ROOTFS_TARGZ=y
CONFIG_TARGET_ROOTFS_PARTSIZE=1024
          
                    
         
# CONFIG_PACKAGE_dnsmasq is not set
CONFIG_LUCI_LANG_zh_Hans=y
CONFIG_PACKAGE_luci-mod-admin-full=y
CONFIG_PACKAGE_luci-app-opkg=y
CONFIG_PACKAGE_luci-i18n-opkg-zh-cn=y
CONFIG_PACKAGE_luci-app-firewall=y
CONFIG_PACKAGE_luci-i18n-firewall-zh-cn=y
CONFIG_PACKAGE_luci-mod-network=y
CONFIG_PACKAGE_luci-mod-rpc=y
CONFIG_PACKAGE_luci-mod-status=y
CONFIG_PACKAGE_luci-mod-system=y
CONFIG_PACKAGE_luci-theme-bootstrap=y
CONFIG_PACKAGE_luci-app-uhttpd=y
CONFIG_PACKAGE_dnsmasq_full=y
CONFIG_PACKAGE_dnsmasq_full_dhcpv6=y
CONFIG_PACKAGE_ipv6helper=y
CONFIG_PACKAGE_luci-proto-ipv6=y
CONFIG_PACKAGE_qrencode=y
CONFIG_PACKAGE_libqrencode=y
CONFIG_PACKAGE_block-mount=y
CONFIG_PACKAGE_cloudflared=y
          
CONFIG_PACKAGE_luci-lib-jsonc=y
CONFIG_DOCKER_CGROUP_OPTIONS=y
CONFIG_PACKAGE_containerd=y
CONFIG_PACKAGE_runc=y
CONFIG_DOCKER_NET_MACVLAN=y
CONFIG_PACKAGE_libnetwork=y
CONFIG_DOCKER_OPTIONAL_FEATURES=y
CONFIG_PACKAGE_tini=y
          
# 文件助手
CONFIG_PACKAGE_luci-app-fileassistant=y
CONFIG_PACKAGE_filebrowser=y
CONFIG_PACKAGE_luci-app-filebrowser=y
CONFIG_PACKAGE_luci-app-filetransfer=y

# UPNP
CONFIG_PACKAGE_luci-app-upnp=y
# 网络带宽监视器
CONFIG_PACKAGE_luci-app-nlbwmon=y
CONFIG_PACKAGE_luci-i18n-nlbwmon-zh-cn=y
# smartdns
CONFIG_PACKAGE_luci-app-smartdns=y
# 终端
CONFIG_PACKAGE_luci-app-ttyd=y
# ssr
CONFIG_PACKAGE_luci-app-ssr-plus=y
          
          
# python ssr
CONFIG_PACKAGE_luci-app-ssrserver-python=y
          
# passwall
CONFIG_PACKAGE_luci-app-passwall2=y
CONFIG_PACKAGE_luci-app-passwall=y
         
CONFIG_PACKAGE_luci-app-openclash=y
CONFIG_PACKAGE_luci-app-openvpn=y
CONFIG_PACKAGE_luci-app-openvpn-server=y
# 内网穿透
CONFIG_PACKAGE_luci-app-frpc=y
CONFIG_PACKAGE_luci-app-frps=y
#ssh连接
CONFIG_PACKAGE_openssh-sftp-server=y
# Turbo ACC 加速插件
# CONFIG_PACKAGE_luci-app-turboacc=y
# 广告屏蔽大师 Plus+
CONFIG_PACKAGE_luci-app-adbyby-plus=y
CONFIG_PACKAGE_adbyby=y
CONFIG_PACKAGE_luci-app-adguardhome=y
CONFIG_PACKAGE_adguardhome=y
# vpn
CONFIG_PACKAGE_luci-app-pptp-server=y
CONFIG_PACKAGE_luci-app-pppoe-server=y
# DiskMan 磁盘管理
CONFIG_PACKAGE_blkid=y
CONFIG_PACKAGE_fdisk=y
CONFIG_PACKAGE_lsblk=y
CONFIG_PACKAGE_luci-app-diskman=y
CONFIG_PACKAGE_luci-app-diskman_INCLUDE_btrfs_progs=y          
CONFIG_PACKAGE_smartmontools=y
# Windows激活
CONFIG_PACKAGE_vlmcsd=y
CONFIG_PACKAGE_luci-app-vlmcsd=y
# wireguard
CONFIG_PACKAGE_luci-app-wireguard=y
CONFIG_PACKAGE_luci-i18n-wireguard-zh-cn=y
CONFIG_PACKAGE_luci-proto-wireguard=y
CONFIG_PACKAGE_wireguard=y
CONFIG_PACKAGE_wireguard-tools=y
CONFIG_PACKAGE_kmod-wireguard=y
# aria2下载工具
CONFIG_PACKAGE_luci-app-aria2=y
# 网络共享（Samba4）
CONFIG_PACKAGE_luci-app-samba4=y
# 监控CPU性能
CONFIG_PACKAGE_netdata=y
CONFIG_PACKAGE_luci-app-netdata=y
# 测速
CONFIG_PACKAGE_luci-app-netspeedtest=y
CONFIG_PACKAGE_luci-i18n-netspeedtest-zh-cn=y
#
CONFIG_PACKAGE_luci-app-zerotier=y
#视频解码
CONFIG_PACKAGE_ffmpeg=y
#重启管理
CONFIG_PACKAGE_luci-app-watchcat=y
#端口开方
CONFIG_PACKAGE_luci-app-natmap=y
#IP/MAC绑定
CONFIG_PACKAGE_luci-app-arpbind=y
#定时任务
CONFIG_PACKAGE_luci-app-autotimeset=y
#关机
CONFIG_PACKAGE_luci-app-poweroffdevice=y
#实时流量
CONFIG_PACKAGE_luci-app-wrtbwmon=y
CONFIG_PACKAGE_wrtbwmon=y
" >> .config

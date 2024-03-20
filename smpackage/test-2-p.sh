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
# sed -i 's/OpenWrt/iStore OS/g' package/base-files/files/bin/config_generate

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


# 添加额外软件包


# 科学上网插件


# 科学上网插件依赖

# adguardhome
# svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-app-adguardhome package/luci-app-adguardhome
# svn export https://github.com/kenzok8/openwrt-packages/trunk/adguardhome package/adguardhome
# svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-adguardhome package/luci-app-adguardhome
# svn export https://github.com/kiddin9/openwrt-packages/trunk/adguardhome package/adguardhome

# mosdns
# svn export https://github.com/kenzok8/openwrt-packages/trunk/luci-app-mosdns package/luci-app-mosdns
# svn export https://github.com/kenzok8/openwrt-packages/trunk/mosdns package/mosdns
# svn export https://github.com/kenzok8/openwrt-packages/trunk/v2dat package/v2dat
# svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-mosdns package/luci-app-mosdns
# svn export https://github.com/kiddin9/openwrt-packages/trunk/mosdns package/mosdns
# svn export https://github.com/kiddin9/openwrt-packages/trunk/v2dat package/v2dat

# 添加第三方应用
mkdir kiddin9
pushd kiddin9
git clone --depth=1 https://github.com/kiddin9/openwrt-packages .
popd
mkdir package/community
pushd package/community
#Diskman
mkdir luci-app-diskman
cp -rf ../../kiddin9/luci-app-diskman/* luci-app-diskman
# 去广告
#ADGuardHome（kiddin9）
mkdir luci-app-adguardhome
mkdir adguardhome
cp -rf ../../kiddin9/luci-app-adguardhome/* luci-app-adguardhome
cp -rf ../../kiddin9/adguardhome/* adguardhome
#svn export https://github.com/kiddin9/openwrt-packages/trunk/adguardhome
#svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-adguardhome
# 文件助手
mkdir filebrowser
mkdir luci-app-filebrowser
mkdir luci-app-fileassistant
mkdir luci-app-filetransfer
mkdir luci-lib-fs

cp -rf ../../kiddin9/filebrowser/* filebrowser
cp -rf ../../kiddin9/luci-app-filebrowser/* luci-app-filebrowser
cp -rf ../../kiddin9/luci-app-fileassistant/* luci-app-fileassistant
cp -rf ../../kiddin9/luci-app-filetransfer/* luci-app-filetransfer
cp -rf ../../kiddin9/luci-lib-fs/* luci-lib-fs
# VPN服务器
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-ssr-mudb-server
# svn export https://github.com/kenzok8/small-package/trunk/luci-app-ipsec-server
svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-pptp-server
svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-openvpn-server

# svn export https://github.com/kenzok8/small-package/trunk/luci-app-softethervpn

popd

# .config 添加自定义软件包
echo "

# 固件大小
# CONFIG_VMDK_IMAGES is not set
# CONFIG_GRUB_EFI_IMAGES is not set
# CONFIG_TARGET_ROOTFS_EXT4FS is not set
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_Generic=y
CONFIG_TARGET_IMAGES_GZIP=y
CONFIG_TARGET_ROOTFS_TARGZ=y
CONFIG_TARGET_ROOTFS_PARTSIZE=1024
CONFIG_LUCI_LANG_zh_Hans=y
# CONFIG_PACKAGE_dnsmasq is not set
CONFIG_PACKAGE_iptables-nft=y
CONFIG_PACKAGE_iptables-mod-conntrack-extra=y
CONFIG_PACKAGE_iptables-mod-iprange=y
CONFIG_PACKAGE_iptables-mod-nat-extra=y
CONFIG_PACKAGE_iptables-mod-socket=y
CONFIG_PACKAGE_iptables-mod-tproxy=y
CONFIG_PACKAGE_luci-mod-admin-full=y
CONFIG_PACKAGE_luci-app-opkg=y
CONFIG_PACKAGE_luci-app-firewall=y
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
CONFIG_PACKAGE_docker=y
CONFIG_PACKAGE_dockerd=y
CONFIG_PACKAGE_luci-app-docker=y
CONFIG_PACKAGE_luci-lib-docker=y
CONFIG_PACKAGE_luci-app-dockerman=y
CONFIG_PACKAGE_luci-lib-jsonc=y
CONFIG_PACKAGE_docker-compose=y
CONFIG_DOCKER_CGROUP_OPTIONS=y
CONFIG_PACKAGE_docker-compose=y
CONFIG_PACKAGE_containerd=y
CONFIG_PACKAGE_runc=y
CONFIG_DOCKER_NET_MACVLAN=y
CONFIG_PACKAGE_libnetwork=y
CONFIG_DOCKER_OPTIONAL_FEATURES=y
CONFIG_PACKAGE_tini=y
CONFIG_PACKAGE_ffmpeg=y
# cloudflare隧道
CONFIG_PACKAGE_cloudflared=y
# passwall
CONFIG_PACKAGE_luci-app-passwall2=y
CONFIG_PACKAGE_luci-app-passwall=y
# ssr
CONFIG_PACKAGE_luci-app-ssr-plus=y
# DiskMan 磁盘管理
CONFIG_PACKAGE_blkid=y
CONFIG_PACKAGE_fdisk=y          
CONFIG_PACKAGE_luci-app-diskman=y
CONFIG_PACKAGE_luci-app-diskman_INCLUDE_btrfs_progs=y
CONFIG_PACKAGE_luci-app-diskman_INCLUDE_lsblk=y
CONFIG_PACKAGE_luci-app-diskman_INCLUDE_mdadm=y
CONFIG_PACKAGE_luci-app-diskman_INCLUDE_kmod_md_raid456=y
CONFIG_PACKAGE_luci-app-diskman_INCLUDE_kmod_md_linear=y
# 文件助手
CONFIG_PACKAGE_luci-lib-fs=y
CONFIG_PACKAGE_luci-app-fileassistant=y
CONFIG_PACKAGE_filebrowser=y
CONFIG_PACKAGE_luci-app-filebrowser=y
CONFIG_PACKAGE_luci-app-filetransfer=y
# 去广告
CONFIG_PACKAGE_luci-app-adguardhome=y
# VPN服务器
# CONFIG_PACKAGE_luci-app-brook-server=y
# CONFIG_PACKAGE_luci-app-ssr-mudb-server=y
# CONFIG_PACKAGE_luci-app-trojan-server=y
CONFIG_PACKAGE_luci-app-openvpn-server=y
CONFIG_PACKAGE_luci-app-pptp-server=y
# CONFIG_PACKAGE_luci-app-softethervpn=y

" >> .config


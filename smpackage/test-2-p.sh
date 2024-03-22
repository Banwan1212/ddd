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

mkdir ddd
pushd ddd
git clone --depth=1 https://github.com/Banwan1212/openwrt-packages .
popd
mkdir package/community
pushd package/community

# 文件助手
mkdir filebrowser
mkdir luci-app-filebrowser
cp -rf ../../ddd/filebrowser/* filebrowser
cp -rf ../../ddd/luci-app-filebrowser/* luci-app-filebrowser


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

# 文件助手
CONFIG_PACKAGE_filebrowser=y
CONFIG_PACKAGE_luci-app-filebrowser=y




" >> .config


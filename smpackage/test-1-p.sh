#!/bin/bash
# =================================================================
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# =================================================================

# Modify default IP
# sed -i 's/192.168.1.1/192.168.1.82/g' package/base-files/files/bin/config_generate
# 静态 to DHCP
sed -i 's/-static/-dhcp/g' package/base-files/files/lib/functions/uci-defaults.sh
sed -i 's/none/dhcp/g' package/base-files/files/bin/config_generate

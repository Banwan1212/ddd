# 切换固件版本
sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=6.1/g' ./target/linux/x86/Makefile \
sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=6.1/g' ./target/linux/x86/Makefile 
# 使用自定义openclash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
# onecloud
CONFIG_TARGET_at91=y \
CONFIG_TARGET_at91_sama5=y \
CONFIG_TARGET_at91_sama5_DEVICE_microchip_sama5d3-xplained=y \
CONFIG_AT91_DFBOOT=y \
CONFIG_TARGET_IMAGES_GZIP=y \
CONFIG_TARGET_INITRAMFS_COMPRESSION_NONE=y \
CONFIG_TARGET_ROOTFS_INITRAMFS=y \
CONFIG_TARGET_ROOTFS_PARTSIZE=1024

# 切换固件版本
sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=6.1/g' ./target/linux/x86/Makefile
sed -i 's/KERNEL_PATCHVER:=5.10/KERNEL_PATCHVER:=6.1/g' ./target/linux/x86/Makefile

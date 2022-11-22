#!/bin/sh

KERNEL=$1
PATCHVER=$2

[ -z "$1" -o -z "$2" ] && {
	echo "usage: refresh_kernel.sh <version> <release>"
	echo "example: refresh_kernel.sh 3.18 3.18.30"
	exit 1
}
targets=$(ls -b target/linux)

for target in $targets; do
	if [ "$target" = "generic" -o -f "$target" ]; then
		continue
	fi

	grep -q "broken" target/linux/$target/Makefile && { \
		echo "Skipping $target (broken)"
		continue
	}

	if [ -e tmp/${target}_${PATCHVER}_done ]; then
		continue
	fi

	grep -q "${KERNEL}" target/linux/$target/Makefile || \
	[ -f target/linux/$target/config-${KERNEL} ] || \
	[ -d target/linux/$target/patches-${KERNEL} ] && {
		echo "refreshing $target ..."
		echo "CONFIG_TARGET_$target=y" > .config
		echo "CONFIG_ALL_KMODS=y" >> .config
		make defconfig KERNEL_PATCHVER=${KERNEL}
		# ensure patches still apply
		make target/linux/refresh V=99 KERNEL_PATCHVER=${KERNEL} LINUX_VERSION=${PATCHVER} || exit 1
		# check for newly added kernel config symbols
		make target/linux/prepare V=99 KERNEL_PATCHVER=${KERNEL} LINUX_VERSION=${PATCHVER} || exit 1
		# don't clutter the build_dir/
		make target/linux/clean
		touch tmp/${target}_${PATCHVER}_done
	} || {
		echo "skipping $target (no support for $1)"
	}
done

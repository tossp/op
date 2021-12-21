#!/bin/bash
# AutoBuild Module by Hyy2001 <https://github.com/Hyy2001X/AutoBuild-Actions>
# AutoBuild DiyScript

Firmware_Diy_Core() {
	Author=TossP
	Author_URL="https://nas.tossp.com"
	Default_FLAG=AUTO
	Default_IP="192.168.9.1"
	Banner_Message="Powered by TossP.com"

	Short_Firmware_Date=true
	Checkout_Virtual_Images=true
	Firmware_Format=AUTO
	REGEX_Skip_Checkout="packages|buildinfo|sha256sums|manifest|kernel|rootfs|factory"

	INCLUDE_AutoBuild_Features=true
	INCLUDE_DRM_I915=false
	INCLUDE_Original_OpenWrt_Compatible=true
}

Firmware-Diy() {

	# 部分可调用变量如下
	# OP_Maintainer		源码作者
	# OP_REPO_NAME		仓库名称
	# OP_BRANCH		源码分支
	# TARGET_PROFILE	设备名称
	# TARGET_BOARD		设备架构

	# CustomFiles		仓库 /CustomFiles 绝对路径
	# Scripts		仓库 /Scripts 绝对路径
	# Home			源码存放绝对路径,等同 ${GITHUB_WORKSPACE}/openwrt
	# feeds_luci		绝对路径,等同 ${GITHUB_WORKSPACE}/openwrt/package/feeds/luci
	# feeds_pkgs		绝对路径,等同 ${GITHUB_WORKSPACE}/openwrt/package/feeds/packages
	# base_files		绝对路径,等同 ${GITHUB_WORKSPACE}/openwrt/package/base-files/files

	case "${OP_Maintainer}/${OP_REPO_NAME}:${OP_BRANCH}" in
	coolsnowwolf/lede:master)
		sed -i "s?/bin/login?/usr/libexec/login.sh?g" ${feeds_pkgs}/ttyd/files/ttyd.config
	;;
	esac

	case "${TARGET_PROFILE}" in
	d-team_newifi-d2)
		patch -i ${CustomFiles}/mac80211_d-team_newifi-d2.patch package/kernel/mac80211/files/lib/wifi/mac80211.sh
		Copy ${CustomFiles}/system_d-team_newifi-d2 ${base_files}/etc/config system
		[[ ${OP_REPO_NAME} == lede ]] && sed -i "/DEVICE_COMPAT_VERSION := 1.1/d" target/linux/ramips/image/mt7621.mk
	;;
	esac

}


print_infomation() {
    ui_print "-Modules Name: AutoADBShell"
    ui_print "--------------------------------"
    ui_print "-Magisk Version: ${MAGISK_VER}"
    ui_print "--------------------------------"
    ui_print "-Magisk Version Code: ${MAGISK_VER_CODE}"
    ui_print "--------------------------------"
    ui_print "-Author: github@K0baya"
    ui_print "--------------------------------"
}

detect_arch() {
    ARCH=$(getprop ro.product.cpu.abi)
    ui_print "-Detected Architecture: ${ARCH}"
    case "$ARCH" in
        arm64-v8a)
        ui_print "Using aarch64 binaries"
        mv -f $MODPATH/adb_bin/usr-aarch64 $MODPATH/usr
        set_perm_recursive $MODPATH 0 0 0755 0644
        set_perm_recursive $MODPATH/usr 0 0 0755 0755
        rm -rf $MODPATH/adb_bin
        ;;
        armeabi-v7a)
        ui_print "Using arm binaries"
        mv -f $MODPATH/adb_bin/usr-arm $MODPATH/usr
        set_perm_recursive $MODPATH 0 0 0755 0644
        set_perm_recursive $MODPATH/usr 0 0 0755 0755
        rm -rf $MODPATH/adb_bin
        ;;
        x86_64)
        ui_print "Using x86_64 binaries"
        mv -f $MODPATH/adb_bin/usr-x86_64 $MODPATH/usr
        set_perm_recursive $MODPATH 0 0 0755 0644
        set_perm_recursive $MODPATH/usr 0 0 0755 0755
        rm -rf $MODPATH/adb_bin
        ;;
        x86)
        ui_print "Using x86 binaries"
        mv -f $MODPATH/adb_bin/usr-x86 $MODPATH/usr
        set_perm_recursive $MODPATH 0 0 0755 0644
        set_perm_recursive $MODPATH/usr 0 0 0755 0755
        rm -rf $MODPATH/adb_bin
        ;;
        *)
        rm -rf $MODPATH
        abort "Unsupported architecture: ${ARCH}"
        ;;
    esac
}

print_infomation
ui_print
detect_arch
ui_print "--------------------------------"
ui_print "-Welcome to AutoADBShell"
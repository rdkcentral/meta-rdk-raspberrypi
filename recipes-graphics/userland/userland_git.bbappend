SRC_URI_remove = "git://github.com/${SRCFORK}/userland.git;protocol=git;branch=${SRCBRANCH}"
SRC_URI += "git://github.com/${SRCFORK}/userland.git;protocol=https;branch=${SRCBRANCH}"

DEPENDS += "freetype"

CFLAGS_append = "\
    -I${PKG_CONFIG_SYSROOT_DIR}/usr/include/freetype2 \
    -I${PKG_CONFIG_SYSROOT_DIR}/usr/include/ \
    -I${S} \
    -I${S}/interface/khronos/include \
    -I${S}/interface/vcos/pthreads \
    -I${S}/host_applications/linux/libs/bcm_host/include \
    -I${S}/interface/vmcs_host/linux \
"

LDFLAGS_append = "\
    ${PKG_CONFIG_SYSROOT_DIR}/lib/libpthread.so.0 \
    -L${PKG_CONFIG_SYSROOT_DIR}/usr/lib \
    -L${PKG_CONFIG_SYSROOT_DIR}/lib \
"

do_compile_append(){
    oe_runmake -C ${S}/host_applications/linux/apps/hello_pi/libs/vgfont
}

do_install_append(){
    install -d ${D}${libdir}
    install -d ${D}${includedir}
    install -m 644 ${S}/host_applications/linux/apps/hello_pi/libs/vgfont/vgfont.h ${D}${includedir}
    install -m 644 ${S}/host_applications/linux/apps/hello_pi/libs/vgfont/libvgfont.a ${D}${libdir}
}

FILES_${PN}_append = "\
    ${includedir}/vgfont.h \
    ${libdir}/libvgfont.a \
"

# no EGL runtime providers for vc4graphics
RPROVIDES_${PN}_remove = "${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', 'libegl', '', d)}"

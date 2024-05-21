SUMMARY = "Custom package group for vendor layer"

LICENSE = "MIT"

PACKAGE_ARCH = "${VENDOR_LAYER_EXTENSION}"

inherit packagegroup
inherit versioned-packagegroup-install-support

DEPENDS = " virtual/kernel make-mod-scripts"

PV = "1.0.0"
PR = "r0"

RDEPENDS_${PN} = "\
        westeros-soc-drm \
        "

# Include MACHINE specific packagegroup.
RDEPENDS_${PN}:append:raspberrypi4 = " \
        packagegroup-kernel-modules-raspberrypi4 \
        packagegroup-hal-raspberrypi4 \
        "

# These packages shall be moved to OSS layer in future.
RDEPENDS_${PN}:append:rdkv-oss = "\
        cairo \
        gstreamer1.0 \
        gstreamer1.0-libav \
        gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-bad \
	westeros-simplebuffer \
        westeros-simpleshell \
        westeros \
        essos \
        westeros-sink \
        libepoxy \
        libdrm \
        librsvg \
        mpg123 \
        pango \
        "

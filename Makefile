INSTALL_TARGET_PROCESSES = SpringBoard

ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
export ARCHS = arm64 arm64e
export TARGET = iphone:clang:14.5:15.0
else
export ARCHS = armv7 armv7s arm64 arm64e
export TARGET = iphone:clang:14.5:8.0
endif

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = KeyboardController

$(TWEAK_NAME)_FILES = $(TWEAK_NAME).xm
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_LIBRARIES = MobileGestalt

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += KeyboardControllerSettings
include $(THEOS_MAKE_PATH)/aggregate.mk

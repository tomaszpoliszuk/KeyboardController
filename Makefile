FINALPACKAGE = 1
DEBUG = 0

INSTALL_TARGET_PROCESSES = SpringBoard

ARCHS = armv7 armv7s arm64 arm64e
TARGET = iphone:clang::9

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = KeyboardController

$(TWEAK_NAME)_FILES = $(TWEAK_NAME).xm
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_LIBRARIES = MobileGestalt


include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += KeyboardControllerSettings
include $(THEOS_MAKE_PATH)/aggregate.mk

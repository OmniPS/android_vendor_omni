# Versioning of the ROM

ifndef ROM_BUILDTYPE
    ROM_BUILDTYPE := HOMEMADE
endif

TARGET_PRODUCT_SHORT := $(TARGET_PRODUCT)
TARGET_PRODUCT_SHORT := $(subst omnips_,,$(TARGET_PRODUCT_SHORT))

# Build the final version string
ifdef BUILDTYPE_RELEASE
    ROM_VERSION := $(PLATFORM_VERSION)-$(TARGET_PRODUCT_SHORT)
else
ifeq ($(ROM_BUILDTIME_UTC),y)
    ROM_VERSION := $(PLATFORM_VERSION)-$(shell date -u +%Y%m%d)-$(TARGET_PRODUCT_SHORT)-$(ROM_BUILDTYPE)
else
    ROM_VERSION := $(PLATFORM_VERSION)-$(shell date +%Y%m%d)-$(TARGET_PRODUCT_SHORT)-$(ROM_BUILDTYPE)
endif
endif

# Apply it to build.prop
PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=OmniPS-$(ROM_VERSION) \
    ro.omni.version=$(ROM_VERSION)

ROM_FINGERPRINT := OmniPS/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date +%Y%m%d)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.omni.fingerprint=$(ROM_FINGERPRINT)

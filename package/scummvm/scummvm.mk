################################################################################
#
# Scummvm
#
################################################################################

SCUMMVM_VERSION = 55cb41798af925c55a95c767ac686c52fdfbf26f
SCUMMVM_REPO = scummvm

SCUMMVM_SITE = $(call github,$(SCUMMVM_REPO),scummvm,$(SCUMMVM_VERSION))

SCUMMVM_LICENSE = GPL2
SCUMMVM_DEPENDENCIES = sdl2 zlib jpeg-turbo libmpeg2 libogg libvorbis flac libmad libpng libtheora \
	faad2 fluidsynth freetype 

SCUMMVM_ADDITIONAL_FLAGS= -I$(STAGING_DIR)/usr/include -I$(STAGING_DIR)/usr/include/interface/vcos/pthreads -I$(STAGING_DIR)/usr/include/interface/vmcs_host/linux -lpthread -lm -L$(STAGING_DIR)/usr/lib -lbcm_host -lGLESv2 -lEGL -lvchostif 

SCUMMVM_CONF_ENV += RANLIB="$(TARGET_RANLIB)" STRIP="$(TARGET_STRIP)" AR="$(TARGET_AR) cru" AS="$(TARGET_AS)"
SCUMMVM_CONF_OPTS += --enable-opengl --disable-debug --enable-optimizations --disable-mt32emu --enable-flac --enable-mad --enable-vorbis --disable-tremor \
		--disable-fluidsynth --disable-taskbar --disable-timidity --disable-alsa --enable-vkeybd --enable-keymapper \
                --prefix=/usr --host=raspberrypi --with-sdl-prefix="$(STAGING_DIR)/usr/bin/" --enable-release \

SCUMMVM_MAKE_OPTS += RANLIB="$(TARGET_RANLIB)" STRIP="$(TARGET_STRIP)" AR="$(TARGET_AR) cru" AS="$(TARGET_AS)" LD="$(TARGET_CXX)"

define SCUMMVM_ADD_VIRTUAL_KEYBOARD
	cp $(@D)/backends/vkeybd/packs/vkeybd_default.zip $(TARGET_DIR)/usr/share/scummvm
	cp $(@D)/backends/vkeybd/packs/vkeybd_small.zip $(TARGET_DIR)/usr/share/scummvm
endef

SCUMMVM_POST_INSTALL_TARGET_HOOKS += SCUMMVM_ADD_VIRTUAL_KEYBOARD

#define SCUMMVM_ADD_EXECUTABLE
#	$(SED) "s|RANLIB := ranlib|RANLIB 
#STRIP := strip
#AR := ar cru
#AS := as

#SCUMMVM_POST_CONFIGURE_HOOKS += SCUMMVM_ADD_EXECUTABLES
$(eval $(autotools-package))

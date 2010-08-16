# Makefile for iPhone Application for Xcode gcc compiler (SDK Headers)

PROJECTNAME=iAUM
APPFOLDER=$(PROJECTNAME).app
INSTALLFOLDER=$(PROJECTNAME).app

IPHONE_IP=192.168.0.12
SDKVER=4.0
SDKMINVER=3.1
DARWINVER=10
GCCVER=4.2.1
HARDWARE_PLATFORM=/Developer/Platforms/iPhoneOS.platform/Developer
SIMULATOR_PLATFORM=/Developer/Platforms/iPhoneSimulator.platform/Developer
SDK=$(HARDWARE_PLATFORM)/SDKs/iPhoneOS$(SDKVER).sdk

CC=$(HARDWARE_PLATFORM)/usr/bin/arm-apple-darwin$(DARWINVER)-gcc-$(GCCVER)
CPP=$(HARDWARE_PLATFORM)/usr/bin/arm-apple-darwin$(DARWINVER)-g++-$(GCCVER)
LD=$(CC)

#LDFLAGS += -framework CoreFoundation
LDFLAGS += -framework Foundation
LDFLAGS += -framework UIKit
LDFLAGS += -framework CoreGraphics
#LDFLAGS += -framework AddressBookUI
#LDFLAGS += -framework AddressBook
LDFLAGS += -framework QuartzCore
#LDFLAGS += -framework GraphicsServices
#LDFLAGS += -framework CoreSurface
#LDFLAGS += -framework CoreAudio
#LDFLAGS += -framework Celestial
#LDFLAGS += -framework AudioToolbox
#LDFLAGS += -framework WebCore
#LDFLAGS += -framework WebKit
LDFLAGS += -framework SystemConfiguration
LDFLAGS += -framework CFNetwork
#LDFLAGS += -framework MediaPlayer
#LDFLAGS += -framework OpenGLES
#LDFLAGS += -framework OpenAL
LDFLAGS += -framework MobileCoreServices

LDFLAGS += -lz
LDFLAGS += -lSystem

LDFLAGS += -L"$(SDK)/usr/lib"
LDFLAGS += -F"$(SDK)/System/Library/Frameworks"
LDFLAGS += -F"$(SDK)/System/Library/PrivateFrameworks"

CFLAGS += -I"."
CFLAGS += -I"Classes"
CFLAGS += -I"Classes/JSON/"
CFLAGS += -I"$(HARDWARE_PLATFORM)/usr/lib/gcc/arm-apple-darwin$(DARWINVER)/$(GCCVER)/include/"
CFLAGS += -I"$(SDK)/usr/include"
CFLAGS += -I"$(HARDWARE_PLATFORM)/usr/include/"
CFLAGS += -I"$(SIMULATOR_PLATFORM)/SDKs/iPhoneSimulator$(SDKVER).sdk/usr/include"
#CFLAGS += -DDEBUG
CFLAGS += -std=c99
CFLAGS += -DTARGET_OS_IPHONE
CFLAGS += -Diphoneos_version_min=$(SDKMINVER)
CFLAGS += -F"$(SDK)/System/Library/Frameworks"
CFLAGS += -F"$(SDK)/System/Library/PrivateFrameworks"
CFLAGS += -O3
CPPFLAGS=$CFLAGS

BUILDDIR=./build/$(SDKVER)
SRCDIR=.
RESOURCES= *.png icons/*.png
RESDIR=./Resources
OBJS=$(patsubst %.m,%.o,$(wildcard $(SRCDIR)/*.m))
OBJS+=$(patsubst %.m,%.o,$(wildcard $(SRCDIR)/Classes/*.m))
OBJS+=$(patsubst %.m,%.o,$(wildcard $(SRCDIR)/Classes/JSON/*.m))
OBJS+=$(patsubst %.c,%.o,$(wildcard $(SRCDIR)/*.c))
OBJS+=$(patsubst %.cpp,%.o,$(wildcard $(SRCDIR)/*.cpp))
OBJS+=$(patsubst %.m,%.o,$(wildcard *.m))
PCH=$(wildcard *.pch)
#RESOURCES=$(wildcard $(RESDIR)/*)
#NIBS=$(patsubst %.xib,%.nib,$(wildcard IBFiles/*.xib))

all:	$(PROJECTNAME)

$(PROJECTNAME):	$(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^ 

%.o:	%.m
	$(CC) -c $(CFLAGS) $< -o $@

%.o:	%.c
	$(CC) -c $(CFLAGS) $< -o $@

%.o:	%.cpp
	$(CPP) -c $(CPPFLAGS) $< -o $@

%.nib:	%.xib
	ibtool $< --compile $@

ipa: dist
	mkdir -p $(BUILDDIR)/ipa/Payload
	cp ItunesArtwork.png $(BUILDDIR)/ipa/ItunesArtwork
	cp -r $(BUILDDIR)/$(APPFOLDER) $(BUILDDIR)/ipa/Payload/
	cd $(BUILDDIR)/ipa && zip -r ../$(PROJECTNAME).ipa *

dist:	$(PROJECTNAME)
	rm -rf $(BUILDDIR)
	mkdir -p $(BUILDDIR)/$(APPFOLDER)
	cp -r $(RESOURCES) $(BUILDDIR)/$(APPFOLDER)
	cp Info.simu.plist $(BUILDDIR)/$(APPFOLDER)/Info.plist
	@echo "APPL????" > $(BUILDDIR)/$(APPFOLDER)/PkgInfo
#	mv $(NIBS) $(BUILDDIR)/$(APPFOLDER)
#	export CODESIGN_ALLOCATE=$(HARDWARE_PLATFORM)/usr/bin/codesign_allocate; ./ldid_intel -S $(PROJECTNAME)
	mv $(PROJECTNAME) $(BUILDDIR)/$(APPFOLDER)

install: ipa
	scp -r $(BUILDDIR)/$(PROJECTNAME).ipa root@$(IPHONE_IP):/private/var/mobile/Documents/Installous/Downloads
	@echo "Application $(INSTALLFOLDER) installed, please respring iPhone"
	#ssh root@$(IPHONE_IP) 'respring'

uninstall:
	ssh root@$(IPHONE_IP) 'rm -fr /Applications/$(INSTALLFOLDER); respring'
	@echo "Application $(INSTALLFOLDER) uninstalled, please respring iPhone"

install_respring:
	scp respring_arm root@$(IPHONE_IP):/usr/bin/respring

clean:
	@rm -f $(SRCDIR)/*.o $(SRCDIR)/Classes/*.o $(SRCDIR)/Classes/External/*.o $(SRCDIR)/Classes/External/ASI/*.o $(SRCDIR)/Classes/External/JSON/*.o $(SRCDIR)/Classes/Extensions/*.o *.o
	@rm -rf $(BUILDDIR)
	@rm -f $(PROJECTNAME)


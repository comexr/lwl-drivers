.PHONY: all clean install dkmsinstall dkmsremove package package-deb package-rpm

PWD := $(shell pwd)
KDIR := /lib/modules/$(shell uname -r)/build

PACKAGE_NAME := $(shell grep -Pom1 '.*(?= \(.*\) .*; urgency=.*)' debian/changelog)
PACKAGE_VERSION := $(shell grep -Pom1 '.* \(\K.*(?=\) .*; urgency=.*)' debian/changelog)

all:
	make -C $(KDIR) M=$(PWD) $(MAKEFLAGS) modules

clean:
	rm -f src/dkms.conf
	rm -f lwl-drivers.spec
	rm -f $(PACKAGE_NAME)-*.tar.gz
	rm -rf debian/.debhelper
	rm -f debian/*.debhelper
	rm -f debian/*.debhelper.log
	rm -f debian/*.substvars
	rm -f debian/debhelper-build-stamp
	rm -f debian/files
	rm -rf debian/lwl-drivers
	rm -rf debian/lwl-cc-wmi
	rm -rf debian/lwl-keyboard
	rm -rf debian/lwl-keyboard-dkms
	rm -rf debian/lwl-keyboard-ite
	rm -rf debian/lwl-touchpad-fix
	rm -rf debian/lwl-wmi-dkms
	rm -rf debian/lwl-xp-xc-airplane-mode-fix
	rm -rf debian/lwl-xp-xc-touchpad-key-fix
	make -C $(KDIR) M=$(PWD) $(MAKEFLAGS) clean

install:
	make -C $(KDIR) M=$(PWD) $(MAKEFLAGS) modules_install

dkmsinstall:
	sed 's/#MODULE_VERSION#/$(PACKAGE_VERSION)/' debian/lwl-drivers.dkms > src/dkms.conf
	if ! [ "$(shell dkms status -m lwl-drivers -v $(PACKAGE_VERSION))" = "" ]; then dkms remove $(PACKAGE_NAME)/$(PACKAGE_VERSION); fi
	rm -rf /usr/src/$(PACKAGE_NAME)-$(PACKAGE_VERSION)
	rsync --recursive --exclude=*.cmd --exclude=*.d --exclude=*.ko --exclude=*.mod --exclude=*.mod.c --exclude=*.o --exclude=modules.order src/ /usr/src/$(PACKAGE_NAME)-$(PACKAGE_VERSION)
	dkms install $(PACKAGE_NAME)/$(PACKAGE_VERSION)

dkmsremove:
	dkms remove $(PACKAGE_NAME)/$(PACKAGE_VERSION) --all
	rm -rf /usr/src/$(PACKAGE_NAME)-$(PACKAGE_VERSION)

package: package-deb package-rpm

package-deb:
	debuild --no-sign

package-rpm:
	sed 's/#MODULE_VERSION#/$(PACKAGE_VERSION)/' debian/lwl-drivers.dkms > src/dkms.conf
	sed 's/#MODULE_VERSION#/$(PACKAGE_VERSION)/' lwl-drivers.spec.in > lwl-drivers.spec
	echo >> lwl-drivers.spec
	./debian-changelog-to-rpm-changelog.awk debian/changelog >> lwl-drivers.spec
	mkdir -p $(shell rpm --eval "%{_sourcedir}")
	tar --create --file $(shell rpm --eval "%{_sourcedir}")/$(PACKAGE_NAME)-$(PACKAGE_VERSION).tar.xz\
		--transform="s/src/$(PACKAGE_NAME)-$(PACKAGE_VERSION)\/usr\/src\/$(PACKAGE_NAME)-$(PACKAGE_VERSION)/"\
		--transform="s/lwl_keyboard.conf/$(PACKAGE_NAME)-$(PACKAGE_VERSION)\/etc\/modprobe.d\/lwl_keyboard.conf/"\
		--transform="s/debian\/copyright/$(PACKAGE_NAME)-$(PACKAGE_VERSION)\/LICENSE/"\
		--transform="s/99-z-lwl-systemd-fix.rules/$(PACKAGE_NAME)-$(PACKAGE_VERSION)\/usr\/lib\/udev\/rules.d\/99-z-lwl-systemd-fix.rules/"\
		--transform="s/99-infinityflex-touchpanel-toggle.rules/$(PACKAGE_NAME)-$(PACKAGE_VERSION)\/usr\/lib\/udev\/rules.d\/99-infinityflex-touchpanel-toggle.rules/"\
		--transform="s/61-sensor-infinityflex.hwdb/$(PACKAGE_NAME)-$(PACKAGE_VERSION)\/usr\/lib\/udev\/hwdb.d\/61-sensor-infinityflex.hwdb/"\
		--exclude=*.cmd\
		--exclude=*.d\
		--exclude=*.ko\
		--exclude=*.mod\
		--exclude=*.mod.c\
		--exclude=*.o\
		--exclude=modules.order\
		src lwl_keyboard.conf debian/copyright 99-z-lwl-systemd-fix.rules 99-infinityflex-touchpanel-toggle.rules 61-sensor-infinityflex.hwdb
	rpmbuild -ba lwl-drivers.spec

#!/bin/sh
set -e

dmi=$(cat /sys/class/dmi/id/product_name 2>/dev/null || echo "")
case "$dmi" in
  "V64x_V65xAU")
    mv /usr/lib/systemd/system/systemd-poweroff.service /usr/lib/systemd/system/systemd-poweroff.service.bak
    ln -s /usr/lib/systemd/system/systemd-hibernate.service \
           /usr/lib/systemd/system/systemd-poweroff.service
    ;;
esac

exit 0
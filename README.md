# Table of Content
- <a href="#description">Description</a>
- <a href="#building-and-install">Building and Install</a>
- <a href="#troubleshooting">Troubleshooting</a>
- <a href="#regarding-upstreaming-of-lwl-drivers">Regarding upstreaming of lwl-drivers</a>

# Description
Drivers for several platform devices for lwl notebooks meant for DKMS.

## Features implemented by this driver package
- Fn-keys
- Keyboard backlight
- Fan control
- Power control
- Other sensors
- Hardware specific userspace quirks

## Modules included in this package
- clevo_acpi
- clevo_wmi
- lwl_keyboard
- uniwill_wmi
- ite_8291
- ite_8291_lb
- ite_8297
- ite_829x
- lwl_io
- lwl_compatibility_check
- lwl_nb05_keyboard
- lwl_nb05_power_profiles
- lwl_nb05_ec
- lwl_nb05_sensors
- lwl_nb04_keyboard
- lwl_nb04_wmi_ab
- lwl_nb04_wmi_bs
- lwl_nb04_sensors
- lwl_nb04_power_profiles
- lwl_nb04_kbd_backlight
- lwl_nb05_kbd_backlight
- lwl_nb02_nvidia_power_ctrl
- lwl_nb05_fan_control
- tuxi_acpi
- lwl_tuxi_fan_control
- stk8321
- gxtp7380

# Building and Install

## Dependencies:
All:
- make

`make package-deb`:
- devscripts
- debhelper
- dh-dkms

`make package-rpm`:
- rpm

# Troubleshooting

## The keyboard backlight control and/or touchpad toggle key combinations do not work
For all devices with a touchpad toggle key(-combo) and some devices with keyboard backlight control key-combos the driver does nothing more then to send the corresponding key event to userspace where it is the desktop environments duty to carry out the action. Some smaller desktop environments however don't bind an action to these keys by default so it seems that these keys don't work.

Please refer to your desktop environments documentation on how to set custom keybindings to fix this.

For keyboard brightness control you should use the D-Bus interface of UPower as actions for the key presses.

For touchpad toggle on X11 you can use `xinput` to enable/disable the touchpad, on Wayland the correct way is desktop environment specific.

# Regarding upstreaming of lwl-drivers
The code, while perfectly functional, is currently not in an upstreamable state. That being said we started an upstreaming effort and the first small part, the keyboard backlight control for the Sirius 16 Gen 1 & 2, already got accepted.

If you want to hack away at this matter yourself please follow the following precautions and guidelines to avoid breakages on both software and hardware level:
- Involve us in the whole process. Nothing is won if at some point lwl-control-center or the dkms variant of lwl-drivers stops working. Especially when you send something to the LKML, please set us in the cc.
- We mostly can't share documentation, but we can answer questions.
- Code interacting with the EC, which is most of lwl-drivers, can brick devices and therefore must be ensured to only run on compatible and tested devices.
- If you use lwl-drivers as a reference or code snippets from it, a "Codeveloped-by:\<name\> \<lwl_email\>" must be included in your upstream commit, with \<name\> and \<lwl_email\> depending on the actual part of lwl-drivers being used. Please talk to us regarding this.

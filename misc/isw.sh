if [[ $EUID -ne 0 ]]; then
	echo "Failed:Run as root!"
	exit
fi
_isw_conf=/etc/isw.conf
cat >"$_isw_conf" <<EOF
[16Q4EMS1]
# GS65_8SE GS65_8SF GS65_8SG GS65_9SD GS65_9SE GS65_9SF GS65_9SG
# 16Q4EMS1.109
address_profile = MSI_ADDRESS_DEFAULT
fan_mode = 140
battery_charging_threshold = 60
# CPU
cpu_temp_0 = 55
cpu_temp_1 = 64
cpu_temp_2 = 70
cpu_temp_3 = 76
cpu_temp_4 = 82
cpu_temp_5 = 88
cpu_fan_speed_0 = 45
cpu_fan_speed_1 = 50
cpu_fan_speed_2 = 60
cpu_fan_speed_3 = 70
cpu_fan_speed_4 = 75
cpu_fan_speed_5 = 80
cpu_fan_speed_6 = 80
# GPU
gpu_temp_0 = 55
gpu_temp_1 = 61
gpu_temp_2 = 65
gpu_temp_3 = 71
gpu_temp_4 = 77
gpu_temp_5 = 86
gpu_fan_speed_0 = 0
gpu_fan_speed_1 = 50
gpu_fan_speed_2 = 60
gpu_fan_speed_3 = 70
gpu_fan_speed_4 = 80
gpu_fan_speed_5 = 90
gpu_fan_speed_6 = 90

[COOLER_BOOST]
address_profile = MSI_ADDRESS_DEFAULT
cooler_boost_off = 0
cooler_boost_on = 128

[USB_BACKLIGHT]
address_profile = MSI_ADDRESS_DEFAULT
usb_backlight_off = 128
usb_backlight_half = 193
usb_backlight_full = 129
[MSI_ADDRESS_DEFAULT]
address_profile = MSI_ADDRESS_DEFAULT
fan_mode_address = 0xf4
cooler_boost_address = 0x98
usb_backlight_address = 0xf7
battery_charging_threshold_address = 0xef
# CPU
cpu_temp_address_0 = 0x6a
cpu_temp_address_1 = 0x6b
cpu_temp_address_2 = 0x6c
cpu_temp_address_3 = 0x6d
cpu_temp_address_4 = 0x6e
cpu_temp_address_5 = 0x6f
cpu_fan_speed_address_0 = 0x72
cpu_fan_speed_address_1 = 0x73
cpu_fan_speed_address_2 = 0x74
cpu_fan_speed_address_3 = 0x75
cpu_fan_speed_address_4 = 0x76
cpu_fan_speed_address_5 = 0x77
cpu_fan_speed_address_6 = 0x78
realtime_cpu_temp_address = 0x68
realtime_cpu_fan_speed_address = 0x71
realtime_cpu_fan_rpm_address = 0xcc
# GPU
gpu_temp_address_0 = 0x82
gpu_temp_address_1 = 0x83
gpu_temp_address_2 = 0x84
gpu_temp_address_3 = 0x85
gpu_temp_address_4 = 0x86
gpu_temp_address_5 = 0x87
gpu_fan_speed_address_0 = 0x8a
gpu_fan_speed_address_1 = 0x8b
gpu_fan_speed_address_2 = 0x8c
gpu_fan_speed_address_3 = 0x8d
gpu_fan_speed_address_4 = 0x8e
gpu_fan_speed_address_5 = 0x8f
gpu_fan_speed_address_6 = 0x90
realtime_gpu_temp_address = 0x80
realtime_gpu_fan_speed_address = 0x89
realtime_gpu_fan_rpm_address = 0xca
EOF
systemctl enable isw@16Q4EMS1.service

function __launch_hpld
    exec env __NV_PRIME_RENDER_OFFLOAD=0 Hyprland >.hyprlog.txt 2>hyprerr.txt
end

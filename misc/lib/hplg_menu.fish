if status is-login
    if test $XDG_VTNR = 1
        if test -z $PCP_LOGIN_TTY
            and test -z $DISPLAY
            __launch_hpld
        else
            set fish_greeting
            printf "0)Hyprland\n1)Reset Hyprland\n2)VR Hyprland\nr)reboot\nx)Poweroff\n..) TTY\n"
            read -n 1 -P "" mchoice
            switch $mchoice
                case 0
                    __launch_hpld
                case 1
                    pcp_cmd restore_gpu
                    pcp_cmd vrboot 0
                    __launch_hpld
                case 2
                    pcp_cmd vrboot 1
                    ln -sf "$HOME/.config/hypr/lib/GPU/3NvidiaFirst.conf" "$HOME/.config/hypr/configs/GPU.conf"
                    ln -sf "$HOME/.config/hypr/lib/Monitor/4VRWide.conf" "$HOME/.config/hypr/configs/Monitors.conf"
                    __launch_hpld
                case r
                    reboot
                case x
                    poweroff
                case '*'
                    echo TTY
            end
        end
    end
end

default:
	just -l
init_pcmds:
	ln -si $(realpath ./pcmds/lib/profile/kitty.sh) ./pcmds/lib/term.sh
	ln -si $(realpath ./pcmds/lib/themes/catppuccin.sh) ./pcmds/lib/current_theme.sh
link_bin:
	ln -si $(realpath ./bin/pcmds.sh) $XDG_BIN_HOME/pcmds
	ln -si $(realpath ./bin/Xmenu.sh) $XDG_BIN_HOME/Xmenu
init_hypr_var:
  mkdir -p ~/.cache/pcp_hypr_var

init_gui_config:
	export DIDM_TARGET_HOME="$HOME";DidM deploy gui

init_git:
	./Install/init_git.sh
init_tide:
	fish -c 'tide configure --auto --style=Lean --prompt_colors="16 colors" --show_time="24-hour format" --lean_prompt_height="Two lines" --prompt_connection=Disconnected --prompt_spacing=Compact --icons="Many icons" --transient=Yes'
init_nvim:
	git clone https://github.com/postcyberpunk/nvim ~/.config/nvim

inti_misc:
	bat cache --build

init_icon:
	mkdir -p /tmp/CatIcon
	git clone --depth=1 -b mocha "https://github.com/PostCyberPunk/Catppuccin-GTK-Theme" /tmp/CatIcon
	mkdir -p ~/.icons
	mv /tmp/CatIcon/Catppuccin-Mocha ~/.icons/
	rm -rf /tmp/CatIcon

init_all:
	(init_pcmds)
	(init_bin)
	(init_hypr_var)

	(init_gui_config)
	(init_git)

	(init_tide)
	(init_nvim)

# tests
test_gui_config:
	export DIDM_TARGET_HOME="$HOME/fakehome";DidM deploy gui
test_github:
	ssh -T git@github.com
# just a note
init_rbw:
	rbw register


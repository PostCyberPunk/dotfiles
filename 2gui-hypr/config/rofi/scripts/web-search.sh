#!/bin/bash

declare -A menu_options=(
	["ba baidu"]="https://www.baidu.com/s?&wd="
	["gg google"]="https://www.google.com/search?q="
	["nxp nix pkgs"]="https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query="
	["nxo nix options"]="https://search.nixos.org/options?channel=unstable&size=50&sort=relevance&type=options&query="
	["nog nixsearch"]="https://noogle.dev/q?term="
	["ghh github"]="https://github.com/search?q="
	["dg duckduckgo"]="https://duckduckgo.com/?t=h_&q="
	["wk wikipedia"]="https://en.wikipedia.org/w/index.php?search="
	["bi bing "]="https://www.bing.com/search?q="
	["sof stackoverflow"]="http://stackoverflow.com/search?q="
	["sc searchcode"]="https://searchcode.com/?q="
	["ytb youtube"]="https://www.youtube.com/results?search_query="
	["bl bilibili"]="https://search.bilibili.com/all?keyword="
	["dbm"]="https://search.douban.com/movie/subject_search?search_text="
	["dbb"]="https://search.douban.com/book/subject_search?search_text="
	["aps"]="https://archlinux.org/packages/?sort=&q="
	["aps"]="https://archlinux.org/packages/?sort=&q="
	["aur"]="https://aur.archlinux.org/packages?O=0&K="
	["awk"]="https://wiki.archlinux.org/index.php?search="
	["qrf"]="https://www.google.com.hk/search?q=site%3Aquickref.me+"
	["ghc"]="https://github.com/copilot/"
	["ghs"]="https://github.com/PostCyberPunk?tab=stars&q="
	["ghr"]="https://github.com/PostCyberPunk?tab=repositories&q="
)

main() {
	choice=$(
		printf "%s\n" "${!menu_options[@]}" |
			rofi -dmenu -config ~/.config/rofi/config-long.rasi \
				-p "Rofi" \
				-mesg "Hello" \
				-max-history-size 0 \
				-auto-select
	)

	if [ -z "$choice" ]; then
		exit 1
	fi

	engine="${menu_options[$choice]}"
	ctx=$(echo "$choice" | rofi -dmenu -config ~/.config/rofi/tools/cmd.rasi)
	[ "$ctx" = "$choice" ] && ctx=""
	xdg-open "$engine""$ctx"
}

main

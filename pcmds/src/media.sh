#!/bin/bash

# Play the next track
play_next() {
	playerctl next
	show_music_notification
}

# Play the previous track
play_previous() {
	playerctl previous
	show_music_notification
}

# Toggle play/pause
toggle_play_pause() {
	playerctl play-pause
	show_music_notification
}

# Stop playback
stop_playback() {
	playerctl stop
	notify-send -r 123 "Playback Stopped"
}

# Display Dunst notification with song information
show_music_notification() {
	status=$(playerctl status)
	if [[ "$status" == "Playing" ]]; then
		song_title=$(playerctl metadata title)
		song_artist=$(playerctl metadata artist)
		notify-send -r 123 "Now Playing:" "$song_title\nby $song_artist"
	elif [[ "$status" == "Paused" ]]; then
		notify-send -r 123 "Playback Paused"
	fi
}

#!/usr/bin/env bash
set -euo pipefail

map_name() {
	local n="${1,,}"
	if [[ "$n" == *mozc* ]]; then
		printf 'ime|Japanese (Mozc)\n'
	elif [[ "$n" == keyboard-jp* || "$n" == *japanese* || "$n" == *jp* ]]; then
		printf 'jp|Keyboard (JP)\n'
	elif [[ "$n" == keyboard-us* || "$n" == *english* || "$n" == *us* ]]; then
		printf 'us|Keyboard (US)\n'
	else
		printf 'us|Keyboard (%s)\n' "$1"
	fi
}

emit() {
	local cls="${1%%|*}"
	local txt="${1#*|}"
	printf '{"text":"%s","class":"%s"}\n' "$txt" "$cls"
}

if command -v fcitx5-remote >/dev/null 2>&1 && pgrep -x fcitx5 >/dev/null 2>&1; then
	cur="$(fcitx5-remote -n 2>/dev/null || true)"
	state="$(map_name "${cur:-keyboard-us}")"
	emit "$state"
	while :; do
		fcitx5-remote -w >/dev/null 2>&1 || sleep 0.05
		cur="$(fcitx5-remote -n 2>/dev/null || true)"
		new="$(map_name "${cur:-keyboard-us}")"
		if [[ "$new" != "$state" ]]; then
			state="$new"
			emit "$state"
		fi
	done
else
	prev=""
	emit "$(map_name keyboard-us)"
	hyprctl -m 2>/dev/null | while read -r _; do
		keymap="$(hyprctl devices -j 2>/dev/null | sed -n 's/.*"active_keymap":"\([^"]*\)".*/\1/p' | head -n1 || true)"
		[[ -z "$keymap" ]] && keymap="keyboard-us"
		new="$(map_name "$keymap")"
		if [[ "$new" != "$prev" ]]; then
			prev="$new"
			emit "$new"
		fi
	done
fi

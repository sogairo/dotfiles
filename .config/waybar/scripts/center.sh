#!/usr/bin/env bash

playerctl -p %any -F metadata --format '{{artist}} - {{title}} - {{status}}' 2>/dev/null \
| while IFS= read -r line; do
    status="${line##* - }"
    text="${line% - *}"
    if [ "$status" = "Playing" ] && [ -n "$text" ]; then
        jq -n -c --arg text "$text" --arg alt "playing" --arg class "playing" \
            '{text:$text, alt:$alt, class:$class}'
    else
         jq -n -c '{"text":"","alt":"","class":""}'
    fi
done

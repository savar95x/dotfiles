#!/bin/sh
# monocle_fs_watch.sh - keep the bar in sync with the focused tag.
#
# The bar (waybar) is a single global surface, but monocle fullscreen is a
# per tag mode. This watcher bridges the two: it follows the focused tag and
# hides the bar while that tag is in monocle fullscreen, and brings the bar
# back on every other tag.
#
# It works by subscribing to mango's IPC:
#   mmsg watch all-monitors
# streams the state of every monitor on each change (tag switch, layout
# change, window opened/closed, ...) - among it the focused monitor, its
# active tag and the layout of every tag. For the focused tag the watcher
# asks scripts/bar.sh to reconcile the bar with that state.
#
# Started from autostart.sh. If mango is restarted the subscription dies and
# the watcher reconnects a second later.
#
# Only one watcher should run: autostart.sh kills the old one before
# starting a new one.

BAR_SH="$(dirname "$0")/bar.sh"

# mango exports the path of its IPC socket into the environment of the
# processes it spawns. When the watcher is started by hand, pick the newest
# socket instead.
if [ -z "${MANGO_INSTANCE_SIGNATURE:-}" ]; then
	for sock in "${XDG_RUNTIME_DIR:-$HOME/.local/run}"/mango-*.sock; do
		[ -S "$sock" ] || continue
		export MANGO_INSTANCE_SIGNATURE="$sock"
	done
fi

while :; do
	mmsg watch all-monitors 2>/dev/null |
		while IFS= read -r line; do
			# "<monitor>:<tag> <layout symbol>" of the focused monitor
			info=$(printf '%s' "$line" | jq -r '
				.monitors[] | select(.active) as $m
				| ($m.active_tags[0]) as $t
				| "\($m.name):\($t) \($m.tags[] | select(.index == $t) | .layout)"' 2>/dev/null)

			key=${info%% *}
			symbol=${info##* }
			[ -n "$key" ] && "$BAR_SH" apply "$key" "$symbol"
		done

	# mango went away (restart?) - wait and subscribe again
	sleep 1
done

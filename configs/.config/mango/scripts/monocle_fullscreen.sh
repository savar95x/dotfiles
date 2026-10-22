#!/bin/sh
# monocle_fullscreen.sh - toggle "monocle fullscreen" for the current tag.
#
# Entering: remember the tag's current layout, switch the tag to monocle,
#           hide the bar (waybar).
# Leaving:  restore the remembered layout, show the bar again.
#
# mangowm keeps a layout per tag, so the remembered layout is stored per
# "<monitor>:<tag>". The bar is global, so it is hidden while the *focused*
# tag is in monocle fullscreen - scripts/monocle_fs_watch.sh takes care of
# that when the tag changes.
#
# The bar itself is driven by scripts/bar.sh, which owns the bar's visible
# state (a hidden waybar cannot be detected from the outside).
#
# Bound to SUPER+f in bind.conf.

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/mango"
STATE_FILE="$STATE_DIR/monocle-fs.state"
BAR_SH="$(dirname "$0")/bar.sh"

# mmsg needs the socket path that mangowm exports into its environment.
[ -n "${MANGO_INSTANCE_SIGNATURE:-}" ] || exit 1

mkdir -p "$STATE_DIR"
[ -f "$STATE_FILE" ] || : >"$STATE_FILE"

# --- current monitor / tag / layout -----------------------------------------

mons=$(mmsg get all-monitors) || exit 1

mon=$(printf '%s' "$mons" | jq -r '.monitors[] | select(.active) | .name')
tag=$(printf '%s' "$mons" | jq -r --arg m "$mon" \
	'.monitors[] | select(.name == $m) | .active_tags[0]')
symbol=$(printf '%s' "$mons" | jq -r --arg m "$mon" --argjson t "$tag" \
	'.monitors[] | select(.name == $m) | .tags[] | select(.index == $t) | .layout')
layouts=$(mmsg get layouts)
layout=$(printf '%s' "$layouts" | jq -r --arg s "$symbol" \
	'.layouts[] | select(.symbol == $s) | .name')

[ -n "$mon" ] && [ -n "$tag" ] && [ -n "$layout" ] || exit 1

key="$mon:$tag"
saved=$(awk -v k="$key" '$1 == k {print $2; exit}' "$STATE_FILE")

# The tag is in monocle fullscreen when it is marked in the state file *and*
# its layout really is monocle. The second part keeps a stale state file
# (left over from a restart of mango) from putting the mode back on.
if [ -n "$saved" ] && [ "$layout" = "monocle" ]; then
	# --- leaving monocle fullscreen ---------------------------------------

	# the layout symbol of the layout that is restored now
	saved_symbol=$(printf '%s' "$layouts" | jq -r --arg n "$saved" \
		'.layouts[] | select(.name == $n) | .symbol')

	mmsg dispatch "setlayout,$saved" >/dev/null
	awk -v k="$key" '$1 != k' "$STATE_FILE" >"$STATE_FILE.tmp" &&
		mv "$STATE_FILE.tmp" "$STATE_FILE"

	# the tag is not in monocle fullscreen anymore, so the bar comes back
	"$BAR_SH" apply "$key" "$saved_symbol"
else
	# --- entering monocle fullscreen ---------------------------------------

	# A tag that was already in monocle has nothing to restore; fall back to
	# tile, which is the layout mango starts every tag with.
	[ "$layout" = "monocle" ] && layout="tile"

	printf '%s %s\n' "$key" "$layout" >>"$STATE_FILE"
	mmsg dispatch "setlayout,monocle" >/dev/null

	# the tag is in monocle fullscreen now, so the bar goes away
	monocle_symbol=$(printf '%s' "$layouts" | jq -r \
		'.layouts[] | select(.name == "monocle") | .symbol')
	"$BAR_SH" apply "$key" "$monocle_symbol"
fi

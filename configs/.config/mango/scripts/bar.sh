#!/bin/sh
# bar.sh - show / hide / toggle the waybar.
#
# Usage:
#   bar.sh apply <monitor>:<tag> <layout-symbol>
#       Reconcile the bar with the state of that tag: hidden while the tag
#       is in monocle fullscreen, otherwise the state the user asked for.
#       Called by scripts/monocle_fullscreen.sh (SUPER+f) and by the watcher
#       scripts/monocle_fs_watch.sh.
#
#   bar.sh toggle
#       Manual toggle (SUPER+b). Does nothing while the current tag is in
#       monocle fullscreen, because the bar is forced hidden there.
#
#   bar.sh reset
#       Record that the bar is visible without signalling it. Used after
#       waybar was (re)started, because a fresh waybar is always visible.
#
# How the bar is actuated
# -----------------------
# waybar handles SIGUSR1, whose default action ("on-sigusr1" in
# ~/.config/waybar/config.jsonc) is "toggle". A *hidden* waybar cannot be
# detected from the outside: it keeps running with its layer surface mapped
# and only drops its opacity and its exclusive zone. mango reports only
# mapped layer surfaces, so "is the bar visible?" has to be remembered here.
#
# Two states are kept in the state directory:
#   bar.state   the state the bar is actually in
#   bar.want    the state the user asked for (SUPER+b). The bar falls back
#               to it whenever the current tag is not in monocle fullscreen.
#
# The monocle script and the watcher both call "apply", so they can run at
# the same time. The whole read - write - signal sequence runs under a lock
# and the state file is written *before* the signal is sent: otherwise two
# callers could both see "shown", both send SIGUSR1 and toggle the bar twice.

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/mango"
STATE_FILE="$STATE_DIR/bar.state"   # the state the bar is actually in
WANT_FILE="$STATE_DIR/bar.want"     # the state the user asked for
FS_STATE_FILE="$STATE_DIR/monocle-fs.state"
LOCK_FILE="$STATE_DIR/bar.lock"

# The layout symbol of mango's monocle layout ("mmsg get layouts").
MONOCLE_SYMBOL="M"

mkdir -p "$STATE_DIR"
[ -f "$STATE_FILE" ] || printf 'shown\n' >"$STATE_FILE"
[ -f "$WANT_FILE" ] || printf 'shown\n' >"$WANT_FILE"

read_state() {
	cat "$1" 2>/dev/null | head -1
}

# Is the tag in monocle fullscreen?
#
# A tag counts as such when it is marked in the state file *and* its layout
# really is monocle. The second part keeps a stale state file (left over
# from a restart of mango, or from switching the layout by hand) from hiding
# the bar forever.
fs_active() {
	grep -qF "$1 " "$FS_STATE_FILE" 2>/dev/null || return 1
	[ "$2" = "$MONOCLE_SYMBOL" ]
}

# The monitor:tag of the focused monitor and that tag's layout symbol.
current_tag() {
	mmsg get all-monitors 2>/dev/null | jq -r '
		.monitors[] | select(.active) as $m
		| ($m.active_tags[0]) as $t
		| "\($m.name):\($t) \($m.tags[] | select(.index == $t) | .layout)"'
}

# Toggle the bar. The state is written first so that a second caller does
# not send a second signal.
bar_toggle() {
	printf '%s\n' "$1" >"$STATE_FILE"
	pkill -SIGUSR1 -x waybar
}

# apply <monitor>:<tag> <layout-symbol>
bar_apply() {
	exec 9>"$LOCK_FILE"
	flock 9

	if fs_active "$1" "$2"; then
		effective="hidden"
	else
		effective=$(read_state "$WANT_FILE")
		[ -n "$effective" ] || effective="shown"
	fi

	[ "$effective" = "$(read_state "$STATE_FILE")" ] || bar_toggle "$effective"

	flock -u 9
}

case "${1:-}" in
apply)
	[ -n "$2" ] && [ -n "$3" ] || {
		printf 'usage: %s apply <monitor>:<tag> <layout-symbol>\n' "$0" >&2
		exit 1
	}
	bar_apply "$2" "$3"
	;;
toggle)
	exec 9>"$LOCK_FILE"
	flock 9

	info=$(current_tag)
	key=${info%% *}
	symbol=${info##* }

	if [ -n "$key" ] && fs_active "$key" "$symbol"; then
		# monocle fullscreen forces the bar away; toggling now would only
		# change what the bar returns to after leaving the mode
		:
	else
		if [ "$(read_state "$WANT_FILE")" = "hidden" ]; then
			want="shown"
		else
			want="hidden"
		fi
		printf '%s\n' "$want" >"$WANT_FILE"
		[ "$want" = "$(read_state "$STATE_FILE")" ] || bar_toggle "$want"
	fi

	flock -u 9
	;;
reset)
	# a freshly started waybar is visible; do not signal it
	printf 'shown\n' >"$STATE_FILE"
	;;
*)
	printf 'usage: %s apply|toggle|reset\n' "$0" >&2
	exit 1
	;;
esac

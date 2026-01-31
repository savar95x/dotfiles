#!/bin/sh
([ "$(eww get is_active_perf)" = "true" ] && eww update is_active_perf=false || eww update is_active_perf=true) &

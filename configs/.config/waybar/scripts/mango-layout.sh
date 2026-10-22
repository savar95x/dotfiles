#!/usr/bin/env bash

# Stream all-monitors directly into jq and deduplicate consecutive identical outputs
mmsg watch all-monitors 2>/dev/null | jq --unbuffered -rc '
    # Select the active monitor (fallback to the first monitor)
    (.monitors | map(select(.active == true))[0] // .monitors[0]) as $mon |

    # Get current layout symbol
    ($mon.layout_symbol // "T") as $sym |

    # Sum client_count across all currently active tags on this monitor
    ([ $mon.tags[]? | select(.is_active == true) | .client_count ] | add // 0) as $n |

    # Map symbol to desired format (Monospace symbols + Inter numbers)
    (
        if $sym == "T" then "<tt>[ ]=</tt>"
        elif $sym == "S" then
            if $n == 0 then "<tt>=</tt> S <tt>=</tt>" else "<tt>=</tt> \($n) <tt>=</tt>" end
        elif $sym == "M" then
            if $n == 0 then "<tt>[</tt> M <tt>]</tt>" else "<tt>[</tt> \($n) <tt>]</tt>" end
        else "<tt>\($sym)</tt>" end
    ) as $text |

    {
        text: $text,
        class: $sym,
        tooltip: "Layout: \($sym) (\($n) active clients)"
    }
' | awk '!seen[$0]++ { print; fflush(); delete seen; seen[$0]=1 }'

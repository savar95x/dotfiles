local mainMod = "SUPER"

------------------
---- MONITORS ----
------------------

hl.monitor({ output = "eDP-1", scale = 1, mode = "1920x1200@60", }) --[cite: 6]
--hl.monitor({ output = "HDMI-A-1", scale = 1, mode = "1920x1080@60", }) --[cite: 6]

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XMODIFIERS", "@im=fcitx") --[cite: 4]
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct") --[cite: 4]
hl.env("QT_WAYLAND_FORCE_DPI", "96") --[cite: 4]
hl.env("QT_QPA_PLATFORM", "Wayland;xcb") --[cite: 4]

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
  hl.exec_cmd("swaybg -i \"$(ls -1 ~/pix/walls/new/* | shuf -n 1)\" -m fill") --[cite: 1]
  hl.exec_cmd("~/.local/repos/waybar/Waybar/build/waybar -c ~/.config/hypr/waybar/config.jsonc") --[cite: 1]
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 5, --[cite: 3]
        gaps_out = 20, --[cite: 3]
        border_size = 1, --[cite: 3]

        col = {
            active_border   = "rgba(404040ff)", --[cite: 3]
            inactive_border = "rgba(212121ff)", --[cite: 3]
        },

        layout = "scrolling", --[cite: 8]
    },

    decoration = {
        rounding = 4, --[cite: 3]
        
        shadow = { enabled = false }, --[cite: 3]
        blur = { enabled = false }, --[cite: 3]
    },

    animations = {
        enabled = false, --[cite: 3]
    },
})

hl.config({
    master = {
        new_status = "master", --[cite: 3]
        mfact = 0.55, --[cite: 3]
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", mods = "ALT", action = "close" })
hl.gesture({ fingers = 3, direction = "up", mods = "SUPER", scale = 1.5, action = "fullscreen" })
--hl.gesture({ fingers = 3, direction = "left", scale = 1.5, action = "float" })

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us,ru", --[cite: 3]
        kb_options = "caps:escape", --[cite: 5]
        
        repeat_rate = 30, --[cite: 5]
        repeat_delay = 250, --[cite: 5]

        touchpad = {
            natural_scroll = true, --[cite: 3]
            tap_to_click = true, --[cite: 3]
            disable_while_typing = true, --[cite: 3]
        },
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

-- Applications
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("foot")) --[cite: 2]
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("rofi -config ~/.config/mango/rofi/config.rasi -show drun")) --[cite: 2]
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("foot -e lf")) --[cite: 2]
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("foot -e ncmpcpp")) --[cite: 2]
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("foot -e pulsemixer")) --[cite: 2]
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("foot -e bluetui")) --[cite: 2]
hl.bind(mainMod .. " + Q", hl.dsp.window.close()) --[cite: 2]

-- Layout & Focus
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" })) --[cite: 2]
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" })) --[cite: 2]
hl.bind(mainMod .. " + E", hl.dsp.layout("master:addmaster")) --[cite: 2]
hl.bind(mainMod .. " + T", hl.dsp.layout("master:removemaster")) --[cite: 2]

-- Workspaces
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i })) --[cite: 2]
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i })) --[cite: 2]
end

-- Media Keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/mango/scripts/volume.sh up")) --[cite: 2]
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/mango/scripts/volume.sh down")) --[cite: 2]
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.config/mango/scripts/brightness.sh up")) --[cite: 2]
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/mango/scripts/brightness.sh down")) --[cite: 2]

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name = "float-rofi",
    match = { class = "Rofi" },
    float = true, --[cite: 7]
    border_size = 0, --[cite: 7]
})

hl.window_rule({
    name = "fullscreen-flameshot",
    match = { class = "flameshot" },
    fullscreen = true, --[cite: 7]
})

hl.window_rule({
    name = "float-blueman",
    match = { class = "blueman-manager" },
    float = true, --[cite: 7]
})

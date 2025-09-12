--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
import XMonad
import XMonad.Layout.Fullscreen
    ( fullscreenEventHook, fullscreenManageHook, fullscreenSupport, fullscreenFull )
import Data.Monoid ()
import System.Exit ()
import XMonad.Util.SpawnOnce ( spawnOnce )
import Graphics.X11.ExtraTypes.XF86 (xF86XK_AudioLowerVolume, xF86XK_AudioRaiseVolume, xF86XK_AudioMute, xF86XK_MonBrightnessDown, xF86XK_MonBrightnessUp, xF86XK_AudioPlay, xF86XK_AudioPrev, xF86XK_AudioNext)
import XMonad.Hooks.EwmhDesktops ( ewmh )
import Control.Monad ( join, when )
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
    ( avoidStruts, docks, manageDocks, Direction2D(D, L, R, U) )
import XMonad.Hooks.ManageHelpers ( doFullFloat, isFullscreen )
import XMonad.Layout.Spacing ( spacingRaw, Border(Border) )
import XMonad.Actions.CycleWS
import XMonad.Layout.Gaps
    ( Direction2D(D, L, R, U),
      gaps,
      setGaps,
      GapMessage(DecGap, ToggleGaps, IncGap) )

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Maybe (maybeToList)
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "st"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 0

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1", "2", "3", "4", "5", "6" ]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#282828"
myFocusedBorderColor = "#303030"

addNETSupported :: Atom -> X ()
addNETSupported x   = withDisplay $ \dpy -> do
    r               <- asks theRoot
    a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
    a               <- getAtom "ATOM"
    liftIO $ do
       sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
       when (fromIntegral x `notElem` sup) $
         changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

addEWMHFullscreen :: X ()
addEWMHFullscreen   = do
    wms <- getAtom "_NET_WM_STATE"
    wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
    mapM_ addNETSupported [wms, wfs]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
clipboardy :: MonadIO m => m () -- Don't question it 
clipboardy = spawn "rofi -modi \"\63053 :greenclip print\" -show \"\63053 \" -run-command '{cmd}' -theme ~/.config/rofi/launcher/style.rasi"

--centerlaunch = spawn "exec ~/bin/eww open-many blur_full weather profile quote search_full disturb-icon vpn-icon home_dir screenshot power_full reboot_full lock_full logout_full suspend_full"
--sidebarlaunch = spawn "exec ~/bin/eww open-many weather_side time_side smol_calendar player_side sys_side sliders_side"
--ewwclose = spawn "exec ~/bin/eww close-all"
--maimcopy = spawn "maim -s | xclip -selection clipboard -t image/png && notify-send \"Screenshot\" \"Copied to Clipboard\" -i flameshot"
--maimsave = spawn "maim -s ~/Desktop/$(date +%Y-%m-%d_%H-%M-%S).png && notify-send \"Screenshot\" \"Saved to Desktop\" -i flameshot"
--rofi_launcher = spawn "rofi -no-lazy-grab -show drun -modi run,drun,window -theme $HOME/.config/rofi/launcher/style -drun-icon-theme \"candy-icons\" "


myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,               xK_a     ), spawn "st -e lfrun")
    , ((modm,               xK_g     ), spawn "st -e gotop")
    , ((modm,               xK_m     ), spawn "st -e ncmpcpp")
    , ((modm,               xK_p     ), spawn "rofi -show drun")
    , ((modm,               xK_o     ), spawn "rofi -show window")
    , ((modm,               xK_s     ), spawn "dmlscripts")

    -- lock screen
    --, ((modm,               xK_F1    ), spawn "betterlockscreen -l")

    -- launch rofi and dashboard
    --, ((modm,               xK_o     ), rofi_launcher)
    --, ((modm,               xK_p     ), centerlaunch)
    --, ((modm .|. shiftMask, xK_p     ), ewwclose)

    -- launch eww sidebar
    --, ((modm,               xK_s     ), sidebarlaunch)
    --, ((modm .|. shiftMask, xK_s     ), ewwclose)

    -- Audio keys
    , ((0,                    xF86XK_AudioPlay), spawn "playerctl play-pause")
    , ((0,                    xF86XK_AudioPrev), spawn "playerctl previous")
    , ((0,                    xF86XK_AudioNext), spawn "playerctl next")
    , ((0,                    xF86XK_AudioRaiseVolume), spawn "~/.config/xmonad/assets/scripts/vol i 2 140")
    , ((0,                    xF86XK_AudioLowerVolume), spawn "~/.config/xmonad/assets/scripts/vol d 2 140")
    , ((0,                    xF86XK_AudioMute), spawn "~/.config/xmonad/assets/scripts/vol t")

    -- Brightness keys
    , ((0,                    xF86XK_MonBrightnessUp), spawn "~/.config/xmonad/assets/scripts/bright  A 2")
    , ((0,                    xF86XK_MonBrightnessDown), spawn "~/.config/xmonad/assets/scripts/bright U 2")
 
    -- Screenshot
    --, ((0,                    xK_Print), maimcopy)
    --, ((modm,                 xK_Print), maimsave)

    -- My Stuff
    --, ((modm,               xK_b     ), spawn "exec ~/bin/bartoggle")
    --, ((modm,               xK_z     ), spawn "exec ~/bin/inhibit_activate")
    --, ((modm .|. shiftMask, xK_z     ), spawn "exec ~/bin/inhibit_deactivate")
    --, ((modm .|. shiftMask, xK_a     ), clipboardy)
    -- Turn do not disturb on and off
    , ((modm,               xK_d     ), spawn "exec ~/bin/do_not_disturb.sh")

    -- close focused window
    , ((modm              , xK_q     ), kill)

    -- GAPS!!!
    , ((modm .|. controlMask, xK_g), sendMessage $ ToggleGaps)               -- toggle all gaps
    , ((modm .|. shiftMask, xK_g), sendMessage $ setGaps [(L,30), (R,30), (U,60), (D,80)]) -- reset the GapSpec
    
    , ((modm .|. controlMask, xK_t), sendMessage $ IncGap 10 L)              -- increment the left-hand gap
    , ((modm .|. shiftMask, xK_t     ), sendMessage $ DecGap 10 L)           -- decrement the left-hand gap
    
    , ((modm .|. controlMask, xK_y), sendMessage $ IncGap 10 U)              -- increment the top gap
    , ((modm .|. shiftMask, xK_y     ), sendMessage $ DecGap 10 U)           -- decrement the top gap
    
    , ((modm .|. controlMask, xK_u), sendMessage $ IncGap 10 D)              -- increment the bottom gap
    , ((modm .|. shiftMask, xK_u     ), sendMessage $ DecGap 10 D)           -- decrement the bottom gap

    , ((modm .|. controlMask, xK_i), sendMessage $ IncGap 10 R)              -- increment the right-hand gap
    , ((modm .|. shiftMask, xK_i     ), sendMessage $ DecGap 10 R)           -- decrement the right-hand gap

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    --, ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    --, ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    --, ((modm .|. shiftMask, xK_q     ), spawn "~/.local/bin/powermenu.sh")
    , ((modm .|. shiftMask, xK_BackSpace   ), spawn "xsecurelock")

    -- Restart xmonad
    --, ((modm .|. shiftMask, xK_r     ), spawn "xmonad --recompile; xmonad --restart")
    , ((modm .|. shiftMask, xK_q     ), spawn "xmonad --restart; ~/.config/xmonad/assets/autostart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))

  --, ((modm,               xK_Down),  nextWS)
  --, ((modm,               xK_Up),    prevWS)
  --, ((modm .|. shiftMask, xK_Down),  shiftToNext)
  --, ((modm .|. shiftMask, xK_Up),    shiftToPrev)
  --, ((modm,               xK_Right), nextScreen)
  --, ((modm,               xK_Left),  prevScreen)
  --, ((modm .|. shiftMask, xK_Right), shiftNextScreen)
  --, ((modm .|. shiftMask, xK_Left),  shiftPrevScreen)
  --, ((modm,               xK_z),     toggleWS)
  , ((modm,               xK_bracketright),  nextWS)
  , ((modm,               xK_bracketleft),    prevWS)
  , ((modm .|. shiftMask, xK_bracketright),  shiftToNext >> nextWS)
  , ((modm .|. shiftMask, xK_bracketleft),    shiftToPrev >> prevWS)
  , ((modm,               xK_Tab),     toggleWS)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts(tiled ||| Mirror tiled ||| Full)
  where
     tiled   = Tall nmaster delta ratio -- default tiling algorithm partitions the screen into two panes
     nmaster = 1 -- The default number of windows in the master pane
     ratio   = 1/2 -- Default proportion of screen occupied by master pane
     delta   = 3/100 -- Percent of screen to increment by when resizing panes

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = fullscreenManageHook <+> manageDocks <+> composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "plank"          --> doIgnore
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , isFullscreen --> doFullFloat
                                 ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty


------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
  spawnOnce "~/.config/xmonad/assets/autostart"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad $ fullscreenSupport $ docks $ ewmh defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        manageHook = myManageHook, 
        layoutHook = gaps [(U,78), (D,108), (R,192), (L, 192)] $
		     spacingRaw False (Border 40 0 0 0) True (Border 5 5 5 5) True $
		     myLayout,-- $ smartBorders,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook >> addEWMHFullscreen
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'super'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]

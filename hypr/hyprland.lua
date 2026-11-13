-- Hyprland Lua config (converted from hyprland.conf, Hyprland 0.55+)

-- Monitors and workspaces (were `source = ./monitor.conf` / `./workspaces.conf`)
require("monitor")
require("workspaces")

---------------------------
---- PROGRAMS / ALIASES ----
---------------------------
local mainMod      = "ALT"
local mainShf      = mainMod .. " + SHIFT"
local CFG          = "~/.config"
local BIN          = CFG .. "/bin"
local CURSOR       = "plan9cursors"
local terminal     = "alacritty"
local fileManager  = "pcmanfm"
local menu         = "pkill -x rofi || rofi -show drun"

---------------------------------
---- ENVIRONMENT VARIABLES ----
---------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", CURSOR)
hl.env("HYPRCURSOR_THEME", CURSOR)
hl.env("NO_AT_BRIDGE", "1")
hl.env("QT_PLATFORMTHEME", "gtk3")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("QT_PLATFORM_PLUGIN", "gtk3")

-----------------
---- AUTOSTART ----
-----------------
hl.on("hyprland.start", function()
    hl.exec_cmd(BIN .. "/wal refresh")
    hl.exec_cmd(BIN .. "/bar refresh")
    hl.exec_cmd(BIN .. "/mon launch")
    hl.exec_cmd(BIN .. "/watcher/wtchr")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY")
    hl.exec_cmd("systemctl --user start gnome-keyring-daemon")
    hl.exec_cmd("/usr/lib/mate-polkit/polkit-mate-authentication-agent-1")
    hl.exec_cmd([[cclipd -s 2 -t "image/png" -t "image/*" -t "text/plain;charset=utf-8" -t "text/*" -t "*"]])
    hl.exec_cmd([[gsettings set org.gnome.desktop.interface gtk-theme "paradise"]])
    hl.exec_cmd([[gsettings set org.gnome.desktop.wm.preferences theme "paradise"]])
    hl.exec_cmd([[gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"]])
end)

----------------------
---- LOOK AND FEEL ----
----------------------
hl.config({
    animations = {
        enabled = false,
    },

    cursor = {
        inactive_timeout = 2,
    },

    decoration = {
        rounding = 3,
        rounding_power = 3,
        dim_inactive = true,
        dim_strength = 0.4,
        shadow = { enabled = false },
        blur   = { enabled = false },
    },

    general = {
        gaps_in = 1,
        gaps_out = 2,
        border_size = 0,
        col = {
            inactive_border = "rgb(555555)",
            active_border   = "rgb(999999)",
        },
        allow_tearing = false,
        layout = "master",
    },

    master = {
        new_status = "slave",
        new_on_active = "after",
        mfact = 0.5,
    },

    misc = {
        font_family = "monospace",
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        background_color = 0xff424242, -- was rgb(424242)
        key_press_enables_dpms = true,
        layers_hog_keyboard_focus = false,
    },

    input = {
        force_no_accel = true,
        accel_profile = "flat",
        kb_options = "ctrl:nocaps",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-------------------
---- KEYBINDINGS ----
-------------------
local held = { locked = true, repeating = true } -- old `bindel`
local locked = { locked = true }                 -- old `bindl`

-- Apps
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(BIN .. "/kc"))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainShf .. " + RETURN", hl.dsp.exec_cmd(terminal, { float = true }))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainShf .. " + E", hl.dsp.exec_cmd(fileManager, { float = true }))
hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(BIN .. "/clip"))
hl.bind(mainShf .. " + W", hl.dsp.exec_cmd(BIN .. "/wal menu"))
hl.bind(mainShf .. " + C", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(BIN .. "/vol switch"))
hl.bind(mainShf .. " + O", hl.dsp.exec_cmd(BIN .. "/mon menu"))
hl.bind(mainShf .. " + R", hl.dsp.exec_cmd(BIN .. "/bar refresh"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(BIN .. "/shot screen"))
hl.bind(mainShf .. " + P", hl.dsp.exec_cmd(BIN .. "/shot window"))
hl.bind(mainMod .. " + SLASH", hl.dsp.exec_cmd(BIN .. "/emoji"))
hl.bind(mainShf .. " + DELETE", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd(BIN .. "/power"))

-- Fullscreen / focus / layout
-- hl.bind("ESCAPE", hl.dsp.exec_cmd(BIN .. "/esc/escape"))
-- hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 2 }))
hl.bind(mainMod .. " + F", hl.dsp.send_shortcut({ mods = "", key = "F11" }))
hl.bind(mainShf .. " + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2 }))
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd(CFG .. "/hypr/focus switch"))
hl.bind(mainMod .. " + J", hl.dsp.exec_cmd(CFG .. "/hypr/focus cyclenext"))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(CFG .. "/hypr/focus cycleprev"))
hl.bind(mainShf .. " + J", hl.dsp.layout("swapnext"))
hl.bind(mainShf .. " + K", hl.dsp.layout("swapprev"))
hl.bind(mainMod .. " + H", hl.dsp.layout("mfact -0.01"), held)
hl.bind(mainMod .. " + L", hl.dsp.layout("mfact +0.01"), held)
hl.bind(mainMod .. " + H", hl.dsp.layout("colresize -0.01"), held)
hl.bind(mainMod .. " + L", hl.dsp.layout("colresize +0.02"), held)
-- hl.bind(mainMod .. " + RETURN", hl.dsp.layout("focusmaster previous"))
-- hl.bind(mainShf .. " + RETURN", hl.dsp.layout("swapwithmaster child ignoremaster"))

-- Workspaces (custom script) and move-to-workspace
for i = 1, 10 do
    local key = i % 10 -- workspace 10 lives on key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.exec_cmd(CFG .. "/hypr/scripts/ws " .. i))
    hl.bind(mainShf .. " + " .. key, hl.dsp.exec_cmd(CFG .. "/hypr/scripts/ws " .. i .. " m"))
end

-- Mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Audio / brightness
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(BIN .. "/vol mute"))
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd(BIN .. "/vol up"), held)
hl.bind(mainMod .. " + COMMA", hl.dsp.exec_cmd(BIN .. "/vol down"), held)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), held)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), held)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), held)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), held)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), held)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), held)

-- Media (playerctl)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked)

------------------------------
---- WINDOWS AND WORKSPACES ----
------------------------------
hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

-- Classes that should always float
local floatClasses = {
    "floaterminal",
    "imv",
    "org.pulseaudio.pavucontrol",
    "org.gnome.FileRoller",
    "engrampa",
    "xarchiver",
    "nwg-look",
    "(chrome-)(.*)(-Default)",
    "org.gnome.gThumb",
}
for _, class in ipairs(floatClasses) do
    hl.window_rule({ match = { class = class }, float = true })
end

-- Titles that should always float
hl.window_rule({ match = { title = "(Save File)" }, float = true })
hl.window_rule({ match = { title = "(.*)(Properties)" }, float = true })

-- Fullscreen follow-through
hl.window_rule({ match = { fullscreen_state_client = 2 }, fullscreen = true })
hl.window_rule({ match = { fullscreen_state_internal = 2 }, fullscreen = true })

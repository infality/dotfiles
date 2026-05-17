-- Monitors
hl.monitor({
	output = "DP-3",
	mode = "1920x1080@144",
	position = "0x0",
	scale = "auto",
})
hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@60",
	position = "1920x0",
	scale = "auto",
})

local terminal = "alacritty"
local fileManager = "thunar"
local menu = "wofi --show drun"
local browser = "librewolf"

-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("waybar > ~/.cache/waybar.log 2>&1")
	hl.exec_cmd("wlsunset -l 48 -L 9 -t 5500")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")

	hl.exec_cmd("hyprctl setcursor Breeze-Obsidian 20")
	hl.exec_cmd("hyprctl dispatch workspace 1")
	hl.exec_cmd("alacritty --hold -e 'nvidia-smi'")
end)

-- Environment variables
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland") -- x11 also possible
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("WINIT_UNIX_BACKEND", "x11")

-- Permissions

-- Look and feel
hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 1,
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,
		layout = "dwindle",
		snap = {
			enabled = true,
		},
	},

	decoration = {
		rounding = 0,
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
		},
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
	},

	animations = {
		enabled = true,
	},

	group = {
		col = {
			border_active = "rgba(400000ff)",
			border_inactive = "rgba(000000ff)",
		},
		groupbar = {
			enabled = false,
			height = 4,
			render_titles = false,
			col = {
				active = "rgba(666666ff)",
				inactive = "rgba(666666ff)",
			},
		},
	},
})

-- Curves / animations
hl.curve("custom", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "custom" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "default" })

-- Rules
hl.workspace_rule({ workspace = 1, monitor = "DP-3", default = true })
hl.workspace_rule({ workspace = 2, monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = 3, monitor = "DP-3" })
hl.workspace_rule({ workspace = 4, monitor = "DP-3" })
hl.workspace_rule({ workspace = 5, monitor = "DP-3" })
hl.workspace_rule({ workspace = 6, monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 7, monitor = "DP-3" })
hl.workspace_rule({ workspace = 8, monitor = "DP-3" })
hl.workspace_rule({ workspace = 9, monitor = "DP-3" })
hl.workspace_rule({ workspace = 10, monitor = "DP-3" })
hl.workspace_rule({ workspace = "w[t1]", no_border = true })

hl.window_rule({
	match = { title = "Picture-in-Picture" },
	float = true,
	size = { 800, 450 },
	keep_aspect_ratio = true,
})

-- Fixes
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})
hl.window_rule({
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

-- Layouts
hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

-- Config
hl.config({
	misc = {
		force_default_wallpaper = 1,
		disable_hyprland_logo = true,
	},
})

hl.config({
	input = {
		kb_layout = "eu",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,
		accel_profile = "flat",
		sensitivity = 0,

		touchpad = {
			natural_scroll = false,
		},
	},
})

-- Bindings
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + Space", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + CTRL + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("speedcrunch"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a --no-fancy"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/Programming/rust/implayer/target/release/implayer /home/alex/Music"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("playerctl set-sink-volume 38 +5%"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("playerctl set-sink-volume 38 -5%"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("playerctl set-sink-mute 38 toggle"), { locked = true, repeating = true })

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ last = true }))

hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + E", hl.dsp.window.move({ monitor = "+1" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "m-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

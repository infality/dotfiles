-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

-- Variable definitions
-- Themes define colours, icons, font and wallpapers.
--beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile.left,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.spiral,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

mymainmenu = awful.menu({ items = { { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
                                    { "restart", awesome.restart }
                                  }
                        })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a status widget
mystatus = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    wibox.container.margin(awful.widget.watch([[bash -c "ip -s link show enp0s31f6 | awk 'NR==4 { print $1 }'"]], 2, function(widget, stdout)
        local current = stdout
        local diff = (current - received) / 2000
        received = current
        widget:set_text(math.ceil(diff) .. " kb/s")
    end), 5, 5, 3, 3),
    wibox.container.margin(awful.widget.watch([[bash -c "df -hl | awk '/^\/dev\/sda2/ { print \"/:\" $5 }'"]], 60), 5, 3, 3, 3),
    wibox.container.margin(awful.widget.watch([[bash -c "df -hl | awk '/^\/dev\/sda3/ { print \"~/:\" $5 }'"]], 60), 3, 5, 3, 3),
    wibox.container.margin(awful.widget.watch([[bash -c "top -bn1 | grep 'MiB Mem :' | sed 's/.*, *\([0-9.]*\)%* used.*/\1/' | awk '{printf \"%.1f GB\", $1 / 1000}'"]], 10), 5, 5, 3, 3),
    wibox.container.margin(awful.widget.watch([[bash -c "top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | awk '{printf \"%.0f%\", 100 - $1}'"]], 2), 5, 3, 3, 3),
    wibox.container.margin(awful.widget.watch([[bash -c "cat /sys/devices/platform/coretemp.0/hwmon/hwmon1/temp1_input | awk '{print $1/1000 \"°C\"}'"]], 4), 3, 5, 3, 3),
}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) view_prev_active_tag(t.screen) end),
                    awful.button({ }, 5, function(t) view_next_active_tag(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(-1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

received = 0
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    if s.geometry.x == 0 then
        awful.tag({ "1", "3", "4", "5", "7", "8", "9" }, s, awful.layout.layouts[1])
    else
        awful.tag({ "2", "6"}, s, awful.layout.layouts[1])
    end

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc(-1) end),
                           awful.button({ }, 5, function () awful.layout.inc( 1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 12,
                right = 12,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout   = {
            spacing = 2,
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    wibox.widget.base.make_widget(),
                    forced_height = 3,
                    bg            = '#666666',
                    widget        = wibox.container.background,
                },
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        valign = 'center',
                        halign = 'center',
                        forced_width = 14,
                        widget = wibox.container.place,
                    },
                    top = 5,
                    bottom = 5,
                    left  = 12,
                    right = 12,
                    widget  = wibox.container.margin
                },
                layout = wibox.layout.align.vertical,
            },
            id = 'background_role',
            widget = wibox.container.background,
        },
    }

    -- Create a tasklist for focused title display
    s.titledisplay = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused,
        style = {
            align = "center",
            fg_normal = "#0000ff",
        },
        widget_template = {
            id     = 'text_role',
            widget = wibox.widget.textbox,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self.visible = false
                self:connect_signal('mouse::enter', function()
                    self.visible = true
                end)
                self:connect_signal('mouse::leave', function()
                    self.visible = false
                end)
            end,
        },
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 27 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.container.margin(s.mytaglist, 0, 4, 0, 0),
            s.mytasklist,
        },
        { -- Middle widget
            layout  = wibox.layout.flex.horizontal,
            s.titledisplay
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- mykeyboardlayout,
            mystatus,
            wibox.container.margin(wibox.widget.systray(), 3, 3, 5, 5),
            mytextclock,
            wibox.container.margin(s.mylayoutbox, 4, 4, 4, 4),
        },
    }
end)

function view_tag_if_active(s, i)
    local t = s.tags[i]
    if not t.selected and #t:clients() > 0 then
        t:view_only()
        return true
    end
    return false
end

function view_next_active_tag(s)
    if s == nil then
        s = awful.screen.focused({client=true, mouse=false})
    end
    if #s.selected_tags ~= 1 then
        return
    end

    local current_index = s.selected_tag.index
    for i = current_index + 1, #s.tags do
        if view_tag_if_active(s, i) then
            return
        end
    end
    for i = 1, current_index - 1 do
        if view_tag_if_active(s, i) then
            return
        end
    end
end

function view_prev_active_tag()
    local s = awful.screen.focused({client=true, mouse=false})
    if #s.selected_tags ~= 1 then
        return
    end

    local current_index = s.selected_tag.index
    for i = current_index - 1, 1, -1 do
        if view_tag_if_active(s, i) then
            return
        end
    end
    for i = #s.tags, current_index + 1, -1 do
        if view_tag_if_active(s, i) then
            return
        end
    end
end

-- Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, view_prev_active_tag),
    awful.button({ }, 5, view_next_active_tag)
))

-- Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "Left",
        function () awful.client.focus.byidx(-1) end,
        {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",
        function () awful.client.focus.byidx( 1) end,
        {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function () awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}
    ),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Right", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Left", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    awful.key({ modkey }, "d", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),

    -- Own program shortcuts
    awful.key({ modkey }, "y", function () awful.spawn("firefox") end,
              {description = "open firefox", group = "launcher"}),
    awful.key({ modkey }, "c", function () awful.spawn("speedcrunch") end,
              {description = "open speedcrunch", group = "launcher"}),
    awful.key({ modkey }, "t", function () awful.spawn("thunar") end,
              {description = "open thunar", group = "launcher"}),
    awful.key({ modkey }, "s", function () awful.spawn("code") end,
              {description = "open code", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "s", function () awful.spawn("flameshot gui") end,
              {description = "open flameshot", group = "launcher"}),

    -- Media keys
    awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("playerctl play-pause") end),
    awful.key({ }, "XF86AudioNext", function () awful.util.spawn("playerctl next") end),
    awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("playerctl previous") end),
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("pactl set-sink-volume 38 +5%") end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("pactl set-sink-volume 38 -5%") end),
    awful.key({ }, "XF86AudioMute", function () awful.util.spawn("pactl set-sink-mute 38 toggle") end)
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "w",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

local function get_screen(i)
    if     i == 2 or i == 6 then return screen[awful.screen.getbycoord(1920, 0)]
    else return screen[awful.screen.getbycoord(0, 0)]
    end
end

local function get_screen_tag(i)
    if     i == 1 then return screen[awful.screen.getbycoord(0, 0)].tags[1]
    elseif i == 2 then return screen[awful.screen.getbycoord(1920, 0)].tags[1]
    elseif i == 3 then return screen[awful.screen.getbycoord(0, 0)].tags[2]
    elseif i == 4 then return screen[awful.screen.getbycoord(0, 0)].tags[3]
    elseif i == 5 then return screen[awful.screen.getbycoord(0, 0)].tags[4]
    elseif i == 6 then return screen[awful.screen.getbycoord(1920, 0)].tags[2]
    else return screen[awful.screen.getbycoord(0, 0)].tags[i - 2]
    end
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local tag = get_screen_tag(i)
                        if tag then
                            if tag.screen ~= awful.screen.focused({client=true, mouse=false}) then
                                awful.screen.focus(get_screen(i))
                            end
                            tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local tag = get_screen_tag(i)
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = get_screen_tag(i)
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    { rule = { instance = "plugin-container" }, properties = { floating = true } },

    { rule = { class = "[Dd]iscord" }, properties = { tag = get_screen_tag(4) } },
    { rule = { class = "[Ss]potify" }, properties = { tag = get_screen_tag(3) } },
}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            --awful.titlebar.widget.stickybutton   (c),
            --awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.screen.focus(awful.screen.getbycoord(0,0))
mouse.coords {
    x = 960,
    y = 540
}

--awful.spawn.once("nm-applet &")
--awful.spawn.once("redshift -l 48:9 &")
--awful.spawn.once("compton --config ~/.compton.conf &")


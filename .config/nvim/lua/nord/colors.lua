local nord = {
    --16 colors
    nord0_gui = "#2E3440"        ,
    nord1_gui = "#303236"        ,
    nord2_gui = "#434C5E"        ,
    nord3_gui = "#4C566A"        ,
    nord3_gui_bright = "#60656c" ,
    nord4_gui = "#C5C8C6"        ,
    nord5_gui = "#E5E9F0"        ,
    nord6_gui = "#ECEFF4"        ,
    nord7_gui = "#8FBCBB"        ,
    nord8_gui = "#5e8d87"        ,
    nord9_gui = "#5E81AC"        ,
    nord10_gui = "#5e8d87"       ,
    nord11_gui = "#BF616A"       ,
    nord12_gui = "#D08770"       ,
    nord13_gui = "#EBCB8B"       ,
    nord14_gui = "#8C9440"       ,
    nord15_gui = "#B48EAD"       ,

    brackets =      '#aeb4b7',
	bg =            '#1d1f21',
	bg_alt =        '#1d1f21',
	fg =            '#C5C8C6',
	text =          '#C5C8C6',
	comments =      '#4C566A',
	selection =     '#3B4252',
	contrast =      '#303236',
	active =        '#5E81AC',
	border =        '#434C5E',
	line_numbers =  '#484b51',
	highlight =     '#c1c9d6',
	disabled =      '#3B4252',
	cursor =        '#E5E9F0',
	accent =        '#C5C8C6',
        gray =          '#C5C8C6',


	error =         '#da2c38',
	link =          '#A3BE8C',

	none =          'NONE'
}

-- Optional colors

-- Enable contrast sidebars, floating windows and popup menus
if vim.g.nord_contrast == true then
    nord.sidebar = nord.bg_alt
    nord.float = nord.bg_alt
else
    nord.sidebar = nord.bg
    nord.float = nord.bg
end

if vim.g.nord_cursorline_transparent == true then
    nord.cursorlinefg = nord.bg
else
    nord.cursorlinefg = nord.nord1_gui
end

return nord

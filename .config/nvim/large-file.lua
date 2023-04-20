local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

--opt.syntax = "disable"
opt.filetype = "off"
opt.undofile = false
opt.swapfile = false
opt.loadplugins = false
opt.autoindent = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.ignorecase = true
opt.mouse = "a"
opt.smartcase = true
opt.linebreak = true
opt.list = true
opt.number = true
opt.wrap = true
opt.hidden = true
opt.termguicolors = true
opt.background = 'dark'
opt.cursorline = true

cmd [[colorscheme owncolors]]

g.mapleader = " "
vim.keymap.set("n", "<C-k>", "<cmd>m-2<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>m+<CR>")
vim.keymap.set("n", "<A-j>", "}zz")
vim.keymap.set("n", "<A-k>", "{zz")
vim.keymap.set("n", "<esc>", "<cmd>noh<CR>")
vim.keymap.set("n", "#", "*Nzz")

vim.keymap.set("v", "<A-j>", "}zz")
vim.keymap.set("v", "<A-k>", "{zz")

vim.keymap.set("v", "<C-y>", '"+y')
vim.keymap.set("n", "<C-p>", '"+p')

vim.keymap.set("n", "<leader>h", "^")
vim.keymap.set("n", "<leader>H", "0")
vim.keymap.set("n", "<leader>l", "g_")
vim.keymap.set("n", "<leader>L", "$")

vim.keymap.set("n", "<A-Left>", "<C-o>")
vim.keymap.set("n", "<A-Right>", "<C-i>")

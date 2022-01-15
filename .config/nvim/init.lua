local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt


-- Packages
require('packer').startup(function()
  use "wbthomason/packer.nvim"
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use "neovim/nvim-lspconfig"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"
  use "kyazdani42/nvim-web-devicons"
  use "nvim-telescope/telescope.nvim"
  use "hrsh7th/nvim-compe"
  use "lewis6991/gitsigns.nvim"
  use "b3nj5m1n/kommentary"
  use "romgrk/barbar.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "hoob3rt/lualine.nvim"
  use "ryanoasis/vim-devicons"
  use "lervag/vimtex"
end)


-- Color scheme
require('owncolors')

require('lualine').setup {
    options = {theme = 'onedark'},
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {{'filename', path = 1}},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {{'diagnostics', sources = {'nvim_diagnostic'}}},
        lualine_z = {'location'}
    },
}


-- Settings
opt.syntax = "enable"
opt.filetype = "on"
opt.autoindent = true
opt.expandtab = true
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


-- Helper to always set noremap
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend("force", options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- Mappings
g.mapleader = " "
map("n", "<C-k>", "<cmd>m-2<CR>")
map("n", "<C-j>", "<cmd>m+<CR>")
map("n", "<A-j>", "}zz")
map("n", "<A-k>", "{zz")
map("n", "<esc>", "<cmd>noh<CR>")
map("n", "#", "*Nzz")

map("v", "<A-j>", "}zz")
map("v", "<A-k>", "{zz")

map("v", "<C-y>", '"+y')
map("n", "<C-p>", '"+p')

map("n", "<leader>h", "^")
map("n", "<leader>H", "0")
map("n", "<leader>l", "g_")
map("n", "<leader>L", "$")

map("n", "<A-Left>", "<C-o>")
map("n", "<A-Right>", "<C-i>")

cmd('au BufReadPost * if line("\'\\"") > 0 && line("\'\\"") <= line("$") | exe "normal! g`\\"" | endif')


local treesitter = require("nvim-treesitter.configs")
treesitter.setup {ensure_installed = "maintained", highlight = {enable = true}}


local lsp = require("lspconfig")

lsp.clangd.setup {}
lsp.rust_analyzer.setup{}
lsp.zls.setup{}
lsp.tsserver.setup{}
lsp.pylsp.setup{root_dir = lsp.util.root_pattern(".git", fn.getcwd())}
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/alex/Programming/avalonia/omnisharp-linux-x64/run"
lsp.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
}

map("n", "gk", "v:lua vim.lsp.diagnostic.goto_prev()<CR>")
map("n", "gj", "v:lua vim.lsp.diagnostic.goto_next()<CR>")
map("n", ">", "v:lua vim.lsp.buf.formatting()<CR>")
map("n", "gi", "v:lua vim.lsp.buf.hover()<CR>")
map("n", "<space>m", "v:lua vim.lsp.buf.rename()<CR>")


map("n", "gr", "v:lua require('telescope.builtin').lsp_references()<CR>")
map("n", "gs", "v:lua require('telescope.builtin').lsp_document_symbols()<CR>")
map("n", "gd", "v:lua require('telescope.builtin').lsp_definitions()<CR>")
map("n", "ga", "v:lua require('telescope.builtin').lsp_code_actions()<CR>")
map("n", "gl", "v:lua require('telescope.builtin').lsp_document_diagnostics()<CR>")
map("n", "<leader>ff", "v:lua require('telescope.builtin').git_files()<CR>")
map("n", "<leader>fd", "v:lua require('telescope.builtin').file_browser()<CR>")
map("n", "<leader>fg", "v:lua require('telescope.builtin').live_grep({layout_strategy='vertical'})<CR>")
map("n", "<leader>fb", "v:lua require('telescope.builtin').buffers()<CR>")
map("n", "<leader>fh", "v:lua require('telescope.builtin').help_tags()<CR>")
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<ScrollWheelUp>"] = actions.preview_scrolling_up,
        ["<ScrollWheelDown>"] = actions.preview_scrolling_down
      },
    },
  }
}


require("gitsigns").setup {
  signs = {
    add          = {hl = "GitSignsAdd"   , text = "│", numhl="GitSignsAddNr"   , linehl="GitSignsAddLn"},
    change       = {hl = "GitSignsChange", text = "│", numhl="GitSignsChangeNr", linehl="GitSignsChangeLn"},
    delete       = {hl = "GitSignsDelete", text = "_", numhl="GitSignsDeleteNr", linehl="GitSignsDeleteLn"},
    topdelete    = {hl = "GitSignsDelete", text = "‾", numhl="GitSignsDeleteNr", linehl="GitSignsDeleteLn"},
    changedelete = {hl = "GitSignsChange", text = "~", numhl="GitSignsChangeNr", linehl="GitSignsChangeLn"},
  },
  numhl = false,
  linehl = false,
  keymaps = {},
  watch_index = {
    interval = 1000
  },
  current_line_blame = false,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  use_decoration_api = true,
  use_internal_diff = true,
}


g.kommentary_create_default_mappings = false
vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("v", "<C-_>", "<Plug>kommentary_visual_default", {})


-- Completion
vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'disable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

map("i", "<C-Space>", "compe#complete()", {expr = true})
map("i", "<CR>", "compe#confirm('<CR>')", {expr = true})
map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


-- Tab bar
map("n", "<C-Tab>", "<cmd>BufferNext<CR>")
map("n", "<C-S-Tab>", "<cmd>BufferPrevious<CR>")
map("n", "<A-l>", "<cmd>BufferNext<CR>")
map("n", "<A-h>", "<cmd>BufferPrevious<CR>")
map("n", "<C-l>", "<cmd>BufferMoveNext<CR>")
map("n", "<C-h>", "<cmd>BufferMovePrevious<CR>")
map("n", "<C-w>", "<cmd>BufferClose<CR>")
map("n", "<A-p>", "<cmd>BufferPick<CR>")

require('colorizer').setup()

g.vimtex_view_method = "zathura"
g.vimtex_quickfix_mode = 0

-- nvim bug workaround https://github.com/neovim/neovim/issues/11330
cmd('autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"')


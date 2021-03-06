local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt


-- Packages
cmd "packadd paq-nvim"
local paq = require("paq-nvim").paq
paq {"savq/paq-nvim", opt = true}
paq {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
paq {"neovim/nvim-lspconfig"}
paq {"nvim-lua/popup.nvim"}
paq {"nvim-lua/plenary.nvim"}
paq {"kyazdani42/nvim-web-devicons"}
paq {"nvim-telescope/telescope.nvim"}
paq {"hrsh7th/nvim-compe"}
paq {"lewis6991/gitsigns.nvim"}
paq {"b3nj5m1n/kommentary"}
paq {"romgrk/barbar.nvim"}
paq {"norcalli/nvim-colorizer.lua"}

paq {"hoob3rt/lualine.nvim"}
paq {"kyazdani42/nvim-web-devicons"}
paq {"ryanoasis/vim-devicons"}


-- Color scheme
require('owncolors')

require('lualine').setup {
    options = {theme = 'onedark'},
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch'},
        lualine_c = {{'filename', path = 2}},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {{'diagnostics', sources = {'nvim_lsp'}}},
        lualine_z = {'location'}
    },
}


-- Settings
cmd("syntax enable")
cmd("filetype indent on")
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

cmd('au BufReadPost * if line("\'\\"") > 0 && line("\'\\"") <= line("$") | exe "normal! g`\\"" | endif')


local treesitter = require("nvim-treesitter.configs")
treesitter.setup {ensure_installed = "maintained", highlight = {enable = true}}


local lsp = require("lspconfig")

lsp.clangd.setup {}
lsp.rust_analyzer.setup{}
lsp.tsserver.setup{}
lsp.pyls.setup {root_dir = lsp.util.root_pattern(".git", fn.getcwd())}
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/alex/Programming/avalonia/omnisharp-linux-x64/run"
lsp.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
}

map("n", "gk", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
map("n", "gj", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
map("n", ">", "<cmd>lua vim.lsp.buf.formatting()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.hover()<CR>")
--map("n", "<space>m", "<cmd>lua vim.lsp.buf.rename()<CR>")


map("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>")
map("n", "gs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
map("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>")
map("n", "ga", "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>")
map("n", "gl", "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>")
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').git_files()<CR>")
map("n", "<leader>fd", "<cmd>lua require('telescope.builtin').file_browser()<CR>")
map("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
map("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>")
map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}


require("gitsigns").setup {
  signs = {
    add          = {hl = "GitSignsAdd"   , text = "???", numhl="GitSignsAddNr"   , linehl="GitSignsAddLn"},
    change       = {hl = "GitSignsChange", text = "???", numhl="GitSignsChangeNr", linehl="GitSignsChangeLn"},
    delete       = {hl = "GitSignsDelete", text = "_", numhl="GitSignsDeleteNr", linehl="GitSignsDeleteLn"},
    topdelete    = {hl = "GitSignsDelete", text = "???", numhl="GitSignsDeleteNr", linehl="GitSignsDeleteLn"},
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
require("compe").setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = "disable";
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;

    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = false;
        ultisnips = false;
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

-- nvim bug workaround https://github.com/neovim/neovim/issues/11330
cmd('autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"')


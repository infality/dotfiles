local cmd = vim.cmd
local fn = vim.fn
local g = vim.g


-- Packages
cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'savq/paq-nvim', opt = true}
paq {'nvim-treesitter/nvim-treesitter'}
paq {'neovim/nvim-lspconfig'}
paq {'nvim-lua/popup.nvim'}
paq {'nvim-lua/plenary.nvim'}
paq {'nvim-telescope/telescope.nvim'}
paq {'hrsh7th/nvim-compe'}
paq {'lewis6991/gitsigns.nvim'}
paq {'b3nj5m1n/kommentary'}
paq {'arcticicestudio/nord-vim'}
paq {'vim-airline/vim-airline'}


-- Helper to ensure global buffer is set
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end


-- Settings
cmd('colorscheme nord')
cmd('se cul')
cmd('hi clear CursorLine')
cmd('hi cursorlinenr guifg=bold')
cmd('autocmd ColorScheme nord highlight Comment ctermfg=7')
cmd('autocmd ColorScheme nord highlight Visual ctermbg=8')
cmd('autocmd ColorScheme nord highlight LspDiagnosticsDefaultError ctermfg=9')
cmd('autocmd ColorScheme nord highlight LspDiagnosticsDefaultWarning ctermfg=136')
cmd('autocmd ColorScheme nord highlight LspDiagnosticsDefaultInformation ctermfg=136')
cmd('autocmd ColorScheme nord highlight LspDiagnosticsDefaultHint ctermfg=136')
g['airline_powerline_fonts'] = true

cmd('syntax enable')
cmd('filetype indent on')
opt('b', 'autoindent', true)
opt('b', 'expandtab', true)
opt('b', 'shiftwidth', 4)
opt('b', 'smartindent', true)
opt('b', 'tabstop', 4)
opt('o', 'ignorecase', true)
opt('o', 'mouse', 'a')
opt('o', 'smartcase', true)
opt('w', 'linebreak', true)
opt('w', 'list', true)
opt('w', 'number', true)
opt('w', 'wrap', true)
--opt('o', 'hidden', true)


-- Helper to always set noremap
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- Mappings
g['mapleader'] = ' '
map('n', '<C-k>', '<cmd>m-2<CR>')
map('n', '<C-j>', '<cmd>m+<CR>')
map('n', '<A-j>', '}zz')
map('n', '<A-k>', '{zz')
map('n', '<esc>', '<cmd>noh<CR>')
map('n', '#', '*Nzz')

map('v', '<A-j>', '}zz')
map('v', '<A-k>', '{zz')

map('v', '<C-y>', '"+y')
map('n', '<C-p>', '"+p')

map('n', '<leader>h', '^')
map('n', '<leader>H', '0')
map('n', '<leader>l', 'g_')
map('n', '<leader>L', '$')

cmd('au BufReadPost * if line("\'\\"") > 0 && line("\'\\"") <= line("$") | exe "normal! g`\\"" | endif')


local treesitter = require('nvim-treesitter.configs')
treesitter.setup {ensure_installed = 'maintained', highlight = {enable = true}}


local lsp = require('lspconfig')

lsp.clangd.setup {}
lsp.rls.setup {
  settings = {
    rust = {
      unstable_features = true,
      build_on_save = false,
      all_features = true,
    },
  },
}
lsp.tsserver.setup{}
lsp.pyls.setup {root_dir = lsp.util.root_pattern('.git', fn.getcwd())}

map('n', 'gk', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', 'gj', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '>', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.hover()<CR>')
--map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')


map('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>')
map('n', 'gs', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>')
map('n', 'gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>')
map('n', 'ga', '<cmd>lua require("telescope.builtin").lsp_code_actions()<CR>')
map('n', 'gl', '<cmd>lua require("telescope.builtin").lsp_document_diagnostics()<CR>')
map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>')
map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<CR>')
map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>')
map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<CR>')


require('gitsigns').setup()


g['kommentary_create_default_mappings'] = false
vim.api.nvim_set_keymap('n', '<C-_>', '<Plug>kommentary_motion_default', {})
vim.api.nvim_set_keymap('v', '<C-_>', '<Plug>kommentary_visual_default', {})


-- Completion
vim.o.completeopt = "menuone,noselect"
require('compe').setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
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
        vsnip = true;
        ultisnips = true;
    };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
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
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})


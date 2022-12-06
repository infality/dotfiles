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
    use "nvim-telescope/telescope-ui-select.nvim"
    use "nvim-telescope/telescope-file-browser.nvim"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    use "lewis6991/gitsigns.nvim"
    use "b3nj5m1n/kommentary"
    use "romgrk/barbar.nvim"
    use "norcalli/nvim-colorizer.lua"
    use "hoob3rt/lualine.nvim"
    use "ryanoasis/vim-devicons"
    use "lervag/vimtex"
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
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


-- Mappings
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

cmd('au BufReadPost * if line("\'\\"") > 0 && line("\'\\"") <= line("$") | exe "normal! g`\\"" | endif')


local treesitter = require("nvim-treesitter.configs")
treesitter.setup {ensure_installed = "all", highlight = {enable = true}}


local lsp = require("lspconfig")

lsp.clangd.setup {}
lsp.rust_analyzer.setup{
    settings = {
        ["rust-analyzer"] = {
            rustc = {
                source = "discover"
            }
        }
    }
}
lsp.zls.setup{}
lsp.html.setup{}
lsp.cssls.setup{}
lsp.tsserver.setup{}
lsp.pylsp.setup{root_dir = lsp.util.root_pattern(".git", fn.getcwd())}
lsp.ltex.setup{}
local pid = vim.fn.getpid()
local omnisharp_bin = "/home/alex/Programming/avalonia/omnisharp-linux-x64/run"
lsp.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
}

vim.keymap.set("n", "gk", "v:lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "gj", "v:lua vim.diagnostic.goto_next()<CR>")
vim.keymap.set("n", ">", "v:lua vim.lsp.buf.formatting()<CR>")
vim.keymap.set("n", "gi", "v:lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<space>m", "v:lua vim.lsp.buf.rename()<CR>")


vim.keymap.set("n", "gr", "v:lua require('telescope.builtin').lsp_references()<CR>")
vim.keymap.set("n", "gs", "v:lua require('telescope.builtin').lsp_document_symbols()<CR>")
vim.keymap.set("n", "gd", "v:lua require('telescope.builtin').lsp_definitions()<CR>")
vim.keymap.set("n", "ga", "v:lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "gl", "v:lua require('telescope.builtin').diagnostics()<CR>")
vim.keymap.set("n", "<leader>ff", "v:lua require('telescope.builtin').git_files()<CR>")
vim.keymap.set("n", "<leader>fd", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>fg", "v:lua require('telescope.builtin').live_grep({layout_strategy='vertical'})<CR>")
vim.keymap.set("n", "<leader>fb", "v:lua require('telescope.builtin').buffers()<CR>")
vim.keymap.set("n", "<leader>fh", "v:lua require('telescope.builtin').help_tags()<CR>")
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
require('telescope').load_extension("ui-select")
require('telescope').load_extension("file_browser")


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
  watch_gitdir = {
    interval = 1000
  },
  current_line_blame = false,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  diff_opts = {
      internal = true
  },
}


g.kommentary_create_default_mappings = false
vim.api.nvim_set_keymap("n", "<C-_>", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("v", "<C-_>", "<Plug>kommentary_visual_default", {})


-- Completion
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

vim.o.completeopt = "menu,menuone,noselect"
local cmp = require'cmp'
cmp.setup({
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.complete(),
        -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        -- ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
    }, {
        { name = 'buffer' },
    })
})


-- Tab bar
vim.keymap.set("n", "<C-Tab>", "<cmd>BufferNext<CR>")
vim.keymap.set("n", "<C-S-Tab>", "<cmd>BufferPrevious<CR>")
vim.keymap.set("n", "<A-l>", "<cmd>BufferNext<CR>")
vim.keymap.set("n", "<A-h>", "<cmd>BufferPrevious<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>BufferMoveNext<CR>")
vim.keymap.set("n", "<C-h>", "<cmd>BufferMovePrevious<CR>")
vim.keymap.set("n", "<C-w>", "<cmd>BufferClose<CR>")
vim.keymap.set("n", "<A-p>", "<cmd>BufferPick<CR>")

require('colorizer').setup()

g.vimtex_view_method = "zathura"
g.vimtex_quickfix_mode = 0
cmd('au User VimtexEventQuit call vimtex#compiler#clean(0)')

g.mkdp_preview_options = {
    mkit = {},
    katex = {},
    uml = {},
    maid = {},
    disable_sync_scroll = 1,
    sync_scroll_type = 'middle',
    hide_yaml_meta = 1,
    sequence_diagrams = {},
    flowchart_diagrams = {},
    content_editable = false,
    disable_filename = 0,
    toc = {}
}

-- nvim bug workaround https://github.com/neovim/neovim/issues/11330
-- cmd('autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"')


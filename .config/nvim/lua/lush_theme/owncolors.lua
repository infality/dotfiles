local lush       = require('lush')
local hsl        = lush.hsl

local background = hsl(210, 6, 12)
local foreground = hsl(140, 3, 78)

local dark       = hsl(210, 5, 20)
local dark2      = hsl(210, 5, 30)
local dark3      = hsl(210, 5, 40)

local yellow     = hsl(66, 40, 40)
local orange     = hsl(40, 70, 45)
local brown      = hsl(30, 55, 40)
local darkgreen  = hsl(135, 20, 40)
local green      = hsl(135, 20, 50)
local green2     = hsl(135, 20, 80)
local turquoise  = hsl(170, 20, 45)
local cyan       = hsl(180, 50, 50)
local lightblue  = hsl(193, 40, 45)
local blue       = hsl(207, 25, 50)
local blue2      = hsl(207, 25, 60)
local darkblue   = hsl(213, 30, 40)
local purple     = hsl(312, 20, 45)
local red        = hsl(355, 55, 55)
local red2       = hsl(355, 100, 88)

---@diagnostic disable: undefined-global
local theme      = lush(function(injected_functions)
    local sym = injected_functions.sym
    return {
        -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
        -- groups, mostly used for styling UI elements.
        -- Empty brackets resolve mostly to Normal style.
        -- See :h highlight-groups

        ColorColumn {},                               -- Columns set with 'colorcolumn'
        Conceal {},                                   -- Placeholder characters substituted for concealed text (see 'conceallevel')
        Cursor {},                                    -- Character under the cursor
        lCursor {},                                   -- Character under the cursor when |language-mapping| is used (see 'guicursor')
        CursorIM {},                                  -- Like Cursor, but used when in IME mode |CursorIM|
        CursorColumn {},                              -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine { bg = dark },                     -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
        Directory { fg = blue },                      -- Directory names (and other special names in listings)
        DiffAdd { fg = green },                       -- Diff mode: Added line |diff.txt|
        DiffChange { fg = purple },                   -- Diff mode: Changed line |diff.txt|
        DiffDelete { fg = red },                      -- Diff mode: Deleted line |diff.txt|
        DiffText { fg = orange },                     -- Diff mode: Changed text within a changed line |diff.txt|
        GitSignsAdd { fg = green },
        GitSignsChange { fg = orange },
        GitSignsDelete { fg = red },
        EndOfBuffer {},                               -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
        TermCursor {},                                -- Cursor in a focused terminal
        TermCursorNC {},                              -- Cursor in an unfocused terminal
        ErrorMsg { fg = red },                        -- Error messages on the command line
        VertSplit {},                                 -- Column separating vertically split windows
        Folded {},                                    -- Line used for closed folds
        FoldColumn {},                                -- 'foldcolumn'
        SignColumn {},                                -- Column where |signs| are displayed
        IncSearch { bg = dark2 },                     -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Substitute {},                                -- |:substitute| replacement text highlighting
        LineNr { fg = dark2 },                        -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr {},                              -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        MatchParen { bg = darkgreen },                -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg {},                                   -- 'showmode' message (e.g., "-- INSERT -- ")
        MsgArea {},                                   -- Area for messages and cmdline
        MsgSeparator {},                              -- Separator for scrolled messages, `msgsep` flag of 'display'
        MoreMsg {},                                   -- |more-prompt|
        NonText {},                                   -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal { fg = foreground, bg = background },  -- Normal text
        NormalFloat { fg = foreground, bg = dark },   -- Normal text in floating windows.
        NormalNC {},                                  -- normal text in non-current windows
        Pmenu { bg = dark },                          -- Popup menu: Normal item.
        PmenuSel { bg = dark2 },                      -- Popup menu: Selected item.
        PmenuSbar { bg = dark },                      -- Popup menu: Scrollbar.
        PmenuThumb { bg = dark3 },                    -- Popup menu: Thumb of the scrollbar.
        Question { gui = "bold" },                    -- |hit-enter| prompt and yes/no questions
        QuickFixLine { fg = blue },                   -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search { bg = dark2 },                        -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
        SpecialKey {},                                -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad { sp = red, gui = "undercurl" },     -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap { sp = blue, gui = "undercurl" },    -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal { sp = green, gui = "undercurl" }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare { sp = purple, gui = "undercurl" }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
        StatusLine {},                                -- Status line of current window
        StatusLineNC {},                              -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        TabLine {},                                   -- Tab pages line, not active tab page label
        TabLineFill { fg = dark3, bg = dark },        -- Tab pages line, where there are no labels
        TabLineSel {},                                -- Tab pages line, active tab page label
        Title {},                                     -- Titles for output from ":set all", ":autocmd" etc.
        Visual { bg = dark },                         -- Visual mode selection
        VisualNOS { bg = dark },                      -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg { fg = orange },                   -- Warning messages
        Whitespace { fg = darkblue },                 -- "nbsp", "space", "tab" and "trail" in 'listchars'
        Winseparator { fg = dark2 },                  -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
        WildMenu { bg = dark },                       -- Current match in 'wildmenu' completion

        -- Common vim syntax groups used for all kinds of code and markup.
        -- Commented-out groups should chain up to their preferred (*) group
        -- by default.
        --
        -- See :h group-name
        --
        -- Uncomment and edit if you want more specific syntax highlighting.

        Comment { fg = dark3 },    -- Any comment

        Constant { fg = purple },  -- (*) Any constant
        String { fg = yellow },    --   A string constant: "this is a string"
        Character { fg = orange }, --   A character constant: 'c', '\n'
        -- Number         { }, --   A number constant: 234, 0xff
        -- Boolean        { }, --   A boolean constant: TRUE, false
        -- Float          { }, --   A floating point constant: 2.3e10

        Identifier { fg = cyan },      -- (*) Any variable name
        Function { fg = turquoise },   --   Function name (also: methods for classes)

        Statement { fg = foreground }, -- (*) Any statement
        Conditional { fg = darkblue }, --   if, then, else, endif, switch, etc.
        Repeat { fg = darkblue },      --   for, do, while, etc.
        Label { fg = darkblue },       --   case, default, etc.
        Operator { fg = darkblue },    --   "sizeof", "+", "*", etc.
        Keyword { fg = darkblue },     --   any other keyword
        Exception { fg = darkblue },   --   try, catch, throw

        PreProc { fg = darkblue },     -- (*) Generic Preprocessor
        -- Include        { }, --   Preprocessor #include
        -- Define         { }, --   Preprocessor #define
        -- Macro          { }, --   Same as Define
        -- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

        Type { fg = blue }, -- (*) int, long, char, etc.
        -- StorageClass   { }, --   static, register, volatile, etc.
        -- Structure      { }, --   struct, union, enum, etc.
        -- Typedef        { }, --   A typedef

        Special {},                         -- (*) Any special symbol
        SpecialChar { fg = brown },         --   Special character in a constant
        Tag {},                             --   You can use CTRL-] on this
        Delimiter {},                       --   Character that needs attention
        SpecialComment { fg = brown },      --   Special things inside a comment (e.g. '\n')
        Debug { fg = brown },               --   Debugging statements

        Underlined { gui = "underline" },   -- Text that stands out, HTML links
        -- Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
        Error { fg = red, gui = "bold" },   -- Any erroneous construct
        Todo { fg = orange, gui = "bold" }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        -- These groups are for the native LSP client and diagnostic system. Some
        -- other LSP clients may use these groups, or use their own. Consult your
        -- LSP client's documentation.

        -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
        --
        -- LspReferenceText            { } , -- Used for highlighting "text" references
        -- LspReferenceRead            { } , -- Used for highlighting "read" references
        -- LspReferenceWrite           { } , -- Used for highlighting "write" references
        -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
        -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
        -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

        -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
        --
        DiagnosticError { fg = red },   -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticWarn { fg = orange }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticInfo { fg = yellow }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        DiagnosticHint { fg = blue2 },  -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
        -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
        -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
        -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
        -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
        -- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
        -- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
        -- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
        -- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
        -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
        -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
        -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
        -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
        -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
        -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
        -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.

        -- Tree-Sitter syntax groups.
        --
        -- See :h treesitter-highlight-groups, some groups may not be listed,
        -- submit a PR fix to lush-template!
        --
        -- Tree-Sitter groups are defined with an "@" symbol, which must be
        -- specially handled to be valid lua code, we do this via the special
        -- sym function. The following are all valid ways to call the sym function,
        -- for more details see https://www.lua.org/pil/5.html
        --
        -- sym("@text.literal")
        -- sym('@text.literal')
        -- sym"@text.literal"
        -- sym'@text.literal'
        --
        -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

        -- sym"@text.literal"      { }, -- Comment
        -- sym"@text.reference"    { }, -- Identifier
        -- sym"@text.title"        { }, -- Title
        -- sym"@text.uri"          { }, -- Underlined
        -- sym"@text.underline"    { }, -- Underlined
        -- sym"@text.todo"         { }, -- Todo
        -- sym"@comment"           { }, -- Comment
        -- sym"@punctuation"       { }, -- Delimiter
        -- sym"@constant"          { }, -- Constant
        -- sym"@constant.builtin"  { }, -- Special
        -- sym"@constant.macro"    { }, -- Define
        -- sym"@define"            { }, -- Define
        -- sym"@macro"             { }, -- Macro
        -- sym"@string"            { }, -- String
        -- sym"@string.escape"     { }, -- SpecialChar
        -- sym"@string.special"    { }, -- SpecialChar
        -- sym"@character"         { }, -- Character
        -- sym"@character.special" { }, -- SpecialChar
        -- sym"@number"            { }, -- Number
        -- sym"@boolean"           { }, -- Boolean
        -- sym"@function"          { }, -- Function
        -- sym"@function.builtin"  { }, -- Special
        -- sym"@function.macro"    { }, -- Macro
        -- sym"@parameter"         { }, -- Identifier
        -- sym"@method"            { }, -- Function
        -- sym"@field"             { }, -- Identifier
        -- sym"@property"          { }, -- Identifier
        -- sym"@constructor"       { }, -- Special
        -- sym"@conditional"       { }, -- Conditional
        -- sym"@repeat"            { }, -- Repeat
        -- sym"@label"             { }, -- Label
        -- sym"@operator"          { }, -- Operator
        -- sym"@keyword"           { }, -- Keyword
        -- sym"@exception"         { }, -- Exception
        -- sym"@variable"          { }, -- Identifier
        -- sym"@type"              { }, -- Type
        -- sym"@type.definition"   { }, -- Typedef
        sym"@type.builtin"         { fg = blue },
        -- sym"@storageclass"      { }, -- StorageClass
        -- sym"@structure"         { }, -- Structure
        -- sym"@namespace"         { }, -- Identifier
        -- sym"@include"           { }, -- Include
        -- sym"@preproc"           { }, -- PreProc
        -- sym"@debug"             { }, -- Debug
        -- sym"@tag"               { }, -- Tag
        sym"@lsp.type.parameter"   { fg = green2 },
        sym"@lsp.type.selfKeyword" { fg = green2 },
        sym"@lsp.typemod.variable.mutable" { fg = red2 },

        -- barbar highlights
        BufferTabpageFill { bg = background },
        BufferCurrent { bg = dark },
        BufferCurrentERROR { bg = dark, fg = red },
        BufferCurrentWARN { bg = dark, fg = orange },
        BufferCurrentHINT { bg = dark, fg = blue2 },
        BufferCurrentINFO { bg = dark, fg = blue2 },
        BufferCurrentMod { bg = dark, fg = yellow },
        BufferCurrentSign { bg = dark, fg = blue },
        BufferInactive { bg = background },
        BufferInactiveERROR { bg = background, fg = red },
        BufferInactiveWARN { bg = background, fg = orange },
        BufferInactiveHINT { bg = background, fg = blue2 },
        BufferInactiveINFO { bg = background, fg = blue2 },
        BufferInactiveMod { bg = background, fg = yellow },
        BufferInactiveSign { bg = background, fg = background },
    }
end)

return theme

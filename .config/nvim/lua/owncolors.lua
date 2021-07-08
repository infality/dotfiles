local owncolors = {
    background = '#1d1f21',
    foreground = '#c5c8c6',

    slightlylight = '#788087',
    light = '#4c566a',
    verylight = '#303336',
    yellow = '#8c9440',
    orange = '#a66b30',
    green = '#5e8d6a',
    turquoise = '#5e8d87',
    blue = '#5e81ac',
    _purple = '#477ec2',
    red = '#cd515d',
}

local syntaxgroups = {
    ColorColumn = { fg = owncolors.foreground },
    Conceal = { fg = owncolors.foreground },
    Cursor = { fg = owncolors.foreground },
    lCursor = { fg = owncolors.foreground },
    CursorIM = { fg = owncolors.foreground },
    CursorColumn = { fg = owncolors.foreground },
    CursorLine = { bg = owncolors.verylight },
    Directory = { fg = owncolors.foreground },
    DiffAdd = { fg = owncolors.foreground },
    DiffChange = { fg = owncolors.foreground },
    DiffDelete = { fg = owncolors.foreground },
    DiffText = { fg = owncolors.foreground },
    EndOfBuffer = { fg = owncolors.foreground },
    TermCursor = { fg = owncolors.foreground },
    TermCursorNC = { fg = owncolors.foreground },
    ErrorMsg = { fg = owncolors.red },
    VertSplit = { fg = owncolors.foreground },
    Folded = { fg = owncolors.foreground },
    FoldColumn = { fg = owncolors.foreground },
    SignColumn = { fg = owncolors.foreground },
    IncSearch = { fg = owncolors.foreground },
    Substitute = { fg = owncolors.foreground },
    LineNr = { fg = owncolors.light },
    CursorLineNr = { fg = owncolors.foreground },
    MatchParen = { fg = owncolors.foreground },
    ModeMsg = { fg = owncolors.foreground },
    MsgArea = { fg = owncolors.foreground },
    MsgSeparator = { fg = owncolors.foreground },
    MoreMsg = { fg = owncolors.foreground },
    NonText = { fg = owncolors.foreground },
    Normal = { fg = owncolors.foreground, bg = owncolors.background },
    NormalFloat = { fg = owncolors.foreground },
    NormalNC = { fg = owncolors.foreground },
    Pmenu = { fg = owncolors.foreground },
    PmenuSel = { fg = owncolors.foreground },
    PmenuSbar = { fg = owncolors.foreground },
    PmenuThumb = { fg = owncolors.foreground },
    Question = { fg = owncolors.foreground },
    QuickFixLine = { fg = owncolors.foreground },
    Search = { fg = owncolors.foreground },
    SpecialKey = { fg = owncolors.foreground },
    SpellBad = { fg = owncolors.foreground },
    SpellCap = { fg = owncolors.foreground },
    SpellLocal = { fg = owncolors.foreground },
    SpellRare = { fg = owncolors.foreground },
    StatusLine = { fg = owncolors.foreground },
    StatusLineNC = { fg = owncolors.foreground },
    TabLine = { fg = owncolors.foreground },
    TabLineFill = { fg = owncolors.slightlylight, bg = owncolors.verylight },
    TabLineSel = { fg = owncolors.foreground },
    Title = { fg = owncolors.foreground },
    Visual = { bg = owncolors.verylight },
    VisualNOS = { fg = owncolors.foreground },
    WarningMsg = { fg = owncolors.orange },
    Whitespace = { fg = owncolors.blue },
    WildMenu = { fg = owncolors.foreground },

    Type = { fg = owncolors.blue },
    StorageClass = { fg = owncolors.foreground },
    Structure = { fg = owncolors.foreground },
    Constant = { fg = owncolors.foreground },
    String = { fg = owncolors.yellow },
    Character = { fg = owncolors.foreground },
    Number = { fg = owncolors.foreground },
    Boolean = { fg = owncolors.foreground },
    Float = { fg = owncolors.foreground },
    Statement = { fg = owncolors.foreground },
    Label = { fg = owncolors.foreground },
    Operator = { fg = owncolors.foreground },
    Exception = { fg = owncolors.foreground },
    PreProc = { fg = owncolors.foreground },
    Include = { fg = owncolors.foreground },
    Define = { fg = owncolors.foreground },
    Macro = { fg = owncolors.foreground },
    Typedef = { fg = owncolors.foreground },
    PreCondit = { fg = owncolors.foreground },
    Special = { fg = owncolors.foreground },
    SpecialChar = { fg = owncolors.foreground },
    Tag = { fg = owncolors.foreground },
    Delimiter = { fg = owncolors.foreground },
    SpecialComment = { fg = owncolors.foreground },
    Debug = { fg = owncolors.foreground },
    Underlined = { fg = owncolors.foreground },
    Ignore = { fg = owncolors.foreground },
    Error= { fg = owncolors.red },
    Todo = { fg = owncolors.foreground },
    Comment = { fg = owncolors.light },
    Conditional = { fg = owncolors.foreground },
    Keyword = { fg = owncolors.foreground },
    Repeat = { fg = owncolors.foreground },
    Function = { fg = owncolors.foreground },

    -- Misc
    TSComment = { fg = owncolors.light },
    TSError = { fg = owncolors.red },
    TSPunctDelimiter = { fg = owncolors.foreground },
    TSPunctBracket = { fg = owncolors.foreground },
    TSPunctSpecial = { fg = owncolors.foreground },

    -- Constants
    TSConstant = { fg = owncolors.foreground },
    TSConstBuiltin = { fg = owncolors.foreground },
    TSConstMacro = { fg = owncolors.foreground },
    TSString = { fg = owncolors.yellow },
    TSStringRegex = { fg = owncolors.yellow },
    TSStringEscape = { fg = owncolors.orange },
    TSCharacter = { fg = owncolors.foreground },
    TSNumber = { fg = owncolors.foreground },
    TSBoolean = { fg = owncolors.foreground },
    TSFloat = { fg = owncolors.foreground },
    TSAnnotation = { fg = owncolors.foreground },
    TSAttribute = { fg = owncolors.foreground },
    TSNamespace = { fg = owncolors.foreground },

    -- Functions
    TSFuncBuiltin = { fg = owncolors.foreground },
    TSFunction = { fg = owncolors.turquoise },
    TSFuncMacro = { fg = owncolors.foreground },
    TSParameter = { fg = owncolors.foreground },
    TSParameterReference = { fg = owncolors.foreground },
    TSMethod = { fg = owncolors.turquoise },
    TSField = { fg = owncolors.foreground },
    TSProperty = { fg = owncolors.foreground },
    TSConstructor = { fg = owncolors.foreground },

    -- Keywords
    TSConditional = { fg = owncolors.foreground },
    TSRepeat = { fg = owncolors.foreground },
    TSLabel = { fg = owncolors.foreground },
    TSKeyword = { fg = owncolors.foreground },
    TSKeywordFunction = { fg = owncolors.foreground },
    TSKeywordOperator = { fg = owncolors.foreground },
    TSOperator = { fg = owncolors.foreground },
    TSException = { fg = owncolors.foreground },
    TSType = { fg = owncolors.blue },
    TSTypeBuiltin = { fg = owncolors.blue },
    TSStructure = { fg = owncolors.foreground },
    TSInclude = { fg = owncolors.foreground },

    -- Variable
    TSVariable = { fg = owncolors.foreground },
    TSVariableBuiltin = { fg = owncolors.foreground },

    -- Text
    TSText = { fg = owncolors.foreground },
    TSStrong = { fg = owncolors.foreground },
    TSEmphasis = { fg = owncolors.foreground },
    TSUnderline = { fg = owncolors.foreground },
    TSTitle = { fg = owncolors.foreground },
    TSLiteral = { fg = owncolors.foreground },
    TSURI = { fg = owncolors.foreground },

    -- Tags
    TSTag = { fg = owncolors.foreground },
    TSTagDelimiter = { fg = owncolors.foreground },

    -- LSP
    LspDiagnosticsDefaultError = { fg = owncolors.red },
    LspDiagnosticsSignError = { fg = owncolors.red },
    LspDiagnosticsFloatingError = { fg = owncolors.red },
    LspDiagnosticsVirtualTextError = { fg = owncolors.red },
    LspDiagnosticsUnderlineError = { fg = owncolors.red },
    LspDiagnosticsDefaultWarning = { fg = owncolors.orange },
    LspDiagnosticsSignWarning = { fg = owncolors.orange },
    LspDiagnosticsFloatingWarning = { fg = owncolors.orange },
    LspDiagnosticsVirtualTextWarning = { fg = owncolors.orange },
    LspDiagnosticsUnderlineWarning = { fg = owncolors.orange },
    LspDiagnosticsDefaultInformation = { fg = owncolors.foreground },
    LspDiagnosticsSignInformation = { fg = owncolors.foreground },
    LspDiagnosticsFloatingInformation = { fg = owncolors.foreground },
    LspDiagnosticsVirtualTextInformation = { fg = owncolors.foreground },
    LspDiagnosticsUnderlineInformation = { fg = owncolors.foreground },
    LspDiagnosticsDefaultHint = { fg = owncolors.foreground },
    LspDiagnosticsSignHint = { fg = owncolors.foreground },
    LspDiagnosticsFloatingHint = { fg = owncolors.foreground },
    LspDiagnosticsVirtualTextHint = { fg = owncolors.foreground },
    LspDiagnosticsUnderlineHint = { fg = owncolors.foreground },
    LspReferenceText = { fg = owncolors.foreground },
    LspReferenceRead = { fg = owncolors.foreground },
    LspReferenceWrite = { fg = owncolors.foreground },

    -- Telescope
    TelescopePromptBorder = { fg = owncolors.foreground },
    TelescopeResultsBorder = { fg = owncolors.foreground },
    TelescopePreviewBorder = { fg = owncolors.foreground },
    TelescopeSelectionCaret = { fg = owncolors.foreground },
    TelescopeSelection = { fg = owncolors.foreground },
    TelescopeMatching = { fg = owncolors.foreground },
    TelescopeNormal = { fg = owncolors.foreground },

    -- GitSigns
    GitSignsAdd = { fg = owncolors.foreground },
    GitSignsAddNr = { fg = owncolors.foreground },
    GitSignsAddLn = { fg = owncolors.foreground },
    GitSignsChange = { fg = owncolors.foreground },
    GitSignsChangeNr = { fg = owncolors.foreground },
    GitSignsChangeLn = { fg = owncolors.foreground },
    GitSignsDelete = { fg = owncolors.foreground },
    GitSignsDeleteNr = { fg = owncolors.foreground },
    GitSignsDeleteLn = { fg = owncolors.foreground },

    -- BufferLine
    BufferLineIndicatorSelected = { fg = owncolors.foreground },
    BufferLineFill = { fg = owncolors.foreground },
}

-- sp = special (underline color etc)
owncolors.highlight = function()
    vim.cmd('hi clear')
    if vim.fn.exists('syntax_on') then
        vim.cmd('syntax reset')
    end
    vim.o.background = 'dark'
    vim.o.termguicolors = true
    vim.cmd('se cul')
    for g,c in pairs(syntaxgroups) do
        local style = c.style and 'gui=' .. c.style or 'gui=NONE'
        local fg = c.fg and 'guifg=' .. c.fg or 'guifg=NONE'
        local bg = c.bg and 'guibg=' .. c.bg or 'guibg=NONE'
        local sp = c.sp and 'guisp=' .. c.sp or ''
        vim.cmd('highlight ' .. g .. ' ' .. style .. ' ' .. fg .. ' ' .. bg..' '..sp)
    end
end

owncolors.highlight()

return owncolors

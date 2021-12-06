local owncolors = {
    background = '#1d1f21',
    foreground = '#c5c8c6',

    dark1 =        '#303336',
    dark2 =        '#484d51',
    dark3 =        '#60666c',
    _dark4 =       '#788087',
    _dark5 =       '#93999f',
    _dark6 =       '#aeb3b7',
    yellow =       '#8c9440',
    orange =       '#c48e21', -- warnings
    brown =        '#a66b30', -- string specials
    green =        '#669973',
    darkgreen=     '#5e8d6a',
    turquoise =    '#5e8d87',
    lightblue =   '#418fa4',
    blue =         '#5f819d',
    darkblue =    '#456387',
    purple =      '#8a5c81',
    red =          '#cd515d', -- errors
}

function mapValues()
    owncolors.functions = owncolors.turquoise;
    owncolors.types = owncolors.blue;
    owncolors.fields = owncolors.darkgreen;
    owncolors.keywords = owncolors.blue;
    owncolors.misc = owncolors.darkblue;
    owncolors.values = owncolors.purple;
    owncolors.strings = owncolors.yellow;
end
mapValues()

local syntaxgroups = {
    ColorColumn = { fg = owncolors.foreground },
    Conceal = { fg = owncolors.foreground },
    Cursor = { fg = owncolors.foreground },
    lCursor = { fg = owncolors.foreground },
    CursorIM = { fg = owncolors.foreground },
    CursorColumn = { fg = owncolors.foreground },
    CursorLine = { bg = owncolors.dark1 },
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
    LineNr = { fg = owncolors.dark2 },
    CursorLineNr = { fg = owncolors.foreground },
    MatchParen = { fg = owncolors.foreground },
    ModeMsg = { fg = owncolors.foreground },
    MsgArea = { fg = owncolors.foreground },
    MsgSeparator = { fg = owncolors.foreground },
    MoreMsg = { fg = owncolors.foreground },
    NonText = { fg = owncolors.foreground },
    Normal = { fg = owncolors.foreground, bg = owncolors.background },
    NormalFloat = { fg = owncolors.foreground, bg = owncolors.dark1 },
    NormalNC = { fg = owncolors.foreground },
    Pmenu = { bg = owncolors.dark1 },
    PmenuSel = { bg = owncolors.dark2 },
    PmenuSbar = { fg = owncolors.foreground },
    PmenuThumb = { fg = owncolors.foreground },
    Question = { fg = owncolors.foreground },
    QuickFixLine = { fg = owncolors.foreground },
    Search = { bg = owncolors.dark2 },
    SpecialKey = { fg = owncolors.foreground },
    SpellBad = { fg = owncolors.foreground },
    SpellCap = { fg = owncolors.foreground },
    SpellLocal = { fg = owncolors.foreground },
    SpellRare = { fg = owncolors.foreground },
    StatusLine = { fg = owncolors.foreground },
    StatusLineNC = { fg = owncolors.foreground },
    TabLine = { fg = owncolors.foreground },
    TabLineFill = { fg = owncolors.dark3, bg = owncolors.dark1 },
    TabLineSel = { fg = owncolors.foreground },
    Title = { fg = owncolors.foreground },
    Visual = { bg = owncolors.dark1 },
    VisualNOS = { fg = owncolors.dark1 },
    WarningMsg = { fg = owncolors.orange },
    Whitespace = { fg = owncolors.darkblue },
    WildMenu = { fg = owncolors.dark1 },

    Type = { fg = owncolors.types },
    StorageClass = { fg = owncolors.types },
    Structure = { fg = owncolors.types },
    Constant = { fg = owncolors.misc },
    String = { fg = owncolors.strings },
    Character = { fg = owncolors.values },
    Number = { fg = owncolors.values },
    Boolean = { fg = owncolors.values },
    Float = { fg = owncolors.values },
    Statement = { fg = owncolors.foreground },
    Label = { fg = owncolors.foreground },
    Operator = { fg = owncolors.keywords },
    Exception = { fg = owncolors.keywords },
    PreProc = { fg = owncolors.misc },
    Include = { fg = owncolors.misc },
    Define = { fg = owncolors.misc },
    Macro = { fg = owncolors.misc },
    Typedef = { fg = owncolors.types },
    PreCondit = { fg = owncolors.misc },
    Special = { fg = owncolors.brown },
    SpecialChar = { fg = owncolors.brown },
    Tag = { fg = owncolors.types },
    Delimiter = { fg = owncolors.keywords },
    SpecialComment = { fg = owncolors.foreground },
    Debug = { fg = owncolors.foreground },
    Underlined = { fg = owncolors.foreground },
    Ignore = { fg = owncolors.foreground },
    Error= { fg = owncolors.red },
    Todo = { fg = owncolors.orange },
    Comment = { fg = owncolors.dark3 },
    Conditional = { fg = owncolors.keywords },
    Keyword = { fg = owncolors.keywords },
    Repeat = { fg = owncolors.keywords },
    Function = { fg = owncolors.functions },

    -- Misc
    TSComment = { fg = owncolors.dark3 },
    TSError = { fg = owncolors.red },
    TSPunctDelimiter = { fg = owncolors.foreground },
    TSPunctBracket = { fg = owncolors.foreground },
    TSPunctSpecial = { fg = owncolors.foreground },

    -- Constants
    TSConstant = { fg = owncolors.misc },
    TSConstBuiltin = { fg = owncolors.misc },
    TSConstMacro = { fg = owncolors.misc },
    TSString = { fg = owncolors.strings },
    TSStringRegex = { fg = owncolors.strings },
    TSStringEscape = { fg = owncolors.brown },
    TSCharacter = { fg = owncolors.brown },
    TSNumber = { fg = owncolors.values },
    TSBoolean = { fg = owncolors.values },
    TSFloat = { fg = owncolors.values },
    TSAnnotation = { fg = owncolors.misc },
    TSAttribute = { fg = owncolors.foreground },
    TSNamespace = { fg = owncolors.types },

    -- Functions
    TSFuncBuiltin = { fg = owncolors.functions },
    TSFunction = { fg = owncolors.functions },
    TSFuncMacro = { fg = owncolors.misc },
    TSParameter = { fg = owncolors.fields },
    TSParameterReference = { fg = owncolors.fields },
    TSMethod = { fg = owncolors.functions },
    TSField = { fg = owncolors.fields },
    TSProperty = { fg = owncolors.fields },
    TSConstructor = { fg = owncolors.functions },

    -- Keywords
    TSConditional = { fg = owncolors.keywords },
    TSRepeat = { fg = owncolors.keywords },
    TSLabel = { fg = owncolors.keywords },
    TSKeyword = { fg = owncolors.keywords },
    TSKeywordFunction = { fg = owncolors.keywords },
    TSKeywordOperator = { fg = owncolors.keywords },
    TSOperator = { fg = owncolors.keywords },
    TSException = { fg = owncolors.keywords },
    TSType = { fg = owncolors.types },
    TSTypeBuiltin = { fg = owncolors.types },
    TSStructure = { fg = owncolors.types },
    TSInclude = { fg = owncolors.misc },

    -- Variable
    TSVariable = { fg = owncolors.foreground },
    TSVariableBuiltin = { fg = owncolors.foreground },

    -- Text
    TSText = { fg = owncolors.strings },
    TSString = { fg = owncolors.strings },
    TSEmphasis = { fg = owncolors.foreground },
    TSUnderline = { fg = owncolors.foreground },
    TSTitle = { fg = owncolors.foreground },
    TSLiteral = { fg = owncolors.foreground },
    TSURI = { fg = owncolors.foreground },

    -- Tags
    TSTag = { fg = owncolors.types },
    TSTagDelimiter = { fg = owncolors.keywords },

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
    LspDiagnosticsDefaultInformation = { fg = owncolors.dark3 },
    LspDiagnosticsSignInformation = { fg = owncolors.dark3 },
    LspDiagnosticsFloatingInformation = { fg = owncolors.dark3 },
    LspDiagnosticsVirtualTextInformation = { fg = owncolors.dark3 },
    LspDiagnosticsUnderlineInformation = { fg = owncolors.dark3 },
    LspDiagnosticsDefaultHint = { fg = owncolors.yellow },
    LspDiagnosticsSignHint = { fg = owncolors.yellow },
    LspDiagnosticsFloatingHint = { fg = owncolors.yellow },
    LspDiagnosticsVirtualTextHint = { fg = owncolors.yellow },
    LspDiagnosticsUnderlineHint = { fg = owncolors.yellow },
    LspReferenceText = { fg = owncolors.foreground },
    LspReferenceRead = { fg = owncolors.foreground },
    LspReferenceWrite = { fg = owncolors.foreground },

    -- Compe
    CompeDocumentation = { fg = owncolors.foreground, bg = owncolors.dark1 },
    CompeDocumentationBorder = { fg = owncolors.foreground },

    -- Telescope
    TelescopePromptBorder = { fg = owncolors.dark3 },
    TelescopeResultsBorder = { fg = owncolors.dark3 },
    TelescopePreviewBorder = { fg = owncolors.dark3 },
    TelescopeSelectionCaret = { fg = owncolors.foreground },
    TelescopeSelection = { bg = owncolors.dark1 },
    TelescopeMatching = { fg = owncolors.turquoise },
    TelescopeNormal = { fg = owncolors.foreground },

    -- GitSigns
    GitSignsAdd = { fg = owncolors.green },
    GitSignsAddNr = { fg = owncolors.green },
    GitSignsAddLn = { fg = owncolors.green },
    GitSignsChange = { fg = owncolors.orange },
    GitSignsChangeNr = { fg = owncolors.orange },
    GitSignsChangeLn = { fg = owncolors.orange },
    GitSignsDelete = { fg = owncolors.red },
    GitSignsDeleteNr = { fg = owncolors.red },
    GitSignsDeleteLn = { fg = owncolors.red },
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

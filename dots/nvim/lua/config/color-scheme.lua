local M = {}

local colors = {
	n0 = "#060606",
	n1 = "#111111",
	n2 = "#141414",
	n3 = "#1F1F1F",
	n4 = "#383838",
	t0 = "#F2F2F2",
	t1 = "#E5E5E5",
	t2 = "#C2C2C2",
	t3 = "#9F9F9F",
	red = "#FF7272",
	orange = "#FFAD72",
	yellow = "#FFDE72",
	green = "#A8FF72",
	neon_green = "#72FF7B",
	cyan = "#72E0FF",
	blue = "#72BBFF",
	purple = "#C272FF",
	pink = "#FF72F6",
}

local function setupSyntaxHighlighting()
	vim.api.nvim_set_hl(0, "Comment", { fg = colors.t3 })
	vim.api.nvim_set_hl(0, "Constant", { fg = colors.orange })
	vim.api.nvim_set_hl(0, "String", { fg = colors.green })
	vim.api.nvim_set_hl(0, "Character", { fg = colors.green })
	vim.api.nvim_set_hl(0, "Number", { fg = colors.orange })
	vim.api.nvim_set_hl(0, "Boolean", { fg = colors.orange })
	vim.api.nvim_set_hl(0, "Float", { fg = colors.orange })

	vim.api.nvim_set_hl(0, "Identifier", { fg = colors.t0 })
	vim.api.nvim_set_hl(0, "Function", { fg = colors.blue })

	vim.api.nvim_set_hl(0, "Statement", { fg = colors.pink })
	vim.api.nvim_set_hl(0, "Conditional", { fg = colors.pink })
	vim.api.nvim_set_hl(0, "Repeat", { fg = colors.pink })
	vim.api.nvim_set_hl(0, "Label", { fg = colors.pink })
	vim.api.nvim_set_hl(0, "Operator", { fg = colors.t1 })
	vim.api.nvim_set_hl(0, "Keyword", { fg = colors.pink })
	vim.api.nvim_set_hl(0, "Exception", { fg = colors.pink })

	vim.api.nvim_set_hl(0, "PreProc", { fg = colors.orange })
	vim.api.nvim_set_hl(0, "Include", { fg = colors.pink })
	vim.api.nvim_set_hl(0, "Define", { fg = colors.orange })
	vim.api.nvim_set_hl(0, "Macro", { fg = colors.orange })
	vim.api.nvim_set_hl(0, "PreCondit", { fg = colors.orange })

	vim.api.nvim_set_hl(0, "Type", { fg = colors.yellow })
	vim.api.nvim_set_hl(0, "StorageClass", { fg = colors.pink })
	vim.api.nvim_set_hl(0, "Structure", { fg = colors.pink })
	vim.api.nvim_set_hl(0, "Typedef", { fg = colors.pink })

	vim.api.nvim_set_hl(0, "Special", { fg = colors.orange })
	vim.api.nvim_set_hl(0, "SpecialChar", { fg = colors.green })
	vim.api.nvim_set_hl(0, "Tag", { fg = colors.blue })
	vim.api.nvim_set_hl(0, "SpecialComment", { fg = colors.t2 })
	vim.api.nvim_set_hl(0, "Debug", { fg = colors.pink })

	vim.api.nvim_set_hl(0, "Underlined", { fg = colors.t0 })

	vim.api.nvim_set_hl(0, "Ignore", { fg = colors.t3 })

	vim.api.nvim_set_hl(0, "Error", { fg = colors.n0, bg = colors.red })

	vim.api.nvim_set_hl(0, "Todo", { fg = colors.orange })

	vim.api.nvim_set_hl(0, "Added", { fg = colors.green })
	vim.api.nvim_set_hl(0, "Changed", { fg = colors.yellow })
	vim.api.nvim_set_hl(0, "Removed", { fg = colors.red })

	vim.api.nvim_set_hl(0, "TodoFgTODO", { fg = colors.orange })
	vim.api.nvim_set_hl(0, "TodoBgTODO", { bg = colors.orange, fg = colors.n0 })
end

local function setupPlugins()
	-- NeoTree
	vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = colors.yellow })
	vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = colors.orange })
	vim.api.nvim_set_hl(0, "NeoTreeFileName", { fg = colors.t1 })
	vim.api.nvim_set_hl(0, "NeoTreeMessage", { fg = colors.t3 })
	vim.api.nvim_set_hl(0, "NeoTreeFileStats", { fg = colors.t3 })
	vim.api.nvim_set_hl(0, "NeoTreeFileStatsHeader", { fg = colors.t3 })
	vim.api.nvim_set_hl(0, "NeoTreeFloatBorder", { fg = colors.n4 })
	vim.api.nvim_set_hl(0, "NeoTreeTitleBar", { fg = colors.t0, bg = colors.n4 })
	vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = colors.red })

	-- BufferLine
	vim.api.nvim_set_hl(0, "BufferLineFill", { fg = colors.n2 })
	vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = colors.n1, fg = colors.t2 })
	vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { bg = colors.n2, fg = colors.t0 })
	vim.api.nvim_set_hl(0, "BufferLineCloseButtonVisible", { bg = colors.n2, fg = colors.t0 })
	vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = colors.n2, fg = colors.t0 })
	vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { bg = colors.n2, fg = colors.t0 })
	vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { bg = colors.n2, fg = colors.t0 })
	vim.api.nvim_set_hl(0, "BufferLineIndicatorVisible", { bg = colors.n2, fg = colors.t0 })
	vim.api.nvim_set_hl(0, "BufferLineDevIconRsSelected", { bg = colors.n2, fg = colors.orange })
	vim.api.nvim_set_hl(0, "BufferLineDevIconRsVisible", { bg = colors.n2, fg = colors.orange })
	vim.api.nvim_set_hl(0, "BufferLineDevIconDefaultSelected", { bg = colors.n2 })
	vim.api.nvim_set_hl(0, "BufferLineDevIconDefaultVisible", { bg = colors.n2 })
	vim.api.nvim_set_hl(0, "BufferLineDevIconLuaSelected", { bg = colors.n2, fg = colors.blue })
	vim.api.nvim_set_hl(0, "BufferLineDevIconLuaVisible", { bg = colors.n2, fg = colors.blue })
	vim.api.nvim_set_hl(0, "BufferLineSeperator", { bg = colors.n2 })
	vim.api.nvim_set_hl(0, "BufferLineSeperatorSelected", { bg = colors.n2 })
	vim.api.nvim_set_hl(0, "BufferLineSeperatorVisible", { bg = colors.n2 })
end

function M.setup()
	setupSyntaxHighlighting()
	setupPlugins()

	vim.api.nvim_set_hl(0, "Normal", { fg = colors.t0, bg = colors.n2 })
	vim.api.nvim_set_hl(0, "Delimiter", { fg = colors.t2 })
	vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = colors.t2 })
	vim.api.nvim_set_hl(0, "@variable", { fg = colors.t0 })

	vim.api.nvim_set_hl(0, "CursorLine", { bg = colors.n3 })

	vim.api.nvim_set_hl(0, "LineNr", { fg = colors.t3 }) -- Line Numbers
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.t0 }) -- Current Line Number

	vim.api.nvim_set_hl(0, "Directory", { fg = colors.t0 }) -- Folders (NeoTree) (Accent)

	vim.api.nvim_set_hl(0, "ColorColumn", { bg = colors.n3 }) -- Line length divider

	vim.api.nvim_set_hl(0, "Cursor", { bg = colors.n1, fg = colors.t0 }) -- Normal box
	vim.api.nvim_set_hl(0, "DiffText", { bg = colors.blue, fg = colors.n0 })
	vim.api.nvim_set_hl(0, "DiffChange", { bg = colors.n4, fg = colors.t0 })
	vim.api.nvim_set_hl(0, "DiffAdd", { bg = colors.green, fg = colors.n4 })

	vim.api.nvim_set_hl(0, "StatusLine", { bg = colors.n1, fg = colors.t0 }) -- Status Bar Items
	vim.api.nvim_set_hl(0, "StatusLineNC", { bg = colors.n3, fg = colors.t0 }) -- Status Bar Items

	-- Tabs
	vim.api.nvim_set_hl(0, "TabLine", { bg = colors.n2, fg = colors.t3 })
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = colors.n2 })
	vim.api.nvim_set_hl(0, "TabLineSel", { bg = colors.n2, fg = colors.t0 })

	-- Popup Menu
	vim.api.nvim_set_hl(0, "Pmenu", { bg = colors.n4, fg = colors.t0 })
	vim.api.nvim_set_hl(0, "PmenuSel", { bg = colors.n3, fg = colors.yellow })
	vim.api.nvim_set_hl(0, "PmenuThumb", { bg = colors.n3, fg = colors.t0 })

	vim.api.nvim_set_hl(0, "Visual", { bg = colors.n4 })
	vim.api.nvim_set_hl(0, "VisualNOS", { bg = colors.n4 })

	vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.n1, fg = colors.t0 })

	vim.api.nvim_set_hl(0, "MoreMsg", { bg = colors.yellow, fg = colors.n0 }) -- (Accent)
	vim.api.nvim_set_hl(0, "ModeMsg", { bg = colors.yellow, fg = colors.n0 }) -- (Accent)
	vim.api.nvim_set_hl(0, "Search", { bg = colors.yellow, fg = colors.n0 }) -- (Accent)
	vim.api.nvim_set_hl(0, "IncSearch", { bg = colors.yellow, fg = colors.n0 }) -- (Accent)
	vim.api.nvim_set_hl(0, "Substitute", { bg = colors.yellow, fg = colors.n0 }) -- (Accent)
	vim.api.nvim_set_hl(0, "WildMenu", { bg = colors.yellow, fg = colors.n0 }) -- (Accent)
	vim.api.nvim_set_hl(0, "Question", { fg = colors.yellow }) -- (Accent)
	vim.api.nvim_set_hl(0, "QuickFixLine", { fg = colors.yellow }) -- (Accent)
	vim.api.nvim_set_hl(0, "WarningMsg", { fg = colors.yellow })

	vim.api.nvim_set_hl(0, "SpecialKey", { fg = colors.t3 })
	vim.api.nvim_set_hl(0, "Conceal", { fg = colors.t3 })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = colors.t3 })
	vim.api.nvim_set_hl(0, "FoldColumn", { fg = colors.t3 })
	vim.api.nvim_set_hl(0, "SignColumn", { fg = colors.t3 })
	vim.api.nvim_set_hl(0, "CursorLineFold", { fg = colors.t3 })
	vim.api.nvim_set_hl(0, "CursorLineSign", { fg = colors.t3 })
	vim.api.nvim_set_hl(0, "NonText", { fg = colors.t3 })

	vim.api.nvim_set_hl(0, "DiffDelete", { fg = colors.red })
	vim.api.nvim_set_hl(0, "ErrorMsg", { fg = colors.red })

	vim.api.nvim_set_hl(0, "TelescopeMatching", { bg = colors.yellow, fg = colors.n0 })

	vim.api.nvim_set_hl(0, "Folded", { bg = colors.n3, fg = colors.t2 })
end

return M

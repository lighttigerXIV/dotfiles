-- Tabs
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- Don't Wrap Lines
vim.cmd("set wrap!")

-- Copy To Clipboard
vim.cmd("set clipboard+=unnamedplus")

-- Numbers In Every File
vim.cmd("set nu")

-- Leader Shortcut
vim.g.mapleader = " "

-- Show Errors
vim.api.nvim_set_keymap("n", "<M-p>", ":lua vim.diagnostic.goto_prev()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<M-n>", ":lua vim.diagnostic.goto_next()<CR>", { noremap = true })

-- Scrolling Keybindings
vim.keymap.set({"n", "i"}, "<C-h>", "20zh", {}); --Scroll To The Left
vim.keymap.set({"n", "i"}, "<C-l>", "20zl", {}); --Scroll To The Right

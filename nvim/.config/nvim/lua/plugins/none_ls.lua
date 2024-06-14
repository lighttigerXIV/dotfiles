-- Plugin to format the code

return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
               null_ls.builtins.formatting.stylua,
               null_ls.builtins.formatting.prettier,
               null_ls.builtins.formatting.autopep8,
               null_ls.builtins.formatting.autoflake,
               null_ls.builtins.diagnostics.eslint_d,
            },
        })

        vim.keymap.set("n", "<C-i>", vim.lsp.buf.format, {})
    end,
}

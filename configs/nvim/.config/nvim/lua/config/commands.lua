vim.api.nvim_create_user_command("FormatJson", function()
	vim.cmd("%!jq")
end, {})

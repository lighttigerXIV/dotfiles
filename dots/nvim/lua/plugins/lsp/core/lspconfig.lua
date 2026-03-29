return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
		},

		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("ca", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
					map("gr", require("telescope.builtin").lsp_references, "References")
					map("gi", require("telescope.builtin").lsp_implementations, "Implementations")
					map("gd", require("telescope.builtin").lsp_definitions, "Definition")
					map("gt", require("telescope.builtin").lsp_type_definitions, "Type Definition")

					------------- Variable highlighting ----------------

					-- Checks if lsp support variable highlighting
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					local client = vim.lsp.get_client_by_id(event.data.client_id)

					-- If it supports variable highlighting
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })

						-- Highlights when stopping the cursor
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						-- Clear the highlights when cursor moves
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						-- Clear highlighting if buffer is closed
						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- Show highlighting after 250ms
					vim.opt.updatetime = 250
				end,
			})

			-- Shows symbols instead of E, W, I, H
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},

				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}

						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local language_servers = {
				lua_ls = {
					settings = {
						Lua = { completion = { callSnippet = "Replace" } },
					},
				},
				rust_analyzer = {
					settings = {
						cargo = { allFeatures = true },
					},
				},
				svelte = {
					settings = {
						svelte = { plugin = { typescript = { enable = true } } },
					},
					on_attach = function(_, _)
						-- Restart LSP if changes were made in typescript/javascript files
						vim.api.nvim_create_autocmd("BufWritePost", {
							pattern = { "*.ts", "*.js" },

							callback = function(_)
								vim.cmd("LspRestart svelte")
							end,
						})
					end,
				},
				ts_ls = {
					filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				},
				tailwindcss = {
					filetypes = {
						"html",
						"css",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"svelte",
					},

					root_markers = {
						"tailwind.config.js",
						"tailwind.config.ts",
						"postcss.config.js",
						"package.json",
					},
				},
			}

			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Lua
					"stylua",
					"lua-language-server",

					-- Rust
					"rust-analyzer",

					-- Svelte
					"svelte-language-server",

					-- TypeScript
					"ts_ls",

					-- Tailwind
					"tailwindcss-language-server",

					-- Python
					"pylsp",

					-- CSS
					"cssls",

					-- General
					"prettier",
				},
			})

			-- Load servers, capabilities and tools
			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = language_servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}

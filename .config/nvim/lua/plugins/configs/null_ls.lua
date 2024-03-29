local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

mason_null_ls.setup({
	ensure_installed = { "prettier", "prettierd", "stylua", "eslint_d" },
})

local builtins = null_ls.builtins
local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
	on_attach = function(client, bufnr)
		if client.name == "html" then
			client.server_capabilities.documentFormattingProvider = false
		end

		if client.supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<Leader>fm", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })

			-- format on save
			vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
			vim.api.nvim_create_autocmd(event, {
				buffer = bufnr,
				group = group,
				callback = function()
					vim.lsp.buf.format({
						filter = function()
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
						async = async,
					})
				end,
				desc = "[lsp] format on save",
			})
		end

		if client.supports_method("textDocument/rangeFormatting") then
			vim.keymap.set("x", "<Leader>fm", function()
				vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
			end, { buffer = bufnr, desc = "[lsp] format" })
		end
	end,
	sources = {
		-- Web formatter & diagnostics
		builtins.formatting.prettier.with({
			filetypes = {
				"html",
				"json",
				"css",
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
			},
		}),

		builtins.diagnostics.eslint_d.with({
			diagnostics_format = "[eslint] #{m}\n(#{c})",
			command = "eslint_d",
			args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" },
		}),

		-- Python formatter & diagnostics
		builtins.diagnostics.flake8.with({
			filetypes = { "python" },
			command = "flake8",
			args = { "--stdin-display-name", "$FILENAME", "-" },
		}),

		builtins.formatting.black.with({
			filetypes = { "python" },
			command = "black",
			args = { "--quiet", "--fast", "-" },
		}),

		-- C/CPP formatter
		builtins.formatting.clang_format.with({
			filetypes = { "c", "cpp", "cs" },
			command = "clang-format",
		}),

		-- Lua
		builtins.formatting.stylua.with({
			filetypes = { "lua" },
		}),

		-- -- Shell
		builtins.formatting.shfmt,
		builtins.diagnostics.shellcheck.with({
			diagnostics_format = "#{m} [#{c}]",
		}),
	},
})

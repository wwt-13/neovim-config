local status, null_ls = pcall(require, "null-ls")

if not status then
	vim.notify("null-ls not find!")
	return
end

local formatting = null_ls.builtins.formatting

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
null_ls.setup({
	debug = false,
	-- 格式化源配置(所有源均需提前安装好)
	sources = {
		-- shell format
		formatting.shfmt,
		-- lua format
		formatting.stylua,
		-- c format
		formatting.clang_format.with({
			extra_args = {
				-- Microsoft应该就是Vscode默认的格式化方案,非常的美味
				"-style=Microsoft",
			},
		}),
		-- fontend
		formatting.prettier.with({
			filetypes = {
				"javascript",
				"typescript",
				"vue",
				"css",
				"html",
				"json",
				"yaml",
			},
		}),
	},
	-- 不需要保存自动格式化,所以不配置
})

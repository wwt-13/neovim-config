-- 配置自动补全
local status, cmp = pcall(require, "cmp")

if not status then
	vim.notify("cmp not find!")
	return
end


cmp.setup({
	-- 指定snippet引擎
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	-- 指定补全源
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
	}, { { name = "buffer" }, { name = "path" }, }),
	-- 快捷键设置
	mapping = require("keybindings").cmp(cmp),
	-- 使用lspkind-nvim显示类型图标
	formatting = require('lsp.ui').formatting
})

-- / 查找模式使用buffer源
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- normal模式使用path和cmdline源
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

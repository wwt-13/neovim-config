local status, indent_blankline = pcall(require, "indent_blankline")
if not status then
	vim.notify("indent_blankline not find!")
end

indent_blankline.setup({
	-- 空行占位
	space_char_blankline = " ",
	-- 用 treesitter 判断上下文
	show_current_context = true,
	show_current_context_start = true,
	context_patterns = {
		"class",
		"function",
		"method",
		"element",
		"^if",
		"^while",
		"^for",
		"^object",
		"^table",
		"block",
		"arguments",
	},
	-- 需要注意的是该插件会在任何界面添加该竖线
	-- 如果你还在哪个不该出现竖线的窗口中看到了竖线,可以使用下面的命令输出当前文件类型,再在该文件中排除它即可
	-- :echo &filetype
	filetype_exclude = {
		"dashboard",
		"packer",
		"terminal",
		"help",
		"log",
		"markdown",
		"TelescopePrompt",
		"lsp-installer",
		"lspinfo",
		"toggleterm",
	},
	-- 竖线样式
	-- char = '¦'
	-- char = '┆'
	-- char = '│'
	-- char = "⎸",
	char = "▏",
})

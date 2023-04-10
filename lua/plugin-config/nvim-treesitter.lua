local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	vim.notify("nvim-treesitter not find!")
	return
end

-- 设置treesitter
treesitter.setup({
	-- 指定要安装的语言高亮支持
	-- 查看支持的语言列表https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
	ensure_installed = {
		'json',
		'html','css','javascript',
		'lua',
		'typescript',
		'c','cpp','cmake','make',
		'python',
		'java',
		'sql',
		'bash',
	},
	-- 启用语法高亮模块
	highlight = {
		enable = true,
		-- 关闭vim语法的正则高亮(不知道为啥要要设置)
		additional_vim_regex_highlighting = false,
	},
})

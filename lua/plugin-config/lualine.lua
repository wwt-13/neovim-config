local status,lualine = pcall(require,"lualine")
if not status then
	vim.notify("lualine not find!")
	return
end

-- lualine的配置参数主要有options,extensions,sections
-- options用于设置样式,extensions设置lualine支持的拓展,sections用于设置不同的分段所需显示的功能模块
lualine.setup({
	options = {
		-- theme设置主题配色,可以设置为auto or 指定主题
		theme = "tokyonight",
		-- 设置分段分隔符
		component_separators = {left="|",right="|"},
		-- 设置分段中的组件分隔符
		section_separators = {left="  ",right="  "},
	},
	extensions = {"nvim-tree","toggleterm"},
	-- 分段格式:这里只对C和X的部分进行修改
-----------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-----------------------------------------------------+
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {
			'filename',
			{
				'lsp_progress',
				-- 设置进度显示(由之前安装的lsp-progress提供)
				spinner_symbols = { " ", " ", " ", " ", " ", " " },
			},
		},
		-- 因为lualine默认的fileformat是用图标先显示的,不是很直观,这里换成和VsCode一致的LF/CRLF/CR格式
		lualine_x = {
			'filesize',
			{
				'fileformat',
				symbols = {
					unix = "LF",
					dos = "CRLF",
					mac = "CR",
				},
			},
			'encoding',
			'filetype',
		},
		lualine_y = {'progress'},
		lualine_z = {'location'},
	},
})
-- 该插件不需要定义快捷键

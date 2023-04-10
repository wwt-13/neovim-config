-- 这里放置对于主题的自定义设置
-- 注意该部分必须在设置主题之前加载
-- 设置参考https://github.com/folke/tokyonight.nvim
require("tokyonight").setup({
	style = "day",
	styles = {
		comments = { italic=true },
		keywords = { italic=true },
	},
})

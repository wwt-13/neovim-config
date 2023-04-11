vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- 快捷键映射指令为vim.api.nvim_set_keymap,每次都输一遍有点长,这里设置一个本地变量用于简化操作
local map = vim.api.nvim_set_keymap
-- 同理设置opt,noremap表示不连续映射,比方说A->B,B->C,A不会映射到C,silent表示不会输出多余信息
local opt = { noremap = true, silent = true }
-- 这样定义后,设置快捷键映射的指令就变成了map('模式','按键','映射为',opt)
-- 模式字母表示(n Normal模式,i insert模式,v Visual模式,t Termainal模式.c Command模式)
-- 下面实现窗口管理功能
-- 先取消s默认功能
map("n", "s", "", opt)
-- split vertically
map("n", "sv", ":vsp<CR>", opt)
-- split horizontally
map("n", "sh", ":sp<CR>", opt)
-- split close:关闭当前
map("n", "sc", "<C-w>c", opt)
-- split close other
map("n", "so", "<C-w>o", opt)
-- 个人认为窗口比例调整和窗口选择直接鼠标就能代劳
-- 行移动
map("n", "<C-S-Up>", ":m .-2<CR>", opt)
map("n", "<C-S-Down>", ":m .+1<CR>", opt)
-- 代码块移动,参考自 -> https://www.chiarulli.me/Neovim-2/02-keymaps/
map("v", "<C-S-Up>", ":move '<-2<CR>gv-gv", opt)
map("v", "<C-S-Down>", ":move '>+1<CR>gv-gv", opt)

-- 快捷进入terminal模式
-- 打开terminal
map("n", "<leader>t", ":sp | terminal<CR>", opt)
-- 在侧边窗口打开terminal
map("n", "<leader>vt", ":vsp | terminal<CR>", opt)
-- 退出terminal(不知道为啥,这一步的设置总是失败)
-- map("t", "<Esc>", "<C-\\><C-n>", opt)

-- 设置侧边栏快捷键
local pluginKeys = {}

map("n", "<C-t>", ":NvimTreeToggle<CR>", opt)
pluginKeys.nvimTreeList = {
	-- 打开文件or文件夹
	{ key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
	-- 分屏打开文件
	{ key = "v", action = "vsplit" },
	{ key = "h", action = "split" },
	-- 显示隐藏文件
	-- 显示自定义隐藏文件
	{ key = "i", action = "toggle_custom" },
	{ key = ".", action = "toggle_dotfiles" },
	-- 文件操作
	{ key = "<C-r>", action = "refresh" },
	-- 创建文件夹, a --> xxx/ 即可
	{ key = "d", action = "remove" },
	{ key = "a", action = "create" },
	{ key = "r", action = "rename" },
	{ key = "x", action = "cut" },
	{ key = "c", action = "copy" },
	{ key = "p", action = "paste" },
	{ key = "I", action = "toggle_file_info" },
	-- { key = "s", action = "system_open" },
}

-- bufferline
-- 左右Tab切换(需要注意的是,原来侧边栏并不算一个Tab)
map("n", "<C-p>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-n>", ":BufferLineCycleNext<CR>", opt)
-- 关闭
-- "moll/vim-bbye"
map("n", "<C-w>", ":Bdelete!<CR>", opt)
map("n", "<leader>cr", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>cl", ":BufferLineCloseLeft<CR>", opt)
-- close current
map("n", "<leader>cc", ":BufferLinePickClose<CR>", opt)

-- 定义模糊查找快捷键
-- 文件名查找
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- 文件内容搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)

-- 定义LSP快捷键
-- 存在bug无法使用,先注释掉
-- pluginKeys.mapLSP = function(mapbuf)
-- rename
-- mapbuf("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
-- code action
-- mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
-- go xx
-- 代码悬停提示
-- mapbuf('n', '<leader>p','<cm:d>lua vim.lsp.buf.type_definition()<CR>', opt)
--	mapbuf("n", "gD", "vim.lsp.buf.declaration", opt)
--	mapbuf("n", "gi", "vim.lsp.buf.implementation", opt)
-- diagnostic
--	mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
--	mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
--	mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
--	mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
-- end

-- 定义LSP快捷键(暂时)
-- 跳转到定义
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
-- 跳转到声明(不支持)
-- map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opt)
-- 跳转到实现(同样不支持)
-- map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opt)
-- 代码悬停提示
map("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
-- 代码保存+格式化
map("n", "<C-s>", "<cmd>lua vim.lsp.buf.format{async=true}<CR>", opt)
-- 显示浮窗(一般是显示报错)
map("n", "se", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)

-- 设置自动补全
pluginKeys.cmp = function(cmp)
	return {
		-- 出现补全
		["<C-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- 取消
		["<C-,>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- 确认(使用Tab是因为<CR>非常容易误触)
		["<Tab>"] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		-- 需要注意的是,命令行中的快捷键上下选择被设置成了官方默认Tab/Shift+Tab
		-- 上一个
		["<Up>"] = cmp.mapping.select_prev_item(),
		-- 下一个
		["<Down>"] = cmp.mapping.select_next_item(),
	}
end

return pluginKeys

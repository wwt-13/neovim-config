-- 设置光标样式为竖线(其中Cursor/lCursor为设置高对比度Cursor)
vim.o.guicursor = "a:ver30-blinkwait300-blinkon200-blinkoff150-Cursor/lCursor"

-- vim.o.guicursor="a:ver25-blinkon0"
-- utf-8
vim.g.encoding="utf-8"
vim.o.fileencoding="utf-8"
-- 高亮所在行
vim.wo.cursorline=true
-- 设置行号
vim.wo.number=true
-- 显示左侧图标指示列(在左侧留出一列用于显示符号)
vim.wo.signcolumn="yes"
-- 设置缩进
vim.o.tabstop=4
vim.bo.tabstop=4
vim.o.shiftwidth=4
vim.bo.shiftwidth=4
-- 自动对齐
vim.o.autoindent=true
vim.bo.autoindent=true
vim.o.smartindent=true
-- 搜索大小写不敏感,除非专门搜索大写
vim.o.ignorecase=true
vim.o.smartcase=true
-- 搜索高亮
vim.o.hlsearch=true
-- 边输入边搜索
vim.o.incsearch=true
-- 设置命令行高为2,提供足够的显示空间
vim.o.cmdheight=2
-- 文件被外部程序修改时,会自动加载
vim.o.autoread=true
vim.bo.autoread=true
-- 禁止自动换行
vim.wo.wrap=false
-- 光标可以移动到下一行(vim中光标默认只能在当前行移动)
vim.o.whichwrap='<,>,[,]'
-- 允许在未保存当前缓冲区内容时切换到其他缓冲区
vim.o.hidden=true
-- 提供鼠标支持
vim.o.mouse="a"
-- 禁止创建备份文件(.swp)
vim.o.backup=false
vim.o.writebackup=false
vim.o.swapfile=false
-- 设置自动保存时间(个人认为保存操作还是手动更好)
-- vim.o.updatetime=300
-- split window从下边和右边出现
vim.o.splitbelow=true
vim.o.splitright=true
-- 设置自动补全选项(简单菜单,一次选择,不插入文本,不自动选择第一行)?(这里还不太理解)
vim.o.completeopt="menu,menuone,noselect,noinsert"
-- 设置样式
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true
-- 永远显示tabline(后续插件需求)
vim.o.showtabline=2
-- 补全增强
vim.o.wildmenu=true
-- 关闭nvim模式显示(因为后续的插件涵盖了该功能)
vim.o.showmode=false

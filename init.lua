-- basic基础设置
-- require 函数通常用于在lua中加载一个模块,该模块通常位于当前目录(runtimepath)中的lua/目录下
-- 也就是说这里我们需要~/.config/nvim/nvim/lua/basic.lua文件
require("basic")
-- 快捷键设置
require("keybindings")
-- 插件管理设置
require("plugins")
-- 主题自定义设置
require("plugin-config.self-colorscheme")
-- 主题设置
require("colorscheme")
-- 侧边栏插件配置
require("plugin-config.nvim-tree")
-- 设置标签栏
require("plugin-config.bufferline")
-- 设置状态栏
require("plugin-config.lualine")
-- 代码高亮设置
require("plugin-config.nvim-treesitter")
-- 内置LSP
require("lsp.setup")
-- 代码补全
require("lsp.cmp")
-- ui美化(非插件)
require("lsp.ui")
-- 上下文竖线
require("plugin-config.indent-blankline")
-- 代码格式化
require("lsp.null-ls")
-- 启动页自定义
require("plugin-config.db")

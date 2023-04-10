-- 配置生效后，Neovim 会增加以下命令
-- :PackerCompile 每次改变插件配置时(也就是plugins.lua文件)，必须运行此命令或 PackerSync, 重新生成编译的加载文件
-- :PackerClean 清除所有不用的插件
-- :PackerInstall 清除,然后安装缺失的插件
-- :PackerUpdate 清除,然后更新并安装插件
-- :PackerSync 执行 PackerUpdate 后，再执行 PackerCompile
-- :PackerLoad 立刻加载 opt 插件

-- 综上所诉,每次修改plugins.lua后,只需要执行一次:PackerSync即可

-- 执行后发现系统缺失lua解释器luajit,需要先通过apt-get安装再将neovim链接到正确的luajit库
-- 将 LuaJIT 添加到 package.path 中(目前报错问题仍未解决)
-- package.path = package.path .. ';' .. '/usr/share/luajit-2.1.0-beta3/jit/?.lua;'
-- package.path = package.path .. ";~/.local/share/nvim/site/pack/packer/start/?.lua"


-- 指定 Neovim 使用 LuaJIT
-- vim.cmd('set rtp+=/usr/share/luajit-2.1.0-beta3/')
-- vim.g.loaded_luajit = true

local packer = require("packer")
packer.startup({
	function(use)
		-- Packer可以自己管理自己
		use("wbthomason/packer.nvim")
		-- use后面跟的插件如果本地没有会自动到github上下载
		-- name/repo 对应github 的地址
		-- 例如上边代码中的 use 'wbthomason/packer.nvim',对应的就是https://github.com/wbthomason/packer.nvim
		-- 插件列表如下

		-- nvim-tree 侧边栏插件(需要nvim-web-devicons插件依赖,这样会同时安装两个组件)
		-- 安装完成后还需要创建lua/plugin-config.nvim-tree.lua对其进行配置
		use({ "nvim-tree/nvim-tree.lua", requires = "nvim-tree/nvim-web-devicons" })

		-- bufferlines插件:用于将Neovim的buffer图形化显示成类似VSCode中标签页的形式
		use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }})

		-- nvim-lualine插件:用于状态栏信息显示
		-- 当前的编辑模式,光标所在的行号,列号,当前文件大小,编码格式,当前git分支等状态
		use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
		-- lualine插件的一个拓展
		use("arkav/lualine-lsp-progress")

		-- telescope:模糊文件查找工具
		-- 指定:checkhealth telescope会发现Warning,这是因为telescope需要ripgrep和fd的子项目依赖
		-- 这里可能还会提示缺失nvim-treesitter,这个暂时不用管,之后代码高亮章节才会使用
		-- 手动通过brew安装即可(brew的牛逼之处啊)
		use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }

		-- nvim-treesitter:代码高亮插件
		-- 因为nvim-treesitter插件版本必须和特定的language parser版本匹配,所以需要指定run=":TSUpdate"同步更新组件
		-- 这里貌似有个小bug,:TSUpdate需要先安装nvim-treesitter才能运行,所以应该先:w运行一次安装treesitter,重启neovim后再:w下载language-parser
		-- 可以运行:TSIntallInfo查看language parser安装情况,运行:TSInstall/TSUninstall <language>来安装/卸载你所需要的语法高亮
		-- 当然,正常来讲都是在nvim-treesitter的配置文件中指定自动安装
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

		-- 开启neovim内置LSP(Language Server Protocol):代码补全、跳转、提示插件
		-- 可以首先理解一下什么是Language Server Protocol(语言服务协议)
		-- 传统的IDE都要为其支持的每个语言实现类似的代码补全、文档提示、跳转到定义等功能，不同的IDE做了很多重复的工作，并且兼容性也不是很好
		-- LSP的出现将变成工具解耦成了Language Server和Language Cliend两部分定义了代码编辑器与语言服务器之间的交互协议
		-- Client端专注于显示样式实现,Server负责提供语言支持,包括自动补全、定义跳转、查找引用、悬停文档等等功能
		-- 所说的neovim 内置LSP就是说Neovim内置了一套Language Client端的实现
		-- 我们只需要将其连接到第三方的Language Server即可实现高质量的语法补全等功能
		-- 1. 配置客户端-> 安装nvim-lsconfig插件(该插件提供了一堆常见服务的配置方式)
		-- 2. 安装语言服务器,比方说需要TypeScript语法支持就去安装TypeScript Language Server
		-- 		但是这样的话,不同的语言都需要分开安装,管理繁琐 -> 安装nvim-lsp-installer插件(用于管理、安装需要的Language Server)
		-- 		由于文章是一年前写的,目前nvim-lsp-installer插件已不再维护,作者将其升级为了mason.nvim,所以这里要装mason.nvim
		-- 3. 配置对应语言服务端
		-- 4. 查看LSP连接状态:lua print(vim.inspect(vim.lsp.buf_get_clients())),连接成功即大功告成
		use({ "neovim/nvim-lspconfig" })
		use({ "williamboman/mason.nvim" })
    	use({ "williamboman/mason-lspconfig.nvim" })


		--------------------------colorscheme----------------------------
		-- tokyonight
		use("folke/tokyonight.nvim")
	end,
	config = {
		-- 只以浮动窗口的形式显示安装插件列表
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	}
})
-- 设置每次保存plugins.lua就自动安装插件
pcall(
	vim.cmd
	[[
		augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
		augroup end
	]]
)

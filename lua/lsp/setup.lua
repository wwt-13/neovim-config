local status, mason = pcall(require,'mason')
if not status then
	vim.notify("mason not find!")
	return
end

local status, mason_config = pcall(require,"mason-lspconfig")
if not status then
	vim.notify("mason-lspconfig not find!")
	return
end

-- 原来bug出现在这里!!!,pcall里面下意识填了mason-lspconfig
local status, lspconfig = pcall(require, "lspconfig")
if not status then
	vim.notify("lspconfig not find!")
	return
end

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

-- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
-- 需要安装的语言服务器
mason_config.setup({
	ensure_installed = {
		-- 太尴尬了,原来bug是名字写错了
		-- 最新的lua服务器为lua_ls
		-- 改完发现还是有bug,寄
		"lua_ls",
		"bashls",
		-- "cmake",
		"clangd",
		"html","cssls",
	},
})

local servers = {
	lua_ls = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
	-- bashls = require("lsp.config.bash"),
	-- cmake = require("lsp.config.cmake"),
	-- clangd = require("lsp.config.clang"),
	-- html = require("lsp.config.html"),
	-- cssls = require("lsp.config.css"),
}

-- 需要对每个Server进行特定的初始化配置
for name, config in pairs(servers) do
	if config ~= nil and type(config)=="table" then
		-- print(lspconfig[name]) 出现bug时,可以通过print来进行调试
		config.on_setup(lspconfig[name])
	else
		lspconfig[name].setup({})
	end
end

-- nvim-lsp-installer不再维护,更换为manson
-- require("nvim-lsp-installer").setup({
	-- 设置自动安装Language Server
-- 	automatic_installation = true,
-- })

-- local lsp_installer = require("nvim-lsp-installer")

-- 安装列表
-- {key:语言 value:配置文件}
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps

-- 首先创建了一个servers字典变量,用于存放所有的LSP Server配置
-- sumneko_lua是nvim-lsp-installer中lua语言的server name,具体语言对应的server name在该网址中可查https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fwilliamboman%2Fnvim-lsp-installer%23available-lsps


-- for name,_ in pairs(servers) do
-- 	local server_is_found, server = lsp_installer.get_server(name)
-- 	if server_is_found then
-- 		if not server:is_installed() then
-- 			print("Installing " .. name)
-- 			server:install()
-- 		end
-- 	end
-- end



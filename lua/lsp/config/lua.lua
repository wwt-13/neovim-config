local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
-- lua的Language Server配置文件
local opts = {
	settings = {
		Lua = {
			runtime = {
				-- 告诉服务器你所使用的Lua版本
				version = 'LuaJIT',
				path = runtime_path,
			},
			diagnostics = {
				-- 让服务器识别vim global(?)
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file('', true),
				checkThirdParty = false,
			},
			telemetry = {
				-- Do not send telemetry data containing a randomized but unique identifier
				enable = false,
			},
		},
	},
	flags = {
		debounce_text_changes = 150,
	},
	on_attach = function(client, bufnr)
		-- 禁用格式化功能,交给专门的插件处理
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false

		--local function buf_set_keymap(...)
		--	vim.api.nvim_buf_set_keymap(bufnr, ...)
		--end
		-- 绑定快捷键
		-- require('keybindings').mapLSP(buf_set_keymap)
		-- 保存时自动格式化(不如使用快捷键)
		-- vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
	end,
}

-- 和setup.lua中相对应
-- 我们需要定制的其实只有其中传入的opts参数,该参数用于初始化语言服务
-- opts中有两个关键参数需要定制: settings和on_attach
-- settings:主要用于配置语言服务,可以在https://link.juejin.cn/?target=https%3A%2F%2Fgithub.com%2Fneovim%2Fnvim-lspconfig%2Fblob%2Fmaster%2Fdoc%2Fserver_configurations.md 中找到对应语言的配置参考
-- on_attach:一个回调函数,当语言服务成功绑定到一个buffer上时会调用这个函数
-- 		通常会在这个函数中做一些如快捷键绑定,自动命令,设置buffer的某些特性等等操作
return {
	on_setup = function(server)
		server.setup(opts)
	end,
}

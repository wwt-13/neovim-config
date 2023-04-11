local opts = {
	settings = {
	},
	cmd = {
		"clangd",
	},
	filetypes = {
		"c",
		"cpp",
		"objc",
		"objcpp",
		"cuda",
		"proto",
	},
	on_attach = function (client,bufnr)
		client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
	end,
}

return {
	on_setup = function (server)
		server.setup(opts)
	end,
}

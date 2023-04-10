local status, bufferline = pcall(require, "bufferline")
if not status then
	vim.notify("bufferline not find!")
	return
end

-- bufferline相当于把所有东西包括侧边栏都看做了标签页
-- bufferline配置
bufferline.setup({
	options = {
		-- 关闭bufferline自带的Tab命令,使用更好用的moll/vim-bbye的:Bdelete命令
		closed_command = "Bdelete! %d",
		right_mouse_command = "Bdelete! %d",
		-- 侧边栏配置
		-- 左侧让出nvim-tree的位置,显示文字File Exploer
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
		-- 使用nvim内置LSP,暂时不理解也无所谓
		diagnostics = "nvim_lsp",
		-- 显示LSP报错图标
		diagnostics_indicator = function(count,level,diagnostics_dict,context)
			local s=" "
			for e,n in pairs(diagnostics_dict) do
				local sym = e == "error" and " " or (e=="warning" and " " or "")
				s = s .. n .. sym
			end
			return s
		end,
	},
})

local status, db = pcall(require, "dashboard")

if not status then
	vim.notify("dashboard not find!")
	return
end

db.setup({
	theme = "hyper",
	config = {
		week_header = {
			enable = true,
		},
		shortcut = {
			{
				desc = " Check",
				group = "@property",
				action = "checkhealth",
				key = "c",
			},
			{
				icon = " ",
				icon_hl = "@variable",
				desc = "Files",
				group = "Label",
				action = "Telescope find_files",
				key = "f",
			},
			{
				icon = "󰆔 ",
				desc = "Content",
				group = "DashboardMruIcon",
				action = "Telescope live_grep",
				key = "n",
			},
			{
				desc = "󰚰 Update",
				group = "DiagnosticHint",
				action = "PackerSync",
				key = "u",
			},
			{
				desc = " ColorScheme",
				group = "Number",
				action = "Telescope colorscheme",
				key = "d",
			},
		},
	},
})

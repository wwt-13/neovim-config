-- 该主题是第三方主题,需要下载
-- 那么如何安装第三方主题呢?之前其实已经提到过了,只需要在plugins.lua中use对应主题即可
local colorscheme = "tokyonight"
-- pcall在lua中用于捕获错误,".."用于连接字符串
local status_ok,_=pcall(vim.cmd,"colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme ".. colorscheme .. " not find!")
	return
end
-- 一个非常重要的问题
-- configuration needs to be set BEFORE loading the color scheme with colorscheme tokyonight


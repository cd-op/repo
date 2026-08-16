local function get_mod_flag(bufnr)
	if vim.fn.getbufinfo(bufnr)[1].changed == 1 then
		return "*"
	end

	return ""
end

local function get_listed_bufs()
	local bufnums = vim.api.nvim_list_bufs()
	local ret = {}

	for _, x in ipairs(bufnums) do
		if vim.fn.buflisted(x) == 1 then
			table.insert(ret, x)
		end
	end

	return ret
end

local function get_buf_shortname(bufnr)
	local bufname = vim.api.nvim_buf_get_name(bufnr)
	return string.gsub(bufname, "^(.*/)(.*)", "%2")
end

local function render_buf_labels()
	local cbuf = vim.api.nvim_get_current_buf()
	local cmodflag = get_mod_flag(cbuf)

	local bufnums = get_listed_bufs()
	if #bufnums > 4 then
		return string.format("[%%n %%t%s] (+ %d)", cmodflag, #bufnums - 1)
	end

	local labels = ""
	for _, x in ipairs(bufnums) do
		local name = get_buf_shortname(x)

		local modflag = get_mod_flag(x)
		local startsep = " "
		local stopsep = " "

		if x == cbuf then
			startsep = "["
			stopsep = "]"
		end

		labels = labels .. startsep .. x .. " " .. name .. modflag .. stopsep
	end

	return labels
end

local function render_buf_size()
	local bytes = vim.fn.line2byte("$") + #(vim.fn.getline("$"))

	if bytes > 1024 then
		return string.format("%1.1fK", bytes / 1024)
	end

	return string.format("%dB", bytes)
end

local function render()
	local labels = render_buf_labels()
	local size = render_buf_size()

	return labels .. "%=%l,%v %LL " .. size
end

return {
	configure = function()
		vim.opt.laststatus = 3
		vim.opt.statusline = "%!v:lua.require('statusline').render()"
	end,

	render = render,
}

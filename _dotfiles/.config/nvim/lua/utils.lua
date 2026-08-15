local function missing_progs(...)
	for _, x in ipairs({ ... }) do
		if vim.fn.executable(x) ~= 1 then
			vim.notify("executable not found in path: " .. x, vim.log.levels.WARN)
			return true
		end
	end

	return false
end

local function imap(l, r)
	vim.keymap.set("i", l, r .. "i", { noremap = true })
end

local function nmap(l, r)
	vim.keymap.set("n", l, r, { noremap = true })
end

local function inmap(l, r)
	imap(l, r)
	nmap(l, r)
end

return {
	missing_progs = missing_progs,

	imap = imap,
	inmap = inmap,
	nmap = nmap,
}

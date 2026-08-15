require("nvim-treesitter").install({ "markdown" })

vim.pack.add({
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("render-markdown").setup({})

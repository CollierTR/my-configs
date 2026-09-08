return {
	"Gentleman-Programming/veil.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("veil").setup({
			auto_enable = false,
			keymaps = {
				toggle = "<leader>tv",
				peek = "<leader>tp",
			},
		})
	end,
}

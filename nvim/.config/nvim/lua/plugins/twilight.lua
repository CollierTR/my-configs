return {
	"folke/twilight.nvim",
	opts = {
		dimming = {
			alpha = 0.25, -- amount of dimming
			-- we try to get the foreground from the highlight groups or fallback color
			color = { "Normal", "#ffffff" },
			term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color

			inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
		},
		context = 10, -- fallback line window when no expand node is found
		treesitter = true, -- use treesitter when available for the filetype
		-- Expand to the top-most matching ancestor. Names must be real Tree-sitter
		-- node types (inspect with :InspectTree) — generic "function"/"method" rarely match.
		expand = {
			-- functions / methods (language-specific node names)
			-- Omit class_*/impl_item so expand stops at the method, not the whole class/impl.
			"function_declaration",
			"function_definition",
			"function_expression",
			"arrow_function",
			"method_definition",
			"method_declaration",
			"function_item", -- rust
			-- lua tables + shared control flow
			"table_constructor",
			"if_statement",
			"for_statement",
			"while_statement",
			"do_statement",
		},
		exclude = {}, -- exclude these filetypes
	},
}

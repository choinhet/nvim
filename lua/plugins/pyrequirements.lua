return {
	{
		"MeanderingProgrammer/py-requirements.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("py-requirements").setup({})
		end,
	},
}

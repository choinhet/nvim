return {
	{
		"neoclide/coc.nvim",
		branch = "release",
		config = function()
			vim.g.coc_global_extensions = {
				"coc-pyright",
				"coc-json",
				"coc-html",
				"coc-css",
				"coc-tsserver",
			}

			function _G.show_documentation()
				local filetype = vim.bo.filetype
				if vim.fn.index({ "vim", "help" }, filetype) >= 0 then
					vim.api.nvim_command("h " .. vim.fn.expand("<cword>"))
				elseif vim.fn["coc#rpc#ready"]() then
					vim.fn.CocActionAsync("doHover")
				else
					vim.api.nvim_command("!" .. vim.bo.keywordprg .. " " .. vim.fn.expand("<cword>"))
				end
			end

			function _G.map_if_coc_ready(mode, lhs, rhs, opts)
				opts = opts or { noremap = true, silent = true }
				if vim.fn["coc#rpc#ready"]() then
					vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
				end
			end

			local opts = { noremap = true, silent = true }

			map_if_coc_ready("n", "K", "<cmd>lua _G.show_documentation()<CR>", opts)
			map_if_coc_ready("n", "gd", "<Plug>(coc-definition)", opts)
			map_if_coc_ready("n", "ge", "<Plug>(coc-diagnostic-next)", opts)
			map_if_coc_ready("n", "gE", "<Plug>(coc-diagnostic-prev)", opts)
			map_if_coc_ready("n", "gu", "<Plug>(coc-references)", opts)
			map_if_coc_ready("n", "gi", "<Plug>(coc-implementation)", opts)
			map_if_coc_ready("n", "<space>ca", "<Plug>(coc-codeaction)", opts)
			map_if_coc_ready("n", "<leader>rn", "<Plug>(coc-rename)", opts)
			map_if_coc_ready("n", "<leader>fm", "<cmd>CocCommand editor.action.formatDocument<CR>", opts)
		end,
	},
	{
		"fannheyward/coc-pyright",
	},
}

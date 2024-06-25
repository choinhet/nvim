local function update_python_path()
	local venv_selector = require("venv-selector")
	local venv_path = venv_selector.python()

	if not venv_path then
		print("venv_path was empty")
		return
	end

	local settings = {}
	settings["python.pythonPath"] = venv_path .. "/bin/python"

	local settings_path = vim.fn.stdpath("config") .. "/coc-settings.json"
	local file = io.open(settings_path, "w")

	print("Loading completions for path:" .. venv_path)
	if file then
		file:write(vim.fn.json_encode(settings))
		file:close()
	end
end

local function on_venv_activate()
	vim.defer_fn(function()
		print("Updating completions source")
		update_python_path()
		vim.cmd("CocRestart")
	end, 1000)
end

return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python",
	},
	branch = "regexp",
	event = "VeryLazy",
	config = function()
		require("venv-selector").setup({
            settings = {
                options = {
                    on_venv_activate_callback = on_venv_activate
                }
            }
        })

		vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", {})
	end,
}

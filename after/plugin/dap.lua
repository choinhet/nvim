local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")

vim.keymap.set("n", "<leader>dn", dap.continue, { desc = "Start Python Debugging" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })

dapui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes", size = 0.5 },
                { id = "repl",   size = 0.5 },
            },
            size = 60,
            position = "right",
        },
    },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.keymap.set("n", "<leader>dc", require("dap.repl").clear, { desc = "Clear DAP REPL" })

local function get_python_path()
    local venv_path = os.getenv("VIRTUAL_ENV")
    if venv_path then
        return venv_path .. "\\Scripts\\python.exe"
    end
    return "python"
end

dap_python.setup(get_python_path())

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch Module",
        module = function()
            local current_filepath = vim.fn.expand("%:.:r")
            return current_filepath:gsub("[\\/]", ".")
        end,
    },
}

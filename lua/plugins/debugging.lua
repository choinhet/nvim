return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local dap = require("dap")
      require("dapui").setup()
      require("dap-python").setup()
      local venv_selector = require("venv-selector")

      dap.adapters.python = {
        type = "executable",
        command = "python3",
        args = { "-m", "debugpy.adapter" },
      }

      local function get_python_path()
        local venv_path = venv_selector.python()
        if not venv_path then
          venv_path = vim.fn.trim(vim.fn.system("pyenv which python"))
        end
        print("Venv path: ", venv_path)  -- Log para verificar o caminho do venv
        return venv_path
      end

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = get_python_path,
        },
      }

      dap.listeners.after.event_initialized["dapui_config"] = function()
        require("dapui").open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        require("dapui").close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        require("dapui").close()
      end

      vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
      vim.keymap.set("n", "<leader>dc", dap.continue, {})

      local opts = { noremap = true, silent = true }

      vim.keymap.set("n", "<leader>dn", ":lua require('dap-python').test_method()<cr>", opts)
      vim.keymap.set("n", "<leader>df", ":lua require('dap-python').test_class()<cr>", opts)
      vim.keymap.set("v", "<leader>ds", ":lua require('dap-python').debug_selection()<cr>", opts)
      vim.keymap.set("n", "<leader>e", "<cmd>lua require('dapui').eval()<cr>", opts)
      vim.keymap.set("v", "<leader>e", "<cmd>lua require('dapui').eval()<cr>", opts)
    end,
  },
}


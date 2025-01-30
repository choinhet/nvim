local builtin = require('telescope.builtin')

require('telescope').setup({
  defaults = {
    cwd = function()
      return vim.fn.getcwd()
    end,
    path_display = { "smart" },
    mappings = {
      i = {
        ["<CR>"] = function(prompt_bufnr)
          local action_state = require("telescope.actions.state")
          local actions = require("telescope.actions")
          local entry = action_state.get_selected_entry()
          local filepath = entry.path or entry.filename

          if filepath then
            filepath = filepath:gsub("\\", "/")
            filepath = vim.fn.fnamemodify(filepath, ":p")
          else
            vim.notify("Error: Invalid file path", vim.log.levels.ERROR)
            return
          end

          actions.close(prompt_bufnr)
          vim.cmd("edit " .. filepath)
        end,
      },
    },
  },
})

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>')

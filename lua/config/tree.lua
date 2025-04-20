-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  update_focused_file = {
    enable = true,
  },
})

vim.keymap.set("n", "<leader>e", function() vim.cmd("NvimTreeFocus") end) 

-- Autocmd to open NvimTree and highlight the current file
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Open the tree and find the file
    require("nvim-tree.api").tree.open({ find_file = false, focus = false })
  end
})


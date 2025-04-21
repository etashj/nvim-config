-- enable line number and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true


--width of a time
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

--user number of spaces to inser a <Tab>
vim.opt.expandtab = true

vim.opt.incsearch = true
vim.opt.hlsearch = true

-- set theme
--vim.cmd ([[colorscheme slate]])
require('kanagawa').setup({
  overrides = function(colors)
    local theme = colors.theme
    local makeDiagnosticColor = function(color)
      local c = require("kanagawa.lib.color")
      return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
    end

    return {
      DiagnosticVirtualTextHint  = makeDiagnosticColor(theme.diag.hint),
      DiagnosticVirtualTextInfo  = makeDiagnosticColor(theme.diag.info),
      DiagnosticVirtualTextWarn  = makeDiagnosticColor(theme.diag.warning),
      DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
    }
  end
})

vim.cmd ([[colorscheme kanagawa-wave]])
vim.opt.termguicolors = true

vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.api.nvim_set_hl(0, 'CursorLineNr', { fg='#957FB8', bold=true })
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#7b788a', bg='#2A2A37' })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#7b788a', bg='#2A2A37' })

vim.opt.scrolloff = 8

-- custom cmd-f equivalent to search document for selection
vim.keymap.set('v', '/', function()
  vim.cmd('normal! "zy')
  vim.fn.setreg('/', vim.fn.escape(vim.fn.getreg('z'), [[\/.*$^~[]\]]))
  vim.cmd('normal! n')
end, {noremap=true, silent=true})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>i", ":lua vim.diagnostic.open_float()<CR>")

require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
})


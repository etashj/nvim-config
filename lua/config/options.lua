-- enable line number and relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true


--width of a time
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

--user number of spaces to inser a <Tab>
vim.opt.expandtab = true

-- set theme
vim.cmd ('colorscheme slate')

-- custom cmd-f equivalent to search document for selection
vim.keymap.set('v', '/', function()
  vim.cmd('normal! "zy')
  vim.fn.setreg('/', vim.fn.escape(vim.fn.getreg('z'), [[\/.*$^~[]\]]))
  vim.cmd('normal! n')
end, {noremap=true, silent=true})

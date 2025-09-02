vim.g.mapleader = " "
require("config.lazy")
require("config.options")
require("config.telescope")
require("config.lualine")
require("mason").setup()
require("mason-lspconfig").setup()
require("config.tree")

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.c0",
  callback = function()
    -- Example: set filetype and run a command
  vim.cmd.source("/Users/etashj/.config/nvim/lua/c0/c0.vim")
vim.cmd.source("/Users/etashj/.config/nvim/lua/c0/c0-detect.vim")
  end,
})


--[[
require("mason-lspconfig").setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {}
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ["rust_analyzer"] = function ()
    require("rust-tools").setup {}
  end
}
]]

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


-- Create an augroup to avoid duplicate autocmds
vim.api.nvim_create_augroup("LaTeXAutoCompile", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = "LaTeXAutoCompile",
  pattern = "*.tex",  -- Only trigger on .tex files
  callback = function()
    local file = vim.fn.expand("%:p")   -- full path of current file
    local dir  = vim.fn.expand("%:p:h") -- directory of current file
    local name = vim.fn.expand("%:t:r") -- file name without extension

    -- Run pdflatex, output PDF to same directory
    vim.fn.jobstart(
      { "pdflatex", "-interaction=nonstopmode", "-output-directory=" .. dir, file },
      {
        cwd = dir,
        on_exit = function(_, code)
          if code == 0 then
            vim.notify("✅ PDF compiled: " .. dir .. "/" .. name .. ".pdf", vim.log.levels.INFO)
            -- vim.fn.jobstart({ "open", dir .. "/" .. name .. ".pdf" }, { detach = true })
          else
            vim.notify("❌ pdflatex failed!", vim.log.levels.ERROR)
          end
        end,
      }
    )
  end,
})


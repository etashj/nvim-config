return {{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", 
                              "python", "java", "javadoc", "cpp", "go", "latex", "html", "json", "css", "javascript", "regex", "bash"},
          sync_install = false,
          auto_install = true,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end
 }}

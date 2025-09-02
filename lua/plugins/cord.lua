return {
  'vyfor/cord.nvim',
  build = ':Cord update',
  opts = function () 
    return {
      display = {
        theme = 'atom',
        flavor = 'accent'
      },
      buttons = {
          {
              label = function(opts)
                  return opts.repo_url and 'View Repository' or 'Website'
              end,
              url = function(opts)
                  return opts.repo_url or 'https://example.com'
              end
          }
      }, 
      timestamp = {
        enabled = false, 
        reset_on_idle = false,
        reset_on_change = false,
      }
    }
  end
}

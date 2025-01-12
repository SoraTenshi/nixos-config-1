local colors = require("kanagawa.colors").setup()

require("incline").setup({
  highlight = {
    groups = {
      InclineNormal = {
        guibg = colors.sumiInk4,
        guifg = colors.sumiInk0,
        -- guibg = "#FC56B1",
        -- guifg = colors.black,
        -- gui = "bold",
      },
      InclineNormalNC = {
        guifg = colors.oniViolet,
        guibg = colors.sumiInk0,
        -- guifg = "#FC56B1",
        -- guibg = colors.black,
      },
    },
  },
  window = {
    margin = {
      vertical = 0,
      horizontal = 1,
    },
  },
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    local icon, color = require("nvim-web-devicons").get_icon_color(filename)
    return {
      { icon, guifg = color },
      { " " },
      { filename },
    }
  end,
})

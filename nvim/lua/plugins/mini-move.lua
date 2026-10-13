return {
  {
    "echasnovski/mini.move",
    version = false,
    config = function()
      require("mini.move").setup({
        mappings = {
          left = "<M-h>",
          right = "<M-l>",
          down = "<M-j>",
          up = "<M-k>",

          line_left = "<M-h>",
          line_right = "<M-l>",
          line_down = "<M-j>",
          line_up = "<M-k>",
        },
      })
    end,
  },
}

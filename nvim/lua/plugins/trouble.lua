return {
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Toggle diagnostics",
      },
      {
        "<leader>xq",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Toggle quickfix list",
      },
    },
  },
}

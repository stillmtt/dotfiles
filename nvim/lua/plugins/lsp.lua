return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("clangd")
      vim.lsp.enable("pylsp")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("gopls")
    end,
  },
}

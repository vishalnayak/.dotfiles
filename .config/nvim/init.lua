-- Modern Neovim Configuration with Native LSP for Go
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keymaps
vim.g.mapleader = " "
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)

-- Plugin Management (Lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "neovim/nvim-lspconfig",
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "nvim-telescope/telescope.nvim",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "lewis6991/gitsigns.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
})

-- LSP / Go Configuration
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "gopls" } })

local lspconfig = require('lspconfig')
lspconfig.gopls.setup({
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

-- Auto-format on save for Go
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format { async = false }
  end,
})

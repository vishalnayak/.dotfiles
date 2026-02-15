-- 1. General Settings (Redundancy check for line numbers)
vim.opt.number = true
vim.opt.relativenumber = true
vim.g.mapleader = " "

-- 2. Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Plugin Management
require("lazy").setup({
    -- LSP & Dependencies
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({ ensure_installed = { "gopls" } })
            
            -- Neovim 0.11+ Native LSP Config
            vim.lsp.config('gopls', {
                cmd = { 'gopls' },
                filetypes = { 'go', 'gomod' },
                settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
            })
            vim.lsp.enable('gopls')
        end
    },

    -- Treesitter
    { 
        "nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "go", "lua", "vim", "markdown" },
            highlight = { enable = true },
        },
    },

    -- UI/Navigation
    { "nvim-telescope/telescope.nvim", dependencies = { 'nvim-lua/plenary.nvim' } },
    "lewis6991/gitsigns.nvim",
})

-- 4. Sourcing Legacy Vimrc (Sourced late to override any plugin defaults)
local vimrc_path = vim.fn.expand("~/.dotfiles/.vimrc")
if vim.fn.filereadable(vimrc_path) == 1 then
    vim.cmd('source ' .. vimrc_path)
end

-- 5. Standard LSP Keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Info' })

-- 6. Go Auto-format
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

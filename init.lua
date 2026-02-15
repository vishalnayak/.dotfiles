-- 1. Muscle Memory (The 'jk' Fix)
-- This is now top-level to ensure it works even if other things fail
vim.keymap.set('i', 'jk', '<Esc>', { silent = true })
vim.keymap.set('v', 'jk', '<Esc>', { silent = true })
vim.keymap.set('c', 'jk', '<C-c>', { silent = true })

-- 1. Source .vimrc (Safe Path)
local vimrc = vim.fn.expand("$HOME/.dotfiles/.vimrc")
if vim.fn.filereadable(vimrc) == 1 then
    vim.cmd("source " .. vimrc)
end

-- 2. Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Plugins
require("lazy").setup({
    -- VIBRANT COLORS
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({ style = "night", terminal_colors = true })
            vim.cmd.colorscheme("tokyonight-night")
        end,
    },

    -- LSP (Native 0.11 Style)
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({ ensure_installed = { "gopls" } })
            
            -- FIX: Wait for client to attach before enabling completion
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client and client.supports_method('textDocument/completion') then
                        vim.lsp.completion.enable(true, client.id)
                    end
                end,
            })

            vim.lsp.config('gopls', {
                cmd = { 'gopls' },
                settings = { gopls = { analyses = { unusedparams = true }, gofumpt = true } },
            })
            vim.lsp.enable('gopls')
        end
    },

    -- TREESITTER (Fixed: No more .configs require)
    { 
        "nvim-treesitter/nvim-treesitter", 
        build = ":TSUpdate",
        config = function()
            -- We call setup on the main nvim-treesitter module directly
            require('nvim-treesitter').setup({
                ensure_installed = { "go", "lua", "vim", "markdown" },
                highlight = { enable = true },
            })
        end
    },
})

-- 4. Native Completion UI (Tab Key)
vim.keymap.set('i', '<Tab>', function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })

-- 5. Standard Keymaps
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover)

-- 6. Go Auto-format on Save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

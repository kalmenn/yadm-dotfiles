vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    { name = "catppuccin", url = "https://github.com/catppuccin/nvim.git" },
    { name = 'treesitter', url = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
    { name = 'lsp-config', url = 'https://github.com/neovim/nvim-lspconfig.git' },
    { name = 'nvim-tree', url = 'https://github.com/nvim-tree/nvim-tree.lua.git' }, -- TODO: replace with neo-tree
})

--[[
    Potential plugins to integrate:
    - https://github.com/fedepujol/move.nvim
]]--

require('catppuccin').setup({
    flavour = "mocha",
    integrations = {
        treesitter = false,
    },
})
vim.cmd.colorscheme("catppuccin")

require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.rust_analyzer.setup {}

-- enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = false,
    },
    sync_root_with_cwd = true,
})

vim.keymap.set('n', '<A-k>', ':move -2<CR>' )
vim.keymap.set('n', '<A-up>', ':move -2<CR>' )
vim.keymap.set('n', '<A-j>', ':move +1<CR>' )
vim.keymap.set('n', '<A-down>', ':move +1<CR>' )

vim.o.number = true
vim.o.relativenumber = true

vim.opt.list = true
vim.opt.listchars = { tab = '→ ', trail = '·' }

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = vim.opt.tabstop:get()
vim.opt.shiftwidth = 4

vim.opt.fillchars:append({ eob = ' '})

vim.notify("starting nvim 🏕️")

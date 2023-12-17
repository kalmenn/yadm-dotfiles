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
    "catppuccin/nvim",
    "nvim-treesitter/nvim-treesitter",
    "neovim/nvim-lspconfig",
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function ()
            require('neo-tree').setup({
                filesystem = {
                    filtered_items = {
                        visible = true,
                    },
                },
            })
        end,
    },
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

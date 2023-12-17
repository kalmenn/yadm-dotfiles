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

require('lazy').setup({ { import = "plugins" } })

--[[
    Potential plugins to integrate:
    - https://github.com/fedepujol/move.nvim
]]

vim.keymap.set('n', '<A-k>', ':move -2<CR>')
vim.keymap.set('n', '<A-up>', ':move -2<CR>')
vim.keymap.set('n', '<A-j>', ':move +1<CR>')
vim.keymap.set('n', '<A-down>', ':move +1<CR>')

vim.o.number = true
vim.o.relativenumber = true

vim.opt.list = true
vim.opt.listchars = { tab = '→ ', trail = '·' }

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = vim.opt.tabstop:get()
vim.opt.shiftwidth = 4

vim.opt.fillchars:append({ eob = ' ' })

vim.notify("starting nvim 🏕️")


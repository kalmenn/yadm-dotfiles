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

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
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

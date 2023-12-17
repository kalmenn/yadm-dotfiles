return {
    "mbbill/undotree",
    keys = {
        {
            "<C-u>",
            function()
                vim.cmd.UndotreeToggle();
                vim.cmd.UndotreeFocus();
            end
        },
    },
}

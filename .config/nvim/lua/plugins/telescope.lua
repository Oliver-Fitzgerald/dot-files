return {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
    -- put your keymaps here
    local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<A-f>", builtin.find_files)
        vim.keymap.set("n", "<A-g>", builtin.live_grep)
    end,
}

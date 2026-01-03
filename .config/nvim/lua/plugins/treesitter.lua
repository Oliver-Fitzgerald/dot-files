return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require("nvim-treesitter").install({ 'cpp', 'java'})
        require("nvim-treesitter").setup(require("plugins.config.treesitter"))
    end,
}

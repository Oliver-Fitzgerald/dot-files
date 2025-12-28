-- Type jj to exit insert mode quickly
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true })

-- Press the space bar to type the : character in command mode
vim.keymap.set('n', '<space>', ':', { noremap = true })

-- Map F5 for Java compilation and execution
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    vim.keymap.set('n', '<F5>', ':w<CR>:!javac % && java %:r<CR>', { noremap = true, buffer = true })
  end
})

-- Navigate split views easier
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<A-i>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<A-o>', '<C-w>l', { noremap = true })

-- Resize split windows using arrow keys
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { noremap = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { noremap = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize -2<CR>', { noremap = true })
vim.keymap.set('n', '<C-Left>', ':vertical resize +2<CR>', { noremap = true })

-- Moving between tabs
vim.keymap.set('n', '<C-i>', ':tabp<CR>', { noremap = true })
vim.keymap.set('n', '<C-o>', ':tabn<CR>', { noremap = true })
vim.keymap.set('n', '<A-n>', ':tabnew<CR>', { noremap = true })
vim.keymap.set('n', '<A-d>', ':tabc<CR>', { noremap = true })

-- Remap Ctrl-V to Ctrl-Q for visual block mode
vim.keymap.set('n', '<C-Q>', '<C-V>', { noremap = true })
vim.keymap.set('v', '<C-Q>', '<C-V>', { noremap = true })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(require("plugins"))

-- <leader>
vim.g.mapleader = "\\"

-- Plugins ---------------------------------------------------------------- {{{

-- Enable syntax highlighting for given file types with treesitter
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cpp' },
  callback = function()

      vim.treesitter.start()
  end,
})

vim.cmd([[
    :hi      NvimTreeRootFolder         gui=bold guifg=#414833
    :hi      NvimTreeFolderName         guifg=#907753
    :hi      NvimTreeEmptyFolderName    ctermfg=14 guifg=#907753
    :hi      NvimTreeOpenedFolderName   ctermfg=14 guifg=#907753 gui=bold
    :hi link NvimTreeImageFile   Title
]])

-- General ----------------------------------------------------------------
require("general.keymaps")

-- System settings
vim.cmd('filetype on')
vim.cmd('filetype plugin on')
vim.cmd('filetype indent on')
vim.cmd('filetype plugin indent on')

-- swap files
vim.o.swapfile = false

-- Set colorscheme and syntax
-- vim.cmd('syntax on')

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Cursor line
vim.opt.cursorline = true
vim.cmd([[
  highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=blue guifg=NONE guibg=#2b2f36
  highlight CursorLineNR cterm=NONE ctermfg=yellow guifg=yellow
]])

-- Indentation
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- No backup files
vim.opt.backup = false

-- Scrolling
vim.opt.scrolloff = 20
vim.opt.sidescrolloff = 75

-- Line wrapping
vim.opt.wrap = false

-- Search settings
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Command line
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.showmatch = true

-- History
vim.opt.history = 1000

-- Wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = 'list:longest'
vim.opt.wildignore = '*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx'

-- Disable bell (Neovim doesn't use t_vb like Vim)
vim.opt.visualbell = true

-- Git difftool
vim.cmd([[
  if &diff
    highlight! link DiffText MatchParen
  endif
]])

-- netrw (File Explorer)
vim.g.loaded_netrw = 1 -- Disables netrw
vim.g.loaded_netrwPlugin = 1 -- Disables netrw
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = '^\\..*$'
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20
-- vim.keymap.set("n", "<A-e>", function()
  -- for _, win in ipairs(vim.api.nvim_list_wins()) do
    -- local buf = vim.api.nvim_win_get_buf(win)
    -- if vim.bo[buf].filetype == "netrw" then
      -- vim.api.nvim_win_close(win, true)
      -- return
    -- end
  -- end
  -- vim.cmd("Vexplore")
-- end, { desc = "Toggle Vexplore" })

-- Autocommands for filetypes
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.cql",
  command = "set filetype=cql"
})

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.ajs",
  command = "set filetype=javascript"
})



-- VIMSCRIPT --------------------------------------------------------------

-- Enable code folding for vim files
vim.api.nvim_create_augroup('filetype_vim', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'filetype_vim',
  pattern = 'vim',
  command = 'setlocal foldmethod=marker'
})

-- JSON formatting
vim.api.nvim_create_augroup('json_formatting', { clear = true })
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  group = 'json_formatting',
  pattern = '*.json',
  command = 'silent! %!jq .'
})

-- STATUS LINE ------------------------------------------------------------ 

vim.opt.statusline = ''
vim.opt.statusline:append(' %F %M %Y %R')
vim.opt.statusline:append('%=')
vim.opt.statusline:append(' ascii: %b hex: 0x%B row: %l col: %c percent: %p%%')
vim.opt.laststatus = 2

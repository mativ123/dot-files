-- leader has to be set before lazy
vim.g.mapleader = " "
-- Lazi.vim
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

require("lazy").setup("plugins")

-- colorscheme
vim.opt.termguicolors = true
vim.cmd([[colorscheme tokyonight-night]])

-- plugin setups
require("lualine").setup()
require('gitsigns').setup()
require('Comment').setup()

-- submodules
require("mappings")
require("prefs")
require("coc")
require("treesitter")
require("coc-extensions")
require("pear-tree")

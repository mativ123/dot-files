return {
    "folke/tokyonight.nvim",
    {"neoclide/coc.nvim", branch = "release"},
    "voldikss/vim-floaterm",
    "nvim-lualine/lualine.nvim",
    "nvim-tree/nvim-web-devicons",
    "lukas-reineke/indent-blankline.nvim",
    "norcalli/nvim-colorizer.lua",
    {"ms-jpq/chadtree", branch = "chad", build = "python3 -m chadtree deps"},
    "sheerun/vim-polyglot",
    "lervag/vimtex",
    {"iamcco/markdown-preview.nvim", build = "cd app && yarn install"},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
}

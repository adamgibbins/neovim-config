vim.g.mapleader = ","

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.spelllang = "en_gb"
vim.opt.spell = true

vim.opt.undodir = vim.fn.expand "~/.cache/nvim/undo"
vim.opt.undolevels = 5000
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.scrolloff = 20
vim.opt.sidescrolloff = 5

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
require("lazy").setup({
  { "tpope/vim-sleuth" },
  { "github/copilot.vim" },
  { "dense-analysis/ale" },
  { "tpope/vim-fugitive" },
  { "HiPhish/rainbow-delimiters.nvim" },
  { "tpope/vim-endwise" },
  { "nuvic/flexoki-nvim",
    lazy = false,
    priority = 1000,
    config = function(plugin)
      vim.cmd("colorscheme flexoki")
    end
  },
  { "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({})
    end
  },
  { "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end
  },
  { "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  { "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = "all",
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "gitcommit" },
        },
        indent = {
          enable = true,
        },
      })
    end
  },
  { "kylechui/nvim-surround",
    version = "*",
    config = function()
      require("nvim-surround").setup()
    end
  },
  { "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  },
  { "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end
  },
})

vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<Leader>,", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "<Leader>ss", "<cmd>setlocal spell!<CR>")
vim.keymap.set("n", "<Leader>tn", "<cmd>tabnew<CR>")

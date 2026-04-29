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
if not vim.uv.fs_stat(lazypath) then
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
  { "avm99963/vim-jjdescription" },
  { "NoahTheDuke/vim-just" },
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
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = {
          "bash", "c", "cpp", "css", "gitcommit", "gitignore",
          "go", "html", "javascript", "json", "just", "lua",
          "markdown", "markdown_inline", "python", "query",
          "regex", "ruby", "rust", "toml", "tsx", "typescript",
          "vim", "vimdoc", "yaml",
        },
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
  { "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      local lspconfig = require("lspconfig")
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<Leader>d", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      end
      require("mason-lspconfig").setup({
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            lspconfig[server_name].setup({ on_attach = on_attach })
          end,
        },
      })
    end
  },
})

vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<Leader>,", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "<Leader>ss", "<cmd>setlocal spell!<CR>")
vim.keymap.set("n", "<Leader>tn", "<cmd>tabnew<CR>")

-- Remove background so terminal transparency works
vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
vim.cmd("highlight NonText ctermbg=NONE guibg=NONE")
vim.cmd("highlight LineNr ctermbg=NONE guibg=NONE")
vim.cmd("highlight SignColumn ctermbg=NONE guibg=NONE")

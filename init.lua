vim.g.mapleader = ","

vim.filetype.add({ extension = { tmpl = "gotmpl" } })

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

vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.opt.complete:prepend("o")
vim.opt.autocomplete = true

vim.diagnostic.config({ virtual_text = true })

-- Remove background so terminal transparency works
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    for _, group in ipairs({ "Normal", "NonText", "LineNr", "SignColumn" }) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    end
  end,
})

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
  { "christoomey/vim-tmux-navigator",
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    keys = {
      { "<M-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<M-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<M-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<M-l>", "<cmd>TmuxNavigateRight<cr>" },
      { "<M-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
    },
  },
  { "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
      },
      default_format_opts = { lsp_format = "fallback" },
      format_on_save = { timeout_ms = 500 },
    },
  },
  { "tpope/vim-fugitive" },
  { "HiPhish/rainbow-delimiters.nvim" },
  { "tpope/vim-endwise" },
  { "avm99963/vim-jjdescription" },
  { "NoahTheDuke/vim-just" },
  { "nathangrigg/vim-beancount" },
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
      require("nvim-treesitter").install({
        "bash", "beancount", "css", "diff", "dockerfile", "git_config", "gitcommit",
        "go", "gomod", "gosum", "gotmpl", "hcl", "helm", "html", "javascript", "jsdoc",
        "json", "just", "lua", "luadoc", "markdown", "markdown_inline", "python", "query",
        "regex", "ruby", "rust", "terraform", "toml", "tsx", "typescript", "vim", "vimdoc",
        "yaml",
      })
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ok = pcall(vim.treesitter.start)
          if not ok then
            return
          end
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end
  },
  { "kylechui/nvim-surround",
    version = "*",
    config = function()
      require("nvim-surround").setup()
    end
  },
  { "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end
  },
  { "neovim/nvim-lspconfig",
    config = function()
      -- server binaries are managed externally (mise/dotfiles), not by nvim
      vim.lsp.enable({
        "bashls", "beancount", "copilot", "cssls", "docker_language_server", "eslint",
        "gopls", "harper_ls", "helm_ls", "html", "jsonls", "just", "lua_ls", "markdown_oxide",
        "pyright", "ruby_lsp", "ruff", "rust_analyzer", "terraformls",
        "tombi", "tsc", "yamlls",
      })
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, args.buf)
          end
          local opts = { buffer = args.buf, silent = true }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        end,
      })
      vim.lsp.inline_completion.enable()
      vim.keymap.set("i", "<Tab>", function()
        if not vim.lsp.inline_completion.get() then
          return "<Tab>"
        end
      end, { expr = true })
    end
  },
})

vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<Leader>,", "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "<Leader>ss", "<cmd>setlocal spell!<CR>")
vim.keymap.set("n", "<Leader>tn", "<cmd>tabnew<CR>")

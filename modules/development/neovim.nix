{
  flake.homeModules.neovim = {pkgs, ...}: {
    home.packages = with pkgs; [
      # gui
      neovide
      # dependencies
      just-lsp
      nil
      nixd
      pyright
      ripgrep
    ];
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withPython3 = false;
      withRuby = false;
      initLua =
        # lua
        ''
          -- Settings --
          vim.opt.relativenumber = true
          vim.opt.colorcolumn = "80,120"
          vim.opt.undofile = true

          -- KeyMaps --
          local map = vim.keymap.set
          vim.g.mapleader = " "
          -- normal
          map("n", "gl", "''$", { desc = "Go to end of line" })
          map("n", "gh", "0", { desc = "Go to start of line" })
          map("n", "gs", "^", { desc = "Go to first char" })
          -- leader
          map("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Pick a code action" })

          -- Plugins --
          require("fidget").setup({})
          require("blink-cmp").setup({})
          require("mini.pairs").setup({})

          local conform = require("conform")
          conform.setup({
            formatters_by_ft = {
              nix = { "alejandra" },
            },
          })
          map('n', '<leader>F', function() conform.format({ lsp_format = "fallback" }) end)

          require("oil").setup({})
          map('n', '-', '<cmd>Oil<enter>', { desc = "Open Oil" })

          -- telescope --
          require("telescope").setup({
            extensions = {
              ["ui-select"] = {
                -- ensure cursor theme is used
                require("telescope.themes").get_cursor {
                }
              }
            }
          })
          require("telescope").load_extension("ui-select")
          local builtin = require('telescope.builtin')
          map('n', 'gr', '<cmd>Telescope lsp_references theme=cursor<enter>')
          map('n', 'gd', '<cmd>Telescope lsp_definitions theme=cursor<enter>')
          map('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
          map('n', '<leader>/', builtin.live_grep, { desc = 'Telescope live grep' })
          map('n', '<leader>g', builtin.git_status, { desc = 'Telescope current changes' })
          map('n', '<leader>b', builtin.buffers, { desc = 'Telescope current changes' })

          -- LSP Settings --
          vim.lsp.codelens.enable(true)
          vim.lsp.inlay_hint.enable(true)
          vim.lsp.inline_completion.enable(true)
          vim.lsp.linked_editing_range.enable(true)

          -- LSP Integrations --
          -- using nvim-lspconfig --
          vim.lsp.enable('just')
          vim.lsp.enable('nixd')
          vim.lsp.enable('nil_ls')
          vim.lsp.enable('pyright')

          -- Theme --
          vim.cmd('colorscheme everforest')
        '';
      plugins = with pkgs.vimPlugins; [
        vim-sleuth # tab/spaces indentation detection
        gitsigns-nvim
        fidget-nvim # lsp info
        blink-cmp # auto complete
        friendly-snippets # snippet source
        nvim-lspconfig # pre-configured lsp config
        oil-nvim # oil
        conform-nvim # formatting
        mini-pairs # auto pairs
        telescope-nvim # extensible fuzzy finder
        telescope-ui-select-nvim # telescope as ui select
        everforest
      ];
    };
  };
}

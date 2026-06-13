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
      tree-sitter
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
          vim.opt.smartcase = true

          -- KeyMaps --
          local map = vim.keymap.set
          vim.g.mapleader = " "
          -- normal
          map("n", "gl", "''$", { desc = "Go to end of line" })
          map("n", "gh", "0", { desc = "Go to start of line" })
          map("n", "gs", "^", { desc = "Go to first char" })
          -- leader
          map("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Pick a code action" })

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
          map('n', '<leader>T', '<cmd>Telescope<enter>', { desc = "Telescope for Telescope"})
          map('n', '<leader>f', builtin.find_files, { desc = 'Telescope find files' })
          map('n', '<leader>/', builtin.live_grep, { desc = 'Telescope live grep' })
          map('n', '<leader>g', builtin.git_status, { desc = 'Telescope current changes' })
          map('n', '<leader>c', builtin.git_commits, { desc = 'Telescope current changes' })
          map('n', '<leader>s', builtin.git_status, { desc = 'Telescope current changes' })
          map('n', '<leader>b', builtin.buffers, { desc = 'Telescope current changes' })
          map('n', '<leader>d', builtin.diagnostics, { desc = "Telescope diagnostics"})
          map('n', '<leader>h', builtin.command_history, { desc = "Telescope history"})

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

          -- Plugins --
          require("fidget").setup({}) -- lsp load spinner
          require("blink-cmp").setup({}) -- better completion
          require("mini.pairs").setup({}) -- auto pairs
          require("nvim-surround").setup() -- better pair motions

          require("nvim-treesitter").setup({}) -- code grammar parsing intellijence
          require("nvim-treesitter-textobjects").setup({})
          -- local highlight_langs = {'nix'}
          vim.api.nvim_create_autocmd('FileType', {
            -- pattern = highlight_langs,
            callback = function()
              -- highlight using grammar ignore failures
              pcall(vim.treesitter.start)
              -- indent expression use treesitter WARN: potential failure?
              -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentExpr()"
            end
          })

          local conform = require("conform")
          conform.setup({
            formatters_by_ft = {
              nix = { "alejandra" },
            },
          })
          map("n", "<leader>F", function() conform.format({ lsp_format = "fallback" }) end)

          require("oil").setup({})
          map("n", "-", "<cmd>Oil<enter>", { desc = "Open Oil" })

          map("n", "<leader>l", "<cmd>LazyGit<enter>", {desc = "Open LazyGit"})
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
        everforest # theme
        nvim-treesitter.withAllGrammars # treesitter grammars
        nvim-treesitter-context # show surrounding area
        nvim-treesitter-textobjects # more objects for motions
        nvim-surround # change surround
        lazygit-nvim # neovim
      ];
    };
  };
}

{ inputs, ... }: {
  flake.nixosModules.nixvim = { pkgs, lib, ... }: {
    imports = [
      inputs.nix-vim.nixosModules.nixvim
    ];

    programs.nixvim = {
      enable = true;

      colorschemes.gruvbox.enable = true;

      plugins = {
        lightline.enable = true;
        telescope.enable = true;
        lspconfig.enable = true;
        typst-preview.enable = true;
        treesitter = {
          enable = true;
          highlight.enable = true;
          folding.enable = true;
          indent = {
            enable = true;
            disable = [ "vue" ];
          };
        };
        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "path"; }
              { name = "buffer"; }
              { name = "luasnip"; }
            ];
            snippet = {
              expand = "function(args) require('luasnip').lsp_expand(args.body) end";
            };
            mapping = {
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-d>" = "cmp.mapping.scroll_docs(-4)";
              "<C-e>" = "cmp.mapping.close()";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            };
          };
        };
        luasnip.enable = true;
        friendly-snippets.enable = true;
        ts-autotag.enable = true;
      };

      opts = {
        number = true;
        relativenumber = true;
        expandtab = true;
        tabstop = 2;
        shiftwidth = 0;
        undofile = true;
        foldlevelstart = 99;
      };

      autoCmd = [
        {
          event = "FileType";
          pattern = [ "go" "make" ];
          command = "setlocal tabstop=4 noexpandtab";
        }
      ];

      globals.mapleader = " ";
      keymaps = [
        {
          mode = "n";
          key = "<leader>ff";
          action = "<cmd>Telescope find_files<cr>";
          options.desc = "Find files";
        }
        {
          mode = "n";
          key = "<leader>fg";
          action = "<cmd>Telescope live_grep<cr>";
          options.desc = "Live grep";
        }
        {
          mode = "n";
          key = "<leader>fb";
          action = "<cmd>Telescope buffers<cr>";
          options.desc = "Buffers";
        }
        {
          mode = "n";
          key = "<C-h>";
          action = "<C-w>h";
        }
        {
          mode = "n";
          key = "<C-j>";
          action = "<C-w>j";
        }
        {
          mode = "n";
          key = "<C-k>";
          action = "<C-w>k";
        }
        {
          mode = "n";
          key = "<C-l>";
          action = "<C-w>l";
        }
      ];

      lsp.servers = {
        nil_ls.enable = true;
        clangd.enable = true;
        pyright.enable = true;
        terraform_lsp.enable = true;
        tflint.enable = true;
        yamlls.enable = true;
        tinymist.enable = true;
        gopls.enable = true;
        hadolint.enable = true;
        vue_ls.enable = true;
        cssls.enable = true;
        html.enable = true;
        emmet_language_server.enable = true;
        ts_ls = {
          enable = true;
          config = {
            filetypes = [ "typescript" "javascript" "javascriptreact" "typescriptreact" "vue" ];
            init_options = {
              plugins = [
                {
                  name = "@vue/typescript-plugin";
                  location = "${pkgs.vue-language-server}/lib/language-tools/packages/language-server";
                  languages = [ "vue" ];
                }
              ];
            };
          };
        };
        eslint.enable = true;
        tailwindcss.enable = true;
      };

    };
  };
}

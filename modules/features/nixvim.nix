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
        treesitter.enable = true;
        lspconfig.enable = true;
      };

      opts = {
        number = true;
        relativenumber = true;
        expandtab = true;
        tabstop = 2;
        shiftwidth = 2;
        undofile = true;
      };

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
      };

      extraPackages = with pkgs; [
        nil
        clang
        pyright
        terraform-ls
        tflint
        yaml-language-server
      ];

    };
  };
}

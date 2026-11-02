{ self, inputs, ... }:

{
  flake.homeConfigurations.homeManager = { ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    nixpkgs.config.allowUnfree = true;
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";

      extraSpecialArgs = {
        repoPath = "/home/khuong/nixos-config";
      };

      users.khuong = {
        home.stateVersion = "26.05";
        imports = [
          self.homeModules.noctalia
          self.homeModules.niri
          self.homeModules.foot
        ];
        programs.obsidian.enable = true;

        xdg.mimeApps = {
          enable = true;
          defaultApplications = {
            "application/pdf" = "firefox.desktop";
            "text/html" = "firefox.desktop";
            "application/x-enten" = "firefox.desktop";
            "x-scheme-handler/http" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
            "x-scheme-handler/about" = "firefox.desktop";
            "x-scheme-handler/unknown" = "firefox.desktop";
          };
        };
      };

    };
    
  };
}

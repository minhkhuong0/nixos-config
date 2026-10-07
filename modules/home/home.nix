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
          self.homeModules.browser
        ];
        programs.obsidian.enable = true;

        xdg.mimeApps = {
          enable = true;
          defaultApplications = {
            "application/pdf" = "zen-beta.desktop";
          };
        };
      };

    };
    
  };
}

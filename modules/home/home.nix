{ self, inputs, ... }:

{
  flake.homeConfigurations.homeManager = { ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

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
      };
    };
    
  };
}

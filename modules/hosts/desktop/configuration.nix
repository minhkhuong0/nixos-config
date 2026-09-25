{ self, inputs, ... }:

{
  flake.nixosModules.desktopConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.commonConfiguration
      self.nixosModules.desktopHardware
      ({ pkgs, ... }: {
        networking.hostName = "desktop";
      })
    ];
  };
}

{ self, inputs, ... }:

{
  flake.nixosModules.laptopConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.commonConfiguration
      self.nixosModules.laptopHardware
      ({ pkgs, ... }: {
        networking.hostName = "laptop";

        services.upower.enable = true;
        services.power-profiles-daemon.enable = true;
      })
    ];
  };
}

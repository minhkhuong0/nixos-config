{ self, inputs, ... }:

{
  flake.nixosModules.laptopHardware = { config, lib, pkgs, modulesPath, ... }: {
  imports   =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];
  
    boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];
  
    fileSystems."/" =
      { device = "/dev/disk/by-uuid/f32a68b4-e4bb-42ea-beb8-d834e3d06759";
        fsType = "ext4";
      };
  
    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/1DE8-289F";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };
  
    swapDevices =
      [ { device = "/dev/disk/by-uuid/2e05eac4-14c3-4675-873a-6d79ed9d9077"; }
      ];
  
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}

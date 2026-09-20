{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
	spawn-at-startup = [
	  (lib.getExe self'.packages.myNoctalia)
	];

	xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input = {
	  keyboard.xkb.layout = "us, altgr-intl";

	  touchpad = {
	    tap = {};
	    natural-scroll = {};
	    dwt = {};
	    accel-profile = "flat";
	    scroll-method = "two-finger";
	    middle-emulation = {};
	  };
	};

	layout.gaps = 5;

	binds = {
	  "Mod+T".spawn = lib.getExe pkgs.ghostty;
	  "Mod+D".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
	  "Mod+Q".close-window = _:{};
	};
      };
    };
  };
}
	  

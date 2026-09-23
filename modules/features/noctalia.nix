{ self, inputs, ... }: {
  flake.nixosModules.noctalia = { pkgs, lib, ... }: {
    systemd.user.services.noctalia = {
      description = "Noctalia Native Wayland Desktop Shell";
      documentation = [ "https://docs.noctalia.dev" ];
      
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];

      path = [
        "/run/current-system/sw"
        "/etc/profiles/per-user/%u"
      ];

      serviceConfig = {
        ExecStart = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia;
        Restart = "on-failure";
        RestartSec = 1;
      };
    };
  };

  perSystem = { pkgs, ... }: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;

      settings =
        (builtins.fromJSON
      	  (builtins.readFile ./noctalia.json)).settings;
    };
  };
}

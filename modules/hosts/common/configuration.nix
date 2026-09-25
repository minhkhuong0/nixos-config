{ self, inputs, ... }:

{
  flake.nixosModules.commonConfiguration = { pkgs, lib, ... }: {
    imports = [
      self.homeConfigurations.homeManager
      self.nixosModules.git
      self.nixosModules.nixvim
    ];
  
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;

        timeout = 1;
      };
      initrd = {
        verbose = false;
      };
    };
  
    networking.wireless.enable = true;
    hardware.bluetooth.enable = true;
  
    # Enable networking
    networking.networkmanager.enable = true;
  
    # Set your time zone.
    time.timeZone = "Europe/Berlin";
  
    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
  
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  
    users.defaultUserShell = "/bin/sh";
    users.users."khuong" = {
      isNormalUser = true;
      description = "Khuong";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.fish;
      packages = with pkgs; [];
    };

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    environment.pathsToLink = 
    [ "/share/applications" "/share/xdg-desktop-portal" ];

    fonts = {
      enableDefaultPackages = true;
      
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];
      fontconfig = {
        defaultFonts = {
          monospace = [ "JetBrainsMono Nerd Font" ];
        };
      };
    };
  
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    hardware.graphics.enable = true;
    environment.systemPackages = with pkgs; [
      wget
      curl
      firefox
      gh
      ripgrep
      yazi
    ];

    programs = {
      ssh.startAgent = true;
      
      foot = {
        enable = true;
        #server.enable = true;

        theme = "gruvbox";
        settings = {
          main = {
            font = "JetBrainsMono Nerd Font:size=12";
            pad = "0x0";
          };

          csd = {
            preferred = "none";
            size = 0;
          };
        };
        enableFishIntegration = true;
      };

      fish = {
        enable = true;
      };

    };

    services = {
      gnome.gcr-ssh-agent.enable = false;

      displayManager.noctalia-greeter = {
        enable = true;
        settings = {
          session.default = "/etc/profiles/per-user/khuong/bin/niri";
          cursor.size = 24;
          keyboard = {
            layout = "de";
            variant = "us";
          };
        };
      };
    };

    systemd.user.services.foot-server = {
      description = "foot terminal daemon (nix-wrapper-modules)";
      documentation = [ "man:foot(1)" ];
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];

      path = [
        "/run/wrappers"
        "/run/current-system/sw"
        "/etc/profiles/per-user/%u"
      ];
      serviceConfig = {
        ExecStart = "${pkgs.foot}/bin/foot --server";
        Restart = "on-failure";
      };
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  
    # List services that you want to enable:
  
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
  
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;
  
    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;
  
    system.stateVersion = "26.05"; # Did you read the comment?
  };
}

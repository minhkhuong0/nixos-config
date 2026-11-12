{ self, ... }:

{
  flake.nixosModules.commonConfiguration = { pkgs, lib, ... }:
    let
      go-migrate-no-snowflake = pkgs.go-migrate.overrideAttrs (oldAttrs: {
        tags = [ "postgres" "pgx5" "mysql" ];
      });
    in
    {
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
        gh
        ripgrep
        yazi
        gcc
        man-pages
        man-pages-posix
        python3
        colmena
        opentofu
        ansible
        kubectl
        kustomize
        kubernetes-helm
        joplin-desktop
        typst
        dig
        nmap
        awscli2
        ssm-session-manager-plugin
        legcord
        hugo
        thunderbird
        sops
        age
        firefox
        forgejo-cli
        qgis
        go
        gnumake
        sqlc
        go-migrate-no-snowflake
      ];

      programs = {
        ssh.startAgent = true;
        niri.enable = true;

        fish = {
          enable = true;
        };

      };

      services = {
        gnome.gcr-ssh-agent.enable = false;

        displayManager.noctalia-greeter = {
          enable = false;
          settings = {
            cursor.size = 24;
            keyboard = {
              layout = "de";
              variant = "us";
            };
          };
        };
      };

      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    
      system.stateVersion = "26.05";
    };
}

{ inputs, ... }: {
  flake.homeModules.browser = { config, repoPath, ... }: {
    imports = [
      inputs.zen-browser.homeModules.beta
    ];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      profiles = {
        default = {
          presets= {
            betterfox.enable = true;
            arkenfox.enable = false;
          };
          settings = {
            "zen.workspaces.continue-where-left-off" = true;
            "zen.view.compact.hide-tabbar" = true;
            "zen.urlbar.behavior" = "float";
            "zen.welcome-screen.seen" = true;
            "zen.view.experimental-no-window-controls" = true;
          };
        };
      };

      policies = {
        Preferences = {
          "browser.startup.homepage" = {
            Value = "about:blank";
            Status = "locked";
          };
          "browser.tabs.warnOnClose" = {
            Value = false;
            Status = "locked"; # User cannot change this
          };
        };
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = true;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };

    };
  };
}

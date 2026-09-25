{ self, inputs, ... }: {
  flake.homeModules.noctalia = { config, repoPath, ... }: {
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
    };

    xdg.configFile."noctalia/config.toml".source =
      config.lib.file.mkOutOfStoreSymlink
        (toString "${repoPath}/modules/home/noctalia/noctalia.toml");
  };
}

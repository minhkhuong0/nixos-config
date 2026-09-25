{ self, inputs, ... }: {
  flake.homeModules.foot = { config, repoPath, ... }: {
    programs.foot = {
      enable = true;
      server.enable = true;
    };

    xdg.configFile."foot/foot.ini".source =
      config.lib.file.mkOutOfStoreSymlink
        (toString "${repoPath}/modules/home/foot/foot.ini");
  };
}

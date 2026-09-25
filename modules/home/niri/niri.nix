{ self, inputs, ... }: {
  flake.homeModules.niri = { config, repoPath, ... }: {
    
    xdg.configFile."niri/config.kdl".source =
      config.lib.file.mkOutOfStoreSymlink
        (toString "${repoPath}/modules/home/niri/niri.kdl");
  };
}
	  

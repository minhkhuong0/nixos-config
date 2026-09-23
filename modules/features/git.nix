{ self, inputs, ... }: {
  flake.nixosModules.git = { pkgs, ... }: {
    programs.git = {
      enable = true;
      config = {
        user = {
          name = "Khuong Nguyen";
          email = "khuong.nguyen@tutamail.com";
        };
      };
    };
  };
}

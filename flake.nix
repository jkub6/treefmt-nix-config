{
  description = "Centralized treefmt configuration";

  inputs = {
    # Fetch your remote repo, but we just want the source tree
    mdformat-pandoc = {
      url = "git+ssh://git@github.com/jkub6/mdformat-pandoc";
      flake = false; 
    };
  };

  outputs = { self, ... }@inputs: {
    treefmtModule = { pkgs, ... }: import ./treefmt.nix { 
      inherit pkgs inputs; 
    };
  };
}

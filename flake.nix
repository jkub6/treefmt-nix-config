{
  description = "Centralized treefmt configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    mdformat-pandoc.url = "git+ssh://git@github.com/jkub6/mdformat-pandoc";
  };

  outputs = { self, nixpkgs, mdformat-pandoc }@inputs: {
    treefmtModule = { pkgs, ... }: import ./treefmt.nix { 
      inherit pkgs inputs; 
    };
  };
}

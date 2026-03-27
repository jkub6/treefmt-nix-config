{
  description = "Centralized treefmt configuration";

  inputs = {
    mdformat-pandoc.url = "github:jkub6/mdformat-pandoc";
    # You can add inputs.nixpkgs.follows = "nixpkgs"; here if you want 
    # to enforce it uses the downstream project's nixpkgs version.
  };

  outputs = { self, ... }@inputs: {
    # Export the module as a function that accepts the consumer's `pkgs`
    # and passes along our local `inputs`
    treefmtModule = { pkgs, ... }: import ./treefmt.nix { 
      inherit pkgs inputs; 
    };
  };
}

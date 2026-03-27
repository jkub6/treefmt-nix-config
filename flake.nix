{
  description = "Centralized treefmt configuration";

  outputs = { self, ... }@inputs: {
    treefmtModule = { pkgs, ... }: import ./treefmt.nix { 
      inherit pkgs inputs; 
    };
  };
}

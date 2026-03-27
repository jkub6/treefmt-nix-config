{
  description = "Standardized treefmt configuration";

  outputs = { self }: {
    # Export the configuration as a reusable Nix module
    treefmtModule = ./treefmt.nix;
  };
}

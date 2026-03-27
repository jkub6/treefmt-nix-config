{ pkgs, ... }:
{
  projectRootFile = "flake.nix";
  
  programs.terraform.enable = true;
  programs.terraform.package = pkgs.terraform_1;
  
  settings.formatter.terraform.excludes = [ "hello.tf" ];
}

{ pkgs, inputs, ... }:
let
  pyPkgs = pkgs.python3Packages;
  buildPy = pyPkgs.buildPythonPackage;

  mdformat-ruff = buildPy rec {
    pname = "mdformat-ruff";
    version = "0.1.3";
    format = "pyproject";
    src = pkgs.fetchPypi {
      pname = "mdformat_ruff";
      inherit version;
      hash = "sha256-Ld0nWN0/ZzjBx7++uJMg0nFFT0zYwoqZlopQ01eLFdY=";
    };
    nativeBuildInputs = [ pyPkgs.poetry-core ];
    propagatedBuildInputs = [ pyPkgs.mdformat pyPkgs.ruff ];
  };

  mdformat-shfmt = buildPy rec {
    pname = "mdformat-shfmt";
    version = "0.2.0";
    format = "pyproject";
    src = pkgs.fetchPypi {
      pname = "mdformat_shfmt";
      inherit version;
      hash = "sha256-DA9mK08Ro/sdF1z2KTMLCAV6/pHNwlloK8joVvzfC3o=";
    };
    nativeBuildInputs = [ pyPkgs.poetry-core ];
    propagatedBuildInputs = [ pyPkgs.mdformat ];
  };

  mdformat-yamlfmt = buildPy rec {
    pname = "mdformat-yamlfmt";
    version = "0.0.1";
    format = "pyproject";
    src = pkgs.fetchPypi {
      pname = "mdformat_yamlfmt";
      inherit version;
      hash = "sha256-Zy/z77ETx6D8pzvoz8on+iojEtiHW1/TRdp6s7zNr+E=";
    };
    nativeBuildInputs = [ pyPkgs.hatchling pyPkgs.ruff ];
    propagatedBuildInputs = [ pyPkgs.mdformat ];
  };

  # mdformat-pandoc = buildPy {
  #   pname = "mdformat-pandoc";
  #   version = "custom";
  #
  #   src = inputs.mdformat-pandoc;
  #   format = "pyproject"; 
  #   nativeBuildInputs = [ pyPkgs.setuptools ]; 
  #   propagatedBuildInputs = [ pyPkgs.mdformat ];
  # };

  # mdformat-pandoc = buildPy {
  #   pname = "mdformat_pandoc";
  #   version = "0.1.0";
  #   format = "pyproject";

  #   src = inputs.mdformat-pandoc;

  #   propagatedBuildInputs = with pyPkgs; [
  #     mdformat
  #     markdown-it-py
  #     mdit-py-plugins
  #     linkify-it-py
  #   ];

  #   nativeBuildInputs = [pyPkgs.flit-core];

  #   doCheck = false;
  # };

  # Construct the fully loaded mdformat package
  mdformat-custom = pkgs.mdformat.withPlugins (p: [
    mdformat-ruff
    mdformat-shfmt
    mdformat-yamlfmt
    inputs.mdformat-pandoc.packages.${pkgs.system}.default
  ]);
in
{
  projectRootFile = "flake.nix";

  settings.global.on-unmatched = "info";

  programs.alejandra.enable = true;
  programs.ruff.format = true;
  programs.yamlfmt.enable = true;
  programs.shfmt.enable = true;
  programs.stylua.enable = true;
  settings.formatter.stylua.options = [ "--column-width" "100" ];

  programs.mdformat.enable = true;
  programs.mdformat.package = mdformat-custom;
  settings.formatter.mdformat.command = "${mdformat-custom}/bin/mdformat";
  settings.formatter.mdformat.options = [
    "--wrap" "100"
    "--number"
    "--end-of-line" "lf"
    "--extensions" "pandoc"
  ];
}

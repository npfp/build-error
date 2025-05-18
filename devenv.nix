{ pkgs, pkgs-unstable, inputs,... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };
in
{
  # https://devenv.sh/packages/
  packages = [
    pkgs-unstable.cmake
    pkgs-unstable.clang
    pkgs.git
    pkgs.pkg-config
    pkgs.python311Full
    pkgs.python311Packages.pybind11
  ];

  env = {
    LDFLAGS = "-L${pkgs.python311Full}/lib";
    CPPFLAGS = "-I${pkgs.python311Full}/include";
    PKG_CONFIG_PATH = "${pkgs.python311Full}/lib/pkgconfig";
    CMAKE_CXX_COMPILER = "${pkgs-unstable.clang}";
    CMAKE_PREFIX_PATH = "${pkgs.python311Full}:${pkgs.python311Packages.pybind11}";
  };

  languages.cplusplus = {
    enable = true;
  };

  languages.python = {
    enable = true;
    version = "3.11";
    venv.enable = true;
    uv.enable = true;
  };

  dotenv.disableHint = true;

  # https://devenv.sh/scripts/
  # Activate the environment right away
  enterShell = ''
  '';

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
  };
}


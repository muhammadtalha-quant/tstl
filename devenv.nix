{
  pkgs,
  ...
}:

{
  stdenv = pkgs.llvmPackages.stdenv;
  packages = with pkgs; [
    statix
    deadnix
    markdownlint-cli2
    marksman
    cmake
    cmake-lint
    cmake-format
    neocmakelsp
  ];
  languages = {
    nix = {
      enable = true;
      lsp.package = pkgs.nil;
    };
    cplusplus = {
      enable = true;
      lsp.package = pkgs.clang-tools;
    };
  };
  scripts = {
    cppc.exec = "clang++ \"$@\"";
    cc.exec = "clang \"$@\"";
  };
}

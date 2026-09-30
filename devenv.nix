{
  pkgs,
  ...
}:

{
  packages = with pkgs; [
    marksman
    markdownlint-cli2
    markdown-toc
    cmake
    neocmakelsp
    ninja
    treefmt
  ];

  languages.cplusplus = {
    enable = true;
    lsp.enable = true;
    lsp.package = pkgs.clang-tools;
  };
}

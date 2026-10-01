{
  pkgs,
  ...
}:

{
  packages = with pkgs; [
    cmakeMinimal
    neocmakelsp
    ninja
    treefmt
    cmake-lint
    lldb
    cmake-format
  ];

  languages.cplusplus = {
    enable = true;
    lsp.enable = true;
    lsp.package = pkgs.clang-tools;
  };

  scripts = {
    tls.exec = "ninja -C build -t targets";
    build.exec = "ninja -C build";
    gen.exec = "cmake -G 'Ninja' -S . -B build";
    run.exec = ''
      BUILD_DIR=./build 
      $BUILD_DIR/$1
    '';
  };
}

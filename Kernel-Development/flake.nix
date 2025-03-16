{
  description = "A Nix-flake-based kernel development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    packages = with pkgs; [
      bc
      coreutils
      cpio
      dos2unix
      gcc
      gcc-unwrapped
      gcc-unwrapped.lib
      gcc-unwrapped.libgcc
      gcc-unwrapped.libgcc.libgcc
      binutils-unwrapped-all-targets
      binutils-unwrapped-all-targets.lib
      fish
      flex
      fontconfig
      bison
      pkg-config
      gnumake
      gnupg
      gperf
      cmake
      autoconf
      automake
      elfutils
      imagemagick
      util-linux
      kmod
      openssl
      openssl.dev
      ncurses.dev
      pngcrush
      python3
      readline
      readline.dev
      rsync
      schedtool
      gdb
      qemu
      git
      git-repo
      glibc
      glibc.static
      glibc.dev
      glibc_multi
      glibc_multi.dev
      squashfsTools
      stdenv.cc
      stdenv.cc.cc
      stdenv.cc.cc.lib
      zlib
      zlib.dev
      zstd
      libelf
      linuxHeaders
      libxslt
      glibcLocales
      xml2
      libxml2
      file
      strace
      perf-tools
      zip
    ];

  in {
    packages."${system}".dev = pkgs.buildFHSEnv {
      name = "kernel-fhs-env";

      buildInputs = packages;
      targetPkgs = pkgs: with pkgs; packages;

      runScript = "fish";
    };
  };
}
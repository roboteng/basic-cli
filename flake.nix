{
  description = "Basic cli devShell flake";

  inputs = {
    roc.url = "github:roc-lang/roc";
    # to use a specific commit:
    # roc.url = "github:roc-lang/roc?rev=635e6058cce4961e6c4fa7363545b794a44f1818";

    nixpkgs.follows = "roc/nixpkgs";

    # rust from nixpkgs has some libc problems, this is patched in the rust-overlay
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # to easily make configs for multiple architectures
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, roc, rust-overlay, flake-utils }:
    let supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
    in flake-utils.lib.eachSystem supportedSystems (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };

        rocPkgs = roc.packages.${system};
        llvmPkgs = pkgs.llvmPackages_16;

        # get current working directory
        cwd = builtins.toString ./.;
        rust =
          pkgs.rust-bin.fromRustupToolchainFile "${toString ./rust-toolchain.toml}";

        linuxInputs = with pkgs;
          lib.optionals stdenv.isLinux [
            valgrind
          ];

        darwinInputs = with pkgs;
          lib.optionals stdenv.isDarwin
          (with pkgs.darwin.apple_sdk.frameworks; [
            Security
          ]);

        sharedInputs = (with pkgs; [
          jq
          rust
          llvmPkgs.clang
          llvmPkgs.lldb # for debugging
          expect
          nmap
          simple-http-server
          rocPkgs.cli
        ]);
      in {

        devShell = pkgs.mkShell {
          buildInputs = sharedInputs ++ darwinInputs ++ linuxInputs;

          # nix does not store libs in /usr/lib or /lib
          NIX_GLIBC_PATH =
            if pkgs.stdenv.isLinux then "${pkgs.glibc.out}/lib" else "";
        };

        formatter = pkgs.nixpkgs-fmt;
      });
}

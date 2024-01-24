{
  description = "fpga_tools";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/85f1ba3e51676fa8cc604a3d863d729026a6b8eb;
  };

  outputs = { self, nixpkgs }:
    let system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
        };
        buildInputs = (with pkgs; [
          # fpga
          yosys nextpnr
        ]);
    in
  {
    # Old hack to collect buildInputs in env vars.
    packages.${system}.default =
      pkgs.stdenv.mkDerivation {
        name = "exo-dev";
        src = self;
        inherit buildInputs;
        builder = ./builder.sh;
      };

    # New standard flake approach
    devShells.${system}.default =
      pkgs.mkShell {
        packages = buildInputs;
        shellHook = ''
          echo fpga_tools/flake.nix
        '';          
      };
  };
}

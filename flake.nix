{
	inputs = {
		nixpkgs.url     = "github:nixos/nixpkgs/nixpkgs-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils }:
		flake-utils.lib.eachDefaultSystem(system:
			let
				pkgs = import nixpkgs { inherit system; };
				revpath = pkgs.rustPlatform.buildRustPackage rec {
					pname = "revpath";
					version = "1.0";
					src = ./.;
					cargoLock.lockFile = "${src}/Cargo.lock";
				};
			in {
				devShells.default = pkgs.mkShell {
					nativeBuildInputs = with pkgs; [
						rustc
						cargo
						clippy
						rustfmt
						rust-analyzer
					];
				};

				packages = {
					default = revpath;
					revpath = revpath;
				};
			}
		);
}

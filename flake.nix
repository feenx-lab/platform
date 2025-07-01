{
  description = "feenx-platform";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          packages = [
            kubectl
            kubernetes-helm
            fluxcd

            # Alias scripts, workaround for https://github.com/direnv/direnv/issues/73
            (pkgs.writeShellScriptBin "k" "kubectl $@")
            (pkgs.writeShellScriptBin "h" "helm $@")
          ];
        };
      }
    );
}
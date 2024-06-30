{
  description = "BowlBird Logo Plymouth Theme";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs= nixpkgs.legacyPackages.${system};

    in {
      packages.default = pkgs.stdenv.mkDerivation {
        pname = "plymouth-theme-bowlbird-logo";
        version = "1.0.0";
        src = ./bowlbird-logo;

        installPhase = ''
          mkdir -p $out/share/plymouth/themes/bowlbird-logo
          cp * $out/share/plymouth/themes/bowlbird-logo
          chmod +x $out/share/plymouth/themes/bowlbird-logo/bowlbird-logo.plymouth $out/share/plymouth/themes/bowlbird-logo/bowlbird-logo.script
          sed -i "s@/usr/@$out/@" $out/share/plymouth/themes/nixos-load/nixos-load.plymouth
        '';
      };
    };
}

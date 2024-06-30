{
  description = "BowlBird Logo Plymouth Theme";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let allSystems = flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system};

        package = pkgs.stdenv.mkDerivation {
          pname = "plymouth-theme-bowlbird-logo";
          version = "2.0.0";
          src = ./bowlbird-logo;

          installPhase = ''
            mkdir -p $out/share/plymouth/themes/bowlbird-logo
            cp * $out/share/plymouth/themes/bowlbird-logo
            chmod +x $out/share/plymouth/themes/bowlbird-logo/bowlbird-logo.plymouth $out/share/plymouth/themes/bowlbird-logo/bowlbird-logo.script
            sed -i "s@/usr/@$out/@" $out/share/plymouth/themes/bowlbird-logo/bowlbird-logo.plymouth
          '';
        };
      in {
        packages.plymouth-theme-bowlbird-logo = package;
        defaultPackage = package;
      }
    );
    in {
      packages = allSystems.packages;
      defaultPackage = allSystems.defaultPackage; 

      overlay = final: prev: {
        boot.plymouth.themePackages = prev.boot.plymouth.themePackages // {
          bowlbird-logo = allSystems.defaultPackage;
        };
        plymouth-theme-bowlbird-logo = 
          allSystems.packages.${final.system}.plymouth-theme-bowlbird-logo;
      };
    };
}
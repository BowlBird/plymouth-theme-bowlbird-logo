{
  description = "BowlBird Logo Plymouth Theme";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, flake-compat }:
    let allSystems =
      flake-utils.lib.eachDefaultSystem (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          package =
            pkgs.stdenv.mkDerivation {
              pname = "plymouth-theme-bowlbird-logo";
              version = "1.0.0";

              src = builtins.path { path = ./.; name = "plymouth-theme-bowlbird-logo"; };

              buildInputs = [ ];

              configurePhase = "mkdir -pv $out/share/plymouth/themes/";
              dontBuild = true;
              installPhase = ''
                cp -rv bowlbird-logo/ $out/share/plymouth/themes/
                substituteInPlace $out/share/plymouth/themes/bowlbird-logo/bowlbird-logo.plymouth \
                  --replace "/usr/" "$out/"
              '';
            };
        in
        {
          packages.plymouth-theme-bowlbird-logo = package;
          defaultPackage = package;
        }
      );
    in
    {
      packages = allSystems.packages;
      defaultPackage = allSystems.defaultPackage;
      overlay = final: prev: {
        plymouth-theme-bowlbird-logo =
          allSystems.packages.${final.system}.plymouth-theme-bowlbird-logo;
      };
    };
}

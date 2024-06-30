{
  description = "BowlBird Logo Plymouth Theme";
  
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, ... }: {
    defaultPackage.x86_64-linux = 
    with import nixpkgs { system = "x86_64-linux"; };
    stdenv.mkDerivation {
      pname = "plymouth-theme-bowlbird-logo";
      version = "1.0.0";
      src = ./bowlbird-logo;
      dontBuild = true;
      installPhase = ''
        mkdir -p $out/share/plymouth/themes/bowlbird-logo
        cp * $out/share/plymouth/themes/bowlbird-logo
        find $out/share/plymouth/themes/ -name \*.plymouth -exec sed -i "s@\/usr\/@$out\/@" {} \;
      '';
    };
  };
}
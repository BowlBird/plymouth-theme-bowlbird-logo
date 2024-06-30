{
  description = "BowlBird Logo Plymouth Theme";
  
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = 
    with import nixpkgs { system = "x86_64-linux"; };
    stdenv.mkDerivation {
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
  };
}
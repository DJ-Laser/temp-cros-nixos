{ stdenv, pkgs, lib }:

pkgs.stdenv.mkDerivation rec {
  name = "cros-ectool";
  nativeBuildInputs = with pkgs; [ cmake ninja pkg-config libusb1 libftdi1 ];
  src = pkgs.fetchFromGitHub {
    owner = "coreboot";
    repo = "chrome-ec";
    rev = "b51842e45fb70b2a643dca77bc89b03ee7b6460e";
    hash = "";
  };
  buildPhase = ''
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp src/ectool $out/bin/ectool
  '';
  meta = with lib; {
    homepage = "https://github.com/coreboot/chrome-ec";
    license = licenses.bsd3;
    platforms = platforms.linux;
    mainProgram = "ectool";
  };
}

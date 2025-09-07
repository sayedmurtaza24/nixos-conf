{ config, pkgs, lib, ... }:

let
  remotegamepad = pkgs.stdenv.mkDerivation rec {
    pname = "remotegamepad";
    version = "1.0";

    src = pkgs.fetchurl {
      url = "https://download.remotegamepad.com/remotegamepad_amd64.tar.gz";
      # You'll need to add the actual sha256 hash here
      # Run: nix-prefetch-url https://download.remotegamepad.com/remotegamepad_amd64.tar.gz
      sha256 = "1w7nxd38lx9b4i1gj6xcixi7dzl94rkncm8i6g0bhfzpkx2lvmvd"; # Replace with actual hash
    };

    nativeBuildInputs = with pkgs; [
      autoPatchelfHook
      makeWrapper
    ];

    buildInputs = with pkgs; [
      glibc
      libxcrypt
      zlib
      gtk3
      pango
      harfbuzz
      atk
      cairo
      gdk-pixbuf
      glib
    ];

    sourceRoot = ".";

    installPhase = ''
      runHook preInstall

      # Create directories
      mkdir -p $out/bin $out/share/remotegamepad $out/lib

      # Copy all files to share directory
      cp -r * $out/share/remotegamepad/

      # Make the binary executable
      chmod +x $out/share/remotegamepad/remotegamepad

      # Create symlink for libcrypt.so.1 compatibility
      ln -sf ${pkgs.libxcrypt}/lib/libcrypt.so.2 $out/lib/libcrypt.so.1

      # Create wrapper script
      makeWrapper $out/share/remotegamepad/remotegamepad $out/bin/remotegamepad \
        --prefix LD_LIBRARY_PATH : "$out/lib:${lib.makeLibraryPath buildInputs}"

      runHook postInstall
    '';

    meta = with lib; {
      description = "Remote Gamepad application";
      homepage = "https://remotegamepad.com";
      license = licenses.unfree;
      platforms = platforms.linux;
      maintainers = [ ];
    };
  };
in
{
  home.packages = [ remotegamepad ];
}

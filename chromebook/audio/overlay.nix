{pkgs, ...}:

{
  nixpkgs.overlays = [(final: prev: {
    chromebook = {
      audioConf = pkgs.fetchFromGitHub {
        owner = "WeirdTreeThing";
        repo = "chromebook-linux-audio";
        sparseCheckout = ["conf"];
        rev = "99eef5cc3d2f82f451c34764f230f3d5d22239cf";
        hash = "sha256-u/sryot3ZujtDC6UaDjnGZT3UbrNUTd27DG4zk8SxEM=";
      };

      alsa-ucm-conf = pkgs.alsa-ucm-conf.overrideAttrs {
        wttsrc = pkgs.fetchFromGitHub {
          owner = "WeirdTreeThing";
          repo = "alsa-ucm-conf-cros";
          rev = "f7be751655e4298851615bded7adaf364ccfb8c3";
          hash = "sha256-GHrK85DmiYF6FhEJlYJWy6aP9wtHFKkTohqt114TluI=";
        };

        postInstall = ''
          echo Out: $out
          echo Wttsrc $wttsrc

          cp -r $wttsrc/ucm2/* $out/share/alsa/ucm2
        '';
      };
    };
  })];
}

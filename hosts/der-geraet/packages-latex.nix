{
  config,
  pkgs,
  ...
}: let
  my-latex-packages = with pkgs;
    texliveFull.withPackages (ps:
      with ps; [
        texlivePackages.minted
      ]);
in {
  environment.systemPackages = [
    my-latex-packages
  ];
}

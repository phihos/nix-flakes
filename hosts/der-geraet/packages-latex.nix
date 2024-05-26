# not included
# using devcontainers now since minted with autogobble needs python3 binary
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

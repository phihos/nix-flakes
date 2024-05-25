{
  config,
  pkgs,
  ...
}: let
  my-latex-packages = with pkgs;
    texlive.withPackages (ps:
      with ps; [
        texdoc # recommended package to navigate the documentation
        perlPackages.LaTeXML.tex # tex files of LaTeXML, omit binaries
        cm-super
        cm-super.texdoc # documentation of cm-super
      ]);
in {
  environment.systemPackages = [
    my-latex-packages
  ];
}

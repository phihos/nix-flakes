{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-software-center.url = "github:snowfallorg/nix-software-center";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    poetry2nix.url = "github:nix-community/poetry2nix";

    nur.url = github:nix-community/NUR;
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    nur,
    ...
  } @ inputs: {
    nixosConfigurations.der-geraet = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./hosts/der-geraet/configuration.nix
        inputs.home-manager.nixosModules.default
        nixos-hardware.nixosModules.framework-13th-gen-intel
        nur.nixosModules.nur
      ];
    };
  };
}

{ inputs, lib }:

let
  inherit (inputs.self.lib) mkDarwinSystem;
  
  # Machine configuration registry
  machines = {
    # MacBook Air - Development focused laptop
    "Viktors-MacBook-Air" = {
      system = "aarch64-darwin";
      features = {
        development = true;
        creative = false;
        gaming = false;
      };
      # No additional modules needed beyond host-specific config
      modules = [];
    };

    # MacBook Air (alternative name) - Same config but with homebrew
    "Air15" = {
      system = "aarch64-darwin";
      features = {
        development = true;
        creative = false;
        gaming = false;
      };
      modules = [
        # Enable nix-homebrew for this machine
        inputs.nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "viktor";
            mutableTaps = true;
          };
        }
      ];
    };

    # Mac Studio - Full workstation with all features
    "Viktors-Mac-Studio" = {
      system = "aarch64-darwin";
      features = {
        development = true;
        creative = true;
        gaming = true;
      };
      modules = [];
    };
  };

in
{
  # Export machine definitions
  inherit machines;

  # Generate darwin configurations from machine definitions
  darwinConfigurations = lib.mapAttrs (hostname: config:
    mkDarwinSystem {
      inherit hostname;
      inherit (config) system modules;
      extraSpecialArgs = {
        features = config.features;
      };
    }
  ) machines;
}
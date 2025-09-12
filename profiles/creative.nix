{ pkgs, lib, ... }:

{
  environment.systemPackages =  [
    # openscad is in homebrew casks
  ];

  # Creative-specific Homebrew packages (matching current setup)
  homebrew = {
    casks = [
      "gimp"
      "inkscape"
      "blender"
      "openscad@snapshot"
      "kicad"
      "arduino-ide"
      "openshot-video-editor"
      "rawtherapee"
      "digikam"
      "ultimaker-cura"
      "orcaslicer"
      "vcv-rack" # modular synth
      "cardinal"
      "calibre" # ebook management
      "adobe-digital-editions" # epub reader
    ];

    brews = [
      "gmsh" # To view stl's
      "wimlib" # To split windows iso files > 4GB for bootable USB
    ];

    taps = [
    ];

    masApps = {
      logic = 634148309;
    };
  };

  # Creative-specific fonts (only current ones)
  fonts.packages = with pkgs; [
    # Design fonts currently in use
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  # Creative-specific system configuration
  system.defaults = {
    # Optimize for creative work
    dock = {
      tilesize = lib.mkDefault 48; # Larger icons for creative apps
    };
  };
}

{ pkgs, lib, ... }:

{
  # Creative profile for design, media creation, and artistic work - only current tools

  environment.systemPackages = with pkgs; [
    # 3D and CAD tools currently in use
    # openscad is in homebrew casks
  ];

  # Creative-specific Homebrew packages (matching current setup)
  homebrew = {
    casks = [
      # Image and design editing
      "gimp"
      "inkscape"
      
      # 3D modeling and design
      "blender"
      "openscad@snapshot"
      
      # CAD and electronics
      "kicad"
      "arduino-ide"
      
      # Video editing
      "openshot-video-editor"
      
      # Photography workflow
      "rawtherapee"
      "digikam"
      
      # 3D printing
      "ultimaker-cura"
      "orcaslicer"
      
      # Audio production
      "vcv-rack" # modular synth
      "cardinal"
      
      # Design utilities
      "calibre" # ebook management
      "adobe-digital-editions" # epub reader
    ];
    
    brews = [
      # 3D mesh viewing
      "gmsh" # To view stl's
      
      # Windows ISO utilities  
      "wimlib" # To split windows iso files > 4GB for bootable USB
    ];
    
    taps = [
      # Already covered in base darwin profile
    ];
    
    masApps = {
      # Creative apps from Mac App Store (already in darwin profile)
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
      tilesize = 48; # Larger icons for creative apps
    };
  };
}
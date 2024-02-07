# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ user, config, pkgs, inputs, ... }:

let
  filesIn = dir: (map (fname: dir + "/${fname}")
                 (builtins.attrNames (builtins.readDir dir)));
in
{
  system.autoUpgrade.flake = "github:nixos/nixpkgs/nixos-unstable";
  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than +5"; #i do a lot of edits :)
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # home-manager = {
  #   extraSpecialArgs = { inherit inputs filesIn user environment; };
  #   users = {
  #     ${user} = import ./home.nix;
  #   };
  # };
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # inputs.home-manager.nixosModules.default
      ./home.nix
		];


	boot.loader = {
		efi = {
			canTouchEfiVariables = true;
			#efiSysMountPoint = "/boot/efi";
		};
		#grub = {
		#	efiSupport = true;
		#	device = "nodev";
		#};
		systemd-boot.enable = true;
		systemd-boot.configurationLimit = 5;
	};

	boot.plymouth.enable = false;

	

  networking.hostName = "mocha"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.networks = {
    "Giovanna 5" = { psk = "Akira2020"; };
  };
  networking.interfaces.wlp2s0.ipv4.addresses = [ {
    address = "192.168.1.122";
    prefixLength = 24;
  } ];
  #networking.interfaces.eth1s0.ipv4.addresses = [ {
  # address = "192.168.1.123";
  #  prefixLength = 24;
  #} ];
  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "1.1.1.1" ];


  #networking.networkmanager.enable = true;
  #networking.networkmanager.unmanaged = [ "except:type:wlan" ];

  time.timeZone = "America/Santiago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_CL.UTF-8";
    LC_IDENTIFICATION = "es_CL.UTF-8";
    LC_MEASUREMENT = "es_CL.UTF-8";
    LC_MONETARY = "es_CL.UTF-8";
    LC_NAME = "es_CL.UTF-8";
    LC_NUMERIC = "es_CL.UTF-8";
    LC_PAPER = "es_CL.UTF-8";
    LC_TELEPHONE = "es_CL.UTF-8";
    LC_TIME = "es_CL.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.variant = "altgr-intl";
    xkb.layout = "us";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  security.sudo.extraConfig = ''
    %wheel      ALL=(ALL:ALL) NOPASSWD: ALL
  '';

  programs.rust-motd = {
    enable = true;
    settings = {
    	banner.color = "white";
	banner.command = "echo '\
[8:14 AM]Todd Howard (⚪/⚫): you can either thug \
this shit out for a promise of stability in \
future or you can just plunge into depths unknown\
\
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣎⠱⣲⠀⠀⠀⠀⠀⠀⠀\
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡠⠤⠒⠒⠒⠒⠤⢄⣈⠈⠁⠀⠀⠀⠀⠀⠀⠀\
⠀⠀⠀⠀⠀⠀⠀⢀⡤⠒⠝⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠲⢄⡀⠀⠀⠀⠀⠀\
⠀⠀⠀⠀⠀⢀⡴⠋⠀⠀⠀⠀⣀⠀⠀⠀⠀⠀⠀⢠⣢⠐⡄⠀⠉⠑⠒⠒⠒⣄\
⠀⠀⠀⣀⠴⠋⠀⠀⠀⡎⢀⣘⠿⠀⠀⢠⣀⢄⡦⠀⣛⣐⢸⠀⠀⠀⠀⠀⠀⢘\
⡠⠒⠉⠀⠀⠀⠀⠀⡰⢅⠣⠤⠘⠀⠀⠀⠀⠀⠀⢀⣀⣤⡋⠙⠢⢄⣀⣀⡠⠊\
⢇⠀⠀⠀⠀⠀⢀⠜⠁⠀⠉⡕⠒⠒⠒⠒⠒⠛⠉⠹⡄⣀⠘⡄⠀⠀⠀⠀⠀⠀\
⠀⠑⠂⠤⠔⠒⠁⠀⠀⡎⠱⡃⠀⠀⡄⠀⠄⠀⠀⠠⠟⠉⡷⠁⠀⠀⠀⠀⠀⠀\
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⠤⠤⠴⣄⡸⠤⣄⠴⠤⠴⠄⠼⠀\
\
\
Welcome to NixOS ${config.system.nixos.release} (${config.system.nixos.codeName}) [v${config.boot.kernelPackages.kernel.version}].'";
    	uptime.prefix = "up and going for";
	filesystems.root = "/";
	memory.swap_pos = "beside";
	last_login = { "${user}" = 1; };
    };
  };



  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     vscode
     curl
     git
     jq
     lm_sensors.out
     waynergy
  ];

	environment.sessionVariables = {
		NIXOZ_OZONE_WL = "1";
	};

	hardware = {
		opengl.enable = true;
		opengl.extraPackages = with pkgs; [
			intel-media-driver
			#vaapiIntel
			vaapiVdpau
			libvdpau-va-gl
		];
	};

	xdg.portal = {
		enable = true;
		extraPortals = [pkgs.xdg-desktop-portal-hyprland];
		config = {
  		common = {
    		default = [
      		"gtk"
    		];
  		};
		};
	};
	sound.enable = true;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.PermitRootLogin = "yes";
  };
#   services.synergy.client = {
#     enable = true;
#     serverAddress = "192.168.1.11";
#     autoStart = true;
#   };
#   services.synergy.server.enable = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}

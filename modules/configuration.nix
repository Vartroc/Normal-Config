# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  	imports =
    	[ # Include the results of the hardware scan.
      		./hardware-configuration.nix
      		./users.nix
		(import ./disko.nix)
    	];

  	# Use the systemd-boot EFI boot loader.
	# Use the systemd-boot GRUB boot loader.
        boot.loader.grub.enable = true;
        boot.loader.grub.devices = [ "nodev" ];
        boot.loader.grub.efiInstallAsRemovable = true;
        boot.loader.grub.efiSupport = true;
        boot.loader.grub.useOSProber = true;
	
  	networking.hostName = "Gartroc"; # Define your hostname.
  	networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  	# Set your time zone.
  	 time.timeZone = "Europe/Berlin";

  	# Configure network proxy if necessary
  	# networking.proxy.default = "http://user:password@proxy:port/";
  	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  	# Select internationalisation properties.
  	# i18n.defaultLocale = "de_US.UTF-8";
   	
  	console = {
  		font = "Lat2-Terminus16";
  		keyMap = "de";
  	#   useXkbConfig = true; # use xkb.options in tty.
  	};

  	# Enable the Hyprland
  	programs.hyprland.enable = true;


  

  	# Enable CUPS to print documents.
   	services.printing.enable = true;

  	# Enable sound.
  	sound.enable = true;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

	programs.steam.enable = true;
	fileSystems = {
		"/".neededForBoot = true;
		"/persist/system".neededForBoot = true;
	};
	
	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = with pkgs; [
		
		# Essentials
                home-manager
                neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
                wget
                waybar
                (waybar.overrideAttrs (oldAttrs: {
                        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
                        }		
		)
                )
                networkmanagerapplet
                hyprpaper
		swww
		mako
		libnotify
		wezterm
                kitty
                rofi-wayland
		wofi
		git
		grim
		slurp
		wf-recorder
		mpv
		zoxide
                zip
		alsa-utils

		# Apps
                firefox
		qutebrowser
                discord
                whatsapp-for-linux
                element-desktop
		pavucontrol
		easyeffects

		# Gaming
                prismlauncher
                lutris
                wine
                winetricks
                bottles
		mindustry-wayland

		# Missalaneous
                pinta
                dolphin
                libreoffice
        ];

	

  	# Some programs need SUID wrappers, can be configured further or are
  	# started in user sessions.
  	programs.mtr.enable = true;
  	programs.gnupg.agent = {
  		enable = true;
  		enableSSHSupport = true;
  	};

  	# List services that you want to enable:

  	# Enable the OpenSSH daemon.
  	# services.openssh.enable = true;

  	# Open ports in the firewall.
  	networking.firewall.allowedTCPPorts = [ 25565 ];
  	networking.firewall.allowedUDPPorts = [ 25565
						34197 ];
  	# Or disable the firewall altogether.
  	# networking.firewall.enable = false;


  
	environment.persistence."/persist/system" = {
		hideMounts = true;
		directories = [
			"/var/log"
      		#	"/var/lib/bluetooth"
      			"/var/lib/nixos"
      			"/var/lib/systemd/coredump"
		];
		files = [
			"/etc/machine-id"
		];
		users.andi = {
			directories = [
				".factorio"
				".steam"
				".mozilla"
				".config/hypr/wallpapers/"
			];
			files = [
				".config/hypr/hyprland.conf"
				".config/hypr/start.sh"
			];
		};
	};
  	

	system.stateVersion = "23.11"; # Did you read the comment?

}


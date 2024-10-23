{ pkgs, ... }: {
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "vmd152122";
  networking.domain = "contaboserver.net";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPGxaPwBikfpS6Kmnhzb1e00P1oD812AYZkz9HtsX4zb thomas@MacBookPro'' ];
  system.stateVersion = "23.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = [
    pkgs.helix
    pkgs.git
  ];
  users.users.psv = {
    isNormalUser = true;
    createHome = true;
    home = "/home/psv";
    hashedPassword = "$y$j9T$1doeF3Fa4EW86xkbjdf4x1$bLyKHWxC1ScFDIH4QX1RaSgpjs1WPY8oBaA4hDMrXH2";
    openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPGxaPwBikfpS6Kmnhzb1e00P1oD812AYZkz9HtsX4zb thomas@MacBookPro'' ];
    extraGroups  = [ "wheel" ];
  };
}

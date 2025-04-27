{ pkgs, ... }: {
  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "vmd152122";
  networking.domain = "contaboserver.net";
  services.openssh.enable = true;
  services.fail2ban.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPGxaPwBikfpS6Kmnhzb1e00P1oD812AYZkz9HtsX4zb thomas@MacBookPro'' ];
  system.stateVersion = "23.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = [
    pkgs.helix
    pkgs.git
    pkgs.gh
  ];
  users.users.psv = {
    isNormalUser = true;
    createHome = true;
    home = "/home/psv";
    hashedPassword = "$y$j9T$1doeF3Fa4EW86xkbjdf4x1$bLyKHWxC1ScFDIH4QX1RaSgpjs1WPY8oBaA4hDMrXH2";
    openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPGxaPwBikfpS6Kmnhzb1e00P1oD812AYZkz9HtsX4zb thomas@MacBookPro'' ];
    extraGroups  = [ "wheel" ];
  };

  # backup
  systemd.services.backupdocker = {
    enable = true;
    startAt = "daily";
    path = [ "/run/booted-system/sw/bin/" ];
    serviceConfig = {
      ExecStart = ''${pkgs.rsync}/bin/rsync -Pav -e "${pkgs.openssh}/bin/ssh -2 -i /home/psv/.ssh/backup_server" /home/psv/docker psv-backup@cloud.franks-im-web.de:'';
    };
  };
}

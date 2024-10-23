{ ... }:
let
  base_dir = "/home/psv/docker";
in {
  networking.firewall.allowedTCPPorts = [
    80 # traefik
    443 # traefik
    9443 # portainer
  ];

  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    portainer = {
      image = "portainer/portainer-ce:latest";
      ports = [
        "8000:8000"
        "9443:9443"
      ];
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "${base_dir}/portainer_data:/data"
      ];
    };
  };
}

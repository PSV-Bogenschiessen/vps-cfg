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
      labels = {
        "traefik.enable" = "true";
        "traefik.http.routers.portainer.rule" = "(Host(`portainer.bogen-psv.de`))";
        "traefik.http.routers.portainer.entrypoints" = "websecure";
        "traefik.http.routers.portainer.tls" = "true";
        "traefik.http.routers.portainer.tls.certresolver" = "myresolver";
        "traefik.http.services.portainer.loadbalancer.server.port" = "9000";
      };
      extraOptions = [
        "--network=traefik_proxy"
      ];
    };
  };
}

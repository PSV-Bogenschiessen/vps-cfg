# PSV Virtual Private Server (VPS)

For hosting various services we operate a storage vps at [Contabo](https://contabo.com).

## Base System
As the operating system we chose NixOS as a secure, declarative and slim base. All services are hosted in docker containers.
The system configuration is located in this repository.

To install NixOS on the contabo VPS [nixos-infect](https://github.com/elitak/nixos-infect) was used.

## Portainer
To facilitate easy configuration and deployment of services we chose [Portainer](https://www.portainer.io).
The portainer container is also declaratively configured in this repository because it's a core service.

## Other Services
All other services are configured in portainer. Simple services are just deployed as a container. More complex ones are deployed with a docker-compose stack.

### Traefik
[Traefik](https://traefik.io/traefik/) is used as a reverse proxy which can auto detect other services based on container labels.
To add a service you need to provide a new domain name correctly configured to point to the vps ip.
This probably needs to be configured at [Alfahosting](https://alfahosting.de) where bogen-psv.de is registered.

### Watchtower
[Watchtower](https://containrrr.dev/watchtower/) keeps all containers up to date.

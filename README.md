<p align="center">
  <img src="https://raw.githubusercontent.com/RouHim/sons-of-the-forest-container-image/main/.github/readme/logo.png" width="250">
</p>

<p align="center">
    <a href="https://github.com/RouHim/sons-of-the-forest-container-image/actions/workflows/pipeline.yml"><img src="https://github.com/RouHim/sons-of-the-forest-container-image/actions/workflows/pipeline.yml/badge.svg?branch=main" alt="Pipeline"></a>
    <a href="https://hub.docker.com/r/rouhim/sons-of-the-forest-server"><img src="https://img.shields.io/docker/pulls/rouhim/sons-of-the-forest-server.svg" alt="Docker Hub pulls"></a>
    <a href="https://hub.docker.com/r/rouhim/sons-of-the-forest-server"><img src="https://img.shields.io/docker/image-size/rouhim/sons-of-the-forest-server" alt="Docker Hub size"></a>
    <a href="https://github.com/aquasecurity/trivy"><img src="https://img.shields.io/badge/trivy-protected-blue" alt="trivy"></a>
    <a href="https://hub.docker.com/r/rouhim/sons-of-the-forest-server/tags"><img src="https://img.shields.io/badge/ARCH-amd64-blueviolet" alt="os-arch"></a>
    <a href="https://buymeacoffee.com/rouhim"><img alt="Donate me" src="https://img.shields.io/badge/-buy_me_a%C2%A0coffee-gray?logo=buy-me-a-coffee"></a>
</p>

<p align="center">
    This project provides a container image for the <a href="https://sons-of-the-forest.com">Sons of the Forest</a>
    game server and shows its usage in a docker-compose environment.
</p>

## Introduction

This repository provides a container image for running a Sons of the Forest game server. It is designed to be used with
Docker and Docker Compose, making it easy to set up and manage your game server environment.

## Installation

To install and run the Sons of the Forest server using this container image, you will need _Docker_ and _Docker Compose_
installed on your system. If you do not have these tools installed, please refer to the official Docker documentation
for installation instructions.

Once Docker and Docker Compose are installed, clone this repository to your local machine:

```bash
git clone https://github.com/RouHim/sons-of-the-forest-container-image.git
cd sons-of-the-forest-container-image
```

Before starting the server, create the required folder structure:

```bash
mkdir config/ data/ && chmod 777 config/ data/
```

## Usage

To start the Sons of the Forest server, navigate to the cloned repository's directory and use Docker Compose:

```bash
docker-compose pull
docker-compose up -d
```

This will pull the latest image and start the server in detached mode. Your Sons of the Forest server should now be
running and accessible.

To restart the server after making changes to the configuration, use the following command:

```bash
docker-compose restart
```

## Configuration

The game server configuration is done within the `dedicatedserver.cfg` located in the `config/` folder. The file is
automatically created on the first start of the container. You need to restart the container for changes to take effect.

The `ownerswhitelist.txt`, also located in the `config/` folder, contains the Steam IDs of the people who are allowed
to join the server. The file is automatically created on the first start of the container. You need to restart the
container for changes to take effect.

The `data/` folder contains the game server data, such as the world/map save files.
Feel free to modify files in this folder, but be aware that the game server must be restarted for changes to take
effect.
The folder can be deleted to reset the game server to its default state.

# Resources

- Inspired by: https://github.com/jammsen/docker-sons-of-the-forest-dedicated-server
- Built from: https://github.com/RouHim/sons-of-the-forest-container-image
- Built to: https://hub.docker.com/r/rouhim/sons-of-the-forest-server
- SteamCMD Documentation: https://developer.valvesoftware.com/wiki/SteamCMD
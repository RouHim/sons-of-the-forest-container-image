<p align="center">
  <img src="https://raw.githubusercontent.com/RouHim/sons-of-the-forest-container-image/main/.github/readme/logo.png" width="250">
</p>

<p align="center">
    <a href="https://github.com/RouHim/sons-of-the-forest-container-image/actions/workflows/pipeline.yml"><img src="https://github.com/RouHim/sons-of-the-forest-container-image/actions/workflows/pipeline.yml/badge.svg?branch=main" alt="Pipeline"></a>
    <a href="https://github.com/RouHim/sons-of-the-forest-container-image/actions/workflows/scheduled-security-audit.yaml"><img src="https://github.com/RouHim/sons-of-the-forest-container-image/actions/workflows/scheduled-security-audit.yaml/badge.svg?branch=main" alt="Pipeline"></a>
    <a href="https://hub.docker.com/r/rouhim/sons-of-the-forest-server"><img src="https://img.shields.io/docker/pulls/rouhim/sons-of-the-forest-server.svg" alt="Docker Hub pulls"></a>
    <a href="https://hub.docker.com/r/rouhim/sons-of-the-forest-server"><img src="https://img.shields.io/docker/image-size/rouhim/sons-of-the-forest-server" alt="Docker Hub size"></a>
    <a href="https://github.com/aquasecurity/trivy"><img src="https://img.shields.io/badge/trivy-protected-blue" alt="trivy"></a>
    <a href="https://hub.docker.com/r/rouhim/sons-of-the-forest-server/tags"><img src="https://img.shields.io/badge/ARCH-amd64-blueviolet" alt="os-arch"></a>
    <a href="https://buymeacoffee.com/rouhim"><img alt="Donate me" src="https://img.shields.io/badge/-buy_me_a%C2%A0coffee-gray?logo=buy-me-a-coffee"></a>
</p>

<p align="center">
    This repository provides a <a href="https://github.com/RouHim/sons-of-the-forest-container-image/actions/workflows/scheduled-security-audit.yaml">safe</a> container image for the <a href="https://sons-of-the-forest.com">Sons of the Forest</a> game server. 
  It is designed to be used with Docker Compose, making it easy to set up and manage your game server environment.
</p>

## Requirements

* [Docker](https://docs.docker.com/engine/install/)
* [Docker Compose](https://docs.docker.com/compose/install/standalone/)
* At least 8GB RAM

## Installation

Once _Docker_ and _Docker Compose_ are installed, clone this repository to your local machine:

```bash
git clone https://github.com/RouHim/sons-of-the-forest-container-image.git
cd sons-of-the-forest-container-image
```

Before starting the server, create the required folder structure, and adjust the permissions:

```bash
mkdir config/ data/ 
chmod 777 config/ data/
```

> The `chmod` command is recommended to avoid permission issues.
> The main reason is, that the user in the container, most likely differs from the user on the host.

## Usage

To start the Sons of the Forest server, navigate to the cloned repository's directory and use Docker Compose:

```bash
docker compose pull
docker compose up -d
```

This will pull the latest image and start the server in detached mode.

When starting the server for the first time:

* The config files and folders will be automatically created in the `config/` folder.
* The server will download the latest version of the game from Steam to the `data/` folder.

> You have to restart after the first start.

To restart the server after making changes to the configuration, use the following command:

```bash
docker compose restart
```

To check the server logs, use the following command:

```bash
docker compose logs -f
```

## Update

To update the server, just restart the container.
The server checks for updates and validates on every boot per default.

> To skip update and validation of the server files on every boot,
> set the `FAST_BOOT` env variable to `true`.

## Configuration

> The server configuration does not differ from the official server configuration.
> Just follow an existing server configuration guide
> like [this](https://steamcommunity.com/sharedfiles/filedetails/?id=2992700419&snr=1_2108_9__2107).

The `config` folder contains the configuration files for the game server:

* The server owners list, in a file called `ownerswhitelist.txt`
* The game server configuration, in a file called `dedicatedserver.cfg`
* The game saves, in a folder called `Saves`
* The game settings, in a file called `SonsGameSettings.cfg`

All files and folders in the `config` will be created automatically when the server is started for the first time.

> `SkipNetworkAccessibilityTest` is always forced to `true`,
> because the test method is not working in a container environment.


The `data/` folder contains the game server data.
Feel free to modify files in this folder,
but be aware that the game server must be restarted for changes to take effect.
The folder can be deleted to reset the game server to its default state.

# Resources

- Inspired by: https://github.com/jammsen/docker-sons-of-the-forest-dedicated-server
- Built from: https://github.com/RouHim/sons-of-the-forest-container-image
- Built to: https://hub.docker.com/r/rouhim/sons-of-the-forest-server
- Based on: https://github.com/RouHim/steamcmd-wine-container-image
- SteamCMD Documentation: https://developer.valvesoftware.com/wiki/SteamCMD
- Dedicated server guide: https://steamcommunity.com/sharedfiles/filedetails/?id=2992700419&snr=1_2108_9__2107

# macOS

Automated workstation setup for macOS

## Install packages

```sh
./packages.sh <home|work>
```

## Symlink Configuration Files

```sh
./stow.sh
```

## Write Defaults

```sh
./defaults.sh
```

## Manual Steps

### GitHub Personal Access Tokens

1. Create a [personal access token](https://github.com/settings/tokens) with full `repo` permissions
1. Write the token to `~/.config/github/token` in order to avoid GitHub API throttling when using Homebrew

When using Git HTTPS Authentication with 2FA, log in using your username and a personal access token instead of your password.

### iTerm Shell Integration

1. iTerm2 > Install Shell Integration
1. Restart shell

### Docker Desktop: Local Squid Proxy

1. Settings > Resources > Proxies > Web Server > <http://docker.for.mac.localhost:3128>

### Other

- Remap modifier keys for Windows keyboard (swap `Option` and `Command`)
- Set up additional Desktops
- Enable Night Shift
- Set default browser

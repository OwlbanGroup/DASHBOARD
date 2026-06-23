# 🔧 Dev Container Troubleshooting Guide

## The Problem

When opening this project in VS Code with Dev Containers, you see an error:

```text
failed to connect to the docker API at npipe:////./pipe/dockerDesktopLinuxEngine; 
check if the path is correct and if the daemon is running
```

**Root Cause:** Docker Desktop is not running on your system.

---

## Solution Options

### Option 1: Start Docker Desktop (Recommended)

1. **Open Docker Desktop**
   - Search for "Docker Desktop" in Start Menu
   - Or double-click the Docker Desktop shortcut

2. **Wait for it to start**
   - Wait for the Docker icon in the system tray to show "Docker is running"
   - This usually takes 10-30 seconds

3. **Retry Dev Container**
   - Press `F1` in VS Code
   - Select "Dev Containers: Reopen in Container"

**Success indicators:**

- Docker icon shows a green/blue indicator
- `docker ps` works in terminal
- Dev Container starts successfully

---

### Option 2: Use Docker Compose Instead (Alternative)

If Docker Desktop won't start, use docker-compose directly:

```bash
# Start development environment
make dev

# Or directly with docker-compose
docker-compose -f docker-compose.dev.yml up

# Access the application
# - Frontend: http://localhost:3000
# - Backend: http://localhost:8000
```

This bypasses Dev Containers but provides the same development experience.

---

### Option 3: Install Docker Engine (Advanced)

If Docker Desktop is not available, install Docker Engine directly:

1. **Download Docker Engine**
   - <https://docs.docker.com/desktop/install/windows-install/>

2. **Install with WSL2 backend** (recommended for Windows)
   - Enable WSL2: `wsl --install`
   - Install Docker Desktop with WSL2 option

3. **Start Docker**
   - Open Docker Desktop
   - Or run: `sudo systemctl start docker` (Linux)

---

## Verification Steps

### Check Docker is Running

```bash
# This should work without errors
docker info

# Should show:
# - Client: Version XX
# - Server: Version XX
```

### Check Docker Contexts

```bash
# List all contexts
docker context ls

# Expected output:
# NAME                TYPE
# default             docker
# desktop-linux *     docker
```

### Test Dev Container Configuration

```bash
# Test without opening Dev Container
docker-compose -f docker-compose.dev.yml config

# This validates your docker-compose files
```

---

## Common Issues

### Issue: "Docker Desktop is not starting"

**Solutions:**

1. Enable virtualization in BIOS
2. Restart computer and try again
3. Reinstall Docker Desktop
4. Use Docker Engine with WSL2 instead

### Issue: "Port already in use"

```bash
# Find what's using the port
netstat -ano | findstr :3000

# Kill the process
taskkill /PID <PID> /F
```

### Issue: "Permission denied"

```bash
# Add user to docker group (Linux)
sudo usermod -aG docker $USER

# Log out and back in
```

### Issue: "Container fails to start"

```bash
# Check logs
docker-compose logs

# Rebuild
docker-compose build --no-cache
docker-compose up
```

---

## Dev Container Configuration

This project's Dev Container configuration:

- **File:** `.devcontainer/devcontainer.json`
- **Uses:** docker-compose.dev.yml
- **Features:** Docker-in-Docker, Git, GitHub CLI

### Key Settings

```json
{
  "name": "Banking Dashboard Development",
  "dockerComposeFile": ["../docker-compose.yml", "../docker-compose.dev.yml"],
  "service": "cloud-platform",
  "workspaceFolder": "/workspace"
}
```

---

## Quick Reference

| Task | Command |
| ------ | --------- |
| Start Docker | Open Docker Desktop app |
| Stop Docker | Right-click Docker icon → Quit |
| Check status | `docker ps` |
| List containers | `docker-compose ps` |
| Start dev env | `make dev` |
| Stop dev env | `make down` |
| View logs | `docker-compose logs` |

---

## Need More Help?

- **Docker Desktop Docs:** <https://docs.docker.com/desktop/>
- **Dev Containers Extension:** <https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers>
- **Docker Compose Docs:** <https://docs.docker.com/compose/>

---

**Status:** Configuration is correct. Just need Docker Desktop running!

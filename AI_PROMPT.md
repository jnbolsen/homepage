# AI prompt
This file provides guidance to an AI model when working with code in this repository.

## Script purpose
This script automates the installation or update of Homepage, a self-hosted startpage/dashboard for your server, by downloading the latest release from GitHub, building it, and setting it up with systemd.

## Variables used
- `APP`: Name of the application, pulled from machine hostname (homepage)
- `LOCAL_IP`: Local IPv4 address of the machine
- `RELEASE`: Latest Github release tag for Homepage
- `VERSION_FILE`: Path to file storing the currently installed version
- `INSTALLED_VERSION`: Current version read from `VERSION_FILE`
- `NEW_INSTALLATION`: Boolean flag indicating if this is a new install

## Directories
- Installation directory: `/opt/homepage`
- Working directory: `/tmp`
- Location of version file: `/opt`

## Script summary
1. Set Initial Variables
   - Define `APP`, `LOCAL_IP`, and fetch latest `RELEASE` from GitHub.
2. Validation Checks
   - Ensure `RELEASE` and `LOCAL_IP` are valid.
   - Check that script runs as root.
   - Confirm `curl` and `npm` are installed.
3. Determine Installation Type
   - If `VERSION_FILE` does not exist → new installation.
   - If `VERSION_FILE` exists but doesn't match `RELEASE` → update.
   - If version matches → exit (no action needed).
4. System Preparation
   - Update system packages.
   - Upgrade `pnpm` (install if missing).
5. Download & Extract Source
   - Download latest release tarball using GitHub API.
   - Extract into `/tmp`.
6. Copy Files to Install Location
   - Move extracted source to `/opt/homepage`.
7. Cleanup
   - Remove temporary files in `/tmp`.
8. New Installation Steps Only
   - Copy skeleton config files from `src/skeleton` to `config/`.
   - Create `.env` file with `HOMEPAGE_ALLOWED_HOSTS` variable.
   - Set up systemd service file.
9. Build & Install Dependencies
   - Run `pnpm install`.
   - Run `pnpm build`.
10. Finalize
    - Write new version to `VERSION_FILE`.
    - Reload systemd daemon.
    - For new installs:
      - Enable and start the service.
    - For updates:
      - Restart the service only.

## Key features implemented
- Idempotent behavior: Won't reinstall if already up-to-date.
- Supports both fresh install and updates.
- Uses pnpm for dependency management.
- Automatically sets up systemd service.
- Handles cleanup and configuration appropriately.

## Notes
- The script assumes curl, npm, and pnpm are available.
- It uses systemd for service management.
- Config files and environment variables are preserved during updates.
- This approach ensures consistent, reproducible deployments of Homepage.
- Create and populate version file with new release version.
- Reload systemd and enable the service only for new installations, otherwise restart the service only.

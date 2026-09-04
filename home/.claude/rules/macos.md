# This machine: macbook (macOS)

- macOS apps: "installed" means release-build, replace `/Applications/<App>.app` (prefer the repo's `scripts/install-macapp.sh`), ad-hoc `codesign --force --deep --sign -` when the project signs that way, then run `--version` out of `/Applications` to confirm.
- Midgar operations vault: `~/.config/midgar/` (chmod 600, never in git) holds `credentials.env`, `signing/` and `OPERATIONS.md`. Read `OPERATIONS.md` before any store, revenue or release work and keep it accurate afterwards. Details in the `app-store` skill.
- While this Mac runs a beta macOS, App Store binaries are built in the `buildvm` stable-macOS guest (`~/Dev/buildvm`), never with local `xcodebuild`; see the `app-store` skill.

# This machine: macbook (macOS)

- macOS apps: "installed" means release-build, replace `/Applications/<App>.app` (prefer the repo's `scripts/install-macapp.sh`), ad-hoc `codesign --force --deep --sign -` when the project signs that way, then run `--version` out of `/Applications` to confirm.
- Midgar operations vault: `~/.config/midgar/` (chmod 600, never in git) holds `credentials.env`, `signing/` and `OPERATIONS.md`. For any store, revenue or release work read `~/Dev/midgar/AGENTS.md` and the relevant runbook in `~/Dev/midgar/ops/runbooks/` first; open `OPERATIONS.md` only for the vault-only facts it still holds (the monorepo runbooks and journal are the source of truth). Details in the `app-store` skill.
- Only while this Mac runs a **major** macOS beta (the summer x.0 seeds), App Store binaries are built in the `buildvm` stable-macOS guest (`~/Dev/buildvm`); on a stable release or a minor/point beta, build and upload locally. See the `app-store` skill.

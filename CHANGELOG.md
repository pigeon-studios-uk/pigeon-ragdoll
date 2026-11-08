# Changelog

All notable changes to Pigeon Ragdoll are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html):

- **Major** versions can need changes to your configuration or other resources. Read the **Upgrade notes**.
- **Minor** versions add features without breaking existing setups.
- **Patch** versions fix bugs only.

## [Unreleased]

First release.

### Highlights

- A key to fall over and lie limp, and get back up
- Toggle, or timed
- A cooldown, and no falling in vehicles or water
- An export to block it while handcuffed
- 23 languages

### Added

- Falling over with one key (U by default, which players can change in GTA's key bindings) or `/ragdoll`, with GTA's own limp ragdoll.
- `Config.Mode`: `'toggle'` (down until the key is pressed again, up to `Config.MaxSeconds`) or `'timed'` (down for `Config.Seconds`).
- A cooldown after getting up, with `Config.CooldownSeconds`.
- No falling over in or getting into vehicles, swimming, falling, climbing, parachuting or dead.
- `IsDown` and `SetBlocked` client exports.
- Messages in 23 languages, following ox_lib's language with `Config.Locale = 'auto'`.
- Update checker from the Pigeon Studios version registry.

[Unreleased]: https://github.com/pigeon-studios-uk/pigeon-ragdoll/commits/main

# Arvital Audio Homebrew tap (retired)

[AudioRoute](https://audio-route.com) is now in Homebrew's main cask repository, so this tap is no longer needed:

```sh
brew install --cask audioroute
```

If you installed AudioRoute from this tap, Homebrew moves it to the main repository automatically the next time you run `brew update` (see `tap_migrations.json`). You can then remove the tap:

```sh
brew untap arvital-audio/audioroute
```

Support: support@audio-route.com

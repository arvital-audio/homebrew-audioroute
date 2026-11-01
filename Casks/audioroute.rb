cask "audioroute" do
  version "1.2.10"
  sha256 "96bcb908e04db6463a0996e5235ceebf286e5c84c49aa6586cdc4e6bbc77992e"

  url "https://pub-ee5d9eb8d65945d1ba1716bc9ca61b0e.r2.dev/AudioRoute-#{version}-signed.pkg"
  name "AudioRoute"
  desc "Captures system and per-app audio into any DAW, or straight to a file"
  homepage "https://audio-route.com/"

  livecheck do
    url "https://audio-route.com/appcast.xml"
    strategy :sparkle
  end

  auto_updates true
  # The PKG itself enforces 14.2 via <allowed-os-versions>; a cask can only
  # express the major version, so this is the closest expressible floor.
  depends_on macos: :sonoma

  pkg "AudioRoute-#{version}-signed.pkg"

  uninstall launchctl: [
              "com.audioroute.app",
              "com.audioroute.daemon",
            ],
            quit:      "com.audioroute.app",
            script:    {
              executable:   "/usr/local/bin/audioroute-uninstall.sh",
              sudo:         true,
              must_succeed: false,
            },
            pkgutil:   [
              "com.audioroute.app",
              "com.audioroute.daemon",
              "com.audioroute.driver",
              "com.audioroute.launchd.app",
              "com.audioroute.launchd.daemon",
              "com.audioroute.plugin.aax",
              "com.audioroute.plugin.au",
              "com.audioroute.plugin.vst3",
              "com.audioroute.uninstall",
            ],
            delete:    [
              "/Library/Audio/Plug-Ins/HAL/AudioRouteDriver.driver",
              "/Library/AudioRoute",
              "/usr/local/bin/audioroute-uninstall.sh",
              "/usr/local/bin/AudioRouteDaemon",
            ]

  # Recordings in ~/Music/AudioRoute are the user's own work and are left alone
  # by the uninstaller on purpose. They are not zapped either.
  zap trash: [
    "~/Library/Application Support/AudioRoute",
    "~/Library/Caches/com.audioroute.app",
    "~/Library/Preferences/com.audioroute.app.plist",
    "~/Library/Saved Application State/com.audioroute.app.savedState",
  ]
end

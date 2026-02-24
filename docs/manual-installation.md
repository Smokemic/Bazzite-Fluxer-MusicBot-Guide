# Manual Installation Guide 📝

This guide walks you through installing the Fluxer MusicBot step by step – perfect if you want to understand every detail or if the automated script doesn't work for you.

## 📋 Prerequisites

Same as in the main README:
- Bazzite OS (or Fedora Atomic derivative)
- Fluxer account and server
- Bot token (from Fluxer/Discord developer portal)
- About 2-3 hours patience
- Google Account (Youtube API v3)
- Spotify Premium Account für Bot erstellung

- 
## 🔧 Step 1: Install System Packages

Bazzite needs a few packages that aren't included by default:

```bash
# Install Python 3.11
rpm-ostree install python3.11

# Install Java 21 (for Lavalink audio)
rpm-ostree install java-21-openjdk-headless

# Install PulseAudio libraries (required for audio)
rpm-ostree install pulseaudio-libs
```

**Important:** After any `rpm-ostree` command, you must reboot:
```bash
systemctl reboot
```

After reboot, verify installations:
```bash
python3.11 --version
java --version
```

## 🐍 Step 2: Create Python Virtual Environment

```bash
# Create the virtual environment in your home directory
python3.11 -m venv ~/redenv

# Activate it
source ~/redenv/bin/activate
```

You'll need to activate this environment every time you run pip commands.

## 📦 Step 3: Install Red-DiscordBot (Fluxer Fork)

With the virtual environment activated:

```bash
# Upgrade pip and install wheel
pip install --upgrade pip wheel

# Install the Fluxer fork of Red
pip install https://github.com/Red-Fluxer-Patches/Red-DiscordBot/archive/fluxer.tar.gz
```

## ⚙️ Step 4: Create Your Bot Instance

```bash
# Run the setup tool
redbot-setup
```

You'll be prompted for:
- **Instance name:** Choose something memorable (e.g., `fluxmusicbot`)
- **Data path:** Press Enter to accept default (`~/.local/share/Red-DiscordBot/data/`)
- **Storage backend:** Press Enter for JSON (simplest)

## 🚀 Step 5: First Bot Start

```bash
# Start your bot (replace with your instance name)
redbot fluxmusicbot
```

On first start, you'll be asked for:
- **Bot token:** Paste your token from Fluxer/Discord developer portal
- **Prefix:** Choose your command prefix (e.g., `!`)

After entering these, the bot will show an **invite URL**. Copy it, open in browser, and invite the bot to your Fluxer server.

Press `Ctrl+C` to stop the bot for now.

## 🔄 Step 6: Set Up Auto-Restart Service

Create a systemd user service so the bot starts automatically:

```bash
# Create the service file
nano ~/.config/systemd/user/redbot.service
```

Paste this content (replace `fluxmusicbot` with your actual instance name):

```ini
[Unit]
Description=Red Discord Bot (Fluxer)
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
Environment=RED_DPY_DEBUG=1
ExecStart=%h/redenv/bin/python -O -m redbot fluxmusicbot --no-prompt
WorkingDirectory=%h/.local/share/redbot
Restart=on-failure
RestartSec=10

[Install]
WantedBy=default.target
```

Save (`Ctrl+O`, Enter) and exit (`Ctrl+X`).

Now enable and start the service:

```bash
systemctl --user daemon-reload
systemctl --user enable --now redbot.service
```

Check if it's running:

```bash
systemctl --user status redbot.service
```

## 🎵 Step 7: Load Audio Cog and Configure APIs

With the bot running, go to any Discord channel and type:

```
!load audio
```

Then follow the **API Key Guide** (`docs/api-keys.md`) to set up:
- Spotify API keys (for playlist support)
- YouTube API key (for actual music playback)

## ✅ Step 8: Test It!

Join a voice channel and try:

```
!play Never Gonna Give You Up
```

Or a Spotify playlist:

```
!play https://open.spotify.com/playlist/37i9dQZF1DXcBWIGoYBM5M
```

## 🆘 Troubleshooting

If something doesn't work:
- Check the bot logs: `journalctl --user -u redbot.service -f`
- See `docs/troubleshooting.md` for common issues
- Open a [GitHub Issue](https://github.com/Smokemic/Bazzite-Fluxer-MusicBot-Guide/issues)

## 🎉 You're Done!

Your Fluxer MusicBot is now manually installed and running. Enjoy the music! 🎶

# Bazzite Fluxer MusicBot Guide 🎵

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/Smokemic/Bazzite-Fluxer-MusicBot-Guide)](https://github.com/Smokemic/Bazzite-Fluxer-MusicBot-Guide/stargazers)

A comprehensive guide to installing and running **Red-DiscordBot (Fluxer fork)** on **Bazzite OS** (Fedora Atomic/immutable). 
This repository contains automated installation scripts, configuration files, and detailed documentation to help you set up your own music bot for Fluxer.
And yes – this is "vibe coded" by a newbie, for newbies. 
With the end of Windows 10 support, many people have switched to Bazzite 
or other Linux distributions. Add to that Discord's controversial ID changes, 
and suddenly a lot of users are searching for alternatives – like Fluxer.

This guide is exactly what I wished I had when I started. 
It covers all the struggles I ran into, so you don't have to.

## ✨ Features

- ✅ **Automated installation** – One script does most of the work
- ✅ **Bazzite-optimized** – Works with rpm-ostree and immutable systems
- ✅ **Auto-restart service** – Bot starts automatically with your system
- ✅ **Spotify & YouTube integration** – Play music from both platforms
- ✅ **Detailed troubleshooting** – Solutions for common problems
- ✅ **Noob-friendly** – Clear instructions, no Linux expertise required

## 📋 Prerequisites

- A system running **Bazzite OS** (or other Fedora Atomic derivatives)
- A **Fluxer account** and server where you can invite the bot
- A **Discord/Fluxer bot token** (see [Creating a bot account](https://docs.discord.red/en/stable/bot_application_guide.html))
- **Spotify Developer** account (for Spotify playback)
- **Google Cloud** account (for YouTube playback)
- About **2-3 hours** of time and patience


## 🚀 Quick Start

### Option 1: Automated Installation (Recommended)

Run the installation script with a single command:

```bash
curl -sSL https://raw.githubusercontent.com/Smokemic/Bazzite-Fluxer-MusicBot-Guide/main/installer/install.sh | bash
```

The script will:
1. Check and install required packages (Python 3.11, Java 21, pulseaudio-libs)
2. Create a Python virtual environment
3. Install the Fluxer fork of Red-DiscordBot
4. Set up an auto-restart systemd service
5. Guide you through the remaining manual steps

### Option 2: Manual Installation

If you prefer to install step by step, follow the detailed guide in [docs/manual-installation.md](docs/manual-installation.md).



## 📖 Post-Installation Setup

After running the installer, you need to complete these steps:

### 1. Create a Bot Instance

```bash
# Activate the virtual environment
source ~/redenv/bin/activate

# Run the setup tool
redbot-setup
```

Follow the prompts to create your bot instance (e.g., name it `fluxmusicbot`).

### 2. Start the Bot and Get Invite Link

```bash
redbot your-instance-name
```

Copy the invite URL shown in the console, paste it in your browser, and invite the bot to your Fluxer server.

### 3. Load the Audio Cog

In any Discord channel where the bot is present, type:

```
!load audio
```

### 4. Configure API Keys

#### Spotify API

1. Go to [Spotify Developer Dashboard](https://developer.spotify.com/dashboard)
2. Create a new application
3. Copy **Client ID** and **Client Secret**
4. In Discord, run:

```
!set api spotify client_id YOUR_CLIENT_ID client_secret YOUR_CLIENT_SECRET
```

#### YouTube API

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project
3. Enable **YouTube Data API v3**
4. Create an **API Key** (choose "Public Data" – no OAuth needed!)
5. In Discord, run:

```
!set api youtube api_key YOUR_YOUTUBE_API_KEY
```

### 5. Set up Auto-Restart Service

The installer already created a service file for you, but you need to adjust it with your instance name:

```bash
# Edit the service file
nano ~/.config/systemd/user/redbot.service
```

Find the line that starts with `ExecStart=` and replace `your-instance-name` with your actual instance name (e.g., `FluxMusicBot`).

The file should look like this after editing:
```ini
[Unit]
Description=Red Discord Bot (Fluxer)
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
Environment=RED_DPY_DEBUG=1
ExecStart=%h/redenv/bin/python -O -m redbot FluxMusicBot --no-prompt
WorkingDirectory=%h/.local/share/redbot
Restart=on-failure
RestartSec=10

[Install]
WantedBy=default.target
```

After saving, reload and enable the service:
```bash
systemctl --user daemon-reload
systemctl --user enable --now redbot.service
```

Check if it's running:
```bash
systemctl --user status redbot.service
```


## 🎮 Basic Commands

Once everything is set up, you can start playing music:

| Command | Description |
|---------|-------------|
| `!play <song name or URL>` | Play a song from YouTube, Spotify, or direct link |
| `!pause` | Pause current playback |
| `!resume` | Resume paused playback |
| `!skip` | Skip to next song in queue |
| `!queue` | Show current song queue |
| `!volume <0-150>` | Adjust volume |
| `!stop` | Stop playback and clear queue |
| `!disconnect` | Disconnect bot from voice channel |

## 🔧 Troubleshooting

### Common Issues and Solutions

| Problem | Solution |
|---------|----------|
| `502 Bad Gateway` errors | Fluxer is experiencing downtime – wait and try again later |
| `libpulse.so.0 not found` | Install pulseaudio-libs: `rpm-ostree install pulseaudio-libs && reboot` |
| Bot doesn't join voice channel | Check bot permissions (need "Connect" and "Speak") |
| Spotify URLs don't work | Verify Spotify API keys with `!set api spotify` |
| YouTube playback fails | Check YouTube API key and quota limits |

For more detailed troubleshooting, see [docs/troubleshooting.md](docs/troubleshooting.md).

## 📁 Repository Structure

```
bazzite-fluxer-musicbot-guide/
├── installer/
│   └── install.sh          # Main installation script
├── config/
│   └── redbot.service      # Systemd service file
├── docs/
│   ├── manual-installation.md  # Step-by-step manual guide
│   ├── troubleshooting.md      # Common issues and solutions
│   ├── api-keys.md            # Detailed API setup with screenshots
│   └── faq.md                  # Frequently asked questions
├── README.md                # This file
└── LICENSE                  # MIT License
```

## 🤝 Contributing

Contributions are welcome! If you have improvements, bug fixes, or additional documentation:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-improvement`)
3. Commit your changes (`git commit -m 'Add amazing improvement'`)
4. Push to the branch (`git push origin feature/amazing-improvement`)
5. Open a Pull Request

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## 📜 License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- The **Red-DiscordBot** team for the amazing bot framework
- **Fluxer** for creating a Discord-compatible platform
- **TrustyJAID** for the excellent cogs
- **DeepSeek** for AI assistance throughout this guide
- **Everyone in the Fluxer community** for testing and feedback

## 📬 Contact & Support

- **GitHub Issues**: For bug reports and feature requests
- **Fluxer Community**: Join the conversation on Fluxer (channel: #bot-development)
- **My Fluxer**: (link is incoming sadly Fluxer gets DDOS´d)

---

**Made with ❤️ for the Bazzite and Fluxer communities**  
*From a noob who figured it out, to all noobs who will follow* 🚀





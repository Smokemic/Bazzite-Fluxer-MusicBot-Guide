# Bazzite Fluxer MusicBot Guide 🎵

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/Smokemic/Bazzite-Fluxer-MusicBot-Guide)](https://github.com/Smokemic/Bazzite-Fluxer-MusicBot-Guide/stargazers)

A comprehensive guide to installing and running **Red-DiscordBot (Fluxer fork)** on **Bazzite OS** (Fedora Atomic/immutable). 
This repository contains automated installation scripts, configuration files, and detailed documentation to help you set up your own music bot for Fluxer.

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

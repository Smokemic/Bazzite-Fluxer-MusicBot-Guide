# Frequently Asked Questions ❓

## General Questions

### What is this project?
A guide and installer for running Red-DiscordBot (Fluxer fork) on Bazzite OS, an immutable Fedora Atomic system.

### Do I need to be a Linux expert?
No! This guide is written for beginners. If you can copy-paste commands, you can do this.

### Is this only for Bazzite?
It's optimized for Bazzite but should work on any Fedora Atomic system (like Fedora Silverblue, Kinoite, etc.) with minor adjustments.

## Bot Setup Questions

### Do I need both Spotify AND YouTube API keys?
**Yes!** The Audio cog uses:
- Spotify API: To get playlist information (song titles, artists)
- YouTube API: To actually play the music (by finding videos of those songs)

### Why can't I just use Spotify directly?
The Audio cog plays music in Discord voice channels for everyone to hear. Spotify's API doesn't allow direct streaming to Discord – so the bot finds each song on YouTube and plays it there instead.

### Can I use this without Spotify?
Absolutely! You can play:
- YouTube links directly: `!play https://youtube.com/...`
- Search for songs: `!play never gonna give you up`
- SoundCloud, Bandcamp, and many other sources

### What's the difference between the Spotify cog and the Audio cog?

| Feature | Audio Cog | Spotify Cog |
|---------|-----------|-------------|
| Plays in Discord voice channel | ✅ Yes | ❌ No (plays on YOUR device) |
| Everyone in channel can hear | ✅ Yes | ❌ No (only you) |
| Requires Spotify Premium | ❌ No | ✅ Yes |
| Requires YouTube API | ✅ Yes | ❌ No |

## Technical Questions

### Why do I need to reboot after installing packages?
Bazzite is immutable – packages installed with `rpm-ostree` create a new "deployment" that only becomes active after reboot.

### My bot works but I see "502 Bad Gateway" errors – what's wrong?
**Nothing!** That means Fluxer's servers are temporarily down (often due to DDoS attacks). Your bot will automatically reconnect when Fluxer is back online.

### Can I run multiple bot instances?
Yes! Each instance needs a different name during `redbot-setup` and its own systemd service file.

### How do I update the bot?
```bash
source ~/redenv/bin/activate
pip install -U https://github.com/Red-Fluxer-Patches/Red-DiscordBot/archive/fluxer.tar.gz
systemctl --user restart redbot.service
```

## Permission Questions

### The bot won't join my voice channel!
Check:
- Are you in a voice channel yourself?
- Does the bot have "Connect" and "Speak" permissions?
- Try re-inviting with the correct permissions using the invite URL

### How do I get my Discord/Fluxer user ID?
Enable Developer Mode in Discord/Fluxer settings, right-click on your name → "Copy ID"

### How do I set the bot owner?
```bash
redbot --edit your-instance-name
```
Then choose the option to set owner and paste your user ID.

## Community Questions

### Can I contribute to this guide?
Yes please! Open a Pull Request or suggest improvements via GitHub Issues.

### Where can I get help?
- Open a [GitHub Issue](https://github.com/Smokemic/Bazzite-Fluxer-MusicBot-Guide/issues)
- Ask in Fluxer channels (#bot-development)
- Check the troubleshooting guide first!

### Will this work on other immutable systems?
It should work on any Fedora Atomic system (Silverblue, Kinoite, etc.) with minor adjustments.

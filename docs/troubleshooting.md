# Troubleshooting Guide 🔧

This guide covers common issues you might encounter when setting up or running your Fluxer MusicBot on Bazzite.

## 🚨 Installation Issues

### Python 3.11 not found

**Error:**
```
bash: python3.11: command not found
```

**Solution:**
```bash
rpm-ostree install python3.11
systemctl reboot
```

After reboot, verify with `python3.11 --version`.

### Java installation fails

**Error:**
```
error: Packages not found: java-17-openjdk-headless
```

**Solution:**
Bazzite uses Java 21 by default:
```bash
rpm-ostree install java-21-openjdk-headless
systemctl reboot
```

### "Packages not found" during rpm-ostree install

**Error:**
```
error: "package" is already provided by: package-version. Use --allow-inactive to explicitly require it.
```

**Solution:**
The package is already installed! Check with:
```bash
rpm -q package-name
```

If confirmed installed, proceed with the next step.

## 🎵 Audio/Music Issues

### libpulse.so.0 not found

**Error in Lavalink logs:**
```
java.lang.UnsatisfiedLinkError: ... libpulse.so.0: cannot open shared object file
```

**Solution:**
```bash
rpm-ostree install pulseaudio-libs
systemctl reboot
```

### Bot doesn't join voice channel

**Error when using !play:**
```
Unable To Play Tracks - Connect to a voice channel first.
I don't have permission to connect and speak in your channel.
```

**Solutions:**
- Make sure you are in a voice channel yourself
- Re-invite the bot with correct permissions (get invite URL from `redbot your-instance-name`)
- Check bot role permissions in server settings

### Audio cog won't load

**Error:**
```
Command "load" not found
```

**Solution:**
```bash
!load downloader
!cog install audio
!load audio
```

## 🔑 API Key Issues

### Spotify URLs don't work

**Error:**
```
Invalid Environment - The owner needs to set the YouTube API key before Spotify URLs or codes can be used.
```

**Solution:**
The Audio cog needs BOTH Spotify AND YouTube API keys:
```
!set api spotify client_id YOUR_CLIENT_ID client_secret YOUR_CLIENT_SECRET
!set api youtube api_key YOUR_YOUTUBE_API_KEY
```

### "This URL is not secure" on Spotify Developer Dashboard

**Problem:** Spotify rejects `localhost` redirect URIs.

**Solution:** Use `127.0.0.1` instead:
```
http://127.0.0.1:8888/callback
```

### YouTube API key creation stuck on OAuth

**Problem:** Google keeps pushing you to create OAuth credentials.

**Solution:**
- Go directly to **"APIs & Services" → "Credentials"**
- Click **"+ Create Credentials"** → **"API Key"**
- Ignore the OAuth consent screen – you don't need it!
- Restrict the key to **YouTube Data API v3** only

## 🔄 Bot Runtime Issues

### Bot crashes with "AttributeError: 'NoneType' object has no attribute 'id'"

**Error on first start:**
```
AttributeError: 'NoneType' object has no attribute 'id'
```

**Solution:** Set the bot owner:
```bash
redbot --edit your-instance-name
```

Choose option to set owner and enter your Discord user ID.

### Auto-restart service fails

**Error:**
```
● redbot.service - Red Discord Bot (Fluxer)
   Active: failed
```

**Check logs:**
```bash
journalctl --user -u redbot.service -e
```

**Common fixes:**
- Verify the path in service file: `~/.config/systemd/user/redbot.service`
- Make sure the Python path is correct: `/home/yourusername/redenv/bin/python`
- Reload and restart:
```bash
systemctl --user daemon-reload
systemctl --user restart redbot.service
```

### 502 Bad Gateway errors

**Error in logs:**
```
aiohttp.client_exceptions.WSServerHandshakeError: 502, message='Invalid response status', url=URL('wss://gateway.fluxer.app/...')
```

**Explanation:** This is **NOT** your bot's fault! Fluxer is experiencing downtime (often due to DDoS attacks).

**What to do:**
- Wait 10-15 minutes and try again
- Check Fluxer status channels for announcements
- Your bot will automatically reconnect when Fluxer is back online

## 📊 Checking Bot Status

### Is my bot running?
```bash
systemctl --user status redbot.service
```

### View live logs
```bash
journalctl --user -u redbot.service -f
```

### Restart the bot
```bash
systemctl --user restart redbot.service
```

## ❓ Still having issues?

If your problem isn't listed here:
- Check the logs: `journalctl --user -u redbot.service -e`
- Search existing [GitHub Issues](https://github.com/Smokemic/Bazzite-Fluxer-MusicBot-Guide/issues)
- Open a new issue with the exact error message, what you were trying to do, and your system info: `cat /etc/os-release`

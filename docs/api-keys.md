# API Key Setup Guide 🔑

This guide walks you through obtaining the necessary API keys for Spotify and YouTube integration.

## 🎵 Spotify API Keys

> **🔴 Important (February 2026 Update)**  
> Spotify has changed its API rules [citation:1]:  
> - You **must have an active Spotify Premium subscription** to create and use API keys  
> - Each developer can only have **one** Development Mode Client ID  
> - Each app is limited to **5 authorized users** (for testing)  
> - If your app grows beyond 5 users, you need to apply for Extended Quota Mode [citation:2]  
>   
> **For this bot:** Only YOU (the person setting it up) need Premium. Your listeners don't need Premium accounts.

### Step 1: Create a Spotify Developer Application
...


## 🎵 Spotify API Keys

### Step 1: Create a Spotify Developer Application

Go to [Spotify Developer Dashboard](https://developer.spotify.com/dashboard)
Log in with your Spotify account (free account works)
Click **"Create App"**

### Step 2: Fill in Application Details

- **App name:** Your bot name (e.g., "FluxMusicBot")
- **App description:** Brief description (e.g., "Music bot for Fluxer")
- **Website:** Leave empty
- **Redirect URI:** `http://127.0.0.1:8888/callback` (click "Add")

**Important:** Use `127.0.0.1` not `localhost` – Spotify rejects `localhost` for security reasons.

### Step 3: API Selection

Check the following box:
- ✅ **Web API**

Do NOT check:
- ❌ Web Playback SDK
- ❌ iOS/Android SDKs

### Step 4: Accept Terms and Create

Check the agreement box
Click **"Create"**

### Step 5: Get Your Credentials

After creation, you'll see:
- **Client ID** – Copy this immediately
- **Client Secret** – Click **"View Client Secret"** and copy it

### Step 6: Add to Your Bot

In Discord, run:
```
!set api spotify client_id YOUR_CLIENT_ID client_secret YOUR_CLIENT_SECRET
```

## ▶️ YouTube API Key

### Step 1: Create a Google Cloud Project

Go to [Google Cloud Console](https://console.cloud.google.com/)
Click the project dropdown (top-left)
Click **"New Project"**
Name it (e.g., "FluxMusicBot")
Click **"Create"**

### Step 2: Enable YouTube Data API

With your new project selected, go to **"APIs & Services" → "Library"**
Search for **"YouTube Data API v3"**
Click on it and press **"Enable"**

### Step 3: Create API Key (Important!)

**DO NOT** get distracted by OAuth consent screens! You need a simple API key:

Go to **"APIs & Services" → "Credentials"**
Click **"+ Create Credentials"** (top of page)
Select **"API Key"** from the dropdown

**⚠️ Important:** If you see an OAuth consent screen warning, ignore it! You don't need OAuth for this.

### Step 4: Copy Your Key

A popup will show your new API key – it looks like:
```
AIzaSyB6X23aT5qZqL3x7mP1rS8tU9vW0cR2fG4
```

**Copy it immediately!** You won't see it again.

### Step 5: Restrict the Key (Recommended)

In the credentials list, click on your new key
Under **"API restrictions"**, select **"Restrict key"**
Choose **"YouTube Data API v3"** from the dropdown
Click **"Save"**

### Step 6: Add to Your Bot

In Discord, run:
```
!set api youtube api_key YOUR_YOUTUBE_API_KEY
```

## ✅ Verification

Test that both APIs are working:
```
!play https://open.spotify.com/playlist/37i9dQZF1DXcBWIGoYBM5M
```

If music plays, both keys are configured correctly!

## 🔒 Security Notes

- **Never share your API keys** – treat them like passwords
- **Use API restrictions** to limit what each key can do
- If a key is compromised, **revoke it immediately** and create a new one

## ❓ Troubleshooting

| Problem | Solution |
|---------|----------|
| Spotify says "URL not secure" | Use `127.0.0.1` instead of `localhost` |
| YouTube key doesn't work | Make sure YouTube Data API v3 is enabled |
| Keys work but no music | Both Spotify AND YouTube keys are required together |
| Quota exceeded | YouTube has daily limits – wait 24 hours |

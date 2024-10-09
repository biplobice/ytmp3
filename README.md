# ytmp3

`ytmp3` is a simple Bash script that allows you to download audio or video from YouTube, with options to specify the format, quality, and whether to split the audio by chapters. It can also embed the thumbnail directly into MP4 files.

## Usage

```bash
ytmp3 <Video_ID/Video_URL> [mp3|mp4] [bitrate/resolution] [split-chapters (yes|no)]
```

### Parameters:

- `<Video_ID/Video_URL>`: The URL or ID of the YouTube video/playlist.
- `[mp3|mp4]`: The output format. Specify `mp3` for audio or `mp4` for video.
- `[bitrate/resolution]`: 
  - For `mp3`: Audio bitrate (e.g., `128`, `192`).
  - For `mp4`: Resolution (e.g., `720`, `1080`).
- `[split-chapters]`: Set `yes` to split audio by chapters, `no` to disable (default is `no`).

### Examples:

```bash
ytmp3 https://www.youtube.com/watch?v=VIDEO_ID mp3 128 yes
ytmp3 https://www.youtube.com/watch?v=VIDEO_ID mp4 720 yes
ytmp3 https://www.youtube.com/playlist?list=PLAYLIST_ID mp3 192 no
```

## Features

- Download audio in MP3 format with specified bitrate.
- Download video in MP4 format with specified resolution.
- Option to split audio by chapters for MP3 format.
- Embed the video thumbnail directly into the MP4 file.

## Requirements

- [yt-dlp](https://github.com/yt-dlp/yt-dlp): Ensure you have `yt-dlp` installed.

## Installation

1. Download the `ytmp3.sh` script.
2. Make it executable:

   ```bash
   chmod +x ytmp3.sh
   ```

3. Optionally, move it to a directory in your PATH for global access:

   ```bash
   mv ytmp3.sh /usr/local/bin/ytmp3
   ```

## License

This project is licensed under the MIT License.

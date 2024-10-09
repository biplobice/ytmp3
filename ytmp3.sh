#!/bin/bash

# Help function to display usage information
show_help() {
    echo "Usage: ytmp3 <Video_ID/Video_URL> [mp3|mp4] [bitrate/resolution] [split-chapters (yes|no)]"
    echo ""
    echo "Parameters:"
    echo "  <Video_ID/Video_URL>   The URL or ID of the YouTube video/playlist."
    echo "  [mp3|mp4]              The output format. 'mp3' for audio, 'mp4' for video."
    echo "  [bitrate/resolution]   The audio bitrate for mp3 format (e.g., 128, 192) or resolution for mp4 (e.g., 720, 1080)."
    echo "  [split-chapters]       Set 'yes' to split by chapters, 'no' to disable (default is 'no')."
    echo ""
    echo "Examples:"
    echo "  ytmp3 https://www.youtube.com/watch?v=VIDEO_ID mp3 128 yes"
    echo "  ytmp3 https://www.youtube.com/watch?v=VIDEO_ID mp4 720 yes"
    echo "  ytmp3 https://www.youtube.com/playlist?list=PLAYLIST_ID mp3 192 no"
    exit 0
}

# Check if help is requested
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
fi

# Validate input arguments
if [[ -z "$1" ]]; then
    echo "Error: Video URL is required."
    show_help
fi

# Variables
VIDEO_URL="$1"
FORMAT="${2:-mp3}"
SPLIT_CHAPTERS="${4:-no}"

# Set default quality based on the format
if [[ "$FORMAT" == "mp3" ]]; then
    QUALITY="${3:-128}"
elif [[ "$FORMAT" == "mp4" ]]; then
    QUALITY="${3:-best}"
else
    echo "Invalid format. Please specify either mp3 or mp4."
    exit 1
fi

# Handle split-chapters option
SPLIT_CHAPTERS_FLAG=""
if [[ "$SPLIT_CHAPTERS" == "yes" ]]; then
    SPLIT_CHAPTERS_FLAG="--split-chapters"
fi

# Handle mp3 format with thumbnail artwork embedding
if [[ "$FORMAT" == "mp3" ]]; then
    echo "Downloading audio in mp3 format with bitrate $QUALITY..."
    
    if [[ "$SPLIT_CHAPTERS" == "yes" ]]; then
        # Download and split by chapters
        yt-dlp --extract-audio --audio-format mp3 --audio-quality "${QUALITY}k" --add-metadata --embed-thumbnail $SPLIT_CHAPTERS_FLAG -o "%(chapter_number)s-%(title)s.%(ext)s" "$VIDEO_URL"
    else
        # Regular download without splitting
        yt-dlp --extract-audio --audio-format mp3 --audio-quality "${QUALITY}k" --add-metadata --embed-thumbnail -o "%(title)s.%(ext)s" "$VIDEO_URL"
    fi
elif [[ "$FORMAT" == "mp4" ]]; then
    echo "Downloading video in mp4 format with resolution $QUALITY..."
    
    # Use best available format if no resolution is specified
    yt-dlp --format "bestvideo[height<=$QUALITY]+bestaudio/best" --merge-output-format mp4 $SPLIT_CHAPTERS_FLAG -o "%(title)s.%(ext)s" "$VIDEO_URL"
else
    echo "Invalid format. Please specify either mp3 or mp4."
    exit 1
fi

# Check if the command succeeded
if [[ $? -eq 0 ]]; then
    echo "Download complete! Files are saved in the current directory."
else
    echo "Failed to download or process the video/playlist."
    exit 1
fi
#!/bin/bash

# Function to allow direct editing of the metadata
prompt_with_default() {
    local prompt="$1"
    local default="$2"
    read -e -p "$prompt" -i "$default" input
    echo "${input:-$default}"
}

# Function to download and convert to M4A, then set metadata
download_and_convert_to_m4a() {
    local youtube_link="$1"
    local is_playlist="$2"
    local audio_quality="$3"
    local output_dir="out"

    # Create output directory if not exists
    mkdir -p "$output_dir"

    # Get metadata using yt-dlp without downloading the file
    metadata=$(yt-dlp --get-title --get-duration --get-description "$youtube_link")
    title=$(echo "$metadata" | sed -n '1p')
    duration=$(echo "$metadata" | sed -n '2p')
    description=$(echo "$metadata" | sed -n '3p')

    # Display and allow direct editing of the title
    echo "Extracted Metadata:"
    title=$(prompt_with_default "Title: " "$title")

    # Ask user to enter optional metadata
    artist=$(prompt_with_default "Enter Artist name (optional): " "")
    album=$(prompt_with_default "Enter Album name (optional): " "")
    genre=$(prompt_with_default "Enter Genre (optional): " "")

    # Base yt-dlp command for extracting M4A
    cmd=("yt-dlp" "-x" "--audio-format" "m4a" "--audio-quality" "$audio_quality" "--add-metadata")

    # Check if it's a playlist
    if [ "$is_playlist" == "yes" ]; then
        read -rp "Enter the playlist name: " playlist_name
        playlist_name=$(sanitize_directory_name "$playlist_name")
        playlist_dir="${output_dir}/${playlist_name}"
        mkdir -p "$playlist_dir"
        cmd+=("-o" "${playlist_dir}/%(playlist_index)s - %(title)s.%(ext)s" "--yes-playlist")
    else
        cmd+=("-o" "${output_dir}/%(title)s.%(ext)s")
    fi

    # Add the YouTube link to the command
    cmd+=("$youtube_link")

    # Execute the command to download and convert
    "${cmd[@]}"

    # Check if the command was successful
    if [ $? -eq 0 ]; then
        echo "Download and conversion complete!"
        # Apply custom metadata using ffmpeg or AtomicParsley
        local output_file="${output_dir}/${title}.m4a"
        echo "Setting metadata..."
        ffmpeg -i "$output_file" -metadata artist="$artist" -metadata album="$album" -metadata genre="$genre" -metadata title="$title" -y "${output_dir}/final_${title}.m4a"
    else
        echo "Download and conversion failed!"
    fi
}

# Main logic
read -rp "Enter the YouTube link or playlist link: " youtube_link

# Check if the link contains "playlist"
if [[ "$youtube_link" == *"playlist"* ]]; then
    is_playlist="yes"
else
    is_playlist="no"
fi

# Get audio quality from the user (0 - best, 9 - worst)
read -rp "Enter audio quality (0 - best, 9 - worst): " audio_quality
audio_quality="${audio_quality:-0}"

# Start the download and conversion process
download_and_convert_to_m4a "$youtube_link" "$is_playlist" "$audio_quality"

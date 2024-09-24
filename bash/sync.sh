#!/bin/bash

# Source and destination directories
SOURCE_DIR="$1"
DEST_DIR="$2"

# Log file to record sync operations
LOG_FILE="sync_log.txt"

# Check if both source and destination directories are provided
if [[ -z "$SOURCE_DIR" || -z "$DEST_DIR" ]]; then
  echo "Usage: $0 [source directory] [destination directory]"
  exit 1
fi

# Check if source directory exists
if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Source directory does not exist: $SOURCE_DIR"
  exit 1
fi

# Check if destination directory exists; if not, create it
if [[ ! -d "$DEST_DIR" ]]; then
  echo "Destination directory does not exist. Creating: $DEST_DIR"
  mkdir -p "$DEST_DIR"
fi

# Perform the file synchronization using rsync
rsync -avh --delete "$SOURCE_DIR/" "$DEST_DIR/" | tee -a "$LOG_FILE"

# Explanation of rsync flags:
# -a: Archive mode, which preserves file permissions, ownership, and timestamps
# -v: Verbose mode, to show what's being synced
# -h: Human-readable file sizes in output
# --delete: Delete files in the destination that no longer exist in the source

# Log the time of synchronization
echo "Sync completed at: $(date)" >> "$LOG_FILE"

# Print success message
echo "Synchronization completed between $SOURCE_DIR and $DEST_DIR."

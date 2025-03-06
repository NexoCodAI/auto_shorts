#!/bin/bash
set -e

# ----------------------------
# Set locale to UTF-8
# ----------------------------
export PYTHONIOENCODING="utf-8"
export LC_ALL="C.UTF-8"
export LANG="C.UTF-8"

# ----------------------------
# Update apt and install OS dependencies
# ----------------------------
# Note: 'sudo' is used here assuming you have the required privileges.
sudo apt-get update -qq
sudo apt-get -qq -y install espeak-ng > /dev/null 2>&1

# ----------------------------
# Upgrade pip to ensure the latest version is used
# ----------------------------
python -m pip install --upgrade pip

# ----------------------------
# Install required Python packages
# ----------------------------
pip install "kokoro>=0.8.2" soundfile yt-dlp requests numpy opencv-python pillow tqdm moviepy google-generativeai

echo "Setup completed successfully."

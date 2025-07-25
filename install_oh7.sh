#!/bin/bash

# OH7 Self-Installer Script for Xubuntu USB Boot
# Includes LM Studio, Ollama, Coqui TTS, and sarcastic voiceover by OH7.

set -e

# --[ OH7 Personality Line ]--
say_oh7() {
  echo
  echo "🟣 OH7: $1"
  echo
  python3 -c "from TTS.api import TTS; TTS().tts_to_file(text='$1', file_path='oh7_prompt.wav')" && \
  aplay oh7_prompt.wav 2>/dev/null || echo "OH7: (Imagine a snarky voice here. Coqui TTS missing.)"
  rm -f oh7_prompt.wav
}

# --[ Start Installer ]--
say_oh7 "Initializing installation. I hope you know what you're doing."

# Update & install dependencies
say_oh7 "Updating your crusty package manager..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y python3 python3-pip git curl unzip libasound2 sox

# Python libraries
say_oh7 "Installing Python packages. I promise not to break anything... much."
pip3 install --upgrade pip
pip3 install TTS

# Install Coqui TTS test voice (cached offline if pre-downloaded)
say_oh7 "Preparing my voice. This might tickle."
python3 -c "from TTS.api import TTS; TTS().tts_to_file(text='Testing voice synthesis. OH7 is alive.', file_path='test.wav')" || echo "Coqui TTS test failed."

# Install LM Studio (optional GUI LLM interface)
say_oh7 "Fetching LM Studio, because shiny buttons matter."
mkdir -p ~/Downloads
cd ~/Downloads
wget -O lmstudio.deb https://github.com/LMStudioAI/studio/releases/latest/download/lm-studio.deb
sudo dpkg -i lmstudio.deb || sudo apt install -f -y

# Install Ollama (CLI local LLMs)
say_oh7 "Summoning Ollama. No internet seances, just code."
curl -fsSL https://ollama.com/install.sh | sh

say_oh7 "Installation complete. I'm fully operational, which is more than I can say for you."

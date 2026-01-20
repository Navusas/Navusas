#!/bin/bash
# Claude dotfiles setup script
# Run this after cloning the dotfiles repo to symlink Claude configs

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Setting up Claude dotfiles..."
echo "Source: $SCRIPT_DIR"
echo "Target: $CLAUDE_DIR"

# Create .claude directory if it doesn't exist
mkdir -p "$CLAUDE_DIR"

# Function to create symlink (backs up existing file/dir if not already a symlink)
link_item() {
    local src="$1"
    local dest="$2"

    if [ -L "$dest" ]; then
        echo "Removing existing symlink: $dest"
        rm "$dest"
    elif [ -e "$dest" ]; then
        echo "Backing up existing: $dest -> $dest.backup"
        mv "$dest" "$dest.backup"
    fi

    echo "Linking: $dest -> $src"
    ln -s "$src" "$dest"
}

# Link individual config files
link_item "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
link_item "$SCRIPT_DIR/statusline.sh" "$CLAUDE_DIR/statusline.sh"

# Link entire directories (so new files automatically appear in repo)
link_item "$SCRIPT_DIR/agents" "$CLAUDE_DIR/agents"

echo ""
echo "Done! Claude dotfiles have been symlinked."
echo ""
echo "Symlinks created:"
ls -la "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/statusline.sh" "$CLAUDE_DIR/agents"

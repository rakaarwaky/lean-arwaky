#!/bin/bash
set -e

BASE_DIR="/home/raka/mcp-arwaky/lean-arwaky"
REPO_DIR="$BASE_DIR/lean-ctx"
DIST_DIR="$BASE_DIR/dist"

echo ">>> Creating dist directory..."
mkdir -p "$DIST_DIR"

echo ">>> Building lean-ctx (release)..."
cd "$REPO_DIR/rust"
export RUST_MIN_STACK=67108864
cargo build --release --locked

echo ">>> Copying binary to dist/..."
cp "$REPO_DIR/rust/target/release/lean-ctx" "$DIST_DIR/lean-ctx"

echo ">>> Setting permissions..."
chmod 755 "$DIST_DIR/lean-ctx"

echo ">>> Installing to ~/.local/bin/..."
mkdir -p "$HOME/.local/bin"
cp "$DIST_DIR/lean-ctx" "$HOME/.local/bin/lean-ctx"
chmod 755 "$HOME/.local/bin/lean-ctx"

echo ">>> Setting up Qwen Code integration..."
export PATH="$HOME/.local/bin:$PATH"
if command -v lean-ctx >/dev/null 2>&1; then
    lean-ctx init --agent qwen
    echo ">>> Qwen Code integration complete!"
else
    echo ">>> Warning: lean-ctx not found in PATH. Run 'lean-ctx init --agent qwen' manually after ensuring ~/.local/bin is in PATH."
fi

echo ">>> Done! Output in $DIST_DIR/lean-ctx, installed to ~/.local/bin/lean-ctx, and Qwen Code integration configured."
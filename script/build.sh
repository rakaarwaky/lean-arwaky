#!/bin/bash
set -e

BASE_DIR="/home/raka/mcp-arwaky/lean-arwaky"
REPO_DIR="$BASE_DIR/lean-ctx"
DIST_DIR="$BASE_DIR/dist"

echo ">>> Creating dist directory..."
mkdir -p "$DIST_DIR"

echo ">>> Building lean-ctx (release)..."
cd "$REPO_DIR/rust"
cargo build --release --locked

echo ">>> Copying binary to dist/..."
cp "$REPO_DIR/rust/target/release/lean-ctx" "$DIST_DIR/lean-ctx"

echo ">>> Setting permissions..."
chmod 755 "$DIST_DIR/lean-ctx"

echo ">>> Done! Output in $DIST_DIR/lean-ctx"
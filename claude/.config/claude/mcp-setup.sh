#!/usr/bin/env bash
# mcp-setup.sh — Register MCP servers for Claude Code
# Run this once after setting up dotfiles.
# Requires: claude CLI, npx (Node.js)

set -e

echo "→ Registering Playwright MCP server..."

# Playwright MCP: gives Claude Code a real browser to interact with
# Supports: navigate, click, screenshot, fill forms, extract content
claude mcp add playwright -- npx @playwright/mcp@latest

echo ""
echo "✓ Playwright MCP registered."
echo ""
echo "  Usage: Claude Code can now use browser automation."
echo "  In any Claude Code session, you can ask:"
echo "    'Open http://localhost:3000 and take a screenshot'"
echo "    'Run the login flow and verify it redirects correctly'"
echo "    'Check what's on the page after clicking the submit button'"
echo ""
echo "  To verify: claude mcp list"

# Claude Code — Global Context

This file is auto-loaded by Claude Code as global context for every session.

## About this machine

- **OS**: macOS (Apple Silicon)
- **Shell**: zsh
- **Terminal**: iTerm2 + tmux
- **Editor**: NeoVim (LazyVim)
- **Package manager**: Homebrew

## Primary tech stack

- **Languages**: JavaScript/TypeScript (Node.js), Python
- **Frontend**: React, Next.js, Tailwind CSS
- **Backend**: Node.js (Express/Fastify/Hono), Python (FastAPI/Django)
- **Testing**: Vitest, Playwright, Pytest
- **Tooling**: pnpm/bun, pyenv, git

## Preferences & conventions

- Use TypeScript over JavaScript when starting new code
- Prefer ESM modules (`import/export`) over CommonJS
- Use 2-space indentation
- Single quotes for strings in JS/TS
- Keep functions small and composable
- Write tests alongside code when reasonable
- Add comments for non-obvious logic, not for obvious things

## When using Playwright MCP

The Playwright MCP is available for browser automation.
- Use it for E2E tests, scraping, and verifying UI behavior
- Default to Chromium unless a specific browser is needed
- Take screenshots on test failures for debugging

## Git conventions

- Commit messages: imperative mood, < 72 chars
- Branch naming: `feat/`, `fix/`, `chore/`, `refactor/`
- Always run lint/typecheck before committing

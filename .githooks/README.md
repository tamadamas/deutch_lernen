# Git Hooks

This directory contains git hooks for the project.

## Setup

Run this command after cloning the repository:

```bash
git config core.hooksPath .githooks
```

Or add to your setup alias in mix.exs:

```elixir
setup: ["deps.get", "cmd git config core.hooksPath .githooks", "ash.setup", ...]
```

## Hooks

- **pre-commit**: Automatically runs `mix format` on staged Elixir files and re-stages them
- **pre-push**: Runs `mix precommit` (compile, format check, tests) before allowing push

## Bypassing Hooks

If you need to bypass hooks temporarily:

```bash
git commit --no-verify   # Skip pre-commit hook
git push --no-verify     # Skip pre-push hook
```

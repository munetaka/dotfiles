# CONTRIBUTING.md

## 🧭 Purpose

This document describes how contributors should participate in this project, from environment setup to code submission.

本ドキュメントは、開発環境構築からコード提出までの貢献手順を定めます。

---

## 🧰 Development Environment

### Requirements

- Python 3.11+
- uv (package manager)
- FastAPI
- MySQL
- Ruff (linter / formatter)
- ty (type checker)
- pre-commit
- (optional) Nix for reproducible builds

### Setup Steps

```bash
# 1. Clone repository
git clone git@github.com:your-org/your-service.git
cd your-service

# 2. Install uv (if not installed)
pip install uv

# 3. Sync dependencies
uv sync

# 4. Install pre-commit hooks
uv run pre-commit install
```

---

## 🧩 Code Style & Quality

All commits must pass the following checks:

| Tool | Purpose |
|------|----------|
| **Ruff** | Lint + format check (`TD001`, `TD002`, `TD003`, `FIX002`) |
| **ty** | Static type checking |
| **pytest** | Unit test validation |
| **pre-commit** | Automated hooks for Ruff & ty |
| **GitHub Actions** | Continuous verification in CI |

### Example Commands

```bash
# Run all checks before commit
uv run ruff check .
uv run ty
pytest
```

---

## 🗒️ Comment Guidelines

Follow the shared conventions defined in [`AGENTS.md`](./AGENTS.md).  
Each TODO, FIXME, or NOTE should be meaningful and linked to a responsible person or issue when applicable.

```python
# Good Example
# TODO(@alice)#112: Add validation for null responses
# NOTE: We intentionally skip retry on 404 errors.
```

---

## 🧾 Branch & Commit Policy

| Branch | Purpose |
|---------|----------|
| `main` | Stable / production |
| `develop` | Active development |
| `feature/*` | New feature branches |
| `fix/*` | Bugfix branches |
| `release/*` | Pre-release stabilization |

**Commit messages:**  
Follow [Conventional Commits](https://www.conventionalcommits.org/)  
Example:  
`feat(api): add user registration endpoint`  
`fix(db): handle null primary key constraint`

---

## 🔄 Pull Request Rules

- PRs must be **small, focused, and well-described**.  
- Include references to relevant **Issues or TODOs**.  
- At least one **peer review** is required before merge.  
- All automated checks (Ruff, ty, tests) must pass.

---

## 🧭 Testing

```bash
# Run tests
pytest -v --maxfail=1 --disable-warnings

# Run a single test
pytest tests/test_user_api.py -k "test_create_user"
```

---

## 🧩 Documentation

- Docstrings must follow **Google style**.  
- API docs auto-generate via **FastAPI** at `/docs` and `/redoc`.  
- Keep `AGENTS.md` and `CONTRIBUTING.md` updated when processes change.

---

**Last Updated:** 2025-10-27  
**Maintainer:** `@CTO`


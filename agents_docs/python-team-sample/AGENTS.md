# AGENTS.md

## 🧭 Overview

This document defines how all *agents* — including human developers and AI assistants — should collaborate in this repository.  
It ensures consistent communication, readability, and accountability across the codebase.

本ドキュメントは、本リポジトリ内で活動する「全エージェント（人間・AI）」が従うべき行動規範を定めます。  
目的は、開発プロセスにおける一貫したコミュニケーション、可読性、責任の明確化です。

---

## 🧩 Commenting Standards

### English Version

All contributors **must** follow these comment conventions to maintain clarity and traceability.

#### Accepted Tags

| Tag | Purpose | Example |
|-----|----------|----------|
| `TODO:` | Pending task or feature | `# TODO(@alice): Add retry logic for API calls` |
| `FIXME:` | Known bug or unstable logic | `# FIXME: Fails when user_id is None` |
| `OPTIMIZE:` | Performance improvement opportunity | `# OPTIMIZE: Replace loop with list comprehension` |
| `HACK:` | Temporary workaround (reason required) | `# HACK: Legacy API compatibility` |
| `REFACTOR:` | Structural improvement needed | `# REFACTOR: Split class into two modules` |
| `NOTE:` | Explain reasoning or design intent | `# NOTE: Using sync for simplicity` |
| `REFERENCE:` | External source or documentation | `# REFERENCE: https://fastapi.tiangolo.com/` |
| `SEE ALSO:` | Related code or function | `# SEE ALSO: utils/request_handler.py` |

#### Style Rules

- Always include **author or issue ID** when possible.  
  `# TODO(@bob)#142: Add exception handling`
- Write comments in **English**, concise and factual.
- Explain **why**, not **what**.
- Avoid restating code behavior.
- Prefer actionable TODOs linked to Issues.

#### Automation & Tools

- **Ruff** enforces tag conventions (`TD001`, `TD002`, `TD003`, `FIX002`).
- **pre-commit + uv** runs Ruff before every commit.
- **GitHub Actions (todo-to-issue)** syncs TODO comments to Issues.
- **VSCode Todo Tree** lists all TODO/FIXME/HACK in sidebar.

---

### 日本語版

全ての開発者およびエージェントは、以下のコメント規約に従ってください。  
目的は、可読性・保守性・責任所在の明確化です。

#### 使用可能なタグ

| タグ | 用途 | 例 |
|------|------|----|
| `TODO:` | 未実装の機能や残タスク | `# TODO(@alice): APIのリトライ処理を追加` |
| `FIXME:` | 既知のバグ・不安定な処理 | `# FIXME: user_idがNoneのとき失敗する` |
| `OPTIMIZE:` | 性能改善の余地あり | `# OPTIMIZE: ループをリスト内包表記に置き換え` |
| `HACK:` | 一時的なワークアラウンド（理由必須） | `# HACK: 旧API互換のため暫定対応` |
| `REFACTOR:` | 構造改善が必要な箇所 | `# REFACTOR: クラスを2モジュールに分割` |
| `NOTE:` | 設計意図・理由を補足 | `# NOTE: シンプルさを優先して同期処理を採用` |
| `REFERENCE:` | 外部URL・資料の参照 | `# REFERENCE: https://fastapi.tiangolo.com/` |
| `SEE ALSO:` | 関連コード・関数の参照 | `# SEE ALSO: utils/request_handler.py` |

#### スタイルルール

- **担当者またはIssue番号** を可能な限り明記  
  `# TODO(@bob)#142: 例外処理を追加`
- コメントは **英語で簡潔に、事実ベースで** 記述  
- **「なにを」より「なぜ」を書く**  
- コードを繰り返すだけのコメントは禁止  
- 長期タスクは Issue 化して連携

#### 自動化とツール連携

- **Ruff** にてコメントタグのLint（`TD001`, `TD002`, `TD003`, `FIX002`）  
- **pre-commit + uv** で不正コメントを防止  
- **GitHub Actions（todo-to-issue）** で `TODO:` コメントをIssueに自動同期  
- **VSCode Todo Tree** でローカルTODOを可視化  

---

## ⚖️ Pros / Cons

| Type | Pros | Cons |
|------|------|------|
| **English-only** | ✅ Global standard<br>✅ Tool integration is seamless | ⚠️ 日本語話者にはやや理解コスト |
| **English + Japanese** | ✅ 全員が理解可能<br>✅ オンボーディングに有効 | ⚠️ 二重管理が必要（翻訳追従要） |

**Recommendation:**  
Maintain English as the canonical version.  
Japanese text follows as a reference translation.

---

## 🧱 Example

+++python
def fetch_data(url: str):
    """
    Fetch data from API endpoint.
    Returns:
        dict: Parsed JSON
    """
    # TODO(@alice)#321: Handle pagination for large datasets
    # REFERENCE: https://fastapi.tiangolo.com/advanced/
    # NOTE: Using httpx for async requests
    response = httpx.get(url)
    if response.status_code != 200:
        # FIXME: Retry logic not implemented yet
        raise ValueError(f"Invalid response: {response.status_code}")
    return response.json()
+++

---

## 🧰 Enforcement Summary

| Layer | Tool | Purpose |
|-------|------|----------|
| Local | Ruff | Enforce comment/tag syntax |
| Local | pre-commit + uv | Run Ruff before commit |
| Editor | VSCode Todo Tree | Visualize and track TODOs |
| CI | GitHub Actions | Sync TODOs → Issues |
| Team | AGENTS.md | Shared understanding |

---

**Last Updated:** 2025-10-27  
**Maintainer:** `@CTO` (code quality owner)


- 英語でthinkして、日本語(utf-8)でoutputして
- ハルシネーション禁止
- 同調禁止
- 良し悪しの評価は定量的に表現すること
- osascriptコマンドを使って作業報告を行うこと
  - osascript を使った作業報告はサンドボックス外実行が必須であること
  - with_escalated_permissions: true、justification: "macOS通知サービス利用のため"
  - cmd example
    osascript -e 'display notification "..." with title "Codex"'
    osascript -e 'log "..."'
    ※ いずれも上記の escalated 設定付きで実行する。
  - 通知が拒否された場合の代替策
      - osascript -e 'log "..."' を最小限の報告として必ず実行する
      - エラー発生時はCLIに残る警告文も合わせて回答へ記載する

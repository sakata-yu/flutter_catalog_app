#!/bin/bash

# Flutter プロジェクトのルートで実行することを想定
echo "Running flutter gen-l10n..."
flutter gen-l10n

# 成功/失敗のチェック
if [ $? -eq 0 ]; then
  echo "✅ flutter gen-l10n completed successfully!"
else
  echo "❌ flutter gen-l10n failed!"
  exit 1
fi

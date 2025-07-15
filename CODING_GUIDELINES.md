## CODING GUIDELINES

このドキュメントでは、Flutter Catalog サンプルアプリにおけるコーディング規約を定義します。プロジェクトの可読性と保守性を高めるため、以下のガイドラインに従って開発を進めてください。

⸻

参考スタイルガイド
- Effective Dart - Style
https://dart.dev/guides/language/effective-dart

⸻

命名規則
- ファイル名：スネークケース（例: count_view_model.dart）
- クラス名：パスカルケース（例: CountViewModel）
- メソッド名／変数名：キャメルケース（例: fetchData()、isLoading）

⸻

ディレクトリ構成
- 各ページごとに features/機能名/ に分割
- UIウィジェットは view/、状態管理は view_model/、データ関連は data/

⸻

Provider命名
- StateNotifier を使う場合：○○ViewModel（例: CountViewModel）
- Provider定義：○○Provider（例: countViewModelProvider）

⸻

一般ルール
- 1ファイル1クラス原則
- UI側では HookConsumerWidget / StatelessWidget を使う
- StateNotifier には必ず初期値と例外処理を書く
- AsyncValue を扱う際は switch で loading / error / data を明示

⸻

Flutter固有スタイル
- Trailing comma（末尾のカンマ）は必ず記述（整形で自動対応）
- 文字列は必ず国際化対応（l10n）（予定）
- ボタン等共通ウィジェットは core/widgets/ に作成
- テーマ・色は core/theme/ に集約

⸻

その他
- flutter_gen / envied / freezed の自動生成ファイルはGitに含めない
- スクリプトは scripts/ に配置、必要に応じて Makefile でコマンド化
- 機能画面にはREADMEを添付し、機能とファイルの概要を明記（FUNCTION_README_TEMPLATE.mdを参照）

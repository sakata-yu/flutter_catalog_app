## Flutter Catalog Sample App

このプロジェクトは、Flutter によるカタログ用サンプルアプリです。
プロジェクト構成は、「The Ultimate Guide to Flutter Clean Architecture」に基づいて設計されています。

### セットアップ手順

プロジェクトをクローン後、初期セットアップを行ってください：

make init

### 利用技術
- Flutter（最新安定版）
- Riverpod
- Dio
- envied（.env 管理）
- flutter_gen
- l10n（国際化対応）（予定）

### ディレクトリ構成
<pre>
flutter_catalog_app/
├── android/
├── ios/
├── lib/
│   ├── core/                    # アプリ全体で使う共通機能
│   │   ├── asset_gen/           # FlutterGen生成先
│   │   ├── env/                 # Envied設定用
│   │   ├── config/              # 定数、環境設定
│   │   ├── exceptions/          # 共通エラー
│   │   ├── extensions/          # 拡張関数
│   │   ├── network/             # Dio設定、API基盤
│   │   ├── router/              # GoRouter 設定
│   │   ├── theme/               # アプリ全体のテーマ
│   │   └── utils/               # ユーティリティ関数など
│   │
│   ├── features/                # 各画面単位の機能ブロック
│   │   ├── home/
│   │   │   ├── data/            # リポジトリ、モデル
│   │   │   ├── view/            # UIウィジェット
│   │   │   ├── view_model/      # StateNotifierやProvider
│   │   │   └── home_page.dart   # 画面のルートWidget
│   │   └── ...                  # 他の機能ブロック
│   │
│   └── main.dart
│
├── test/
│   └── ...                      # 各機能ごとのテスト
│
├── scripts/                     # コマンド管理用シェルスクリプト
│   ├── generate_localization.sh
│   ├── generate_freezed.sh
│   ├── format.sh
│   ├── analyze.sh
│   ├── build_runner.sh
│   ├── clean.sh
│   └── prepare_env.sh
│
├── .env.sample                  # 環境変数コピー元ファイル
├── .gitignore
├── Makefile                     # コマンド簡略化
├── pubspec.yaml
└── README.md
</pre>

### 新規画面作成コマンド
```
make create-feature cid=000 name=hogehoge
```

### 参考

このリポジトリは以下の設計ガイドラインをベースに構築されています：

The Ultimate Guide to Flutter Clean Architecture
（https://codewithandrea.com/articles/flutter-clean-architecture-features-modularization/）

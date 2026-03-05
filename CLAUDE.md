# Neovim Config - CLAUDE.md

## プロジェクト概要

Lazy.nvim で管理する個人 Neovim 設定。

## ディレクトリ構造

```
~/.config/nvim/
├── init.lua                  # エントリポイント
├── lua/
│   ├── base.lua              # 基本設定
│   ├── keymaps.lua           # キーマップ定義
│   ├── config/
│   │   ├── lazy.lua          # Lazy.nvim セットアップ
│   │   └── im-select.lua     # 入力メソッド切り替え
│   └── plugins/              # プラグイン設定（1ファイル = 1プラグイン）
└── docs/                     # 各プラグインのドキュメント（.md）
```

## docs/ ドキュメント作成タスク

### 目的

`docs/` 配下に各プラグインの説明を `.md` ファイルとして作成する。

### 対象プラグイン一覧（lua/plugins/ 内のファイル）

| ファイル名 | プラグイン | 用途 |
|---|---|---|
| alpha-nvim.lua | goolord/alpha-nvim | スタートダッシュボード |
| barbar-nvim.lua | romgrk/barbar.nvim | バッファ・タブ管理 |
| blink-cmp.lua | saghen/blink.cmp | 補完エンジン |
| claudecode-nvim.lua | coder/claudecode.nvim | Claude Code 連携 |
| colorful-winsep-nvim.lua | nvim-zh/colorful-winsep.nvim | ウィンドウ区切り線のカラー表示 |
| comment-nvim.lua | numToStr/Comment.nvim | コメントトグル |
| dropbar.lua | Bekaboo/dropbar.nvim | パンくずナビゲーション |
| gitsigns-nvim.lua | lewis6991/gitsigns.nvim | Git 差分サイン表示 |
| glance-nvim.lua | dnlhc/glance.nvim | 定義・参照のプレビュー |
| hlchunk-nvim.lua | shellRaining/hlchunk.nvim | コードチャンクのハイライト |
| lazygit.lua | kdheepak/lazygit.nvim | LazyGit UI 統合 |
| lualine.lua | nvim-lualine/lualine.nvim | ステータスライン |
| markview.lua | OXY2DEV/markview.nvim | Markdown プレビュー |
| neogit.lua | NeogitOrg/neogit | Git 操作・差分表示 |
| nvim-lspconfig.lua | neovim/nvim-lspconfig | LSP 設定 |
| nvim-scrollbar.lua | petertriho/nvim-scrollbar | スクロールバー表示 |
| nvim-tree.lua | nvim-tree/nvim-tree.lua | ファイルツリー |
| nvim-treesitter.lua | nvim-treesitter/nvim-treesitter | シンタックスパーサー |
| nvim-treesitter-context.lua | nvim-treesitter/nvim-treesitter-context | コンテキスト表示 |
| telescope.lua | nvim-telescope/telescope.nvim | ファジーファインダー |
| toggleterm.lua | akinsho/toggleterm.nvim | ターミナル統合 |
| tokyonight.lua | folke/tokyonight.nvim | カラースキーム |
| trouble.lua | folke/trouble.nvim | 診断・エラー一覧 |
| which-key-nvim.lua | folke/which-key.nvim | キーバインドヘルプ |

### 各 .md ファイルのフォーマット

`docs/<plugin-name>.md` として作成。内容は以下の構成に従う。

```markdown
# <プラグイン名>

## 概要

<プラグインの目的・役割を1〜2文で説明>

## リポジトリ

<GitHub URL>

## 設定ファイル

`lua/plugins/<filename>.lua`

## 主な機能

- <機能1>
- <機能2>

## キーマップ

| キー | モード | 説明 |
|---|---|---|
| `<key>` | normal | <説明> |

※ キーマップがないプラグインはこのセクションを省略する。

## 設定のポイント

<このリポジトリ固有の設定や注意点があれば記載>
```

### 作業手順

1. `lua/plugins/<plugin>.lua` を読む
2. 上記フォーマットに従って `docs/<plugin-name>.md` を作成する
3. ファイル名は `lua/plugins/` のファイル名から `.lua` を除いたもの（例: `alpha-nvim.md`）

### 注意事項

- キーマップは実際の設定ファイルから正確に転記する
- LSP サーバー一覧など詳細情報も設定ファイルから読み取って記載する
- 説明は日本語で書く
- 存在しない機能や設定は記載しない

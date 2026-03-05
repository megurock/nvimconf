# alpha-nvim

## 概要

Neovim 起動時に表示するスタートダッシュボード。最近開いたファイルへのクイックアクセスなどを提供する。

## リポジトリ

https://github.com/goolord/alpha-nvim

## 設定ファイル

`lua/plugins/alpha-nvim.lua`

## 主な機能

- 起動時にスタートダッシュボードを表示
- `startify` テーマを使用したレイアウト
- 最近開いたファイルの一覧表示
- ファイルアイコン表示（nvim-web-devicons 使用）

## 設定のポイント

- テーマは `alpha.themes.startify` を使用
- ファイルアイコンのプロバイダーとして `devicons` を明示的に指定（デフォルトは `mini`）
- `nvim-mini/mini.icons` も利用可能だがコメントアウト済み

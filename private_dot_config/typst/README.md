# Typst Templates

レポート作成用の、Typstのテンプレートです。

## 使い方

### フォントについて

デフォルトで、以下のフォントを使用しています。

- 見出し: [Noto Sans JP](https://fonts.google.com/specimen/Noto+Sans+JP)
- 本文: [Noto Serif JP](https://fonts.google.com/specimen/Noto+Serif+JP)
- 等幅: [UDEV Gothic NFLG](https://github.com/yuru7/udev-gothic)

### テンプレートのインストール

#### 自動インストール

このレポジトリをクローンして、このREADMEがあるディレクトリで以下のコマンドを実行してください。

```sh
deno run -A install.ts
```

#### 手動インストール

`./template.typ`をコピーして、レポートのファイルの先頭に以下のコードを追加することでも使用できます。

```typ
#import "./template.typ": report, code-info
#show: report.with(
  title: [
    #text(font: "Noto Emoji")[#emoji.crab] \
    計算機科学基礎実験 \
    第一回レポート \
    Rustによるプログラミング演習
  ],
  author: [
    IS科 \
    Rai
  ]
)
```

### テンプレートのアンインストール

```sh
# Linux
rm -rf ~/.local/share/typst/packages/local/jsreport

# MacOS
rm -rf ~/Library/Application Support/typst/packages/local/jsreport

# Windows
rm $env:APPDATA\typst\packages\local\jsreport
```

> https://github.com/typst/packages#local-packages

### テンプレートの使用

以下のコードを、レポートのファイルの先頭に追加してください。

```typ
#import "@local/jsreport:0.1.0": report, code-info
#show: report.with(
  title: [
    #text(font: "Noto Emoji")[#emoji.crab] \
    計算機科学基礎実験 \
    第一回レポート \
    Rustによるプログラミング演習
  ],
  author: [
    IS科 \
    Rai
  ]
)
```

> [!IMPORTANT]
> 詳しくは、[sample/sample-report.typ](./sample/sample-report.typ) を参照してください。

#### コードブロックについて

Typstでは、コードブロックに対して行番号の表示やキャプションの挿入、相互参照などをデフォルトではサポートしていません。したがって、このテンプレートではこれら機能を`#code-info()`関数を通して独自に実装しています。

`code-info`関数の定義は次の通りです：

```typ
#let code-info(
  caption: none,
  label: none,
  show-line-numbers: false,
  start-line: 1,
  highlight-line: ()
) = ...
```

- `caption`: コードブロックのキャプションを指定します。デフォルトでは、キャプションは表示されません。
- `label`: コードブロックにラベルを付けます。ラベルは、`#ref`関数を用いて参照することができます。
- `show-line-numbers`: 行番号を表示するか否かを指定します。デフォルトでは、行番号は表示されません。
- `start-line`: 行番号の開始番号を指定します。デフォルトでは、行番号は1から始まります。
- `highlight-line`: ハイライトする行番号のリストを指定します。デフォルトでは、ハイライトする行はありません。

例えば、次のようにしてコードブロックを挿入することができます：

````typ
#import "@local/jsreport:0.1.0": code-info

プログラムを @code:fizzbuzz に示す。

#code-info(
  caption: "fizzbuzz.rs",
  label: "code:fizzbuzz",
  show-line-numbers: true,
  start-line: 1,
)
```rs
fn main() {
    for i in 1..=100 {
        if i % 15 == 0 {
            println!("FizzBuzz");
        } else if i % 3 == 0 {
            println!("Fizz");
        } else if i % 5 == 0 {
            println!("Buzz");
        } else {
            println!("{}", i);
        }
    }
}
```
````

#### フォントについて

- `heading-font`: 見出しのフォントを指定します。
  - type: `string`
  - default: `"Noto Sans JP"`
- `body-font`: 本文のフォントを指定します。
  - type: `string`
  - default: `"Noto Serif JP"`
- `mono-font`: 等幅のフォントを指定します。
  - type: `string`
  - default: `"UDEV Gothic NFLG"`
- `title-font`: タイトルのフォントを指定します。
  - type: `string`
  - default: `"Noto Serif JP"`

例えば、次のようにしてフォントを変更することができます：

```typ
#import "@local/jsreport:0.1.0": report

#show: report.with(
  heading-font: "Noto Sans JP",
  body-font: "Noto Serif JP",
  mono-font: "UDEV Gothic NFLG",
  title-font: "Noto Serif JP",
)
```

#### タイトルページについて

- `title`: タイトルを指定します。
  - type: `content`
  - default: `[タイトル]`
- `author`: 著者を指定します。
  - type: `content`
  - default: `[著者]`
- `date`: 日付を指定します。
  - type: `datetime`
  - default: `datetime.today()`
- `title-type`: タイトルの種類を指定します。
  - type: `"fullpage" | "inpage" | "none"`
    - `"fullpage"`: 1ページ目にタイトルページを挿入します。
    - `"inpage"`: 1ページ目の上部にタイトルを挿入します。
    - `"none"`: タイトルを挿入しません。
  - default: `"fullpage"`
- `title-component`: タイトルページのコンポーネントを指定します。コンポーネントは、以下のtypeを満たす関数です。
  - type: `(title: [タイトル], author: [著者], date: datetime.today(), font: "Noto Serif JP", gap: (32pt, 32pt)) => {}`
  - default: `report-title`

例えば、次のようにしてタイトルページを変更することができます：

```typ
#import "@local/jsreport:0.1.0": report

#show: report.with(
  title: [
    計算機科学基礎実験 \
    第一回レポート \
    Rustによるプログラミング演習
  ],
  author: [
    情報科学科 \
    ○○ ○○
  ],
  title-type: "inpage",
  date: datetime(
    year: 2023,
    month: 12,
    day: 3,
  ),
)
```

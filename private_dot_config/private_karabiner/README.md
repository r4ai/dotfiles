# Config for Karabiner-Elements

## compile

Compile `./karabiner.edn` to `~/.config/karabiner/karabiner.json`.

```bash
make
```

For manual compile, use `goku` command. For example:

```bash
# Copy karabiner.edn to ~/.config/karabiner.edn
# By default, ~/.config/karabiner.edn is the config file for goku to compile.
cp ./karabiner.edn ~/.config/karabiner.edn

# Compile ~/.config/karabiner.edn to ~/.config/karabiner/karabiner.json
goku
```

Also, you can use `$GOKU_EDN_CONFIG_FILE` to specify the config file. For example:

```bash
# set the path to your config file (karabiner.edn)
set -x GOKU_EDN_CONFIG_FILE ~/.config/karabiner/karabiner.edn

# compile $GOKU_EDN_CONFIG_FILE
goku

# autocompile (watching file changes)
gokuw
```

## references

- <https://github.com/yqrashawn/GokuRakuJoudo>
- <https://github.com/yqrashawn/GokuRakuJoudo/blob/master/tutorial.md>
- <https://github.com/yqrashawn/GokuRakuJoudo/blob/master/examples.org>
- <https://qiita.com/QuestionDriven/items/da4459c471fc3def031f>

## フォルダ構成

- `~/.config/karabiner`: KarabinerElementsの設定ファイルである`karabiner.json`を置く場所。このファイルは、`goku`コマンドによって`~/.config/karabiner.end`から生成される。
- `~/.config/karabiner.edn`: KarabinerElementsの設定ファイルである`karabiner.json`を生成するための設定ファイル。このファイルは、`goku`コマンドによって`~/.config/karabiner.json`に変換される。

## modifier-keys

```clojure
;; !  | means mandatory
;; #  | means optional
;; C  | left_command
;; T  | left_control
;; O  | left_option
;; S  | left_shift
;; F  | fn
;; Q  | right_command
;; W  | right_control
;; E  | right_option
;; R  | right_shift
;; P  | caps_lock
;; !! | mandatory command + control + optional + shift (hyper)
;; ## | optional any
```

## examples

```clojure
{:main [{:des "command a to control 1" [:!Ca :!T1]}]}

;; this is a little bit weird, but it's convenient
;; the rule [:!Ca :!T1]
;; means from command a to control 1
;; :!Ca is keycode :a and prefix a with !C

;; here's the definition

;; !  | means mandatory
;; #  | means optional
;; C  | left_command
;; T  | left_control
;; O  | left_option
;; S  | left_shift
;; F  | fn
;; Q  | right_command
;; W  | right_control
;; E  | right_option
;; R  | right_shift
;; P  | caps_lock
;; !! | mandatory command + control + optional + shift (hyper)
;; ## | optional any

;; examples

;; !CTSequal_sign  | mandatory command control shift =
;;                 | which is command control +
;; !O#Sright_arrow | mandatory option optional any right_arrow

;; karabiner definition of mandatory and optional
;; https://karabiner-elements.pqrs.org/docs/json/complex-modifications-manipulator-definition/from/modifiers/

;; rule [<from> <to>]
;; if simplified modifier is used in <to>, optional(#) definition will be
;; ignored.
```

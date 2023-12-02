import json
import re
import os

# MEMO
# CapsLock → F21
# F21 → 132


def configure(keymap):
    # *---jsonファイルの読み込み
    with open('keymap.jsonc', encoding="utf-8") as f:
        raw_data = f.read()
    raw_data_comments_ignored = re.sub(r'/\*[\s\S]*?\*/|//.*', '', raw_data)

    df :dict = json.loads(raw_data_comments_ignored)
    modifiers :dict = df["modifier"]
    hotkeys :dict = df["hotkeys"]


    # *---Modifierの設定
    for key, value in modifiers.items():
        keymap.defineModifier(key, value)


    # *---hotkeyの設定
    keymap_global = keymap.defineWindowKeymap()

    def blind(key :str, value :str) -> None:
        default_modifiers_list = (
            "", "S-", "C-", "C-S-", "A-", "A-S-", "A-C-", "A-C-S-", "W-",
            "W-S-", "W-C-", "W-C-S-", "W-A-", "W-A-S-", "W-A-C-", "W-A-C-S-"
            )
        for modifier in default_modifiers_list:
            keymap_global[modifier + key] = modifier + value

    def send(key: str, value: str) -> None:
        keymap_global[key] = value

    for genre in hotkeys.keys():
        for key, value in hotkeys[genre].items():
            if genre == "IME":
                send(key, value)
            else:
                blind(key, value)

#!/bin/bash
# 部分由ChatGPT生成
# 仅在系统重装后并重新安装VSCode Journal拓展后使用

# 设置新的journal.base值
new_journal_base="$HOME/Notes/Diary/"

# 用sed命令替换journal.base的值
json_file="$HOME/.config/VSCodium/User/settings.json"
sed -i "s/\(\"journal.base\": \)\"[^\"]*\"/\1\"$new_journal_base\"/" "$json_file"

echo "journal.base已更新"

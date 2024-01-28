#!/bin/bash
# 由ChatGPT生成

# 源目录
source_dir="/home/shoreninth/Journal/"

# 目标目录
target_dir="/home/shoreninth/Notes/Diary/"

# 确保目标目录存在，如果不存在则创建
mkdir -p "$target_dir"

# 移动文件和文件夹到目标目录
cp "$source_dir"* "$target_dir"

# 输出移动完成的消息
echo "操作完成"

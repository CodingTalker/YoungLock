#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="$SCRIPT_DIR/../test/build"

echo "确保目录存在: $TARGET_DIR"
mkdir -p "$TARGET_DIR"

echo "正在进入目录: $TARGET_DIR"
cd "$TARGET_DIR"

# 替代 realpath 的方法
CURRENT_DIR=$(pwd)
EXPECTED_DIR=$(cd "$SCRIPT_DIR/../test/build" && pwd)

echo "当前目录: $CURRENT_DIR"
echo "期望目录: $EXPECTED_DIR"

if [ "$CURRENT_DIR" = "$EXPECTED_DIR" ]; then
    echo "清空目录: $CURRENT_DIR"
    # 保留隐藏文件（如.gitkeep）如果不需要可以删除 -name '.*' 部分
    find . -mindepth 1 -not -name '.*' -exec rm -rf {} + 2>/dev/null || true
else
    echo "错误: 不在预期目录中。当前: $CURRENT_DIR, 期望: $EXPECTED_DIR"
    exit 1
fi

cmake ..
make

echo "构建完成!"
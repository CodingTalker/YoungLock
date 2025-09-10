#!/bin/bash
# 1. 进入 test/build 目录
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR/../test/build"

# 2. 清空 test/build 文件夹下的所有文件及目录
if [ "$(pwd)" == "$(cd "$(dirname "$0")/../test/build" && pwd)" ]; then
	rm -rf ./*
else
	echo "Error: Not in the expected directory. Aborting cleanup."
	exit 1
fi

# 3. 进入 test/build 目录，运行 cmake 和 make
cmake ..
make
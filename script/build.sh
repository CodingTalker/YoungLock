#!/bin/bash
set -e

# 默认行为：只编译
MODE="build"

# 参数解析函数
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -b|--build)
                MODE="build"
                shift
                ;;
            -r|--run)
                MODE="build_and_run"
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                echo "未知选项: $1"
                show_help
                exit 1
                ;;
        esac
    done
}

# 显示帮助信息
show_help() {
    cat << EOF
用法: $(basename "$0") [选项]

选项:
  -b, --build      只编译（默认行为）
  -r, --run        编译并运行测试
  -h, --help       显示此帮助信息

如果没有提供选项，默认行为是只编译。
EOF
}

# 运行测试函数
run_tests() {
    echo "运行测试..."
    # 假设测试可执行文件名为 test_run（根据实际情况调整）
    local test_executable="test_run"
    
    if [ -f "$test_executable" ]; then
        ./"$test_executable"
    else
        # 尝试查找任何可执行文件
        local executable=$(find . -maxdepth 1 -type f -executable | head -n 1)
        if [ -n "$executable" ]; then
            echo "找到可执行文件: $executable"
            ./"$executable"
        else
            echo "错误: 未找到可执行文件"
            exit 1
        fi
    fi
}

# 主函数
main() {
    # 解析参数
    parse_arguments "$@"
    
    # 设置目录
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    TARGET_DIR="$SCRIPT_DIR/../test/build"
    
    echo "确保目录存在: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
    
    echo "正在进入目录: $TARGET_DIR"
    cd "$TARGET_DIR"
    
    # 获取当前目录和期望目录
    CURRENT_DIR=$(pwd)
    EXPECTED_DIR=$(cd "$SCRIPT_DIR/../test/build" && pwd)
    
    echo "当前目录: $CURRENT_DIR"
    echo "期望目录: $EXPECTED_DIR"
    
    # 检查目录是否正确
    if [ "$CURRENT_DIR" = "$EXPECTED_DIR" ]; then
        echo "清空目录: $CURRENT_DIR"
        # 保留隐藏文件（如.gitkeep）如果不需要可以删除 -name '.*' 部分
        find . -mindepth 1 -not -name '.*' -exec rm -rf {} + 2>/dev/null || true
    else
        echo "错误: 不在预期目录中。当前: $CURRENT_DIR, 期望: $EXPECTED_DIR"
        exit 1
    fi
    
    # 运行 CMake 和 Make
    echo "运行 CMake..."
    cmake ..
    
    echo "运行 Make..."
    make
    
    echo "构建完成!"
    
    # 根据模式决定是否运行测试
    case "$MODE" in
        "build_and_run")
            run_tests
            ;;
        *)
            echo "使用 -r 选项来编译并运行测试"
            ;;
    esac
}

# 执行主函数，传递所有参数
main "$@"
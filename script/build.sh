#!/bin/sh
set -e

# 配置变量
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."
MAIN_BUILD_DIR="$PROJECT_ROOT/build"
TEST_BUILD_DIR="$PROJECT_ROOT/test/build"

# 默认行为：只编译主工程
MODE="build_main"
VERBOSE=false

# 参数解析函数
parse_arguments() {
    while [ $# -gt 0 ]; do
        case $1 in
            -b|--build)
                MODE="build_main"
                shift
                ;;
            -r|--run)
                MODE="build_run_main"
                shift
                ;;
            -tb|--test-build)
                MODE="build_test"
                shift
                ;;
            -tr|--test-run)
                MODE="build_run_test"
                shift
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                echo "错误: 未知选项 '$1'"
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
  -b,  --build          只编译主工程（默认行为）
  -r,  --run            编译并运行主工程
  -tb, --test-build     只编译测试工程
  -tr, --test-run       编译并运行测试工程
  -v,  --verbose        显示详细输出
  -h,  --help           显示此帮助信息

示例:
  $ $(basename "$0") --build        # 编译主工程
  $ $(basename "$0") -tr            # 编译并运行测试工程
  $ $(basename "$0") -r -v          # 编译并运行主工程，显示详细输出
EOF
}

# 清理构建目录
clean_build_dir() {
    dir="$1"
    if [ "$VERBOSE" = true ]; then
        echo "检查目录: $dir"
    fi
    # 确保目录存在
    mkdir -p "$dir"
    # 进入目录
    cd "$dir"
    # 获取当前目录和期望目录
    current_dir=$(pwd)
    expected_dir=$(cd "$dir" && pwd)
    if [ "$current_dir" != "$expected_dir" ]; then
        echo "错误: 无法进入预期目录"
        echo "当前目录: $current_dir"
        echo "期望目录: $expected_dir"
        exit 1
    fi
    if [ "$VERBOSE" = true ]; then
        echo "清空目录: $current_dir"
    fi
    # 清空目录（保留隐藏文件）
    find . -mindepth 1 ! -name '.*' -exec rm -rf {} + 2>/dev/null || true
}

# 运行 CMake 和 Make
run_cmake_make() {
    source_dir="$1"
    if [ "$VERBOSE" = true ]; then
        echo "运行 CMake (源目录: $source_dir)..."
        cmake "$source_dir"
        echo "运行 Make..."
        make VERBOSE=1
    else
        echo "运行 CMake..."
        cmake "$source_dir" > /dev/null
        echo "运行 Make..."
        make > /dev/null
    fi
    echo "构建完成!"
}

# 查找并运行可执行文件
find_and_run_executable() {
    default_name="$1"
    echo "查找可执行文件..."
    if [ -f "$default_name" ]; then
        echo "运行: ./$default_name"
        ./"$default_name"
        return 0
    fi
    # 尝试查找任何可执行文件
    executable=$(find . -maxdepth 1 -type f -executable | head -n 1)
    if [ -n "$executable" ]; then
        echo "找到可执行文件: $executable"
        echo "运行: ./$executable"
        ./"$executable"
        return 0
    else
        echo "错误: 未找到可执行文件"
        return 1
    fi
}

# 主函数
main() {
    # 解析参数
    parse_arguments "$@"
    if [ "$VERBOSE" = true ]; then
        echo "模式: $MODE"
        echo "项目根目录: $PROJECT_ROOT"
    fi
    # 根据模式执行相应操作
    case "$MODE" in
        "build_main")
            echo "编译主工程..."
            clean_build_dir "$MAIN_BUILD_DIR"
            run_cmake_make "$PROJECT_ROOT"
            ;;
        "build_run_main")
            echo "编译并运行主工程..."
            clean_build_dir "$MAIN_BUILD_DIR"
            run_cmake_make "$PROJECT_ROOT"
            echo "运行主工程..."
            find_and_run_executable "younglock"
            ;;
        "build_test")
            echo "编译测试工程..."
            clean_build_dir "$TEST_BUILD_DIR"
            run_cmake_make "$PROJECT_ROOT/test"
            ;;
        "build_run_test")
            echo "编译并运行测试工程..."
            clean_build_dir "$TEST_BUILD_DIR"
            run_cmake_make "$PROJECT_ROOT/test"
            echo "运行测试..."
            find_and_run_executable "test_run"
            ;;
    esac
    echo "操作完成!"
}

# 执行主函数，传递所有参数
main "$@"
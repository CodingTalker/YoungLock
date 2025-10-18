cmake_minimum_required(VERSION 3.10)
project(test_encryptor)  # 可选：添加项目名称，方便管理

# 关键：设置构建类型为 Debug（生成调试信息，关闭优化）
# 若需要在命令行覆盖，可通过 -DCMAKE_BUILD_TYPE=Debug 实现
set(CMAKE_BUILD_TYPE Debug)

# 根据编译器类型设置调试选项（兼容不同编译器，如 GCC/Clang/MSVC）
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
        # GCC 或 Clang 编译器（Linux/macOS）
        set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g -O0")
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        # MSVC 编译器（Windows）
        set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /Zi /Od")
    endif()
endif()

find_package(GTest REQUIRED)
find_package(Threads REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

add_executable(test_encryptor
    test_encryptor.cpp
    # ...如需测试SDK实现可加 ../sdk/encryptor.cpp ...
)
target_link_libraries(test_encryptor GTest::GTest GTest::Main Threads::Threads)

enable_testing()
add_test(NAME EncryptorTest COMMAND test_encryptor)

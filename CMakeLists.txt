cmake_minimum_required(VERSION 3.10)
project(YoungLock)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

add_subdirectory(sdk)
add_subdirectory(cli)
add_subdirectory(script)
add_subdirectory(test)
# packaging目录不参与编译，仅用于打包交付

# 安装命令行工具到系统路径
install(TARGETS younglock RUNTIME DESTINATION bin)

# 安装SDK头文件和库
install(DIRECTORY sdk/include/ DESTINATION include/younglock)
install(TARGETS younglock_sdk LIBRARY DESTINATION lib ARCHIVE DESTINATION lib)

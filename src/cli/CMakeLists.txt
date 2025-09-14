cmake_minimum_required(VERSION 3.10)
project(younglock VERSION 1.0.0)

# 设置C++标准
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(younglock
    main.cpp
)
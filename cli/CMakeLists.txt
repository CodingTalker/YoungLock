add_executable(younglock main.cpp)
target_link_libraries(younglock PRIVATE younglock_sdk)
target_include_directories(younglock PRIVATE ../sdk/include)
install(TARGETS younglock RUNTIME DESTINATION bin)

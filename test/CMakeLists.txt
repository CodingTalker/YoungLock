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

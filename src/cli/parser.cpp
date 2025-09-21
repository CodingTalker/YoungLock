#include "cli.h"
#include "younglock_api.h"
#include <CLI/CLI.hpp>
#include <iostream>
#include <string>

namespace younglock {
namespace cli {

int parse_command_line(int argc, char** argv) {
    CLI::App app{"YoungLock - 文件加密工具"};

    // 子命令: encrypt
    auto encrypt = app.add_subcommand("encrypt", "加密文件");
    std::string encrypt_file;
    std::string encrypt_password;
    bool encrypt_random = false;
    std::string encrypt_time;
    std::string encrypt_output;
    bool encrypt_quiet = false;

    encrypt->add_option("file", encrypt_file, "要加密的文件")->required();
    encrypt->add_option("-p,--password", encrypt_password, "直接指定密码");
    encrypt->add_flag("-r,--random", encrypt_random, "使用随机密码");
    encrypt->add_option("-t,--time", encrypt_time, "设置有效时间段");
    encrypt->add_option("-o,--output", encrypt_output, "指定输出文件");
    encrypt->add_flag("-q,--quiet", encrypt_quiet, "安静模式");

    // 子命令: decrypt
    auto decrypt = app.add_subcommand("decrypt", "解密文件");
    std::string decrypt_file;
    std::string decrypt_output;
    bool decrypt_temporary = false;
    bool decrypt_quiet = false;

    decrypt->add_option("file", decrypt_file, "要解密的文件")->required();
    decrypt->add_flag("-t,--temporary", decrypt_temporary, "临时解密");
    decrypt->add_option("-o,--output", decrypt_output, "指定输出文件");
    decrypt->add_flag("-q,--quiet", decrypt_quiet, "安静模式");

    // 全局选项
    app.set_help_all_flag("--help-all", "显示所有帮助");
    app.require_subcommand(1); // 必须指定一个子命令

    try {
        app.parse(argc, argv);
        if (*encrypt) {
            return api::handle_encrypt(encrypt_file, encrypt_password, encrypt_random,
                                 encrypt_time, encrypt_output, encrypt_quiet);
        } else if (*decrypt) {
            return api::handle_decrypt(decrypt_file, decrypt_temporary,
                                 decrypt_output, decrypt_quiet);
        }
    } catch (const CLI::ParseError &e) {
        return app.exit(e);
    }
    return 0;
}

} // namespace cli
} // namespace younglock
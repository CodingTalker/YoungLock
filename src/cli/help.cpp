#include "cli.h"
#include <iostream>

namespace younglock {
namespace cli {

void show_help() {
    std::cout << R"(
YoungLock - 安全文件加密工具

用法: younglock [命令] [选项] <文件>

命令:
  encrypt     加密文件
  decrypt     解密文件

使用 'younglock [命令] --help' 查看特定命令的帮助
)";
}

void show_encrypt_help() {
    std::cout << R"(
加密命令: younglock encrypt [选项] <文件>

选项:
  -p, --password <密码>   直接指定密码（不提示确认）
  -r, --random           使用随机密码（密码保存到.password文件）
  -t, --time <时间段>     设置有效时间段（格式: "HH:MM-HH:MM"）
  -o, --output <文件>     指定输出文件名
  -q, --quiet            安静模式（不输出提示信息）
  -h, --help             显示此帮助信息

示例:
  younglock encrypt document.txt
  younglock encrypt -p "mypass" document.txt
  younglock encrypt -r document.txt
  younglock encrypt -t "09:00-17:00" document.txt
)";
}

void show_decrypt_help() {
    std::cout << R"(
解密命令: younglock decrypt [选项] <文件>

选项:
  -t, --temporary       临时解密，文件保持加密状态
  -o, --output <文件>   指定输出文件名
  -q, --quiet           安静模式（不输出提示信息）
  -h, --help            显示此帮助信息

示例:
  younglock decrypt document.txt.lock
  younglock decrypt -t document.txt.lock
)";
}

} // namespace cli
} // namespace younglock
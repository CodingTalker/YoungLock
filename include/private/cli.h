#ifndef YOUNGLOCK_CLI_H
#define YOUNGLOCK_CLI_H
#include <CLI/CLI.hpp>
#include <iostream>
#include <string>

namespace younglock {
namespace cli {

int parse_command_line(int argc, char** argv);
void show_help();
void show_decrypt_help();
void show_encrypt_help();

}
}
#endif
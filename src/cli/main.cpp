#include "cli.h"

int main(int argc, char** argv) {
    return younglock::cli::parse_command_line(argc, argv);
}
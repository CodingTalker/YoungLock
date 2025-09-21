#ifndef YOUNGLOCK_API_H
#define YOUNGLOCK_API_H
#include <string>

namespace younglock{
namespace api{
/**
 * @brief 处理文件加密操作
 *
 * @param file_path 要加密的文件路径
 * @param password 用户指定的密码（如果为空，则需要提示用户输入）
 * @param use_random_password 是否使用随机生成的密码
 * @param time_constraint 时间约束字符串（格式："HH:MM-HH:MM"）
 * @param output_path 输出文件路径（如果为空，则使用默认命名规则）
 * @param quiet_mode 是否启用安静模式（减少输出）
 * @return int 执行结果：0表示成功，非0表示错误
 */
int handle_encrypt(const std::string& file_path,
                  const std::string& password,
                  bool use_random_password,
                  const std::string& time_constraint,
                  const std::string& output_path,
                  bool quiet_mode);

/**
 * @brief 处理文件解密操作
 *
 * @param file_path 要解密的文件路径（通常是加密后的文件）
 * @param temporary_mode 是否为临时解密（解密后文件保持加密状态）
 * @param output_path 输出文件路径（如果为空，则尝试恢复原始文件名）
 * @param quiet_mode 是否启用安静模式（减少输出）
 * @return int 执行结果：0表示成功，非0表示错误
 */
int handle_decrypt(const std::string& file_path,
                  bool temporary_mode,
                  const std::string& output_path,
                  bool quiet_mode);
}
}
#endif
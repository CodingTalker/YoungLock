# YoungLock

分层架构命令行加密工具，支持跨平台和SDK交付。

## 构建
```bash
mkdir build && cd build
cmake ..
make
sudo make install
```

## 交付
- 命令行工具：`younglock`，支持 Windows (.msi)、Linux (.rpm)
- SDK开发包：头文件和库，供开发者集成
- 打包脚本见 `packaging/` 目录

## 使用
```bash
younglock <命令> <文件路径> <参数>
```

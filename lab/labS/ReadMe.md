# ICS_LAB_S

## 实验目的
在已有框架上实现LC-3模拟器

##  汇编器的命令行参数
| 命令行参数 | 说明|
| --- | --- |
| -h  | 显示帮助信息 |
| -f  | 指定`.bin`文件路径 |
| -r  | 指定寄存器文件路径 |
| -s  | 单步运行 |
| -b  | 指定起始地址 |
| -so | 指定输出文件路径 |
| -d  | 输出每步执行后的寄存器等信息|

## 测试

使用`register.txt`初始化所有寄存器，模拟`input.bin`中的程序

```shell
./lc3simulator -f input.bin -r register.txt -d
```
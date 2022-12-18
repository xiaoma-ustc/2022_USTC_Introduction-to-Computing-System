# ICS_LAB_A

## 实验目的

在已有框架上实现LC-3汇编器
##  汇编器的命令行参数
| 命令行参数 | 说明|
| --- | --- |
| -h  | 显示帮助信息 |
| -f  | 指定`.asm`文件路径 |
| -o  | 指定输出`.bin`文件路径 |
| -d  | 输出调试信息 |
| -e  | 输出错误信息 |
| -s  | 使用16进制模式 |
## 实验原理
### LC-3汇编器的汇编过程
- 第一次遍历
  - 对汇编指令进行预处理（包括替换字符，删除注释等）
  - 判断程序是否合法
  - 将LABEL的值存入哈希表
- 第二次遍历 
  -  将对应LABEL替换成相对地址
  -  将`.BLKW` , `.FILL` ,`.STRINGZ`转换为对应机器码
  -  将基本操作转换为对应二进制操作码

## 实验任务

### 第一次遍历
1. 按行格式化`.asm`文件：
   - 去掉注释（去掉每行第一个`;`以及其后的内容
   - 将小写字母转为大写
   - 将`,`用空格替换，用于分割指令
   - 将`\t, \n, \r, \f, \v`等用空格替换
   - 去掉每行指令前后的空白部分
2. 判断程序是否合法
3. 使用哈希表存储 **label** 对应的值

需要填充的内容：
```C++
static inline std::string& Trim(std::string& s)
static std::string FormatLine(const std::string& line)
static int RecognizeNumberValue(const std::string& str)
static std::string NumberToAssemble(const int& number)
static std::string NumberToAssemble(const std::string& bin)
int assembler::firstPass(std::string& input_filename)
```


### 第二次遍历
1. 将对应LABEL替换成相对地址
2. 将`.BLKW` , `.FILL` ,`.STRINGZ`转换为对应机器码
3. 将基本操作转换为对应二进制操作码

需要填充的内容：

```C++
std::string assember::TranslateOprand(unsigned int current_address, std::string str, int opcode_length)
std::string assember::TranslatePseudo(std::stringstream& command_stream)
std::string assembler::TranslateCommand(std::stringstream& command_stream, unsigned int current_address)
```

## 测试

使用`./test/testcases`中的三个`.asm`文件进行测试，与`./test/expected`中的正确结果进行比较，若完全相同，则实验完成。


1. 编译
   ```shell
   make
   ```
2. 生成`.bin`文件
   ```shell
   mkdir /test/actual
   ./assembler -f ./test/testcases/testcase1.asm -o ./test/actual/testcase1.bin
   ```
3. 比较
   ```shell
   diff ./test/actual/testcase1.bin ./test/expected/testcase1.bin
   ```
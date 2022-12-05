/*
 * @Author       : Chivier Humber
 * @Date         : 2021-09-15 21:15:24
 * @LastEditors  : Chivier Humber
 * @LastEditTime : 2021-11-23 16:08:51
 * @Description  : file content
 */

#include "memory.h"
#include "common.h"

namespace virtual_machine_nsp
{
    void memory_tp::ReadMemoryFromFile(std::string filename, int beginning_address)
    {
        // Read from the file
        // TO BE DONE
        std::ifstream file(filename);
        std::string readline;
        int address = beginning_address;
        while(std::getline(file, readline))
        {
            memory[address] = TranslateInstruction(readline);
            ++address;
        }
        return;
    }

    int16_t memory_tp::GetContent(int address) const
    {
        // get the content
        // TO BE DONE
        return memory[address];
    }

    int16_t &memory_tp::operator[](int address)
    {
        // get the content
        // TO BE DONE
        return memory[address];
    }
}; // virtual machine namespace


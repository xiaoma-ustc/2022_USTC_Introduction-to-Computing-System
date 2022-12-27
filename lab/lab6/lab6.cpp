#include <cstdint>
#include <iostream>
#include <fstream>
#define MAXLEN 100
#ifndef LENGTH
#define LENGTH 3
#endif
int16_t lab1(int16_t a, int16_t b)
{
    // initialize
    int16_t ans = 0;
    int16_t judge = 1;
    // calculation
    for (int i = 0; i < b; ++i)
    {
        int16_t temp = a & judge;
        judge += judge;
        if (temp != 0)
        {
            ++ans;
        }
    }
    // return value
    return ans;
}
int16_t lab2(int16_t p, int16_t q, int16_t n)
{
    // initialize
    int16_t num1 = 1;
    int16_t num2 = 1;
    int16_t ans;
    // calculation
    for(int16_t N = n - 1; N > 0; --N)
    {
        int16_t temp1 = (p - 1) & num1;
        int16_t temp2 = num2;
        while(temp2 >= 0)
        {
            temp2 -= q;
        }
        temp2 += q;
        ans = temp1 + temp2;
        num1 = num2;
        num2 = ans;
    }
    // return value
    return ans;
}
int16_t lab3(int16_t n, char s[])
{
    // initialize
    int16_t right = s[0];
    int16_t left = s[0];
    int16_t ans = 1;
    int16_t temp = 1;
    // calculation
    for(int16_t i = 1; i < n; ++i)
    {
        right = s[i];
        if(left == right)   ++temp;
        else
        {
            if(ans < temp)  ans = temp;
            temp = 1;
        }
        left = right;
    }
    if(ans < temp)  ans = temp;
    // return value
    return ans;
}
void lab4(int16_t score[], int16_t *a, int16_t *b)
{
    // initialize
    int16_t numa = 0;
    int16_t numb = 0;
    // calculation
    for(int i = 15; i >= 0; --i)
    {
        int16_t max_index = i;
        for(int j = i - 1; j >= 0; --j)
        {
            if(score[max_index] < score[j]) max_index = j;
        }
        if(i != max_index)
        {
            int16_t temp = score[max_index];
            score[max_index] = score[i];
            score[i] = temp;
        }
        if(score[i] >= 85 && numa < 4)  ++numa;
        else if(score[i] >= 85 && numa + numb < 8)  ++numb;
        else if(score[i] >= 75 && numa + numb < 8)  ++numb;
    }
    *a = numa;
    *b = numb;
    // return value
    return;
}
int main()
{
    std::fstream file;
    file.open("test.txt", std::ios::in);
    if(!file.is_open())
    {
        std::cout<<"file is not opened"<<std::endl;
    }
    // lab1
    int16_t a = 0, b = 0;
    for (int i = 0; i < LENGTH; ++i)
    {
        file >> a >> b;
        std::cout << lab1(a, b) << std::endl;
    }
    // lab2
    int16_t p = 0, q = 0, n = 0;
    for (int i = 0; i < LENGTH; ++i)
    {
        file >> p >> q >> n;
        std::cout << lab2(p, q, n) << std::endl;
    }
    // lab3
    char s[MAXLEN];
    for (int i = 0; i < LENGTH; ++i)
    {
        file >> n >> s;
        std::cout << lab3(n, s) << std::endl;
    }
    // lab4
    int16_t score[16];
    for (int i = 0; i < LENGTH; ++i)
    {
        for (int j = 0; j < 16; ++j)
        {
            file >> score[j];
        }
        lab4(score, &a, &b);
        for (int j = 0; j < 16; ++j)
        {
            std::cout << score[j] << " ";
        }
        std::cout << std::endl << a << " " << b << std::endl;
    }
    file.close();
    return 0;
}
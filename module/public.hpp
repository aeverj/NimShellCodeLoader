#include <Windows.h>
#include <TlHelp32.h>

int APC(char *buf,SIZE_T shellSize);
int Early(char *shellcode,SIZE_T shellcodeSize);
int OEP(char *shellcode,SIZE_T shellcodeSize);
int Thread(char *shellcode,SIZE_T shellcodeSize);
int Direct_Load(char *shellcode,SIZE_T shellcodeSize);
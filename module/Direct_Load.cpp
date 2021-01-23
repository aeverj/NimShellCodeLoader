#include "public.hpp"

int Direct_Load(char *shellcode,SIZE_T shellcodeSize)
{
    LPVOID Memory = VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
	memcpy(Memory, shellcode, shellcodeSize);
	((void(*)())Memory)();
	return 0;
}
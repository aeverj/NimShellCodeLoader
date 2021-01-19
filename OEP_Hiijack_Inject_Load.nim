import public

{.compile: "module\\OEP.cpp".}
proc OEPNim(plainBuffer:cstring,size:cint):cint {.importcpp:"OEP(@)",header:"module\\public.hpp".}

discard OEPNim(code,codelen)

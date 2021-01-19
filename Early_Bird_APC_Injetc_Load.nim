import public

{.compile: "module\\Early_APC.cpp".}
proc EarlyAPCNim(plainBuffer:cstring,size:cint):cint {.importcpp:"Early(@)",header:"module\\public.hpp".}

discard EarlyAPCNim(code,codelen)

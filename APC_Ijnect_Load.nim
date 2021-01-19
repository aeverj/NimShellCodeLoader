import public

{.compile: "module\\APC.cpp".}
proc APCNim(plainBuffer:cstring,size:cint):cint {.importcpp:"APC(@)",header:"module\\public.hpp".}

discard APCNim(code,codelen)

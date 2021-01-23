import public

{.compile: "module\\Direct_Load.cpp".}
proc Direct_LoadNim(plainBuffer:cstring,size:cint):cint {.importcpp:"Direct_Load(@)",header:"module\\public.hpp".}

discard Direct_LoadNim(code,codelen)

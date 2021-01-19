import public

{.compile: "module\\Thread.cpp".}
proc ThreadNim(plainBuffer:cstring,size:cint):cint {.importcpp:"Thread(@)",header:"module\\public.hpp".}

discard ThreadNim(code,codelen)

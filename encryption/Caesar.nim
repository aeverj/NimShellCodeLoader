#[
    compile this with following nim command:
        nim c -d:release -d:strip --opt:size Caesar.nim
]#

import sequtils
import random, os

var dict = toSeq(0..255).mapIt(it.uint8)
randomize()
dict.shuffle()

let entireFile = readFile(paramStr(1)).mapIt(it.uint8)
var finallTable = newSeq[uint8](entireFile.len)
for i in 0..high(entireFile):
    for k in 0..high(dict):
        if entireFile[i] == dict[k]:
            finallTable[i] = k.uint8

# 格式：[字典256字节][加密数据]
let outputData = concat(dict, finallTable)

# 输出到临时文件（使用绝对路径）
let outputFile = getTempDir() / "caesar_encrypted.bin"
var f = open(outputFile, fmWrite)
for b in outputData:
    f.write(b.char)
f.close()

# 输出文件路径到标准输出（供 public.nim 读取）
stdout.write outputFile
stdout.flushFile()

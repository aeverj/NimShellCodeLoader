#[
    compile this with following nim command:
        nim c -d:release -d:strip --opt:size Caesar.nim
]#

import sequtils
import random,os
import strutils

var dict = toSeq(0..255).mapIt(it.uint8)
randomize()
dict.shuffle()

let entireFile = readFile(paramStr(1)).mapIt(it.uint8)
var finallTable = newSeq[uint8](entireFile.len)
for i in 0..high(entireFile):
    for k in 0..high(dict):
        if entireFile[i] == dict[k]:
            finallTable[i] = k.uint8
for i in concat(dict,finallTable):
    stdout.write i.uint8.toHex
stdout.flushFile()
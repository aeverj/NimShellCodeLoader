import sequtils
import random,os
import base64

var dict = toSeq(0..255).mapIt(it.uint8)
randomize()
dict.shuffle()

let entireFile = readFile(paramStr(1)).mapIt(it.uint8)
var finallTable = newSeq[uint8](entireFile.len)
for i in 0..high(entireFile):
    for k in 0..high(dict):
        if entireFile[i] == dict[k]:
            finallTable[i] = k.uint8
let result = encode(concat(dict,finallTable))
echo result
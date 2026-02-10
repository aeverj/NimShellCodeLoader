#!/usr/bin/env nim
## XOR 加密脚本
## 格式: [16字节密钥][加密数据]

import os
import random
import strutils

proc xorEncrypt(data: seq[byte], key: seq[byte]): seq[byte] =
    result = newSeq[byte](data.len)
    for i in 0..<data.len:
        result[i] = data[i] xor key[i mod key.len]

proc main() =
    if paramCount() < 1:
        echo "Usage: Xor.nim <input_file>"
        quit(1)
    
    # 移除可能的引号
    var inputFile = paramStr(1).strip(chars = {'"', ' '})
    
    if not fileExists(inputFile):
        echo "Error: File not found: ", inputFile
        quit(1)
    
    # 读取原始数据
    let shellcode = readFile(inputFile)
    let shellcodeBytes = cast[seq[byte]](shellcode)
    
    # 生成随机16字节密钥
    randomize()
    var key = newSeq[byte](16)
    for i in 0..<16:
        key[i] = byte(rand(255))
    
    # XOR加密
    let encrypted = xorEncrypt(shellcodeBytes, key)
    
    # 组合: [密钥][加密数据]
    var output = newSeq[byte](16 + encrypted.len)
    for i in 0..<16:
        output[i] = key[i]
    for i in 0..<encrypted.len:
        output[16 + i] = encrypted[i]
    
    # 保存到临时文件
    let outputFile = getTempDir() / "xor_encrypted.bin"
    writeFile(outputFile, cast[string](output))
    
    # 输出文件路径（最后一行）
    echo outputFile

when isMainModule:
    main()

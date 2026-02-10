#[
    compile this with following nim command:
        nim c -d:release -d:strip --opt:size Aes256Ctr.nim
]#

import nimcrypto
import nimcrypto/sysrand
import os
import random

func toByteSeq*(str: string): seq[byte] {.inline.} =
  ## Converts a string to the corresponding byte sequence.
  @(str.toOpenArrayByte(0, str.high))

# 读取原始 shellcode 文件
let entireFile = readFile(paramStr(1))
var data: seq[byte] = toByteSeq(entireFile)

# 使用环境变量作为密钥种子（可以改为随机字符串）
var envkey: string = "TARGETDOMAIN"

var
  ectx: CTR[aes256]
  key: array[aes256.sizeKey, byte]
  iv: array[aes256.sizeBlock, byte]
  plaintext = newSeq[byte](len(data))
  enctext = newSeq[byte](len(data))

# 创建随机 IV
discard randomBytes(addr iv[0], 16)

# CTR 模式无需填充，逐字节工作
copyMem(addr plaintext[0], addr data[0], len(data))

# 使用 SHA256 将密钥扩展为 32 字节
var expandedkey = sha256.digest(envkey)
copyMem(addr key[0], addr expandedkey.data[0], len(expandedkey.data))

# 加密
ectx.init(key, iv)
ectx.encrypt(plaintext, enctext)
ectx.clear()

# 格式：[IV 16字节][加密数据]
var outputData = newSeq[byte]()
for i in 0..15:
  outputData.add(iv[i])
for b in enctext:
  outputData.add(b)

# 输出到临时文件（使用绝对路径）
let outputFile = getTempDir() / "aes_encrypted.bin"
var f = open(outputFile, fmWrite)
for b in outputData:
  f.write(b.char)
f.close()

# 输出文件路径到标准输出（供 public.nim 读取）
stdout.write outputFile
stdout.flushFile()

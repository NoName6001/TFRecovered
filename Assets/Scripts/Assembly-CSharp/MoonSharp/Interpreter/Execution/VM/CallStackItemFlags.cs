namespace MoonSharp.Interpreter.Execution.VM
{
	internal enum CallStackItemFlags
	{
		None = 0,
		EntryPoint = 1,
		ResumeEntryPoint = 3,
		CallEntryPoint = 5,
		TailCall = 16,
		MethodCall = 32,
	}
}

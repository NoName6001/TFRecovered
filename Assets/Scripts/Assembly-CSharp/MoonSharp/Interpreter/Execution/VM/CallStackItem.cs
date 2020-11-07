namespace MoonSharp.Interpreter.Execution.VM
{
	internal class CallStackItem
	{
		public int Debug_EntryPoint;
		public int BasePointer;
		public int ReturnAddress;
		public CallStackItemFlags Flags;
	}
}

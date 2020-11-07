using MoonSharp.Interpreter;

namespace MoonSharp.Interpreter.Execution.VM
{
	internal class ExecutionState
	{
		public int InstructionPtr;
		public CoroutineState State;
	}
}

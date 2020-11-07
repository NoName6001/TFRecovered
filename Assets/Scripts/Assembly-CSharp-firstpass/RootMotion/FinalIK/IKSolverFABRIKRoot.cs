using System;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKSolverFABRIKRoot : IKSolver
	{
		public int iterations;
		public float rootPin;
		public FABRIKChain[] chains;
	}
}

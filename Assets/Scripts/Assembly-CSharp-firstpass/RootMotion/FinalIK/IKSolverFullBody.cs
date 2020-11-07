using System;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKSolverFullBody : IKSolver
	{
		public int iterations;
		public FBIKChain[] chain;
		public IKEffector[] effectors;
		public IKMappingSpine spineMapping;
		public IKMappingBone[] boneMappings;
		public IKMappingLimb[] limbMappings;
		public bool FABRIKPass;
	}
}

using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKSolverHeuristic : IKSolver
	{
		public Transform target;
		public float tolerance;
		public int maxIterations;
		public bool useRotationLimits;
		public bool XY;
		public IKSolver.Bone[] bones;
	}
}

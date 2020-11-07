using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKSolverAim : IKSolverHeuristic
	{
		public Transform transform;
		public Vector3 axis;
		public Vector3 poleAxis;
		public Vector3 polePosition;
		public float poleWeight;
		public Transform poleTarget;
		public float clampWeight;
		public int clampSmoothing;
	}
}

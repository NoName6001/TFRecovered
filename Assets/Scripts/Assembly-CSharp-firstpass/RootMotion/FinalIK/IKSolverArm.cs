using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKSolverArm : IKSolver
	{
		public float IKRotationWeight;
		public Quaternion IKRotation;
		public IKSolver.Point chest;
		public IKSolver.Point shoulder;
		public IKSolver.Point upperArm;
		public IKSolver.Point forearm;
		public IKSolver.Point hand;
		public bool isLeft;
		public IKSolverVR.Arm arm;
	}
}

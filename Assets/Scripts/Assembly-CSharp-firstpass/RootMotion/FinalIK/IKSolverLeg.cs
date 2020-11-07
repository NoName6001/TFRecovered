using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKSolverLeg : IKSolver
	{
		public float IKRotationWeight;
		public Quaternion IKRotation;
		public IKSolver.Point pelvis;
		public IKSolver.Point thigh;
		public IKSolver.Point calf;
		public IKSolver.Point foot;
		public IKSolver.Point toe;
		public IKSolverVR.Leg leg;
		public Vector3 heelOffset;
	}
}

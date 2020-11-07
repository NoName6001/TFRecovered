using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKSolverLookAt : IKSolver
	{
		[Serializable]
		public class LookAtBone : IKSolver.Bone
		{
		}

		public Transform target;
		public LookAtBone[] spine;
		public LookAtBone head;
		public LookAtBone[] eyes;
		public float bodyWeight;
		public float headWeight;
		public float eyesWeight;
		public float clampWeight;
		public float clampWeightHead;
		public float clampWeightEyes;
		public int clampSmoothing;
		public AnimationCurve spineWeightCurve;
		public Vector3 spineTargetOffset;
	}
}

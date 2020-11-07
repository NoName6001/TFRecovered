using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	public class VRIK : IK
	{
		[Serializable]
		public class References
		{
			public Transform root;
			public Transform pelvis;
			public Transform spine;
			public Transform chest;
			public Transform neck;
			public Transform head;
			public Transform leftShoulder;
			public Transform leftUpperArm;
			public Transform leftForearm;
			public Transform leftHand;
			public Transform rightShoulder;
			public Transform rightUpperArm;
			public Transform rightForearm;
			public Transform rightHand;
			public Transform leftThigh;
			public Transform leftCalf;
			public Transform leftFoot;
			public Transform leftToes;
			public Transform rightThigh;
			public Transform rightCalf;
			public Transform rightFoot;
			public Transform rightToes;
		}

		public References references;
		public IKSolverVR solver;
	}
}

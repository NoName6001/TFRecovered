using System;
using UnityEngine;

namespace RootMotion
{
	[Serializable]
	public class BipedLimbOrientations
	{
		[Serializable]
		public class LimbOrientation
		{
			public Vector3 upperBoneForwardAxis;
			public Vector3 lowerBoneForwardAxis;
			public Vector3 lastBoneLeftAxis;
		}

		public LimbOrientation leftArm;
		public LimbOrientation rightArm;
		public LimbOrientation leftLeg;
		public LimbOrientation rightLeg;
	}
}

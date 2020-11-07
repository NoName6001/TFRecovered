using UnityEngine;
using System;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class KissingRig : MonoBehaviour
	{
		[Serializable]
		public class Partner
		{
			public FullBodyBipedIK ik;
			public Transform mouth;
			public Transform mouthTarget;
			public Transform touchTargetLeftHand;
			public Transform touchTargetRightHand;
			public float bodyWeightHorizontal;
			public float bodyWeightVertical;
			public float neckRotationWeight;
			public float headTiltAngle;
			public Vector3 headTiltAxis;
		}

		public Partner partner1;
		public Partner partner2;
		public float weight;
		public int iterations;
	}
}

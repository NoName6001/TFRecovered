using UnityEngine;
using System;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class FBBIKSettings : MonoBehaviour
	{
		[Serializable]
		public class Limb
		{
			public FBIKChain.Smoothing reachSmoothing;
			public float maintainRelativePositionWeight;
			public float mappingWeight;
		}

		public FullBodyBipedIK ik;
		public bool disableAfterStart;
		public Limb leftArm;
		public Limb rightArm;
		public Limb leftLeg;
		public Limb rightLeg;
		public float rootPin;
		public bool bodyEffectChildNodes;
	}
}

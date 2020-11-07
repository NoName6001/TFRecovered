using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	public class Recoil : OffsetModifier
	{
		[Serializable]
		public class RecoilOffset
		{
			[Serializable]
			public class EffectorLink
			{
				public FullBodyBipedEffector effector;
				public float weight;
			}

			public Vector3 offset;
			public float additivity;
			public float maxAdditiveOffsetMag;
			public EffectorLink[] effectorLinks;
		}

		public enum Handedness
		{
			Right = 0,
			Left = 1,
		}

		public AimIK aimIK;
		public bool aimIKSolvedLast;
		public Handedness handedness;
		public bool twoHanded;
		public AnimationCurve recoilWeight;
		public float magnitudeRandom;
		public Vector3 rotationRandom;
		public Vector3 handRotationOffset;
		public float blendTime;
		public RecoilOffset[] offsets;
		public Quaternion rotationOffset;
	}
}

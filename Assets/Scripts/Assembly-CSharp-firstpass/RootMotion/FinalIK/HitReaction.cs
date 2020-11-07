using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	public class HitReaction : OffsetModifier
	{
		[Serializable]
		public class HitPoint
		{
			public string name;
			public Collider collider;
			[SerializeField]
			private float crossFadeTime;
		}

		[Serializable]
		public class HitPointEffector : HitPoint
		{
			[Serializable]
			public class EffectorLink
			{
				public FullBodyBipedEffector effector;
				public float weight;
			}

			public AnimationCurve offsetInForceDirection;
			public AnimationCurve offsetInUpDirection;
			public EffectorLink[] effectorLinks;
		}

		[Serializable]
		public class HitPointBone : HitPoint
		{
			[Serializable]
			public class BoneLink
			{
				public Transform bone;
				public float weight;
			}

			public AnimationCurve aroundCenterOfMass;
			public BoneLink[] boneLinks;
		}

		public HitPointEffector[] effectorHitPoints;
		public HitPointBone[] boneHitPoints;
	}
}

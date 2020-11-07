using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	public class Inertia : OffsetModifier
	{
		[Serializable]
		public class Body
		{
			[Serializable]
			public class EffectorLink
			{
				public FullBodyBipedEffector effector;
				public float weight;
			}

			public Transform transform;
			public EffectorLink[] effectorLinks;
			public float speed;
			public float acceleration;
			public float matchVelocity;
			public float gravity;
		}

		public Body[] bodies;
		public OffsetModifier.OffsetLimits[] limits;
	}
}

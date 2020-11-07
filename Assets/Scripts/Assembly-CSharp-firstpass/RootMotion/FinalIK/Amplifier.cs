using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	public class Amplifier : OffsetModifier
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
			public Transform relativeTo;
			public EffectorLink[] effectorLinks;
			public float verticalWeight;
			public float horizontalWeight;
			public float speed;
		}

		public Body[] bodies;
	}
}

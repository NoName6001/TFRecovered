using System;
using UnityEngine;

namespace RootMotion.Dynamics
{
	[Serializable]
	public class SubBehaviourBalancer : SubBehaviourBase
	{
		[Serializable]
		public class Settings
		{
			public float damperForSpring;
			public float maxForceMlp;
			public float IMlp;
			public float velocityF;
			public Vector3 copOffset;
			public float torqueMlp;
			public float maxTorqueMag;
		}

	}
}

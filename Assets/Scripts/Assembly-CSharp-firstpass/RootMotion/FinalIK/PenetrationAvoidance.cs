using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	public class PenetrationAvoidance : OffsetModifier
	{
		[Serializable]
		public class Avoider
		{
			[Serializable]
			public class EffectorLink
			{
				public FullBodyBipedEffector effector;
				public float weight;
			}

			public Transform[] raycastFrom;
			public Transform raycastTo;
			public float raycastRadius;
			public EffectorLink[] effectors;
			public float smoothTimeIn;
			public float smoothTimeOut;
			public LayerMask layers;
		}

		public Avoider[] avoiders;
	}
}

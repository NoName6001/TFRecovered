using UnityEngine;
using System;

namespace RootMotion.FinalIK
{
	public class OffsetPose : MonoBehaviour
	{
		[Serializable]
		public class EffectorLink
		{
			public FullBodyBipedEffector effector;
			public Vector3 offset;
			public Vector3 pin;
			public Vector3 pinWeight;
		}

		public EffectorLink[] effectorLinks;
	}
}

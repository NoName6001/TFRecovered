using UnityEngine;
using System;

namespace RootMotion.FinalIK
{
	public class OffsetModifier : MonoBehaviour
	{
		[Serializable]
		public class OffsetLimits
		{
			public FullBodyBipedEffector effector;
			public float spring;
			public bool x;
			public bool y;
			public bool z;
			public float minX;
			public float maxX;
			public float minY;
			public float maxY;
			public float minZ;
			public float maxZ;
		}

		public float weight;
		public FullBodyBipedIK ik;
	}
}

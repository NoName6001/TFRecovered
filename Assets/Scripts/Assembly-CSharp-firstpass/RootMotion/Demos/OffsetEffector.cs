using RootMotion.FinalIK;
using System;
using UnityEngine;

namespace RootMotion.Demos
{
	public class OffsetEffector : OffsetModifier
	{
		[Serializable]
		public class EffectorLink
		{
			public FullBodyBipedEffector effectorType;
			public float weightMultiplier;
			public Vector3 localPosition;
		}

		public EffectorLink[] effectorLinks;
	}
}

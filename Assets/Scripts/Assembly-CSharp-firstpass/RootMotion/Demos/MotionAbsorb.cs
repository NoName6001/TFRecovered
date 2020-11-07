using RootMotion.FinalIK;
using System;
using UnityEngine;

namespace RootMotion.Demos
{
	public class MotionAbsorb : OffsetModifier
	{
		[Serializable]
		public class Absorber
		{
			public FullBodyBipedEffector effector;
			public float weight;
		}

		public enum Mode
		{
			Position = 0,
			PositionOffset = 1,
		}

		public Mode mode;
		public Absorber[] absorbers;
		public AnimationCurve falloff;
		public float falloffSpeed;
	}
}

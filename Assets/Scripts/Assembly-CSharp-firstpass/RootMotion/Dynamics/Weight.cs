using System;
using UnityEngine;

namespace RootMotion.Dynamics
{
	[Serializable]
	public class Weight
	{
		public enum Mode
		{
			Float = 0,
			Curve = 1,
		}

		public Mode mode;
		public float floatValue;
		public AnimationCurve curve;
		public string tooltip;
	}
}

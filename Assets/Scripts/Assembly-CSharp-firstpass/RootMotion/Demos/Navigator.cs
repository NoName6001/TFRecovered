using System;

namespace RootMotion.Demos
{
	[Serializable]
	public class Navigator
	{
		public bool activeTargetSeeking;
		public float cornerRadius;
		public float recalculateOnPathDistance;
		public float maxSampleDistance;
		public float nextPathInterval;
	}
}

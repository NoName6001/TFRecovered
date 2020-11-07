using System;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class InteractionLookAt
	{
		public LookAtIK ik;
		public float lerpSpeed;
		public float weightSpeed;
		public bool isPaused;
	}
}

using System;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class FABRIKChain
	{
		public FABRIK ik;
		public float pull;
		public float pin;
		public int[] children;
	}
}

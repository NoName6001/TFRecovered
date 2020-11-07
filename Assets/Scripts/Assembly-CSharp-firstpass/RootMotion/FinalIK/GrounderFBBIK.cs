using System;

namespace RootMotion.FinalIK
{
	public class GrounderFBBIK : Grounder
	{
		[Serializable]
		public class SpineEffector
		{
			public FullBodyBipedEffector effectorType;
			public float horizontalWeight;
			public float verticalWeight;
		}

		public FullBodyBipedIK ik;
		public float spineBend;
		public float spineSpeed;
		public SpineEffector[] spine;
	}
}

using RootMotion;
using System;

namespace RootMotion.Dynamics
{
	public class PuppetMasterSettings : Singleton<PuppetMasterSettings>
	{
		[Serializable]
		public class PuppetUpdateLimit
		{
			public int puppetsPerFrame;
		}

		public PuppetUpdateLimit kinematicCollidersUpdateLimit;
		public PuppetUpdateLimit freeUpdateLimit;
		public PuppetUpdateLimit fixedUpdateLimit;
		public bool collisionStayMessages;
		public bool collisionExitMessages;
		public float activePuppetCollisionThresholdMlp;
	}
}

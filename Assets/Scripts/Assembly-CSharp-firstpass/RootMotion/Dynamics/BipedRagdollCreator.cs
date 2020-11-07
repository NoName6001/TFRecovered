using System;

namespace RootMotion.Dynamics
{
	public class BipedRagdollCreator : RagdollCreator
	{
		[Serializable]
		public struct Options
		{
			public float weight;
			public bool spine;
			public bool chest;
			public bool hands;
			public bool feet;
			public RagdollCreator.JointType joints;
			public float jointRange;
			public float colliderLengthOverlap;
			public RagdollCreator.ColliderType torsoColliders;
			public RagdollCreator.ColliderType headCollider;
			public RagdollCreator.ColliderType armColliders;
			public RagdollCreator.ColliderType handColliders;
			public RagdollCreator.ColliderType legColliders;
			public RagdollCreator.ColliderType footColliders;
		}

		public bool canBuild;
		public BipedRagdollReferences references;
		public Options options;
	}
}

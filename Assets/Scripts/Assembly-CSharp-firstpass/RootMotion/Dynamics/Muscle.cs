using System;
using UnityEngine;

namespace RootMotion.Dynamics
{
	[Serializable]
	public class Muscle
	{
		[Serializable]
		public class Props
		{
			public Muscle.Group group;
			public float mappingWeight;
			public float pinWeight;
			public float muscleWeight;
			public float muscleDamper;
			public bool mapPosition;
		}

		public enum Group
		{
			Hips = 0,
			Spine = 1,
			Head = 2,
			Arm = 3,
			Hand = 4,
			Leg = 5,
			Foot = 6,
			Tail = 7,
			Prop = 8,
		}

		public string name;
		public ConfigurableJoint joint;
		public Transform target;
		public Props props;
		public int[] parentIndexes;
		public int[] childIndexes;
		public bool[] childFlags;
		public int[] kinshipDegrees;
		public MuscleCollisionBroadcaster broadcaster;
		public JointBreakBroadcaster jointBreakBroadcaster;
		public Vector3 positionOffset;
		public Vector3 mappedVelocity;
		public Vector3 mappedAngularVelocity;
	}
}

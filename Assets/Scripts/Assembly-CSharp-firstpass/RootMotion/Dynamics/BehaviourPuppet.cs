using System;
using UnityEngine;

namespace RootMotion.Dynamics
{
	public class BehaviourPuppet : BehaviourBase
	{
		[Serializable]
		public class MasterProps
		{
			public BehaviourPuppet.NormalMode normalMode;
			public float mappingBlendSpeed;
			public bool activateOnStaticCollisions;
			public float activateOnImpulse;
		}

		[Serializable]
		public struct CollisionResistanceMultiplier
		{
			public LayerMask layers;
			public float multiplier;
			public float collisionThreshold;
		}

		[Serializable]
		public struct MuscleProps
		{
			public float unpinParents;
			public float unpinChildren;
			public float unpinGroup;
			public float minMappingWeight;
			public float maxMappingWeight;
			public bool disableColliders;
			public float regainPinSpeed;
			public float collisionResistance;
			public float knockOutDistance;
			public PhysicMaterial puppetMaterial;
			public PhysicMaterial unpinnedMaterial;
		}

		[Serializable]
		public struct MusclePropsGroup
		{
			public string name;
			public Muscle.Group[] groups;
			public BehaviourPuppet.MuscleProps props;
		}

		public enum NormalMode
		{
			Active = 0,
			Unmapped = 1,
			Kinematic = 2,
		}

		public MasterProps masterProps;
		public LayerMask groundLayers;
		public LayerMask collisionLayers;
		public float collisionThreshold;
		public Weight collisionResistance;
		public CollisionResistanceMultiplier[] collisionResistanceMultipliers;
		public int maxCollisions;
		public float regainPinSpeed;
		public float boostFalloff;
		public MuscleProps defaults;
		public MusclePropsGroup[] groupOverrides;
		public float knockOutDistance;
		public float unpinnedMuscleWeightMlp;
		public float maxRigidbodyVelocity;
		public float pinWeightThreshold;
		public bool unpinnedMuscleKnockout;
		public bool dropProps;
		public bool canGetUp;
		public float getUpDelay;
		public float blendToAnimationTime;
		public float maxGetUpVelocity;
		public float minGetUpDuration;
		public float getUpCollisionResistanceMlp;
		public float getUpRegainPinSpeedMlp;
		public float getUpKnockOutDistanceMlp;
		public Vector3 getUpOffsetProne;
		public Vector3 getUpOffsetSupine;
		public BehaviourBase.PuppetEvent onGetUpProne;
		public BehaviourBase.PuppetEvent onGetUpSupine;
		public BehaviourBase.PuppetEvent onLoseBalance;
		public BehaviourBase.PuppetEvent onLoseBalanceFromPuppet;
		public BehaviourBase.PuppetEvent onLoseBalanceFromGetUp;
		public BehaviourBase.PuppetEvent onRegainBalance;
		public bool canMoveTarget;
	}
}

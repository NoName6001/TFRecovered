using System;
using UnityEngine;

namespace RootMotion.Dynamics
{
	public class BehaviourAnimatedStagger : BehaviourBase
	{
		[Serializable]
		public struct FallParams
		{
			public float startPinWeightMlp;
			public float startMuscleWeightMlp;
			public float losePinSpeed;
		}

		[Serializable]
		public struct FallParamsGroup
		{
			public Muscle.Group[] groups;
			public BehaviourAnimatedStagger.FallParams fallParams;
		}

		public LayerMask groundLayers;
		public float animationBlendSpeed;
		public float animationMag;
		public float momentumMag;
		public float unbalancedMuscleWeightMlp;
		public float unbalancedMuscleDamperAdd;
		public bool dropProps;
		public float maxGetUpVelocity;
		public float minHipHeight;
		public SubBehaviourCOM centerOfMass;
		public FallParams defaults;
		public FallParamsGroup[] groupOverrides;
		public BehaviourBase.PuppetEvent onUngrounded;
		public BehaviourBase.PuppetEvent onFallOver;
		public BehaviourBase.PuppetEvent onRest;
		public Vector3 moveVector;
		public bool isGrounded;
		public Vector3 forward;
	}
}

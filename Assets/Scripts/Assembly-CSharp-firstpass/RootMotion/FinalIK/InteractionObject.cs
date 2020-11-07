using UnityEngine;
using System;
using UnityEngine.Events;

namespace RootMotion.FinalIK
{
	public class InteractionObject : MonoBehaviour
	{
		[Serializable]
		public class WeightCurve
		{
			public enum Type
			{
				PositionWeight = 0,
				RotationWeight = 1,
				PositionOffsetX = 2,
				PositionOffsetY = 3,
				PositionOffsetZ = 4,
				Pull = 5,
				Reach = 6,
				RotateBoneWeight = 7,
				Push = 8,
				PushParent = 9,
				PoserWeight = 10,
			}

			public Type type;
			public AnimationCurve curve;
		}

		[Serializable]
		public class Multiplier
		{
			public InteractionObject.WeightCurve.Type curve;
			public float multiplier;
			public InteractionObject.WeightCurve.Type result;
		}

		[Serializable]
		public class AnimatorEvent
		{
			public Animator animator;
			public Animation animation;
			public string animationState;
			public float crossfadeTime;
			public int layer;
			public bool resetNormalizedTime;
		}

		[Serializable]
		public class Message
		{
			public string function;
			public GameObject recipient;
		}

		[Serializable]
		public class InteractionEvent
		{
			public float time;
			public bool pause;
			public bool pickUp;
			public InteractionObject.AnimatorEvent[] animations;
			public InteractionObject.Message[] messages;
			public UnityEvent unityEvent;
		}

		public Transform otherLookAtTarget;
		public Transform otherTargetsRoot;
		public Transform positionOffsetSpace;
		public WeightCurve[] weightCurves;
		public Multiplier[] multipliers;
		public InteractionEvent[] events;
	}
}

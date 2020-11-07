using UnityEngine;
using System;

namespace RootMotion.FinalIK
{
	public class InteractionTarget : MonoBehaviour
	{
		[Serializable]
		public class Multiplier
		{
			public InteractionObject.WeightCurve.Type curve;
			public float multiplier;
		}

		public FullBodyBipedEffector effectorType;
		public Multiplier[] multipliers;
		public float interactionSpeedMlp;
		public Transform pivot;
		public Vector3 twistAxis;
		public float twistWeight;
		public float swingWeight;
		public bool rotateOnce;
	}
}

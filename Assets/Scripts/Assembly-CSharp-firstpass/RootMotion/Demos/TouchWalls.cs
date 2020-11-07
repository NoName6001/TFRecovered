using UnityEngine;
using System;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class TouchWalls : MonoBehaviour
	{
		[Serializable]
		public class EffectorLink
		{
			public bool enabled;
			public FullBodyBipedEffector effectorType;
			public InteractionObject interactionObject;
			public Transform spherecastFrom;
			public float spherecastRadius;
			public float minDistance;
			public LayerMask touchLayers;
			public float lerpSpeed;
			public float minSwitchTime;
			public float releaseDistance;
			public bool sliding;
		}

		public InteractionSystem interactionSystem;
		public EffectorLink[] effectorLinks;
	}
}

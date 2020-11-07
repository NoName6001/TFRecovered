using UnityEngine;
using System;

namespace RootMotion.FinalIK
{
	public class InteractionTrigger : MonoBehaviour
	{
		[Serializable]
		public class CharacterPosition
		{
			public bool use;
			public Vector2 offset;
			public float angleOffset;
			public float maxAngle;
			public float radius;
			public bool orbit;
			public bool fixYAxis;
		}

		[Serializable]
		public class CameraPosition
		{
			public Collider lookAtTarget;
			public Vector3 direction;
			public float maxDistance;
			public float maxAngle;
			public bool fixYAxis;
		}

		[Serializable]
		public class Range
		{
			[Serializable]
			public class Interaction
			{
				public InteractionObject interactionObject;
				public FullBodyBipedEffector[] effectors;
			}

			[SerializeField]
			public string name;
			[SerializeField]
			public bool show;
			public InteractionTrigger.CharacterPosition characterPosition;
			public InteractionTrigger.CameraPosition cameraPosition;
			public Interaction[] interactions;
		}

		public Range[] ranges;
	}
}

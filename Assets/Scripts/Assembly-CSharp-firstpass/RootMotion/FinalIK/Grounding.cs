using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class Grounding
	{
		public enum Quality
		{
			Fastest = 0,
			Simple = 1,
			Best = 2,
		}

		public LayerMask layers;
		public float maxStep;
		public float heightOffset;
		public float footSpeed;
		public float footRadius;
		public float footCenterOffset;
		public float prediction;
		public float footRotationWeight;
		public float footRotationSpeed;
		public float maxFootRotationAngle;
		public bool rotateSolver;
		public float pelvisSpeed;
		public float pelvisDamper;
		public float lowerPelvisWeight;
		public float liftPelvisWeight;
		public float rootSphereCastRadius;
		public bool overstepFallsDown;
		public Quality quality;
	}
}

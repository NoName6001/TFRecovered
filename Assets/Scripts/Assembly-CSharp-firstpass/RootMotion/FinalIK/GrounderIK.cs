using UnityEngine;

namespace RootMotion.FinalIK
{
	public class GrounderIK : Grounder
	{
		public IK[] legs;
		public Transform pelvis;
		public Transform characterRoot;
		public float rootRotationWeight;
		public float rootRotationSpeed;
		public float maxRootRotationAngle;
	}
}

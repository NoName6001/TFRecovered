using UnityEngine;

namespace RootMotion.FinalIK
{
	public class GrounderQuadruped : Grounder
	{
		public Grounding forelegSolver;
		public float rootRotationWeight;
		public float minRootRotation;
		public float maxRootRotation;
		public float rootRotationSpeed;
		public float maxLegOffset;
		public float maxForeLegOffset;
		public float maintainHeadRotationWeight;
		public Transform characterRoot;
		public Transform pelvis;
		public Transform lastSpineBone;
		public Transform head;
		public IK[] legs;
		public IK[] forelegs;
		public Vector3 gravity;
	}
}

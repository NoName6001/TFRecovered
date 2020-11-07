using UnityEngine;

namespace RootMotion.FinalIK
{
	public class AimController : MonoBehaviour
	{
		public AimIK ik;
		public float weight;
		public Transform target;
		public float targetSwitchSmoothTime;
		public float weightSmoothTime;
		public bool smoothTurnTowardsTarget;
		public float maxRadiansDelta;
		public float maxMagnitudeDelta;
		public float slerpSpeed;
		public Vector3 pivotOffsetFromRoot;
		public float minDistance;
		public Vector3 offset;
		public float maxRootAngle;
		public bool turnToTarget;
		public float turnToTargetTime;
		public bool useAnimatedAimDirection;
		public Vector3 animatedAimDirection;
	}
}

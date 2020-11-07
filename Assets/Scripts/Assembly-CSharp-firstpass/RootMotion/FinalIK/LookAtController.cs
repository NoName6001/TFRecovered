using UnityEngine;

namespace RootMotion.FinalIK
{
	public class LookAtController : MonoBehaviour
	{
		public LookAtIK ik;
		public Transform target;
		public float weight;
		public Vector3 offset;
		public float targetSwitchSmoothTime;
		public float weightSmoothTime;
		public bool smoothTurnTowardsTarget;
		public float maxRadiansDelta;
		public float maxMagnitudeDelta;
		public float slerpSpeed;
		public Vector3 pivotOffsetFromRoot;
		public float minDistance;
		public float maxRootAngle;
	}
}

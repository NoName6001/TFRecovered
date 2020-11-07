using UnityEngine;

namespace RootMotion.FinalIK
{
	public class RagdollUtility : MonoBehaviour
	{
		public IK ik;
		public float ragdollToAnimationTime;
		public bool applyIkOnRagdoll;
		public float applyVelocity;
		public float applyAngularVelocity;
	}
}

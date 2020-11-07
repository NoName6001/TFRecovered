using UnityEngine;
using RootMotion.Dynamics;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class RagdollAiming : MonoBehaviour
	{
		public PuppetMaster puppetMaster;
		public AimIK aimIKBeforePhysics;
		public Transform target;
		public bool fixAiming;
		public bool fixLeftHand;
		public AimIK aimIKAfterPhysics;
		public LimbIK leftHandIK;
		public Transform leftHandTarget;
	}
}

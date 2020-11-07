using UnityEngine;
using RootMotion.Dynamics;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class AimIKDemo : MonoBehaviour
	{
		public Prop prop;
		public PropRoot connectTo;
		public bool pickUpOnStart;
		public Animator animator;
		public AimIK aimGun;
		public AimIK aimHead;
		public Vector3 animatedAimingDirection;
	}
}

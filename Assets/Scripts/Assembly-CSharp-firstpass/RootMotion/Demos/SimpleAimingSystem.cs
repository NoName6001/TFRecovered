using UnityEngine;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class SimpleAimingSystem : MonoBehaviour
	{
		public AimPoser aimPoser;
		public AimIK aim;
		public LookAtIK lookAt;
		public Animator animator;
		public float crossfadeTime;
		public float minAimDistance;
	}
}

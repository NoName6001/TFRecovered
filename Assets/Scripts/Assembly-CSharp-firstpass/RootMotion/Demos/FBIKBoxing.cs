using UnityEngine;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class FBIKBoxing : MonoBehaviour
	{
		public Transform target;
		public Transform pin;
		public FullBodyBipedIK ik;
		public AimIK aim;
		public float weight;
		public FullBodyBipedEffector effector;
		public AnimationCurve aimWeight;
	}
}

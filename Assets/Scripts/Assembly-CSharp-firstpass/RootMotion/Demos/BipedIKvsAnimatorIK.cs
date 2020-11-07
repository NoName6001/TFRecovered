using UnityEngine;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class BipedIKvsAnimatorIK : MonoBehaviour
	{
		public Animator animator;
		public BipedIK bipedIK;
		public Transform lookAtTargetBiped;
		public Transform lookAtTargetAnimator;
		public float lookAtWeight;
		public float lookAtBodyWeight;
		public float lookAtHeadWeight;
		public float lookAtEyesWeight;
		public float lookAtClampWeight;
		public float lookAtClampWeightHead;
		public float lookAtClampWeightEyes;
		public Transform footTargetBiped;
		public Transform footTargetAnimator;
		public float footPositionWeight;
		public float footRotationWeight;
		public Transform handTargetBiped;
		public Transform handTargetAnimator;
		public float handPositionWeight;
		public float handRotationWeight;
	}
}

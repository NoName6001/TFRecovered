using UnityEngine;

namespace RootMotion.Demos
{
	public class MotionAbsorbCharacter : MonoBehaviour
	{
		public Animator animator;
		public MotionAbsorb motionAbsorb;
		public Transform cube;
		public float cubeRandomPosition;
		public AnimationCurve motionAbsorbWeight;
	}
}

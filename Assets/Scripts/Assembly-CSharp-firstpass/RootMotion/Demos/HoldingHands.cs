using UnityEngine;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class HoldingHands : MonoBehaviour
	{
		public FullBodyBipedIK rightHandChar;
		public FullBodyBipedIK leftHandChar;
		public Transform rightHandTarget;
		public Transform leftHandTarget;
		public float crossFade;
		public float speed;
	}
}

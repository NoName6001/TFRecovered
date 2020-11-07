using UnityEngine;

namespace RootMotion.FinalIK
{
	public class TwistRelaxer : MonoBehaviour
	{
		public IK ik;
		public Transform parent;
		public Transform child;
		public float weight;
		public float parentChildCrossfade;
		public float twistAngleOffset;
	}
}

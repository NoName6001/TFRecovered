using UnityEngine;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class VRIKPlatformController : MonoBehaviour
	{
		public VRIK ik;
		public Transform trackingSpace;
		public Transform platform;
		public bool moveToPlatform;
	}
}

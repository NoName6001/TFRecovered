using UnityEngine;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class VRIKCalibrationController : MonoBehaviour
	{
		public VRIK ik;
		public VRIKCalibrator.Settings settings;
		public Transform headTracker;
		public Transform bodyTracker;
		public Transform leftHandTracker;
		public Transform rightHandTracker;
		public Transform leftFootTracker;
		public Transform rightFootTracker;
		public VRIKCalibrator.CalibrationData data;
	}
}

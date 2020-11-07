using UnityEngine;
using RootMotion.FinalIK;
using RootMotion;

namespace RootMotion.Demos
{
	public class FPSAiming : MonoBehaviour
	{
		public float aimWeight;
		public float sightWeight;
		public float maxAngle;
		public Vector3 aimOffset;
		[SerializeField]
		private bool animatePhysics;
		[SerializeField]
		private Transform gun;
		[SerializeField]
		private Transform gunTarget;
		[SerializeField]
		private FullBodyBipedIK ik;
		[SerializeField]
		private AimIK gunAim;
		[SerializeField]
		private CameraControllerFPS cam;
		[SerializeField]
		private Recoil recoil;
		[SerializeField]
		private float cameraRecoilWeight;
	}
}

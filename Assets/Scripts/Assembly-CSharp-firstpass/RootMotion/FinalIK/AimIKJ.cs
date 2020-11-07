using UnityEngine;

namespace RootMotion.FinalIK
{
	public class AimIKJ : MonoBehaviour
	{
		public Transform target;
		public Transform poleTarget;
		public Transform aimTransform;
		public float axisX;
		public float axisY;
		public float axisZ;
		public float poleAxisX;
		public float poleAxisY;
		public float poleAxisZ;
		public float weight;
		public float poleWeight;
		public float tolerance;
		public int maxIterations;
		public float clampWeight;
		public int clampSmoothing;
		public bool useRotationLimits;
		public bool XY;
		public Transform[] bones;
	}
}

using UnityEngine;

namespace RootMotion.Demos
{
	public class PendulumExample : MonoBehaviour
	{
		public float weight;
		public float hangingDistanceMlp;
		public Vector3 rootTargetPosition;
		public Quaternion rootTargetRotation;
		[SerializeField]
		private Transform target;
		[SerializeField]
		private Transform leftHandTarget;
		[SerializeField]
		private Transform rightHandTarget;
		[SerializeField]
		private Transform leftFootTarget;
		[SerializeField]
		private Transform rightFootTarget;
		[SerializeField]
		private Transform pelvisTarget;
		[SerializeField]
		private Transform bodyTarget;
		[SerializeField]
		private Transform headTarget;
		[SerializeField]
		private Vector3 pelvisDownAxis;
	}
}

using UnityEngine;

namespace RootMotion.Demos
{
	public class MechSpider : MonoBehaviour
	{
		public LayerMask raycastLayers;
		public float scale;
		public Transform body;
		public MechSpiderLeg[] legs;
		public float legRotationWeight;
		public float rootPositionSpeed;
		public float rootRotationSpeed;
		public float breatheSpeed;
		public float breatheMagnitude;
		public float height;
		public float minHeight;
		public float raycastHeight;
		public float raycastDistance;
	}
}

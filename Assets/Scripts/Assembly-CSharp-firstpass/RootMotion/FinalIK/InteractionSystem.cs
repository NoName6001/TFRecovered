using UnityEngine;

namespace RootMotion.FinalIK
{
	public class InteractionSystem : MonoBehaviour
	{
		public string targetTag;
		public float fadeInTime;
		public float speed;
		public float resetToDefaultsSpeed;
		public Collider characterCollider;
		public Transform FPSCamera;
		public LayerMask camRaycastLayers;
		public float camRaycastDistance;
		[SerializeField]
		private FullBodyBipedIK fullBody;
		public InteractionLookAt lookAt;
	}
}

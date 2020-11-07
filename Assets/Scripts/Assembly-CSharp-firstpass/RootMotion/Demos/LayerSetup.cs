using UnityEngine;

namespace RootMotion.Demos
{
	public class LayerSetup : MonoBehaviour
	{
		public Transform characterController;
		public int characterControllerLayer;
		public int ragdollLayer;
		public LayerMask ignoreCollisionWithCharacterController;
		public LayerMask ignoreCollisionWithRagdoll;
	}
}

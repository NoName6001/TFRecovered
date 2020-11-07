using UnityEngine;

namespace RootMotion.Dynamics
{
	public class RagdollEditor : MonoBehaviour
	{
		public enum Mode
		{
			Colliders = 0,
			Joints = 1,
		}

		public Rigidbody selectedRigidbody;
		public Collider selectedCollider;
		public bool symmetry;
		public Mode mode;
	}
}

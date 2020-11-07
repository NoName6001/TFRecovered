using UnityEngine;

namespace RootMotion.Dynamics
{
	public class RagdollCreator : MonoBehaviour
	{
		public enum JointType
		{
			Configurable = 0,
			Character = 1,
		}

		public enum ColliderType
		{
			Box = 0,
			Capsule = 1,
		}

	}
}

using UnityEngine;
using RootMotion;

namespace RootMotion.Demos
{
	public class SimpleLocomotion : MonoBehaviour
	{
		public enum RotationMode
		{
			Smooth = 0,
			Linear = 1,
		}

		[SerializeField]
		private CameraController cameraController;
		[SerializeField]
		private float accelerationTime;
		[SerializeField]
		private float turnTime;
		[SerializeField]
		private bool walkByDefault;
		[SerializeField]
		private RotationMode rotationMode;
		[SerializeField]
		private float moveSpeed;
	}
}

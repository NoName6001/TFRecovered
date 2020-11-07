using UnityEngine;

namespace RootMotion
{
	public class CameraController : MonoBehaviour
	{
		public enum UpdateMode
		{
			Update = 0,
			FixedUpdate = 1,
			LateUpdate = 2,
			FixedLateUpdate = 3,
		}

		public Transform target;
		public Transform rotationSpace;
		public UpdateMode updateMode;
		public bool lockCursor;
		public bool smoothFollow;
		public Vector3 offset;
		public float followSpeed;
		public float rotationSensitivity;
		public float yMinLimit;
		public float yMaxLimit;
		public bool rotateAlways;
		public bool rotateOnLeftButton;
		public bool rotateOnRightButton;
		public bool rotateOnMiddleButton;
		public float distance;
		public float minDistance;
		public float maxDistance;
		public float zoomSpeed;
		public float zoomSensitivity;
		public LayerMask blockingLayers;
		public float blockingRadius;
		public float blockingSmoothTime;
		public float blockedOffset;
	}
}

using UnityEngine;

namespace RootMotion.Demos
{
	public class BoardController : MonoBehaviour
	{
		public int groundLayer;
		public Transform rotationTarget;
		public float torque;
		public float skidDrag;
		public float turnSensitivity;
	}
}

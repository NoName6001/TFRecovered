using UnityEngine;
using System;

namespace RootMotion.FinalIK
{
	public class AimPoser : MonoBehaviour
	{
		[Serializable]
		public class Pose
		{
			public bool visualize;
			public string name;
			public Vector3 direction;
			public float yaw;
			public float pitch;
		}

		public float angleBuffer;
		public Pose[] poses;
	}
}

using UnityEngine;
using System;

namespace RootMotion.Demos
{
	public class Turret : MonoBehaviour
	{
		[Serializable]
		public class Part
		{
			public Transform transform;
		}

		public Transform target;
		public Part[] parts;
	}
}

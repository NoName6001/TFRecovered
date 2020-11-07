using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class Finger
	{
		public enum DOF
		{
			One = 0,
			Three = 1,
		}

		public float weight;
		public float rotationWeight;
		public DOF rotationDOF;
		public Transform bone1;
		public Transform bone2;
		public Transform bone3;
		public Transform tip;
		public Transform target;
	}
}

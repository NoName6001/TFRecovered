using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKConstraintBend
	{
		public Transform bone1;
		public Transform bone2;
		public Transform bone3;
		public Transform bendGoal;
		public Vector3 direction;
		public Quaternion rotationOffset;
		public float weight;
		public Vector3 defaultLocalDirection;
		public Vector3 defaultChildDirection;
	}
}

using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKSolver
	{
		[Serializable]
		public class Point
		{
			public Transform transform;
			public float weight;
			public Vector3 solverPosition;
			public Quaternion solverRotation;
			public Vector3 defaultLocalPosition;
			public Quaternion defaultLocalRotation;
		}

		[Serializable]
		public class Node : Point
		{
			public float length;
			public float effectorPositionWeight;
			public float effectorRotationWeight;
			public Vector3 offset;
		}

		[Serializable]
		public class Bone : Point
		{
			public float length;
			public float sqrMag;
			public Vector3 axis;
		}

		public Vector3 IKPosition;
		public float IKPositionWeight;
		[SerializeField]
		protected Transform root;
	}
}

using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKEffector
	{
		public Transform bone;
		public Transform target;
		public float positionWeight;
		public float rotationWeight;
		public Vector3 position;
		public Quaternion rotation;
		public Vector3 positionOffset;
		public bool effectChildNodes;
		public float maintainRelativePositionWeight;
		public Transform[] childBones;
		public Transform planeBone1;
		public Transform planeBone2;
		public Transform planeBone3;
		public Quaternion planeRotationOffset;
	}
}

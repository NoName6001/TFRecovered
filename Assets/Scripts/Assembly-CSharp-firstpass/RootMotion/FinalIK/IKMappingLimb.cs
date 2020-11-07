using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKMappingLimb : IKMapping
	{
		public Transform parentBone;
		public Transform bone1;
		public Transform bone2;
		public Transform bone3;
		public float maintainRotationWeight;
		public float weight;
	}
}

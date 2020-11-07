using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKMappingSpine : IKMapping
	{
		public Transform[] spineBones;
		public Transform leftUpperArmBone;
		public Transform rightUpperArmBone;
		public Transform leftThighBone;
		public Transform rightThighBone;
		public int iterations;
		public float twistWeight;
	}
}

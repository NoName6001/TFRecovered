using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKMappingBone : IKMapping
	{
		public Transform bone;
		public float maintainRotationWeight;
	}
}

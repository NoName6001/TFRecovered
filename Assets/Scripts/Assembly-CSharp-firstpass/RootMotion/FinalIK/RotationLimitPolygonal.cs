using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	public class RotationLimitPolygonal : RotationLimit
	{
		[Serializable]
		public class LimitPoint
		{
			public Vector3 point;
			public float tangentWeight;
		}

		[Serializable]
		public class ReachCone
		{
			public Vector3[] tetrahedron;
			public float volume;
			public Vector3 S;
			public Vector3 B;
		}

		public float twistLimit;
		public int smoothIterations;
		[SerializeField]
		public LimitPoint[] points;
		[SerializeField]
		public Vector3[] P;
		[SerializeField]
		public ReachCone[] reachCones;
	}
}

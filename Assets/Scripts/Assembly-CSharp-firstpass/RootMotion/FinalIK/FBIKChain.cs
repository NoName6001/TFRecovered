using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class FBIKChain
	{
		[Serializable]
		public class ChildConstraint
		{
			public float pushElasticity;
			public float pullElasticity;
			[SerializeField]
			private Transform bone1;
			[SerializeField]
			private Transform bone2;
		}

		public enum Smoothing
		{
			None = 0,
			Exponential = 1,
			Cubic = 2,
		}

		public float pin;
		public float pull;
		public float push;
		public float pushParent;
		public float reach;
		public Smoothing reachSmoothing;
		public Smoothing pushSmoothing;
		public IKSolver.Node[] nodes;
		public int[] children;
		public ChildConstraint[] childConstraints;
		public IKConstraintBend bendConstraint;
	}
}

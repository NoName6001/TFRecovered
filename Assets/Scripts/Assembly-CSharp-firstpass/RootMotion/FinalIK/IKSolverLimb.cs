using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKSolverLimb : IKSolverTrigonometric
	{
		public enum BendModifier
		{
			Animation = 0,
			Target = 1,
			Parent = 2,
			Arm = 3,
			Goal = 4,
		}

		public AvatarIKGoal goal;
		public BendModifier bendModifier;
		public float maintainRotationWeight;
		public float bendModifierWeight;
		public Transform bendGoal;
	}
}

using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class ConstraintRotationOffset : Constraint
	{
		public Quaternion offset;
	}
}

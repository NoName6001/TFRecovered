using UnityEngine;

namespace RootMotion.FinalIK
{
	public class RotationLimitSpline : RotationLimit
	{
		public float twistLimit;
		[SerializeField]
		public AnimationCurve spline;
	}
}

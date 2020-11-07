using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	public class HitReactionVRIK : OffsetModifierVRIK
	{
		[Serializable]
		public class Offset
		{
			public string name;
			public Collider collider;
			[SerializeField]
			private float crossFadeTime;
		}

		[Serializable]
		public class PositionOffset : Offset
		{
			[Serializable]
			public class PositionOffsetLink
			{
				public IKSolverVR.PositionOffset positionOffset;
				public float weight;
			}

			public int forceDirCurveIndex;
			public int upDirCurveIndex;
			public PositionOffsetLink[] offsetLinks;
		}

		[Serializable]
		public class RotationOffset : Offset
		{
			[Serializable]
			public class RotationOffsetLink
			{
				public IKSolverVR.RotationOffset rotationOffset;
				public float weight;
			}

			public int curveIndex;
			public RotationOffsetLink[] offsetLinks;
		}

		public AnimationCurve[] offsetCurves;
		public PositionOffset[] positionOffsets;
		public RotationOffset[] rotationOffsets;
	}
}

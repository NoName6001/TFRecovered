using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	public class VRIKCalibrator
	{
		[Serializable]
		public class Settings
		{
			public float scaleMlp;
			public Vector3 headTrackerForward;
			public Vector3 headTrackerUp;
			public Vector3 bodyTrackerForward;
			public Vector3 bodyTrackerUp;
			public Vector3 handTrackerForward;
			public Vector3 handTrackerUp;
			public Vector3 footTrackerForward;
			public Vector3 footTrackerUp;
			public Vector3 headOffset;
			public Vector3 handOffset;
			public float footForwardOffset;
			public float footInwardOffset;
			public float footHeadingOffset;
			public float pelvisPositionWeight;
			public float pelvisRotationWeight;
		}

		[Serializable]
		public class CalibrationData
		{
			[Serializable]
			public class Target
			{
				public bool used;
				public Vector3 localPosition;
				public Quaternion localRotation;
			}

			public float scale;
			public Target head;
			public Target leftHand;
			public Target rightHand;
			public Target pelvis;
			public Target leftFoot;
			public Target rightFoot;
			public Target leftLegGoal;
			public Target rightLegGoal;
			public Vector3 pelvisTargetRight;
			public float pelvisPositionWeight;
			public float pelvisRotationWeight;
		}

	}
}

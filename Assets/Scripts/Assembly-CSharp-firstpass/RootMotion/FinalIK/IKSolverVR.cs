using System;
using UnityEngine;
using RootMotion;
using UnityEngine.Events;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKSolverVR : IKSolver
	{
		[Serializable]
		public class VirtualBone
		{
			public Vector3 readPosition;
			public Quaternion readRotation;
			public Vector3 solverPosition;
			public Quaternion solverRotation;
			public float length;
			public float sqrMag;
			public Vector3 axis;
		}

		[Serializable]
		public class BodyPart
		{
			public IKSolverVR.VirtualBone[] bones;
		}

		[Serializable]
		public class Spine : BodyPart
		{
			public Transform headTarget;
			public Transform pelvisTarget;
			public float positionWeight;
			public float rotationWeight;
			public float pelvisPositionWeight;
			public float pelvisRotationWeight;
			public Transform chestGoal;
			public float chestGoalWeight;
			public float minHeadHeight;
			public float bodyPosStiffness;
			public float bodyRotStiffness;
			public float neckStiffness;
			public float rotateChestByHands;
			public float chestClampWeight;
			public float headClampWeight;
			public float moveBodyBackWhenCrouching;
			public float maintainPelvisPosition;
			public float maxRootAngle;
		}

		[Serializable]
		public class Arm : BodyPart
		{
			public enum ShoulderRotationMode
			{
				YawPitch = 0,
				FromTo = 1,
			}

			public Transform target;
			public Transform bendGoal;
			public float positionWeight;
			public float rotationWeight;
			public ShoulderRotationMode shoulderRotationMode;
			public float shoulderRotationWeight;
			public float shoulderTwistWeight;
			public float bendGoalWeight;
			public float swivelOffset;
			public Vector3 wristToPalmAxis;
			public Vector3 palmToThumbAxis;
			public float armLengthMlp;
			public AnimationCurve stretchCurve;
		}

		[Serializable]
		public class Leg : BodyPart
		{
			public Transform target;
			public Transform bendGoal;
			public float positionWeight;
			public float rotationWeight;
			public float bendGoalWeight;
			public float swivelOffset;
			public float bendToTargetWeight;
			public float legLengthMlp;
			public AnimationCurve stretchCurve;
		}

		[Serializable]
		public class Locomotion
		{
			public float weight;
			public float footDistance;
			public float stepThreshold;
			public float angleThreshold;
			public float comAngleMlp;
			public float maxVelocity;
			public float velocityFactor;
			public float maxLegStretch;
			public float rootSpeed;
			public float stepSpeed;
			public AnimationCurve stepHeight;
			public AnimationCurve heelHeight;
			public float relaxLegTwistMinAngle;
			public float relaxLegTwistSpeed;
			public InterpolationMode stepInterpolation;
			public Vector3 offset;
			public bool blockingEnabled;
			public LayerMask blockingLayers;
			public float raycastRadius;
			public float raycastHeight;
			public UnityEvent onLeftFootstep;
			public UnityEvent onRightFootstep;
		}

		public enum PositionOffset
		{
			Pelvis = 0,
			Chest = 1,
			Head = 2,
			LeftHand = 3,
			RightHand = 4,
			LeftFoot = 5,
			RightFoot = 6,
			LeftHeel = 7,
			RightHeel = 8,
		}

		public enum RotationOffset
		{
			Pelvis = 0,
			Chest = 1,
			Head = 2,
		}

		public bool plantFeet;
		public Spine spine;
		public Arm leftArm;
		public Arm rightArm;
		public Leg leftLeg;
		public Leg rightLeg;
		public Locomotion locomotion;
	}
}

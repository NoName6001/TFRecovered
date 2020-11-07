using RootMotion;
using UnityEngine;

namespace RootMotion.Demos
{
	public class CharacterThirdPerson : CharacterBase
	{
		public enum MoveMode
		{
			Directional = 0,
			Strafe = 1,
		}

		public CharacterAnimationBase characterAnimation;
		public UserControlThirdPerson userControl;
		public CameraController cam;
		public MoveMode moveMode;
		public bool smoothPhysics;
		public float smoothAccelerationTime;
		public float linearAccelerationSpeed;
		public float platformFriction;
		public float groundStickyEffect;
		public float maxVerticalVelocityOnGround;
		public float velocityToGroundTangentWeight;
		public bool lookInCameraDirection;
		public float turnSpeed;
		public float stationaryTurnSpeedMlp;
		public float airSpeed;
		public float airControl;
		public float jumpPower;
		public float jumpRepeatDelayTime;
		public bool doubleJumpEnabled;
		public float doubleJumpPowerMlp;
		[SerializeField]
		private LayerMask wallRunLayers;
		public float wallRunMaxLength;
		public float wallRunMinMoveMag;
		public float wallRunMinVelocityY;
		public float wallRunRotationSpeed;
		public float wallRunMaxRotationAngle;
		public float wallRunWeightSpeed;
		public float crouchCapsuleScaleMlp;
	}
}

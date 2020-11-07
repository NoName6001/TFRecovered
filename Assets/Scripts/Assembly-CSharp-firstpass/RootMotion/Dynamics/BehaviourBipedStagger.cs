using UnityEngine;

namespace RootMotion.Dynamics
{
	public class BehaviourBipedStagger : BehaviourBase
	{
		public LayerMask groundLayers;
		public SubBehaviourBalancer.Settings balancerSettings;
		public float maxDuration;
		public float finishTime;
		public float unbalancedMuscleWeightMlp;
		public float minAngle;
		public float maxAngle;
		public float stepHeight;
		public float stepRotationVFactor;
		public float speedMlp;
		public AnimationCurve speedByAngle;
		public AnimationCurve weightByProgress;
		public AnimationCurve stepHeightmlpByProneDot;
		public AnimationCurve minAngleMlpByProneDot;
		public Weight windmillWeight;
		public Weight muscleWeight;
		public Weight windmillSpeed;
		public Weight windmillSpread;
		public Weight windmillRadius;
		public float maintainArmRelativePos;
		public float windmillSyncOffset;
		public Vector3 windmillOffset;
		public float spineMuscleWeightMlp;
		public BehaviourBase.PuppetEvent onActivate;
		public BehaviourBase.PuppetEvent onLoseBalance;
		public BehaviourBase.PuppetEvent onFinished;
	}
}

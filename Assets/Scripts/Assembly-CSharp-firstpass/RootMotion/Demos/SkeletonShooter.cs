using UnityEngine;
using RootMotion.Dynamics;

namespace RootMotion.Demos
{
	public class SkeletonShooter : MonoBehaviour
	{
		public PuppetMaster puppetMaster;
		public Skeleton skeleton;
		public MuscleRemoveMode removeMuscleMode;
		public LayerMask layers;
		public float unpin;
		public float force;
		public ParticleSystem particles;
	}
}

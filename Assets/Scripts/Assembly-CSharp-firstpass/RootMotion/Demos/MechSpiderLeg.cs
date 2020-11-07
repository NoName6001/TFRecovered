using UnityEngine;

namespace RootMotion.Demos
{
	public class MechSpiderLeg : MonoBehaviour
	{
		public MechSpider mechSpider;
		public MechSpiderLeg unSync;
		public Vector3 offset;
		public float minDelay;
		public float maxOffset;
		public float stepSpeed;
		public float footHeight;
		public float velocityPrediction;
		public float raycastFocus;
		public AnimationCurve yOffset;
		public ParticleSystem sand;
	}
}

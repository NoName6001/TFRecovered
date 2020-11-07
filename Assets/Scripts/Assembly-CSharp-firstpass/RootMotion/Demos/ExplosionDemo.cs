using UnityEngine;

namespace RootMotion.Demos
{
	public class ExplosionDemo : MonoBehaviour
	{
		public SimpleLocomotion character;
		public float forceMlp;
		public float upForce;
		public float weightFalloffSpeed;
		public AnimationCurve weightFalloff;
		public AnimationCurve explosionForceByDistance;
		public AnimationCurve scale;
	}
}

using UnityEngine;

namespace RootMotion.Dynamics
{
	public class BehaviourFall : BehaviourBase
	{
		public string stateName;
		public float transitionDuration;
		public int layer;
		public float fixedTime;
		public LayerMask raycastLayers;
		public string blendParameter;
		public float writheHeight;
		public float writheYVelocity;
		public float blendSpeed;
		public float blendMappingSpeed;
		public bool canEnd;
		public float minTime;
		public float maxEndVelocity;
		public BehaviourBase.PuppetEvent onEnd;
	}
}

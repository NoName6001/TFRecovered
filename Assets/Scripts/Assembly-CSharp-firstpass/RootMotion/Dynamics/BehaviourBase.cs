using UnityEngine;
using System;
using UnityEngine.Events;

namespace RootMotion.Dynamics
{
	public class BehaviourBase : MonoBehaviour
	{
		[Serializable]
		public class AnimatorEvent
		{
			public string animationState;
			public float crossfadeTime;
			public int layer;
			public bool resetNormalizedTime;
		}

		[Serializable]
		public struct PuppetEvent
		{
			public string switchToBehaviour;
			public BehaviourBase.AnimatorEvent[] animations;
			public UnityEvent unityEvent;
		}

		public PuppetMaster puppetMaster;
		public bool deactivated;
	}
}

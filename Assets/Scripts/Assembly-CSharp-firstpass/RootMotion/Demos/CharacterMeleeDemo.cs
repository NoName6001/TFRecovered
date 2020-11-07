using System;
using RootMotion.Dynamics;

namespace RootMotion.Demos
{
	public class CharacterMeleeDemo : CharacterPuppet
	{
		[Serializable]
		public class Action
		{
			[Serializable]
			public class Anim
			{
				public string stateName;
				public int layer;
				public float transitionDuration;
				public float fixedTime;
			}

			public string name;
			public int inputActionIndex;
			public float duration;
			public float minFrequency;
			public Anim anim;
			public int[] requiredPropTypes;
			public Booster[] boosters;
		}

		public Action[] actions;
		public int currentActionIndex;
		public float lastActionTime;
	}
}

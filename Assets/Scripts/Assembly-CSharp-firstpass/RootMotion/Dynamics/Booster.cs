using System;
using UnityEngine;

namespace RootMotion.Dynamics
{
	[Serializable]
	public class Booster
	{
		public bool fullBody;
		public ConfigurableJoint[] muscles;
		public Muscle.Group[] groups;
		public float immunity;
		public float impulseMlp;
		public float boostParents;
		public float boostChildren;
		public float delay;
	}
}

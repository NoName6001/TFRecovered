using UnityEngine;

namespace RootMotion.Demos
{
	public class UserControlAI : UserControlThirdPerson
	{
		public Transform moveTarget;
		public float stoppingDistance;
		public float stoppingThreshold;
		public Navigator navigator;
	}
}

using UnityEngine;

namespace RootMotion.Dynamics
{
	public class BehaviourTemplate : BehaviourBase
	{
		public SubBehaviourCOM centerOfMass;
		public LayerMask groundLayers;
		public BehaviourBase.PuppetEvent onLoseBalance;
		public float loseBalanceAngle;
	}
}

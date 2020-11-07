using UnityEngine;
using RootMotion.Dynamics;

namespace RootMotion.Demos
{
	public class FXCollisionBlood : MonoBehaviour
	{
		public BehaviourPuppet puppet;
		public float minCollisionImpulse;
		public int emission;
		public float emissionImpulseAdd;
		public int maxEmission;
	}
}

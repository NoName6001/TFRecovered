using UnityEngine;

namespace RootMotion.Dynamics
{
	public class MuscleCollisionBroadcaster : MonoBehaviour
	{
		[SerializeField]
		public PuppetMaster puppetMaster;
		[SerializeField]
		public int muscleIndex;
	}
}

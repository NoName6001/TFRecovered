using UnityEngine;

namespace RootMotion.Dynamics
{
	public class JointBreakBroadcaster : MonoBehaviour
	{
		[SerializeField]
		public PuppetMaster puppetMaster;
		[SerializeField]
		public int muscleIndex;
	}
}

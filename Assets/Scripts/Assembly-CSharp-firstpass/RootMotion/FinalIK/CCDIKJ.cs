using UnityEngine;

namespace RootMotion.FinalIK
{
	public class CCDIKJ : MonoBehaviour
	{
		public Transform target;
		public float weight;
		public float tolerance;
		public int maxIterations;
		public bool useRotationLimits;
		public bool XY;
		public Transform[] bones;
	}
}

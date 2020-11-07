using UnityEngine;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class TerrainOffset : MonoBehaviour
	{
		public AimIK aimIK;
		public Vector3 raycastOffset;
		public LayerMask raycastLayers;
		public float min;
		public float max;
		public float lerpSpeed;
	}
}

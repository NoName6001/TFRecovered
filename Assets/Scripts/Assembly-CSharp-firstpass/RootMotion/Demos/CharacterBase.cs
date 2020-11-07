using UnityEngine;

namespace RootMotion.Demos
{
	public class CharacterBase : MonoBehaviour
	{
		public Transform gravityTarget;
		[SerializeField]
		protected float gravityMultiplier;
		[SerializeField]
		protected float airborneThreshold;
		[SerializeField]
		private float slopeStartAngle;
		[SerializeField]
		private float slopeEndAngle;
		[SerializeField]
		private float spherecastRadius;
		[SerializeField]
		private LayerMask groundLayers;
	}
}

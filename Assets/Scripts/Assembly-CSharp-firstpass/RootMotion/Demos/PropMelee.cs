using RootMotion.Dynamics;
using UnityEngine;

namespace RootMotion.Demos
{
	public class PropMelee : Prop
	{
		public CapsuleCollider capsuleCollider;
		public BoxCollider boxCollider;
		public float actionColliderRadiusMlp;
		public float actionAdditionalPinWeight;
		public float actionMassMlp;
		public Vector3 COMOffset;
	}
}

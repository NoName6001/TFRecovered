using UnityEngine;

namespace RootMotion.Demos
{
	public class CharacterAnimationSimple : CharacterAnimationBase
	{
		[SerializeField]
		private CharacterThirdPerson characterController;
		[SerializeField]
		private float pivotOffset;
		[SerializeField]
		private AnimationCurve moveSpeed;
	}
}

using UnityEngine;

namespace RootMotion.Demos
{
	public class CharacterAnimationThirdPerson : CharacterAnimationBase
	{
		public CharacterThirdPerson characterController;
		[SerializeField]
		private float turnSensitivity;
		[SerializeField]
		private float turnSpeed;
		[SerializeField]
		private float runCycleLegOffset;
		[SerializeField]
		private float animSpeedMultiplier;
	}
}

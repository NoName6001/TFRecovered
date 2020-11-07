using UnityEngine;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class UserControlInteractions : UserControlThirdPerson
	{
		[SerializeField]
		private CharacterThirdPerson character;
		[SerializeField]
		private InteractionSystem interactionSystem;
		[SerializeField]
		private bool disableInputInInteraction;
		public float enableInputAtProgress;
	}
}

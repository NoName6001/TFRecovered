using UnityEngine;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class PickUp2Handed : MonoBehaviour
	{
		[SerializeField]
		private int GUIspace;
		public InteractionSystem interactionSystem;
		public InteractionObject obj;
		public Transform pivot;
		public Transform holdPoint;
		public float pickUpTime;
	}
}

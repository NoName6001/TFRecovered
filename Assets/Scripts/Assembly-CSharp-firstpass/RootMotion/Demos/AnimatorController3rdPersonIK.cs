using UnityEngine;
using RootMotion.FinalIK;

namespace RootMotion.Demos
{
	public class AnimatorController3rdPersonIK : AnimatorController3rdPerson
	{
		public float headLookWeight;
		public Vector3 gunHoldOffset;
		public Vector3 leftHandOffset;
		public Recoil recoil;
	}
}

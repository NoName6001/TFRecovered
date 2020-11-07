using System;
using UnityEngine;

namespace RootMotion
{
	[Serializable]
	public class BipedReferences
	{
		public Transform root;
		public Transform pelvis;
		public Transform leftThigh;
		public Transform leftCalf;
		public Transform leftFoot;
		public Transform rightThigh;
		public Transform rightCalf;
		public Transform rightFoot;
		public Transform leftUpperArm;
		public Transform leftForearm;
		public Transform leftHand;
		public Transform rightUpperArm;
		public Transform rightForearm;
		public Transform rightHand;
		public Transform head;
		public Transform[] spine;
		public Transform[] eyes;
	}
}

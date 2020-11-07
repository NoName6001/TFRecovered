using UnityEngine;
using System;

namespace RootMotion.FinalIK
{
	public class FBBIKHeadEffector : MonoBehaviour
	{
		[Serializable]
		public class BendBone
		{
			public Transform transform;
			public float weight;
		}

		public FullBodyBipedIK ik;
		public float positionWeight;
		public float bodyWeight;
		public float thighWeight;
		public bool handsPullBody;
		public float rotationWeight;
		public float bodyClampWeight;
		public float headClampWeight;
		public float bendWeight;
		public BendBone[] bendBones;
		public float CCDWeight;
		public float roll;
		public float damper;
		public Transform[] CCDBones;
		public float postStretchWeight;
		public float maxStretch;
		public float stretchDamper;
		public bool fixHead;
		public Transform[] stretchBones;
		public Vector3 chestDirection;
		public float chestDirectionWeight;
		public Transform[] chestBones;
		public float m_test;
	}
}

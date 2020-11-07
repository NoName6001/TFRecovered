using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	[Serializable]
	public class IKSolverFullBodyBiped : IKSolverFullBody
	{
		public Transform rootNode;
		public float spineStiffness;
		public float pullBodyVertical;
		public float pullBodyHorizontal;
		public FBBIKHeadEffector m_headEffector;
	}
}

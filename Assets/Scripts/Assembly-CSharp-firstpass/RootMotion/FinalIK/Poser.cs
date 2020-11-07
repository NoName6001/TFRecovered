using RootMotion;
using UnityEngine;

namespace RootMotion.FinalIK
{
	public class Poser : SolverManager
	{
		public Transform poseRoot;
		public float weight;
		public float localRotationWeight;
		public float localPositionWeight;
	}
}

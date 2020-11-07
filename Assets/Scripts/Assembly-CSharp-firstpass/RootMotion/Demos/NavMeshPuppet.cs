using UnityEngine;
using RootMotion.Dynamics;
using UnityEngine.AI;

namespace RootMotion.Demos
{
	public class NavMeshPuppet : MonoBehaviour
	{
		public BehaviourPuppet puppet;
		public NavMeshAgent agent;
		public Transform target;
		public Animator animator;
	}
}

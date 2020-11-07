using RootMotion.Dynamics;

namespace RootMotion.Demos
{
	public class UserControlAIMelee : UserControlThirdPerson
	{
		public BehaviourPuppet targetPuppet;
		public float stoppingDistance;
		public float stoppingThreshold;
	}
}

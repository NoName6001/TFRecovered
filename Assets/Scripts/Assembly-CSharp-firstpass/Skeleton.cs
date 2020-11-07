using UnityEngine;
using RootMotion.Dynamics;

public class Skeleton : MonoBehaviour
{
	public Animator animator;
	public PuppetMaster puppetMaster;
	public ConfigurableJoint[] leftLeg;
	public ConfigurableJoint[] rightLeg;
}

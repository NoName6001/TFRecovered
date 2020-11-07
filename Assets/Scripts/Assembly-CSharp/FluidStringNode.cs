using UnityEngine;

public class FluidStringNode : MonoBehaviour
{
	public FluidString m_fluidString;
	public ConfigurableJoint m_joint;
	public Rigidbody m_rigidbody;
	public Collider m_collider;
	public Fluid m_followFluid;
	public Vector3 m_velocity;
}

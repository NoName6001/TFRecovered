using UnityEngine;

public class IK_State : MonoBehaviour
{
	public IK m_IK;
	public Transform m_parent;
	public Vector3 m_position;
	public Vector3 m_target;
	public Vector3 m_origin;
	public Vector3 m_aimPoint;
	public float m_lerp;
	public bool m_limitWrap;
	public float m_angleWeight;
	public float m_distance;
	public Vector3 m_angleOffset;
}

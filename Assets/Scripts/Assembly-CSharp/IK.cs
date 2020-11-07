using UnityEngine;
using System.Collections.Generic;

public class IK : MonoBehaviour
{
	public Transform m_bone;
	public IK_State m_rest;
	public IK_State m_enter;
	public IK_State m_final;
	public Transform m_baseIK;
	public Transform m_offsetIK;
	public Transform m_lastOffsetIK;
	public List<IK_State> m_states;
	public float m_speed;
	public Vector2 m_xLimit;
	public Vector2 m_yLimit;
	public Vector2 m_zLimit;
	public float m_angleLimit;
	public bool m_isEye;
	public float m_limbLimit;
	public Transform m_limbStart;
	public ConfigurableJoint m_attachJoint;
	public Transform m_bendBone;
	public Transform m_bendTarget;
	public Vector3 m_bendVectorLS;
	public bool m_snap;
	public bool m_controlled;
}

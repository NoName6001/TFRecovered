using UnityEngine;
using System.Collections.Generic;

public class Fluid : MonoBehaviour
{
	public SphereCollider m_collider;
	public Rigidbody m_rigidbody;
	public Renderer m_renderer;
	public List<FluidSmear> m_smears;
	public float m_size;
	public float m_slideSpeed;
	public bool m_isFirstContact;
	public bool m_isFresh;
	public float m_timer;
	public float m_uvTimer;
	public Transform m_transform;
	public Vector3 m_velocity;
	public bool m_pooled;
}

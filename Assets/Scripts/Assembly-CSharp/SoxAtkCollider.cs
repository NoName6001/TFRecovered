using UnityEngine;

public class SoxAtkCollider : MonoBehaviour
{
	public enum ColliderType
	{
		Sphere = 0,
	}

	public enum Axis
	{
		X = 0,
		Y = 1,
		Z = 2,
	}

	public float m_version;
	public ColliderType m_colliderType;
	public Axis m_referenceAxisOfScale;
	public float m_sphereRadius;
	public float m_sphereRadiusScaled;
	public float m_friction;
	public float m_frictionInverse;
	public Color m_gizmoColor;
	public bool m_showGizmoAtPlay;
	public bool m_showGizmoAtEditor;
}

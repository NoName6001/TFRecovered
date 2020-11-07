using UnityEngine;

public class SoxAtkJiggleBoneSimple : MonoBehaviour
{
	public enum Axis
	{
		X = 0,
		Y = 1,
		Z = 2,
	}

	public enum UpnodeControl
	{
		LookAt = 0,
		AxisAlignment = 1,
	}

	public float m_version;
	public bool m_ifHead;
	public SoxAtkJiggleBoneSimple[] m_tree;
	public float m_targetDistance;
	public bool m_targetFlip;
	public float m_tension;
	public float m_inercia;
	public bool m_upWorld;
	public Transform m_upNode;
	public Axis m_upNodeAxis;
	public UpnodeControl m_upnodeControl;
	public Vector3 m_gravity;
	public SoxAtkCollider[] m_colliders;
	public Transform m_targetRoot;
	public Vector3 m_lookWPos;
	public Vector3 m_beforTargetWPos;
	public bool m_optShowGizmosAtPlaying;
	public bool m_optShowGizmosAtEditor;
	public float m_optGizmoSize;
	public bool m_optShowHiddenNodes;
	public bool m_isControlled;
	public bool m_hierarchyChanged;
}

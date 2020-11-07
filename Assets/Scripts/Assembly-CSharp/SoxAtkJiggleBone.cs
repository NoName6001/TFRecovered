using UnityEngine;

public class SoxAtkJiggleBone : MonoBehaviour
{
	public enum SimType
	{
		Simple = 0,
		KeepDistance = 1,
	}

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
	public SoxAtkJiggleBone[] m_tree;
	public bool m_animated;
	public bool m_autoDisable;
	public SimType m_simType;
	public float m_targetDistance;
	public bool m_targetFlip;
	public float m_tension;
	public float m_inercia;
	public Axis m_lookAxis;
	public bool m_lookAxisFlip;
	public Axis m_sourceUpAxis;
	public bool m_sourceUpAxisFlip;
	public bool m_upWorld;
	public Transform m_upNode;
	public Axis m_upNodeAxis;
	public UpnodeControl m_upnodeControl;
	public Vector3 m_gravity;
	public SoxAtkCollider[] m_colliders;
	public bool m_optShowGizmosAtPlaying;
	public bool m_optShowGizmosAtEditor;
	public float m_optGizmoSize;
	public bool m_optShowHiddenNodes;
	public bool m_hierarchyChanged;
}

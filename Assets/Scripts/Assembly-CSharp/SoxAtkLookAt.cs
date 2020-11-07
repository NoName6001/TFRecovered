using UnityEngine;
using System.Collections.Generic;

public class SoxAtkLookAt : MonoBehaviour
{
	public enum lookType
	{
		Camera = 0,
		Nodes = 1,
	}

	public enum upType
	{
		Camera = 0,
		Node = 1,
		World = 2,
	}

	public enum upCtrType
	{
		LootAt = 0,
		AxisAlignment = 1,
	}

	public enum axisType
	{
		X = 0,
		Y = 1,
		Z = 2,
	}

	public float m_version;
	public bool m_EditorLookAt;
	public lookType m_lookAtType;
	public List<Transform> m_lookAtNodeList;
	public bool m_lookAtFilp;
	public upType m_upAxisType;
	public Transform m_upNode;
	public upCtrType m_upControl;
	public bool m_sourceAxisFilp;
	public axisType m_alignedToUpnodeAxis;
}

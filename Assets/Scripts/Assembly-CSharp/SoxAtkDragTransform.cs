using UnityEngine;
using System;

public class SoxAtkDragTransform : MonoBehaviour
{
	[Serializable]
	public struct DragTransformSet
	{
		public Transform m_sourceObject;
		public Transform m_dragObject;
		public float m_positionTension;
		public float m_rotationTension;
		public Vector3 m_localPosBak;
		public Quaternion m_localRotBak;
		public Vector3 m_posBefore;
		public Quaternion m_rotBefore;
	}

	public float m_version;
	public bool m_equalTension;
	public float m_tensionMultiplier;
	[SerializeField]
	public DragTransformSet[] m_dragSet;
}

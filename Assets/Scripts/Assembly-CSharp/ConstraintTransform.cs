using UnityEngine;

public class ConstraintTransform : MonoBehaviour
{
	public enum ScaleMode
	{
		LocalScale = 0,
		HierarchyScale = 1,
	}

	public float m_version;
	public Transform m_target;
	public ScaleMode scaleMode;
}

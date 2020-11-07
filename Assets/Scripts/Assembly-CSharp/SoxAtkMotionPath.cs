using UnityEngine;

public class SoxAtkMotionPath : MonoBehaviour
{
	public float m_version;
	public bool m_initialized;
	public Animator m_animator;
	public Transform m_motionPathObject;
	public int m_animClipIndex;
	public bool m_autoUpdate;
	public Color m_pathColor;
	public int m_pathStep;
	public Vector3[] m_pathPositions;
	public float m_timeStart;
	public float m_timeEnd;
	public float m_animationSlider;
}

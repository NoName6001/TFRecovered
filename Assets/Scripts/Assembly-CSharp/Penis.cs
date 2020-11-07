using UnityEngine;
using FluffyUnderware.Curvy;
using System.Collections.Generic;

public class Penis : MonoBehaviour
{
	public Girl m_girl;
	public CurvySpline m_spline;
	public List<Transform> m_bones;
	public CurvySplineSegment m_rootIK;
	public CurvySplineSegment m_midIK;
	public CurvySplineSegment m_tipIK;
	public CurvySplineSegment m_tipEnd;
	public AdvancedCollider m_penisCollider;
	public List<Vector2> m_sizes;
	public float m_lerp;
	public Vector2 m_emitRange;
	public Vector2 m_forceRange;
	public Vector2 m_sizeRange;
	public Vector2 m_slideSpdRange;
	public float m_maxRdmAngle;
	public float m_angleUpTime;
	public float m_angleDownTime;
	public float m_maxLength;
	public float m_stopTime;
	public float m_timer;
	public List<Fluid> m_fluids;
	public FluidString m_fString;
	public float m_fStringTime;
}

using UnityEngine;
using FluffyUnderware.Curvy;
using System.Collections.Generic;

public class FluidString : MonoBehaviour
{
	public CurvySpline m_spline;
	public FluidStringNode m_start;
	public FluidStringNode m_mid;
	public FluidStringNode m_end;
	public List<FluidStringNode> m_nodes;
	public int[] m_segments;
	public float m_timer;
	public float m_length;
	public float m_slideSpeed;
	public bool m_canAttach;
	public bool m_canBreak;
	public float m_breakTime;
	public float m_instantDissolveTime;
	public bool isLengthBreak;
	public float m_leakAttachTime;
	public float m_breakLength;
	public float m_weightFactor;
	public float m_maxWeight;
}

using UnityEngine;
using System;
using System.Collections.Generic;

public class SoxAtkTentacle : MonoBehaviour
{
	[Serializable]
	public struct Waveset
	{
		public SoxAtkTentacle.Axis m_rotateAxis;
		public float m_frequency;
		public float m_frequencyProxy;
		public float m_strengthStart;
		public float m_strengthEnd;
		public float m_speed;
		public float m_offset;
		public float[] m_nodesSaveStrengths;
	}

	public enum Axis
	{
		X = 0,
		Y = 1,
		Z = 2,
	}

	public float m_version;
	public bool m_animated;
	public bool m_keepInitialRotation;
	public Transform[] m_nodes;
	public List<SoxAtkJiggleBone> m_jiggleboneHeads;
	public Waveset[] wavesets;
}

using UnityEngine;
using System.Collections.Generic;

namespace FluffyUnderware.Curvy
{
	public class CurvySpline : MonoBehaviour
	{
		public List<CurvySplineSegment> ControlPoints;
		public bool m_AutoEndTangents;
		public float m_AutoHandleDistance;
		public float m_Bias;
		public int m_CacheDensity;
		public bool m_CheckTransform;
		public bool m_Closed;
		public float m_Continuity;
		public Girl m_girl;
		public Color m_GizmoColor;
		public Color m_GizmoSelectionColor;
		public CurvyInterpolation m_Interpolation;
		public CurvyOrientation m_Orientation;
		public bool m_RestrictTo2D;
		public float m_Tension;
		public CurvyUpdateMethod m_UpdateIn;
		public bool m_UsePooling;
		public bool m_UseThreading;
		public bool ShowGizmos;
	}
}

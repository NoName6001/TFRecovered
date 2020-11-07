using UnityEngine;

namespace FluffyUnderware.Curvy
{
	public class CurvySplineSegment : MonoBehaviour
	{
		public bool m_AutoBakeOrientation;
		public float m_AutoHandleDistance;
		public bool m_AutoHandles;
		public bool m_ConnectionSyncPosition;
		public bool m_ConnectionSyncRotation;
		public float m_EndBias;
		public float m_EndContinuity;
		public float m_EndTension;
		public CurvySplineSegment m_FollowUp;
		public ConnectionHeadingEnum m_FollowUpHeading;
		public Girl m_girl;
		public Vector3 m_HandleIn;
		public Vector3 m_HandleOut;
		public bool m_OrientationAnchor;
		public bool m_OverrideGlobalBias;
		public bool m_OverrideGlobalContinuity;
		public bool m_OverrideGlobalTension;
		public float m_StartBias;
		public float m_StartContinuity;
		public float m_StartTension;
		public CurvyOrientationSwirl m_Swirl;
		public float m_SwirlTurns;
		public bool m_SynchronizeTCB;
		public CurvySpline m_spline;
	}
}

using UnityEngine;
using System.Collections.Generic;

public class FaceRig : MonoBehaviour
{
	public Rig m_rig;
	public bool m_active;
	public bool m_reset;
	public bool m_rigging;
	public bool m_offsetActive;
	public bool m_saveDefault;
	public float m_scale;
	public List<FaceControl> controls;
}

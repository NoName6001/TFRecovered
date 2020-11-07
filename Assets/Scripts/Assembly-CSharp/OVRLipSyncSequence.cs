using System;
using UnityEngine;
using System.Collections.Generic;

[Serializable]
public class OVRLipSyncSequence : ScriptableObject
{
	public List<OVRLipSync.Frame> entries;
	public float length;
}

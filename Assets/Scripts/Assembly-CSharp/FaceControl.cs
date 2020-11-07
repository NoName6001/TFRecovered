using System;
using UnityEngine;
using System.Collections.Generic;

[Serializable]
public class FaceControl
{
	public Transform transform;
	public bool saveXWeight;
	public bool saveYWeight;
	public List<FaceBone> bones;
	public Vector3 offset;
	public Vector3 scale;
}

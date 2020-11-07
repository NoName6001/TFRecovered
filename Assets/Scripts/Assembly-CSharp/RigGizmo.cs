using UnityEngine;
using System.Collections.Generic;

public class RigGizmo : MonoBehaviour
{
	public Vector3 center;
	public Vector3 scale;
	public Vector3 rotation;
	public Mesh mesh;
	public List<Vector3> points;
	public Transform connectPoint;
	public Color color;
	public bool active;
}

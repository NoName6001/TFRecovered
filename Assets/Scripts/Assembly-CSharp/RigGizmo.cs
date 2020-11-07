using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200003E RID: 62
public class RigGizmo : MonoBehaviour
{
	// Token: 0x060001D0 RID: 464 RVA: 0x0001037F File Offset: 0x0000E57F
	private void OnDrawGizmos()
	{
		if (!this.active)
		{
			return;
		}
		Gizmos.color = this.color;
		this.DrawStuff();
	}

	// Token: 0x060001D1 RID: 465 RVA: 0x0001039B File Offset: 0x0000E59B
	private void OnDrawGizmosSelected()
	{
		if (!this.active)
		{
			return;
		}
		Gizmos.color = new Color(0f, 0f, 1f, 0.4f);
		this.DrawStuff();
	}

	// Token: 0x060001D2 RID: 466 RVA: 0x000103CC File Offset: 0x0000E5CC
	public void DrawStuff()
	{
		if (this.mesh != null)
		{
			Gizmos.DrawMesh(this.mesh, base.transform.position + base.transform.TransformDirection(this.center), Quaternion.Euler(base.transform.rotation.eulerAngles + this.rotation), this.scale);
		}
		for (int i = 0; i < this.points.Count; i++)
		{
			if (i < this.points.Count - 1)
			{
				Gizmos.DrawLine(base.transform.TransformPoint(this.points[i] * this.scale.x), base.transform.TransformPoint(this.points[i + 1] * this.scale.x));
			}
		}
		if (this.connectPoint != null)
		{
			Gizmos.DrawLine(base.transform.position, this.connectPoint.transform.position);
		}
	}

	// Token: 0x040001A8 RID: 424
	public Vector3 center = Vector3.zero;

	// Token: 0x040001A9 RID: 425
	public Vector3 scale = Vector3.one;

	// Token: 0x040001AA RID: 426
	public Vector3 rotation = Vector3.zero;

	// Token: 0x040001AB RID: 427
	public Mesh mesh;

	// Token: 0x040001AC RID: 428
	public List<Vector3> points = new List<Vector3>();

	// Token: 0x040001AD RID: 429
	public Transform connectPoint;

	// Token: 0x040001AE RID: 430
	public Color color = new Color(0f, 1f, 0f, 0.4f);

	// Token: 0x040001AF RID: 431
	public bool active = true;
}

using System;
using UnityEngine;

// Token: 0x0200004A RID: 74
public class StringHit
{
	// Token: 0x06000250 RID: 592 RVA: 0x00014A09 File Offset: 0x00012C09
	public StringHit(float tf, float dist, TrianglePos triPos, Vector3 point)
	{
		this.tf = tf;
		this.dist = dist;
		this.triPos = triPos;
		this.point = point;
	}

	// Token: 0x0400020F RID: 527
	public float tf;

	// Token: 0x04000210 RID: 528
	public float dist;

	// Token: 0x04000211 RID: 529
	public TrianglePos triPos;

	// Token: 0x04000212 RID: 530
	public Vector3 point;
}

using System;
using UnityEngine;

// Token: 0x02000049 RID: 73
public class StringPos
{
	// Token: 0x0600024E RID: 590 RVA: 0x000149F1 File Offset: 0x00012BF1
	public Vector3 GetWorldPos()
	{
		return this.fluidString.m_spline.Interpolate(this.tf);
	}

	// Token: 0x0400020D RID: 525
	public float tf;

	// Token: 0x0400020E RID: 526
	public FluidString fluidString;
}

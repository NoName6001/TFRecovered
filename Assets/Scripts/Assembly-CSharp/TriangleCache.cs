using System;
using System.Collections.Generic;

// Token: 0x0200002E RID: 46
[Serializable]
public class TriangleCache
{
	// Token: 0x1700001D RID: 29
	// (get) Token: 0x06000142 RID: 322 RVA: 0x0000C701 File Offset: 0x0000A901
	// (set) Token: 0x06000143 RID: 323 RVA: 0x0000C709 File Offset: 0x0000A909
	public RenderMaterial RenderMat { get; set; }

	// Token: 0x06000144 RID: 324 RVA: 0x0000C712 File Offset: 0x0000A912
	public TriangleCache()
	{
		this.triangleIds = new List<int>();
		this.triggers = new List<string>();
	}

	// Token: 0x0400011F RID: 287
	public int subMeshId;

	// Token: 0x04000120 RID: 288
	public List<string> triggers;

	// Token: 0x04000121 RID: 289
	public List<int> triangleIds;
}

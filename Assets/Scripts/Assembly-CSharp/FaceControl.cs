using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000044 RID: 68
[Serializable]
public class FaceControl
{
	// Token: 0x040001D6 RID: 470
	public Transform transform;

	// Token: 0x040001D7 RID: 471
	public bool saveXWeight;

	// Token: 0x040001D8 RID: 472
	public bool saveYWeight;

	// Token: 0x040001D9 RID: 473
	public List<FaceBone> bones;

	// Token: 0x040001DA RID: 474
	public Vector3 offset = Vector3.zero;

	// Token: 0x040001DB RID: 475
	public Vector3 scale = Vector3.zero;
}

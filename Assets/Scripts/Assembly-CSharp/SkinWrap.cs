using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200002F RID: 47
[Serializable]
public class SkinWrap
{
	// Token: 0x04000123 RID: 291
	public string name;

	// Token: 0x04000124 RID: 292
	public List<int> vertexIds;

	// Token: 0x04000125 RID: 293
	public List<Transform> bones;

	// Token: 0x04000126 RID: 294
	public List<List<int>> boneVerts;

	// Token: 0x04000127 RID: 295
	public List<int> triangleIds;

	// Token: 0x04000128 RID: 296
	public List<int> hardVerts;

	// Token: 0x04000129 RID: 297
	public List<bool> isHardVerts;

	// Token: 0x0400012A RID: 298
	public bool noHardVerts;

	// Token: 0x0400012B RID: 299
	public Transform[] boneParents;

	// Token: 0x0400012C RID: 300
	public float[] baseTFs;

	// Token: 0x0400012D RID: 301
	public float[] lastTFs;

	// Token: 0x0400012E RID: 302
	public Vector3[][] lastPoses;

	// Token: 0x0400012F RID: 303
	public Quaternion[] lastRots;

	// Token: 0x04000130 RID: 304
	public float[] wetVertDists;

	// Token: 0x04000131 RID: 305
	public List<int> wetTris;

	// Token: 0x04000132 RID: 306
	public List<float> wetTriDists;

	// Token: 0x04000133 RID: 307
	public float wetFactor;

	// Token: 0x04000134 RID: 308
	public float wetDistance;

	// Token: 0x04000135 RID: 309
	public bool wetStrings;

	// Token: 0x04000136 RID: 310
	public Girl girl;

	// Token: 0x04000137 RID: 311
	public int wrapDepth = 1;

	// Token: 0x04000138 RID: 312
	public float wrapThreshold = 0.1f;

	// Token: 0x04000139 RID: 313
	public float wrapCage = 0.03f;

	// Token: 0x0400013A RID: 314
	public float wrapSaveDistance = 0.01f;

	// Token: 0x0400013B RID: 315
	public float wrapSaveWeight = 0.1f;

	// Token: 0x0400013C RID: 316
	[Space]
	public float maxDistance = 0.02f;

	// Token: 0x0400013D RID: 317
	public float maxPushFactor;

	// Token: 0x0400013E RID: 318
	public float insideMaxDistance = 0.03f;

	// Token: 0x0400013F RID: 319
	public float insidePushFactor = 0.2f;

	// Token: 0x04000140 RID: 320
	public float insidePushSmooth = 0.05f;

	// Token: 0x04000141 RID: 321
	[Space]
	public float maxHolePush = 0.2f;

	// Token: 0x04000142 RID: 322
	public float maxHoleDistance = 0.05f;

	// Token: 0x04000143 RID: 323
	public float maxHolePow = 1f;

	// Token: 0x04000144 RID: 324
	public float holeOffset;
}

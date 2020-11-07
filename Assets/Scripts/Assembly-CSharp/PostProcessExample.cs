using System;
using UnityEngine;

// Token: 0x02000011 RID: 17
[ExecuteInEditMode]
public class PostProcessExample : MonoBehaviour
{
	// Token: 0x06000050 RID: 80 RVA: 0x00003035 File Offset: 0x00001235
	private void Awake()
	{
		if (this.PostProcessMat == null)
		{
			base.enabled = false;
			return;
		}
		this.PostProcessMat.mainTexture = this.PostProcessMat.mainTexture;
	}

	// Token: 0x06000051 RID: 81 RVA: 0x00003063 File Offset: 0x00001263
	private void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
		Graphics.Blit(src, dest, this.PostProcessMat);
	}

	// Token: 0x04000027 RID: 39
	public Material PostProcessMat;
}

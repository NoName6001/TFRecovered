using System;
using UnityEngine;

// Token: 0x0200002B RID: 43
[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
[AddComponentMenu("Image Effects/FXAA")]
public class FXAA : FXAAPostEffectsBase
{
	// Token: 0x0600011A RID: 282 RVA: 0x000085DA File Offset: 0x000067DA
	private void CreateMaterials()
	{
		if (this.mat == null)
		{
			this.mat = base.CheckShaderAndCreateMaterial(this.shader, this.mat);
		}
	}

	// Token: 0x0600011B RID: 283 RVA: 0x00008602 File Offset: 0x00006802
	private void Start()
	{
		this.shader = Shader.Find("Hidden/FXAA3");
		this.CreateMaterials();
		base.CheckSupport(false);
	}

	// Token: 0x0600011C RID: 284 RVA: 0x00008624 File Offset: 0x00006824
	public void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		this.CreateMaterials();
		float num = 1f / (float)Screen.width;
		float num2 = 1f / (float)Screen.height;
		this.mat.SetVector("_rcpFrame", new Vector4(num, num2, 0f, 0f));
		this.mat.SetVector("_rcpFrameOpt", new Vector4(num * 2f, num2 * 2f, num * 0.5f, num2 * 0.5f));
		Graphics.Blit(source, destination, this.mat);
	}

	// Token: 0x040000F9 RID: 249
	private Shader shader;

	// Token: 0x040000FA RID: 250
	private Material mat;
}

using System;
using UnityEngine;

// Token: 0x0200000C RID: 12
[RequireComponent(typeof(Camera))]
[ImageEffectAllowedInSceneView]
[ExecuteInEditMode]
public class Pixelize : MonoBehaviour
{
	// Token: 0x17000011 RID: 17
	// (get) Token: 0x06000039 RID: 57 RVA: 0x00002A88 File Offset: 0x00000C88
	private Shader ScreenAndMaskShader
	{
		get
		{
			if (this._screenAndMaskShader == null)
			{
				this._screenAndMaskShader = Shader.Find("Hidden/PostProcess/Pixelize/ScreenAndMask");
			}
			return this._screenAndMaskShader;
		}
	}

	// Token: 0x17000012 RID: 18
	// (get) Token: 0x0600003A RID: 58 RVA: 0x00002AAE File Offset: 0x00000CAE
	private Material ScreenAndMaskMaterial
	{
		get
		{
			if (this._screenAndMaskMaterial == null)
			{
				this._screenAndMaskMaterial = new Material(this.ScreenAndMaskShader);
			}
			return this._screenAndMaskMaterial;
		}
	}

	// Token: 0x17000013 RID: 19
	// (get) Token: 0x0600003B RID: 59 RVA: 0x00002AD5 File Offset: 0x00000CD5
	private RenderTexture TemporaryRenderTarget
	{
		get
		{
			if (this._temporaryRenderTexture == null)
			{
				this.CreateTemporaryRenderTarget();
			}
			return this._temporaryRenderTexture;
		}
	}

	// Token: 0x17000014 RID: 20
	// (get) Token: 0x0600003C RID: 60 RVA: 0x00002AF1 File Offset: 0x00000CF1
	private Shader CombineLayersShader
	{
		get
		{
			if (this._combineLayersShader == null)
			{
				this._combineLayersShader = Shader.Find("Hidden/PostProcess/Pixelize/CombineLayers");
			}
			return this._combineLayersShader;
		}
	}

	// Token: 0x17000015 RID: 21
	// (get) Token: 0x0600003D RID: 61 RVA: 0x00002B17 File Offset: 0x00000D17
	private Material CombineLayersMaterial
	{
		get
		{
			if (this._combineLayersMaterial == null)
			{
				this._combineLayersMaterial = new Material(this.CombineLayersShader);
			}
			return this._combineLayersMaterial;
		}
	}

	// Token: 0x0600003E RID: 62 RVA: 0x00002B3E File Offset: 0x00000D3E
	private void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
		this.CheckTemporaryRenderTarget();
		Graphics.Blit(src, this.TemporaryRenderTarget, this.ScreenAndMaskMaterial);
		Graphics.Blit(this.TemporaryRenderTarget, dest, this.CombineLayersMaterial);
	}

	// Token: 0x0600003F RID: 63 RVA: 0x00002B6C File Offset: 0x00000D6C
	private void CreateTemporaryRenderTarget()
	{
		this._temporaryRenderTexture = new RenderTexture(Screen.width, Screen.height, 0, RenderTextureFormat.Default, RenderTextureReadWrite.Linear);
		this._temporaryRenderTexture.useMipMap = true;
		this._temporaryRenderTexture.autoGenerateMips = true;
		this._temporaryRenderTexture.wrapMode = TextureWrapMode.Clamp;
		this._temporaryRenderTexture.filterMode = FilterMode.Point;
		this._temporaryRenderTexture.Create();
	}

	// Token: 0x06000040 RID: 64 RVA: 0x00002BCD File Offset: 0x00000DCD
	private void CheckTemporaryRenderTarget()
	{
		if (this.TemporaryRenderTarget.width != Screen.width || this.TemporaryRenderTarget.width != Screen.height)
		{
			this.ReleaseTemporaryRenderTarget();
		}
	}

	// Token: 0x06000041 RID: 65 RVA: 0x00002BF9 File Offset: 0x00000DF9
	private void ReleaseTemporaryRenderTarget()
	{
		this._temporaryRenderTexture.Release();
		this._temporaryRenderTexture = null;
	}

	// Token: 0x04000011 RID: 17
	private Shader _screenAndMaskShader;

	// Token: 0x04000012 RID: 18
	private Material _screenAndMaskMaterial;

	// Token: 0x04000013 RID: 19
	private RenderTexture _temporaryRenderTexture;

	// Token: 0x04000014 RID: 20
	private Shader _combineLayersShader;

	// Token: 0x04000015 RID: 21
	private Material _combineLayersMaterial;
}

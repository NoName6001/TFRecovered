using System;
using MoonSharp.Interpreter;
using UnityEngine;
using UnityEngine.Rendering;

// Token: 0x02000035 RID: 53
[MoonSharpUserData]
public class FluidRenderer : MonoBehaviour
{
	// Token: 0x06000182 RID: 386 RVA: 0x0000DDE9 File Offset: 0x0000BFE9
	private void Awake()
	{
		this.currentCam = base.GetComponent<Camera>();
	}

	// Token: 0x06000183 RID: 387 RVA: 0x0000DDF7 File Offset: 0x0000BFF7
	public void OnEnable()
	{
		base.GetComponent<Camera>().forceIntoRenderTexture = true;
		this.DestroyCommandBuffer();
		this.Cleanup();
	}

	// Token: 0x06000184 RID: 388 RVA: 0x0000DE11 File Offset: 0x0000C011
	public void OnDisable()
	{
		this.DestroyCommandBuffer();
		this.Cleanup();
	}

	// Token: 0x06000185 RID: 389 RVA: 0x0000DE1F File Offset: 0x0000C01F
	protected Material CreateMaterial(Shader shader)
	{
		if (!shader || !shader.isSupported)
		{
			return null;
		}
		return new Material(shader)
		{
			hideFlags = HideFlags.HideAndDontSave
		};
	}

	// Token: 0x06000186 RID: 390 RVA: 0x0000DE44 File Offset: 0x0000C044
	public void SetColor(Color color)
	{
		this.fluidMaterial.SetColor("_CloudinessColor", color);
		ParticleRenderer[] array = this.particleRenderers;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].particleColor = color;
		}
	}

	// Token: 0x06000187 RID: 391 RVA: 0x0000DE80 File Offset: 0x0000C080
	private void DestroyCommandBuffer()
	{
		if (this.renderFluid != null)
		{
			base.GetComponent<Camera>().RemoveCommandBuffer(this.cameraEvent, this.renderFluid);
			this.renderFluid = null;
		}
	}

	// Token: 0x06000188 RID: 392 RVA: 0x0000DEA8 File Offset: 0x0000C0A8
	private void OnPreRender()
	{
		if (!base.gameObject.activeInHierarchy || !base.enabled || this.particleRenderers == null || this.particleRenderers.Length == 0)
		{
			this.DestroyCommandBuffer();
			this.Cleanup();
			return;
		}
		this.Setup();
		if (this.renderFluid == null)
		{
			this.renderFluid = new CommandBuffer();
			this.renderFluid.name = "Render fluid";
			this.UpdateFluidRenderingCommandBuffer();
			this.currentCam.AddCommandBuffer(this.cameraEvent, this.renderFluid);
			return;
		}
		if (this.autoupdate)
		{
			this.UpdateFluidRenderingCommandBuffer();
		}
	}

	// Token: 0x06000189 RID: 393 RVA: 0x0000DF40 File Offset: 0x0000C140
	protected void Setup()
	{
		base.GetComponent<Camera>().depthTextureMode |= DepthTextureMode.Depth;
		if (this.depth_BlurMaterial == null)
		{
			this.depth_BlurMaterial = this.CreateMaterial(Shader.Find("Hidden/ScreenSpaceCurvatureFlow"));
		}
		if (this.normal_ReconstructMaterial == null)
		{
			this.normal_ReconstructMaterial = this.CreateMaterial(Shader.Find("Hidden/NormalReconstruction"));
		}
		if (this.thickness_Material == null)
		{
			this.thickness_Material = this.CreateMaterial(Shader.Find("Hidden/FluidThickness"));
		}
		if (!this.depth_BlurMaterial || !this.normal_ReconstructMaterial || !this.thickness_Material || !SystemInfo.supportsImageEffects || !SystemInfo.SupportsRenderTextureFormat(RenderTextureFormat.Depth) || !SystemInfo.SupportsRenderTextureFormat(RenderTextureFormat.RFloat) || !SystemInfo.SupportsRenderTextureFormat(RenderTextureFormat.ARGBHalf))
		{
			base.enabled = false;
			Debug.LogWarning("Obi Fluid Renderer not supported in this platform.");
			return;
		}
		Shader.SetGlobalMatrix("_Camera_to_World", this.currentCam.cameraToWorldMatrix);
		Shader.SetGlobalMatrix("_World_to_Camera", this.currentCam.worldToCameraMatrix);
		Shader.SetGlobalMatrix("_InvProj", this.currentCam.projectionMatrix.inverse);
		float fieldOfView = this.currentCam.fieldOfView;
		float farClipPlane = this.currentCam.farClipPlane;
		float num = this.currentCam.orthographic ? (2f * this.currentCam.orthographicSize) : (2f * Mathf.Tan(fieldOfView * 0.0174532924f * 0.5f) * farClipPlane);
		float x = num * this.currentCam.aspect;
		Shader.SetGlobalVector("_FarCorner", new Vector3(x, num, farClipPlane));
		this.depth_BlurMaterial.SetFloat("_BlurScale", this.currentCam.orthographic ? 1f : ((float)this.currentCam.pixelWidth / this.currentCam.aspect * (1f / Mathf.Tan(fieldOfView * 0.0174532924f * 0.5f))));
		this.depth_BlurMaterial.SetFloat("_BlurRadiusWorldspace", this.blurRadius);
		if (this.fluidMaterial != null)
		{
			this.fluidMaterial.SetFloat("_ThicknessCutoff", this.thicknessCutoff);
		}
	}

	// Token: 0x0600018A RID: 394 RVA: 0x0000E178 File Offset: 0x0000C378
	protected void Cleanup()
	{
		if (this.depth_BlurMaterial != null)
		{
			DestroyImmediate(this.depth_BlurMaterial);
		}
		if (this.normal_ReconstructMaterial != null)
		{
			DestroyImmediate(this.normal_ReconstructMaterial);
		}
		if (this.thickness_Material != null)
		{
			DestroyImmediate(this.thickness_Material);
		}
	}

	// Token: 0x0600018B RID: 395 RVA: 0x0000E1D0 File Offset: 0x0000C3D0
	public void UpdateFluidRenderingCommandBuffer()
	{
		this.renderFluid.Clear();
		if (this.particleRenderers == null || this.fluidMaterial == null)
		{
			return;
		}
		int nameID = Shader.PropertyToID("_Refraction");
		int nameID2 = Shader.PropertyToID("_FluidDepthTexture");
		int nameID3 = Shader.PropertyToID("_FluidThickness1");
		int nameID4 = Shader.PropertyToID("_FluidThickness2");
		int nameID5 = Shader.PropertyToID("_FluidThickness3");
		int nameID6 = Shader.PropertyToID("_FluidSurface");
		int nameID7 = Shader.PropertyToID("_FluidNormals");
		int fluidRenderTextureSize = Game.Instance.m_fluidRenderTextureSize;
		this.renderFluid.GetTemporaryRT(nameID, fluidRenderTextureSize, fluidRenderTextureSize, 0, FilterMode.Bilinear);
		this.renderFluid.GetTemporaryRT(nameID2, fluidRenderTextureSize, fluidRenderTextureSize, 24, FilterMode.Point, RenderTextureFormat.Depth);
		this.renderFluid.GetTemporaryRT(nameID3, 0, 0, 0, FilterMode.Bilinear, RenderTextureFormat.ARGBHalf);
		this.renderFluid.GetTemporaryRT(nameID4, fluidRenderTextureSize - 1, fluidRenderTextureSize - 1, 0, FilterMode.Bilinear, RenderTextureFormat.ARGBHalf);
		this.renderFluid.GetTemporaryRT(nameID5, fluidRenderTextureSize - 1, fluidRenderTextureSize - 1, 0, FilterMode.Bilinear, RenderTextureFormat.ARGBHalf);
		this.renderFluid.GetTemporaryRT(nameID6, fluidRenderTextureSize, fluidRenderTextureSize, 0, FilterMode.Point, RenderTextureFormat.RFloat);
		this.renderFluid.GetTemporaryRT(nameID7, fluidRenderTextureSize, fluidRenderTextureSize, 0, FilterMode.Bilinear, RenderTextureFormat.ARGBHalf);
		this.renderFluid.Blit(BuiltinRenderTextureType.CurrentActive, nameID);
		this.renderFluid.SetRenderTarget(nameID3, BuiltinRenderTextureType.Depth);
		this.renderFluid.ClearRenderTarget(false, true, this.thicknessBufferClear);
		foreach (ParticleRenderer particleRenderer in this.particleRenderers)
		{
			if (particleRenderer != null)
			{
				this.renderFluid.SetGlobalColor("_ParticleColor", particleRenderer.particleColor);
				this.renderFluid.SetGlobalFloat("_RadiusScale", particleRenderer.radiusScale);
				this.renderFluid.DrawMesh(particleRenderer.mesh, Matrix4x4.identity, this.thickness_Material, 0, 0);
				this.renderFluid.DrawMesh(particleRenderer.mesh, Matrix4x4.identity, this.colorMaterial, 0, 0);
			}
		}
		this.renderFluid.Blit(nameID3, nameID4, this.thickness_Material, 1);
		this.renderFluid.Blit(nameID4, nameID5, this.thickness_Material, 2);
		this.renderFluid.SetRenderTarget(nameID2);
		this.renderFluid.ClearRenderTarget(true, true, Color.clear);
		foreach (ParticleRenderer particleRenderer2 in this.particleRenderers)
		{
			if (particleRenderer2 != null && particleRenderer2.ParticleMaterial != null)
			{
				this.renderFluid.DrawMesh(particleRenderer2.mesh, Matrix4x4.identity, particleRenderer2.ParticleMaterial, 0, 0);
			}
		}
		this.renderFluid.Blit(nameID2, nameID6, this.depth_BlurMaterial);
		this.renderFluid.Blit(nameID6, nameID7, this.normal_ReconstructMaterial);
		this.renderFluid.SetGlobalTexture("_FluidDepth", nameID2);
		this.renderFluid.SetGlobalTexture("_Refraction", nameID);
		this.renderFluid.SetGlobalTexture("_Thickness", nameID5);
		this.renderFluid.SetGlobalTexture("_Normals", nameID7);
		this.renderFluid.Blit(nameID6, BuiltinRenderTextureType.CameraTarget, this.fluidMaterial);
		this.renderFluid.ReleaseTemporaryRT(nameID2);
	}

	// Token: 0x0400015E RID: 350
	public float blurRadius = 0.02f;

	// Token: 0x0400015F RID: 351
	[Range(0.01f, 2f)]
	public float thicknessCutoff = 1.2f;

	// Token: 0x04000160 RID: 352
	private Material depth_BlurMaterial;

	// Token: 0x04000161 RID: 353
	private Material normal_ReconstructMaterial;

	// Token: 0x04000162 RID: 354
	private Material thickness_Material;

	// Token: 0x04000163 RID: 355
	private Color thicknessBufferClear = new Color(1f, 1f, 1f, 0f);

	// Token: 0x04000164 RID: 356
	public Material colorMaterial;

	// Token: 0x04000165 RID: 357
	public Material fluidMaterial;

	// Token: 0x04000166 RID: 358
	public ParticleRenderer[] particleRenderers;

	// Token: 0x04000167 RID: 359
	public bool autoupdate = true;

	// Token: 0x04000168 RID: 360
	protected CommandBuffer renderFluid;

	// Token: 0x04000169 RID: 361
	protected Camera currentCam;

	// Token: 0x0400016A RID: 362
	public CameraEvent cameraEvent = CameraEvent.BeforeImageEffectsOpaque;
}

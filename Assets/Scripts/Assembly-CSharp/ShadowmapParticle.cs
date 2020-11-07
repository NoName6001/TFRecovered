using System;
using UnityEngine;
using UnityEngine.Rendering;

// Token: 0x0200003F RID: 63
public class ShadowmapParticle : MonoBehaviour
{
	// Token: 0x060001D4 RID: 468 RVA: 0x0001054D File Offset: 0x0000E74D
	public void Awake()
	{
		this.unityLight = base.GetComponent<Light>();
	}

	// Token: 0x060001D5 RID: 469 RVA: 0x0001055B File Offset: 0x0000E75B
	public void OnEnable()
	{
		this.Cleanup();
		this.afterShadow = new CommandBuffer();
		this.afterShadow.name = "FluidShadows";
		this.unityLight.AddCommandBuffer(LightEvent.AfterShadowMapPass, this.afterShadow);
	}

	// Token: 0x060001D6 RID: 470 RVA: 0x00010590 File Offset: 0x0000E790
	public void OnDisable()
	{
		this.Cleanup();
	}

	// Token: 0x060001D7 RID: 471 RVA: 0x00010598 File Offset: 0x0000E798
	private void Cleanup()
	{
		if (this.afterShadow != null)
		{
			this.unityLight.RemoveCommandBuffer(LightEvent.AfterShadowMapPass, this.afterShadow);
			this.afterShadow = null;
		}
	}

	// Token: 0x060001D8 RID: 472 RVA: 0x000105BC File Offset: 0x0000E7BC
	public void SetupFluidShadowsCommandBuffer()
	{
		this.afterShadow.Clear();
		if (this.particleRenderers == null)
		{
			return;
		}
		foreach (ParticleRenderer particleRenderer in this.particleRenderers)
		{
			if (particleRenderer != null)
			{
				this.afterShadow.DrawMesh(particleRenderer.mesh, Matrix4x4.identity, particleRenderer.ParticleMaterial, 0, 1);
			}
		}
		this.afterShadow.SetGlobalTexture("_MyShadowMap", new RenderTargetIdentifier(BuiltinRenderTextureType.CurrentActive));
	}

	// Token: 0x060001D9 RID: 473 RVA: 0x00010633 File Offset: 0x0000E833
	private void Update()
	{
		if (!base.gameObject.activeInHierarchy || !base.enabled || this.particleRenderers == null || this.particleRenderers.Length == 0)
		{
			this.Cleanup();
			return;
		}
		if (this.afterShadow != null)
		{
			this.SetupFluidShadowsCommandBuffer();
		}
	}

	// Token: 0x040001B0 RID: 432
	private Light unityLight;

	// Token: 0x040001B1 RID: 433
	private CommandBuffer afterShadow;

	// Token: 0x040001B2 RID: 434
	public ParticleRenderer[] particleRenderers;
}

using System;
using UnityEngine;

// Token: 0x0200003D RID: 61
public struct UV_DrawCommand
{
	// Token: 0x060001CF RID: 463 RVA: 0x00010324 File Offset: 0x0000E524
	public UV_DrawCommand(Vector2 uv, Color color, float scale, Material material)
	{
		this.uv = uv;
		this.color = color;
		this.scale = scale;
		this.material = ((material != null) ? material : Game.Instance.defaultParticleUV);
		this.index = (int)(uv.x * (float)Game.m_uvTextureRows + uv.y);
	}

	// Token: 0x040001A3 RID: 419
	public Vector2 uv;

	// Token: 0x040001A4 RID: 420
	public Color color;

	// Token: 0x040001A5 RID: 421
	public float scale;

	// Token: 0x040001A6 RID: 422
	public Material material;

	// Token: 0x040001A7 RID: 423
	public int index;
}

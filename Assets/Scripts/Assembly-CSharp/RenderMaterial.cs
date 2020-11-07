using System;
using System.Collections.Generic;
using MoonSharp.Interpreter;
using UnityEngine;

// Token: 0x0200003B RID: 59
[MoonSharpUserData]
[Serializable]
public class RenderMaterial
{
	// Token: 0x060001C7 RID: 455 RVA: 0x0000FF84 File Offset: 0x0000E184
	public void Init()
	{
		List<bool> list = new List<bool>
		{
			this.m_isWet,
			this.m_isColored
		};
		List<string> list2 = new List<string>
		{
			"_WetnessRT",
			"_ColorRT"
		};
		this.m_textures = new RenderMatTexture[list.Count];
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i])
			{
				RenderMatTexture renderMatTexture = new RenderMatTexture();
				this.material.SetTexture(Shader.PropertyToID(list2[i]), renderMatTexture.Init(this));
				this.m_textures[i] = renderMatTexture;
			}
		}
	}

	// Token: 0x060001C8 RID: 456 RVA: 0x00010023 File Offset: 0x0000E223
	public void DrawUV(int textureId, Color color, Vector2 uv, float scale = 1f, Material mat = null)
	{
		if (this.m_textures != null && textureId < this.m_textures.Length && this.m_textures[textureId] != null)
		{
			this.m_textures[textureId].AddDrawCommand(color, uv, scale, mat);
		}
	}

	// Token: 0x060001C9 RID: 457 RVA: 0x00010058 File Offset: 0x0000E258
	public void AddTextureToStack(List<RenderMatTexture> renderStack)
	{
		foreach (RenderMatTexture renderMatTexture in this.m_textures)
		{
			if (renderMatTexture != null && renderMatTexture.m_needRender && !renderStack.Contains(renderMatTexture))
			{
				renderStack.Add(renderMatTexture);
			}
		}
	}

	// Token: 0x0400019A RID: 410
	public Material material;

	// Token: 0x0400019B RID: 411
	public float scale = 1f;

	// Token: 0x0400019C RID: 412
	public bool m_isWet = true;

	// Token: 0x0400019D RID: 413
	public bool m_isColored;

	// Token: 0x0400019E RID: 414
	public RenderMatTexture[] m_textures;
}

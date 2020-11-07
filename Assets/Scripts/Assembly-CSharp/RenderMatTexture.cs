using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200003C RID: 60
public class RenderMatTexture
{
	// Token: 0x060001CB RID: 459 RVA: 0x000100B4 File Offset: 0x0000E2B4
	public RenderTexture Init(RenderMaterial renderMat)
	{
		this.m_renderMat = renderMat;
		this.m_colorTex = new RenderTexture(Game.Instance.renderTextureSize, Game.Instance.renderTextureSize, 0, RenderTextureFormat.ARGB32)
		{
			wrapMode = TextureWrapMode.Repeat
		};
		this.m_colorTex.Create();
		return this.m_colorTex;
	}

	// Token: 0x060001CC RID: 460 RVA: 0x00010104 File Offset: 0x0000E304
	public void Render(Camera cam)
	{
		List<UV_DrawCommand> list = new List<UV_DrawCommand>();
		for (int i = 0; i < this.m_drawCommands.Count; i++)
		{
			UV_DrawCommand uv_DrawCommand = this.m_drawCommands[i];
			if (!Game.Instance.m_hasUVFluid[uv_DrawCommand.index])
			{
				Game.Instance.m_hasUVFluid[uv_DrawCommand.index] = true;
				list.Add(uv_DrawCommand);
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			UV_DrawCommand uv_DrawCommand2 = list[j];
			Fluid_UV fluid_UV = Game.Instance.m_uvFluidPool[j];
			fluid_UV.m_transform.localPosition = new Vector3(uv_DrawCommand2.uv.x - 0.5f, Mathf.Lerp(-0.5f, 0.5f, uv_DrawCommand2.uv.y), 0f);
			fluid_UV.m_transform.localScale = new Vector3(0.01f, 0.01f, 0.01f) * uv_DrawCommand2.scale * this.m_renderMat.scale;
			fluid_UV.m_sprite.color = uv_DrawCommand2.color;
		}
		cam.SetTargetBuffers(this.m_colorTex.colorBuffer, Game.Instance.m_depthTexture.depthBuffer);
		cam.Render();
		for (int k = 0; k < list.Count; k++)
		{
			Game.Instance.m_uvFluidPool[k].m_transform.localPosition = new Vector3(0f, 0f, -10f);
		}
		this.m_drawCommands = new List<UV_DrawCommand>();
		foreach (UV_DrawCommand uv_DrawCommand3 in list)
		{
			Game.Instance.m_hasUVFluid[uv_DrawCommand3.index] = false;
		}
		this.m_needRender = false;
	}

	// Token: 0x060001CD RID: 461 RVA: 0x000102F0 File Offset: 0x0000E4F0
	public void AddDrawCommand(Color color, Vector2 uv, float scale = 1f, Material mat = null)
	{
		this.m_drawCommands.Add(new UV_DrawCommand(uv, color, scale, mat));
		this.m_needRender = true;
	}

	// Token: 0x0400019F RID: 415
	public bool m_needRender;

	// Token: 0x040001A0 RID: 416
	public RenderTexture m_colorTex;

	// Token: 0x040001A1 RID: 417
	public RenderMaterial m_renderMat;

	// Token: 0x040001A2 RID: 418
	public List<UV_DrawCommand> m_drawCommands = new List<UV_DrawCommand>();
}

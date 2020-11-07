using System;
using UnityEngine;

// Token: 0x02000047 RID: 71
[Serializable]
public class FluidSmear
{
	// Token: 0x0600023B RID: 571 RVA: 0x00013858 File Offset: 0x00011A58
	public FluidSmear(string texture, Color color, float duration, float scale)
	{
		this.texture = texture;
		this.color = color;
		this.duration = duration;
		this.scale = scale;
		this.timer = duration;
	}

	// Token: 0x0600023C RID: 572 RVA: 0x000138BC File Offset: 0x00011ABC
	public FluidSmear Randomized()
	{
		Color color = this.color;
		color.a *= UnityEngine.Random.Range(0.5f, 1f);
		float num = Mathf.Lerp(this.duration * 0.1f, this.duration, Mathf.Pow(UnityEngine.Random.value, 2f));
		float num2 = this.scale * UnityEngine.Random.Range(0.5f, 1f);
		return new FluidSmear(this.texture, color, num, num2);
	}

	// Token: 0x040001F4 RID: 500
	public string texture = "_ColorRT";

	// Token: 0x040001F5 RID: 501
	public Color color = Color.white;

	// Token: 0x040001F6 RID: 502
	public float duration = 5f;

	// Token: 0x040001F7 RID: 503
	public float scale = 1f;

	// Token: 0x040001F8 RID: 504
	public Material material;

	// Token: 0x040001F9 RID: 505
	[HideInInspector]
	public float timer;
}

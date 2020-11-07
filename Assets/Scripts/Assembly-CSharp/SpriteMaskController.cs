using System;
using UnityEngine;
using UnityEngine.Sprites;

// Token: 0x02000012 RID: 18
[ExecuteInEditMode]
public class SpriteMaskController : MonoBehaviour
{
	// Token: 0x06000053 RID: 83 RVA: 0x00003072 File Offset: 0x00001272
	private void OnEnable()
	{
		this.m_spriteRenderer = base.GetComponent<SpriteRenderer>();
		this.m_uvs = DataUtility.GetInnerUV(this.m_spriteRenderer.sprite);
		this.m_spriteRenderer.sharedMaterial.SetVector("_CustomUVS", this.m_uvs);
	}

	// Token: 0x04000028 RID: 40
	private SpriteRenderer m_spriteRenderer;

	// Token: 0x04000029 RID: 41
	private Vector4 m_uvs;
}

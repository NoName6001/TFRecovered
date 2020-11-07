using System;
using System.Collections.Generic;
using MoonSharp.Interpreter;
using UnityEngine;

// Token: 0x02000033 RID: 51
[MoonSharpUserData]
[Serializable]
public class GirlToggle
{
	// Token: 0x17000023 RID: 35
	// (get) Token: 0x0600017D RID: 381 RVA: 0x0000DCF4 File Offset: 0x0000BEF4
	// (set) Token: 0x0600017E RID: 382 RVA: 0x0000DD44 File Offset: 0x0000BF44
	public bool Active
	{
		get
		{
			if (this.m_colliders.Count > 0)
			{
				return this.m_colliders[0].Active;
			}
			return this.m_renderers.Count > 0 && this.m_renderers[0].enabled;
		}
		set
		{
			foreach (AdvancedCollider advancedCollider in this.m_colliders)
			{
				advancedCollider.Active = value;
			}
			foreach (Renderer renderer in this.m_renderers)
			{
				renderer.enabled = value;
			}
		}
	}

	// Token: 0x0600017F RID: 383 RVA: 0x0000DDD8 File Offset: 0x0000BFD8
	public void Toggle()
	{
		this.Active = !this.Active;
	}

	// Token: 0x04000158 RID: 344
	public string name;

	// Token: 0x04000159 RID: 345
	public List<AdvancedCollider> m_colliders;

	// Token: 0x0400015A RID: 346
	public List<Renderer> m_renderers;
}

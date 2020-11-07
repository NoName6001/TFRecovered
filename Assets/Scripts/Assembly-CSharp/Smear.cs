using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000010 RID: 16
public class Smear : MonoBehaviour
{
	// Token: 0x17000016 RID: 22
	// (get) Token: 0x0600004B RID: 75 RVA: 0x00002F87 File Offset: 0x00001187
	// (set) Token: 0x0600004C RID: 76 RVA: 0x00002F8F File Offset: 0x0000118F
	private Material InstancedMaterial
	{
		get
		{
			return this.m_instancedMaterial;
		}
		set
		{
			this.m_instancedMaterial = value;
		}
	}

	// Token: 0x0600004D RID: 77 RVA: 0x00002F98 File Offset: 0x00001198
	private void Start()
	{
		this.InstancedMaterial = this.Renderer.material;
	}

	// Token: 0x0600004E RID: 78 RVA: 0x00002FAC File Offset: 0x000011AC
	private void LateUpdate()
	{
		if (this.m_recentPositions.Count > this.FramesBufferSize)
		{
			this.InstancedMaterial.SetVector("_PrevPosition", this.m_recentPositions.Dequeue());
		}
		this.InstancedMaterial.SetVector("_Position", base.transform.position);
		this.m_recentPositions.Enqueue(base.transform.position);
	}

	// Token: 0x04000023 RID: 35
	private Queue<Vector3> m_recentPositions = new Queue<Vector3>();

	// Token: 0x04000024 RID: 36
	public int FramesBufferSize;

	// Token: 0x04000025 RID: 37
	public Renderer Renderer;

	// Token: 0x04000026 RID: 38
	private Material m_instancedMaterial;
}

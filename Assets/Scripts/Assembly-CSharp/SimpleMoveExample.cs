using System;
using UnityEngine;

// Token: 0x0200000F RID: 15
public class SimpleMoveExample : MonoBehaviour
{
	// Token: 0x06000048 RID: 72 RVA: 0x00002DC9 File Offset: 0x00000FC9
	private void Start()
	{
		this.m_originalPosition = base.transform.position;
		this.m_previous = base.transform.position;
		this.m_target = base.transform.position;
	}

	// Token: 0x06000049 RID: 73 RVA: 0x00002E00 File Offset: 0x00001000
	private void Update()
	{
		base.transform.position = Vector3.Slerp(this.m_previous, this.m_target, Time.deltaTime * this.Speed);
		this.m_previous = base.transform.position;
		if (Vector3.Distance(this.m_target, base.transform.position) < 0.1f)
		{
			this.m_target = base.transform.position + UnityEngine.Random.onUnitSphere * UnityEngine.Random.Range(0.7f, 4f);
			this.m_target.Set(Mathf.Clamp(this.m_target.x, this.m_originalPosition.x - this.BoundingVolume.x, this.m_originalPosition.x + this.BoundingVolume.x), Mathf.Clamp(this.m_target.y, this.m_originalPosition.y - this.BoundingVolume.y, this.m_originalPosition.y + this.BoundingVolume.y), Mathf.Clamp(this.m_target.z, this.m_originalPosition.z - this.BoundingVolume.z, this.m_originalPosition.z + this.BoundingVolume.z));
		}
	}

	// Token: 0x0400001E RID: 30
	private Vector3 m_previous;

	// Token: 0x0400001F RID: 31
	private Vector3 m_target;

	// Token: 0x04000020 RID: 32
	private Vector3 m_originalPosition;

	// Token: 0x04000021 RID: 33
	public Vector3 BoundingVolume = new Vector3(3f, 1f, 3f);

	// Token: 0x04000022 RID: 34
	public float Speed = 10f;
}

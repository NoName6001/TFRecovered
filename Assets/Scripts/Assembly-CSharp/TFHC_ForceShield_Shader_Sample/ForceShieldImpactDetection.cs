using UnityEngine;

namespace TFHC_ForceShield_Shader_Sample
{
	// Token: 0x020001E2 RID: 482
	public class ForceShieldImpactDetection : MonoBehaviour
	{
		// Token: 0x0600101F RID: 4127 RVA: 0x0004FD72 File Offset: 0x0004DF72
		private void Start()
		{
			this.mat = base.GetComponent<Renderer>().material;
		}

		// Token: 0x06001020 RID: 4128 RVA: 0x0004FD88 File Offset: 0x0004DF88
		private void Update()
		{
			if (this.hitTime > 0f)
			{
				this.hitTime -= Time.deltaTime * 1000f;
				if (this.hitTime < 0f)
				{
					this.hitTime = 0f;
				}
				this.mat.SetFloat("_HitTime", this.hitTime);
			}
		}

		// Token: 0x06001021 RID: 4129 RVA: 0x0004FDE8 File Offset: 0x0004DFE8
		private void OnCollisionEnter(Collision collision)
		{
			foreach (ContactPoint contactPoint in collision.contacts)
			{
				this.mat.SetVector("_HitPosition", base.transform.InverseTransformPoint(contactPoint.point));
				this.hitTime = 500f;
				this.mat.SetFloat("_HitTime", this.hitTime);
			}
		}

		// Token: 0x0400083E RID: 2110
		private float hitTime;

		// Token: 0x0400083F RID: 2111
		private Material mat;
	}
}

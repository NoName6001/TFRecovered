using UnityEngine;

namespace TFHC_ForceShield_Shader_Sample
{
	// Token: 0x020001E1 RID: 481
	public class ForceShieldDestroyBall : MonoBehaviour
	{
		// Token: 0x0600101D RID: 4125 RVA: 0x0004FD4C File Offset: 0x0004DF4C
		private void Start()
		{
			Object.Destroy(base.gameObject, this.lifetime);
		}

		// Token: 0x0400083D RID: 2109
		public float lifetime = 5f;
	}
}

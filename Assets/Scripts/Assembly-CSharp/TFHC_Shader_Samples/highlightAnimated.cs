using UnityEngine;

namespace TFHC_Shader_Samples
{
	// Token: 0x020001E0 RID: 480
	public class highlightAnimated : MonoBehaviour
	{
		// Token: 0x06001018 RID: 4120 RVA: 0x0004FD06 File Offset: 0x0004DF06
		private void Start()
		{
			this.mat = base.GetComponent<Renderer>().material;
		}

		// Token: 0x06001019 RID: 4121 RVA: 0x0004FD19 File Offset: 0x0004DF19
		private void OnMouseEnter()
		{
			this.switchhighlighted(true);
		}

		// Token: 0x0600101A RID: 4122 RVA: 0x0004FD22 File Offset: 0x0004DF22
		private void OnMouseExit()
		{
			this.switchhighlighted(false);
		}

		// Token: 0x0600101B RID: 4123 RVA: 0x0004FD2B File Offset: 0x0004DF2B
		private void switchhighlighted(bool highlighted)
		{
			this.mat.SetFloat("_Highlighted", highlighted ? 1f : 0f);
		}

		// Token: 0x0400083C RID: 2108
		private Material mat;
	}
}

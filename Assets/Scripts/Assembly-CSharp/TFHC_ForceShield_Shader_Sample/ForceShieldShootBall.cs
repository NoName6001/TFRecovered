using UnityEngine;

namespace TFHC_ForceShield_Shader_Sample
{
	// Token: 0x020001E3 RID: 483
	public class ForceShieldShootBall : MonoBehaviour
	{
		// Token: 0x06001023 RID: 4131 RVA: 0x0004FE5C File Offset: 0x0004E05C
		private void Update()
		{
			if (Input.GetButtonDown("Fire1"))
			{
				Vector3 vector = new Vector3(Input.mousePosition.x, Input.mousePosition.y, this.distance);
				vector = Camera.main.ScreenToWorldPoint(vector);
				Rigidbody rigidbody = Object.Instantiate<Rigidbody>(this.bullet, base.transform.position, Quaternion.identity);
				rigidbody.transform.LookAt(vector);
				rigidbody.AddForce(rigidbody.transform.forward * this.speed);
			}
		}

		// Token: 0x04000840 RID: 2112
		public Rigidbody bullet;

		// Token: 0x04000841 RID: 2113
		public Transform origshoot;

		// Token: 0x04000842 RID: 2114
		public float speed = 1000f;

		// Token: 0x04000843 RID: 2115
		private float distance = 10f;
	}
}

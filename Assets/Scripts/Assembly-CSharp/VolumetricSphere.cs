using System;
using UnityEngine;

// Token: 0x0200000D RID: 13
[ExecuteInEditMode]
public class VolumetricSphere : MonoBehaviour
{
	// Token: 0x06000043 RID: 67 RVA: 0x00002C18 File Offset: 0x00000E18
	private void Update()
	{
		Shader.SetGlobalVector("_SpherePosition", base.transform.position);
		Shader.SetGlobalFloat("_SphereRadius", this.radius);
		Shader.SetGlobalFloat("_MaskDensity", this.density);
		Shader.SetGlobalFloat("_MaskExponent", this.exponent);
		Shader.SetGlobalInt("_MaxPixelizationLevel", this.maxPixelizationLevel);
		if (this.enableLayersInterpolation)
		{
			Shader.EnableKeyword("_INTERPOLATE_LAYERS_ON");
		}
		else
		{
			Shader.DisableKeyword("_INTERPOLATE_LAYERS_ON");
		}
		if (this.debugSphere)
		{
			Shader.EnableKeyword("_DEBUG_MASK_ON");
			return;
		}
		Shader.DisableKeyword("_DEBUG_MASK_ON");
	}

	// Token: 0x06000044 RID: 68 RVA: 0x00002CBA File Offset: 0x00000EBA
	private void OnDrawGizmosSelected()
	{
		Gizmos.color = Color.green;
		Gizmos.DrawWireSphere(base.transform.position, this.radius);
	}

	// Token: 0x04000016 RID: 22
	[Header("Parameters")]
	[Tooltip("The radius of the sphere")]
	[Range(0f, 50f)]
	public float radius = 3f;

	// Token: 0x04000017 RID: 23
	[Tooltip("The density of the sphere")]
	[Range(0f, 10f)]
	public float density = 1f;

	// Token: 0x04000018 RID: 24
	[Tooltip("The curve of the fade-out")]
	[Range(0.2f, 5f)]
	public float exponent = 0.333333343f;

	// Token: 0x04000019 RID: 25
	[Tooltip("The maximum pixelization size")]
	[Range(1f, 10f)]
	public int maxPixelizationLevel = 5;

	// Token: 0x0400001A RID: 26
	[Tooltip("Enabled the interpolation between the layers of different pixels size")]
	public bool enableLayersInterpolation = true;

	// Token: 0x0400001B RID: 27
	[Header("Debug")]
	[Tooltip("Outputs the sphere mask")]
	public bool debugSphere;
}

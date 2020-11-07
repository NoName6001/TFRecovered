using UnityEngine;
using UnityEngine.Rendering;

public class FluidRenderer : MonoBehaviour
{
	public float blurRadius;
	public float thicknessCutoff;
	public Material colorMaterial;
	public Material fluidMaterial;
	public ParticleRenderer[] particleRenderers;
	public bool autoupdate;
	public CameraEvent cameraEvent;
}

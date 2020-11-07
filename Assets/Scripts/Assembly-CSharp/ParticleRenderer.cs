using UnityEngine;

public class ParticleRenderer : MonoBehaviour
{
	public bool render;
	public Shader shader;
	public Color particleColor;
	public float radiusScale;
	public float cameraOffset;
	public Material material;
	public ParticleSystem particleSystem;
	public Mesh mesh;
	public bool renderGameFluid;
}

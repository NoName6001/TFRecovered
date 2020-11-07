using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000038 RID: 56
public class ParticleRenderer : MonoBehaviour
{
	// Token: 0x17000027 RID: 39
	// (get) Token: 0x06000199 RID: 409 RVA: 0x0000E93D File Offset: 0x0000CB3D
	public Material ParticleMaterial
	{
		get
		{
			return this.material;
		}
	}

	// Token: 0x0600019A RID: 410 RVA: 0x0000E948 File Offset: 0x0000CB48
	public void Start()
	{
		this.material = new Material(this.shader);
		this.mesh = new Mesh();
		Quaternion rotation = Quaternion.Inverse((base.transform.localToWorldMatrix * Matrix4x4.identity.inverse).rotation * new Quaternion(0f, 0f, 0f, 1f));
		this.b1 = rotation * Vector3.right;
		this.b2 = rotation * Vector3.up;
		this.b3 = rotation * Vector3.forward;
		this.b1[3] = 0.03968503f;
		this.b2[3] = 0.03968503f;
		this.b3[3] = 0.03968503f;
	}

	// Token: 0x0600019B RID: 411 RVA: 0x0000EA30 File Offset: 0x0000CC30
	private void OnPreCull()
	{
		this.vertices.Clear();
		this.normals.Clear();
		this.colors.Clear();
		this.triangles.Clear();
		this.anisotropy1.Clear();
		this.anisotropy2.Clear();
		this.anisotropy3.Clear();
		this.sizes.Clear();
		Vector3 position = Game.Instance.m_camera.transform.position;
		if (this.renderGameFluid)
		{
			for (int i = 0; i < Game.Instance.m_fluids.Count; i++)
			{
				Fluid fluid = Game.Instance.m_fluids[i];
				float d = this.cameraOffset * fluid.GetRenderOffset();
				Vector3 b = (position - fluid.transform.position).normalized * d;
				this.AddToMesh(i, fluid.transform.position + b, fluid.GetRenderSize());
			}
		}
		else
		{
			this.particles = new ParticleSystem.Particle[this.particleSystem.particleCount];
			this.particleSystem.GetParticles(this.particles);
			for (int j = 0; j < this.particles.Length; j++)
			{
				this.AddToMesh(j, this.particles[j].position, 1f);
			}
		}
		if (this.mesh == null)
		{
			this.mesh = new Mesh();
		}
		this.mesh.Clear();
		this.mesh.SetVertices(this.vertices);
		this.mesh.SetNormals(this.normals);
		this.mesh.SetColors(this.colors);
		this.mesh.SetUVs(0, this.anisotropy1);
		this.mesh.SetUVs(1, this.anisotropy2);
		this.mesh.SetUVs(2, this.anisotropy3);
		this.mesh.SetUVs(3, this.sizes);
		this.mesh.SetTriangles(this.triangles, 0, true);
		if (this.material != null)
		{
			this.material.SetFloat("_RadiusScale", this.radiusScale);
			this.material.SetColor("_Color", this.particleColor);
			if (this.render)
			{
				Graphics.DrawMesh(this.mesh, Matrix4x4.identity, this.material, 8);
			}
		}
	}

	// Token: 0x0600019C RID: 412 RVA: 0x0000EC98 File Offset: 0x0000CE98
	public void AddToMesh(int i, Vector3 position, float size = 1f)
	{
		Color white = Color.white;
		this.vertices.Add(position);
		this.vertices.Add(position);
		this.vertices.Add(position);
		this.vertices.Add(position);
		this.normals.Add(this.particleOffset0);
		this.normals.Add(this.particleOffset1);
		this.normals.Add(this.particleOffset2);
		this.normals.Add(this.particleOffset3);
		this.colors.Add(white);
		this.colors.Add(white);
		this.colors.Add(white);
		this.colors.Add(white);
		this.anisotropy1.Add(this.b1);
		this.anisotropy1.Add(this.b1);
		this.anisotropy1.Add(this.b1);
		this.anisotropy1.Add(this.b1);
		this.anisotropy2.Add(this.b2);
		this.anisotropy2.Add(this.b2);
		this.anisotropy2.Add(this.b2);
		this.anisotropy2.Add(this.b2);
		this.anisotropy3.Add(this.b3);
		this.anisotropy3.Add(this.b3);
		this.anisotropy3.Add(this.b3);
		this.anisotropy3.Add(this.b3);
		this.sizes.Add(new Vector2(size, size));
		this.sizes.Add(new Vector2(size, size));
		this.sizes.Add(new Vector2(size, size));
		this.sizes.Add(new Vector2(size, size));
		int num = i * 4;
		this.triangles.Add(num + 2);
		this.triangles.Add(num + 1);
		this.triangles.Add(num);
		this.triangles.Add(num + 3);
		this.triangles.Add(num + 2);
		this.triangles.Add(num);
	}

	// Token: 0x04000172 RID: 370
	public bool render = true;

	// Token: 0x04000173 RID: 371
	public Shader shader;

	// Token: 0x04000174 RID: 372
	public Color particleColor = Color.white;

	// Token: 0x04000175 RID: 373
	public float radiusScale = 1f;

	// Token: 0x04000176 RID: 374
	public float cameraOffset = 0.005f;

	// Token: 0x04000177 RID: 375
	public Material material;

	// Token: 0x04000178 RID: 376
	private List<Vector3> vertices = new List<Vector3>(20000);

	// Token: 0x04000179 RID: 377
	private List<Vector3> normals = new List<Vector3>(20000);

	// Token: 0x0400017A RID: 378
	private List<Color> colors = new List<Color>(20000);

	// Token: 0x0400017B RID: 379
	private List<int> triangles = new List<int>(30000);

	// Token: 0x0400017C RID: 380
	private List<Vector4> anisotropy1 = new List<Vector4>(20000);

	// Token: 0x0400017D RID: 381
	private List<Vector4> anisotropy2 = new List<Vector4>(20000);

	// Token: 0x0400017E RID: 382
	private List<Vector4> anisotropy3 = new List<Vector4>(20000);

	// Token: 0x0400017F RID: 383
	private List<Vector2> sizes = new List<Vector2>(20000);

	// Token: 0x04000180 RID: 384
	private int particlesPerDrawcall;

	// Token: 0x04000181 RID: 385
	private int drawcallCount;

	// Token: 0x04000182 RID: 386
	private Vector3 particleOffset0 = new Vector3(1f, 1f, 0f);

	// Token: 0x04000183 RID: 387
	private Vector3 particleOffset1 = new Vector3(-1f, 1f, 0f);

	// Token: 0x04000184 RID: 388
	private Vector3 particleOffset2 = new Vector3(-1f, -1f, 0f);

	// Token: 0x04000185 RID: 389
	private Vector3 particleOffset3 = new Vector3(1f, -1f, 0f);

	// Token: 0x04000186 RID: 390
	public ParticleSystem particleSystem;

	// Token: 0x04000187 RID: 391
	public ParticleSystem.Particle[] particles = new ParticleSystem.Particle[2000];

	// Token: 0x04000188 RID: 392
	public Mesh mesh;

	// Token: 0x04000189 RID: 393
	public bool renderGameFluid;

	// Token: 0x0400018A RID: 394
	private Vector4 b1;

	// Token: 0x0400018B RID: 395
	private Vector4 b2;

	// Token: 0x0400018C RID: 396
	private Vector4 b3;
}

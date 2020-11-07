using System;
using System.Collections.Generic;
using MoonSharp.Interpreter;
using UnityEngine;

// Token: 0x02000046 RID: 70
[MoonSharpUserData]
public class Fluid : MonoBehaviour
{
	// Token: 0x1700002D RID: 45
	// (get) Token: 0x0600022F RID: 559 RVA: 0x00012EE5 File Offset: 0x000110E5
	public Vector3 Velocity
	{
		get
		{
			return base.transform.position - this.m_lastPos;
		}
	}

	// Token: 0x06000230 RID: 560 RVA: 0x00012F00 File Offset: 0x00011100
	public void Init(Vector3 pos)
	{
		this.m_timer = 0f;
		this.m_isFirstContact = false;
		this.m_isFresh = true;
		this.m_smears = new List<FluidSmear>();
		this.m_uvTimer = 0f;
		base.gameObject.SetActive(true);
		this.m_rigidbody.isKinematic = false;
		this.m_renderer.enabled = Game.Instance.fluidSpheres;
		this.m_collider.enabled = true;
		this.m_rigidbody.collisionDetectionMode = CollisionDetectionMode.ContinuousDynamic;
		this.m_collider.contactOffset = 0.005f;
		this.m_transform.position = pos;
		this.m_rigidbody.velocity = Vector3.zero;
		this.m_rigidbody.angularVelocity = Vector3.zero;
		this.m_contacts = new ContactPoint[10];
		this.m_pooled = false;
		this.m_lastPos = pos;
	}

	// Token: 0x06000231 RID: 561 RVA: 0x00012FD8 File Offset: 0x000111D8
	public void Pool()
	{
		base.gameObject.SetActive(false);
		this.m_triPos = null;
		this.m_stringPos = null;
		this.m_smears = new List<FluidSmear>();
		this.m_pooled = true;
	}

	// Token: 0x06000232 RID: 562 RVA: 0x00013008 File Offset: 0x00011208
	public bool UpdateFluid(float deltaTime)
	{
		this.m_timer += deltaTime;
		this.m_uvTimer += deltaTime;
		if (this.m_triPos != null)
		{
			AdvancedCollider collider = this.m_triPos.m_collider;
			collider.RecheckMeshData();
			TriangleCache triangleCache = collider.m_triangleCache[this.m_triPos.triId];
			bool flag = false;
			if (this.m_isFirstContact)
			{
				if (this.m_isFresh && collider.m_girl != null && triangleCache.triggers.Count > 0)
				{
					collider.m_girl.OnTriangleImpact(this, triangleCache.triggers);
				}
				this.m_isFirstContact = false;
				this.m_isFresh = false;
				this.m_transform.position = this.m_triPos.GetWorldPos();
			}
			else
			{
				bool flag2;
				TrianglePos slidePos = collider.GetSlidePos(this.m_triPos, this.m_slideSpeed * deltaTime, out flag, out flag2);
				if (flag)
				{
					Vector3 worldPos = slidePos.GetWorldPos();
					RaycastHit raycastHit;
					if (Physics.Raycast(new Ray(worldPos, Vector3.down), out raycastHit, 0.02f, LayerMask.GetMask(new string[]
					{
						"Default"
					})))
					{
						AdvancedCollider collider2 = Game.Instance.m_collidersDict[raycastHit.collider];
						this.m_triPos = new TrianglePos(collider2, raycastHit.triangleIndex, raycastHit.barycentricCoordinate, default(Vector3));
						this.m_transform.position = this.m_triPos.GetWorldPos();
					}
					else
					{
						if (this.m_triPos.GetTriggers().Contains("InsideMouth"))
						{
							return true;
						}
						bool flag3 = false;
						foreach (FluidString fluidString in Game.Instance.m_fluidStrings)
						{
							flag3 = fluidString.TryDripIntoString(this);
							if (flag3)
							{
								this.m_triPos = null;
								break;
							}
						}
						if (!flag3)
						{
							float length = UnityEngine.Random.Range(0.035f, 0.05f);
							if (this.m_stringPos == null && Game.Instance.CanAddFluidString(length))
							{
								FluidString fluidString2 = Game.Instance.AddFluidString(worldPos, worldPos + Vector3.down * 0.01f, worldPos + Vector3.down * 0.02f, length, false, -1f);
								if (UnityEngine.Random.value > 0.85f)
								{
									fluidString2.m_maxWeight = 5f;
								}
								fluidString2.m_start.m_triPos = this.m_triPos;
								fluidString2.UpdateFluidString(0f);
								fluidString2.AddFluidToString(0f, this);
								this.m_triPos = null;
							}
							else
							{
								this.m_transform.position = this.m_triPos.GetWorldPos();
							}
						}
					}
				}
				else
				{
					this.m_triPos = slidePos;
					this.m_transform.position = this.m_triPos.GetWorldPos();
				}
			}
			if (!flag && this.m_uvTimer >= Game.Instance.fluidUVTime)
			{
				Vector2 uv = this.m_triPos.CalculateUVPos();
				RenderMaterial renderMat = collider.m_triangleCache[this.m_triPos.triId].RenderMat;
				if (renderMat != null)
				{
					renderMat.DrawUV(0, Color.white, uv, 1f, null);
					foreach (FluidSmear fluidSmear in this.m_smears)
					{
						float scale = fluidSmear.scale * renderMat.scale * Mathf.Max(fluidSmear.timer / fluidSmear.duration, 0.6f) * UnityEngine.Random.Range(0.8f, 1.2f);
						Color color = fluidSmear.color;
						color.a *= Mathf.Pow(fluidSmear.timer / fluidSmear.duration, 2f);
						renderMat.DrawUV(1, color, uv, scale, fluidSmear.material);
					}
				}
				this.m_uvTimer = 0f;
			}
		}
		if (this.m_stringPos != null)
		{
			this.m_stringPos.fluidString.SlideOnString(this, deltaTime);
		}
		Vector3 position = this.m_transform.position;
		if (position.x < -1f || position.x > 1f || position.y < 0.01f || position.y > 2f || position.z < -1f || position.z > 1f)
		{
			return true;
		}
		if (this.m_timer >= Game.Instance.fluidDestroyTime && this.m_stringPos == null)
		{
			Vector3 vector = Camera.main.WorldToScreenPoint(position);
			if (vector.x < 10f || vector.x > (float)(Screen.width + 10) || vector.y < 10f || vector.y > (float)(Screen.height + 10))
			{
				return true;
			}
		}
		this.m_lastPos = position;
		for (int i = this.m_smears.Count - 1; i >= 0; i--)
		{
			FluidSmear fluidSmear2 = this.m_smears[i];
			fluidSmear2.timer -= deltaTime;
			if (fluidSmear2.timer <= 0f)
			{
				this.m_smears.RemoveAt(i);
			}
		}
		return false;
	}

	// Token: 0x06000233 RID: 563 RVA: 0x00013554 File Offset: 0x00011754
	public void AddSmear(FluidSmear smear)
	{
		this.m_smears.Add(smear);
	}

	// Token: 0x06000234 RID: 564 RVA: 0x00013564 File Offset: 0x00011764
	private void OnCollisionEnter(Collision collision)
	{
		if (this.m_triPos != null)
		{
			return;
		}
		Collider collider = collision.collider;
		if (collider.tag == "AdvancedCollider")
		{
			int contacts = collision.GetContacts(this.m_contacts);
			collision.GetContacts(this.m_contacts);
			List<RaycastHit> list = new List<RaycastHit>();
			for (int i = 0; i < contacts; i++)
			{
				ContactPoint contactPoint = this.m_contacts[i];
				Vector3 velocity = this.m_velocity;
				Vector3 direction = (velocity != Vector3.zero) ? velocity : (-contactPoint.normal);
				Ray ray = new Ray(contactPoint.point - direction.normalized * 0.005f, direction);
				RaycastHit item;
				if (collider.Raycast(ray, out item, 0.05f))
				{
					list.Add(item);
				}
			}
			if (list.Count != 0)
			{
				list.Sort((RaycastHit a, RaycastHit b) => (a.point - base.transform.position).sqrMagnitude.CompareTo((b.point - base.transform.position).sqrMagnitude));
				TrianglePos triPos = new TrianglePos(Game.Instance.m_collidersDict[(MeshCollider)collider], list[0].triangleIndex, list[0].barycentricCoordinate, default(Vector3));
				this.AddToCollider(triPos);
			}
			Array.Clear(this.m_contacts, 0, 10);
		}
	}

	// Token: 0x06000235 RID: 565 RVA: 0x000136AD File Offset: 0x000118AD
	public void AddToCollider(TrianglePos triPos)
	{
		this.m_triPos = triPos;
		this.m_isFirstContact = true;
		this.m_uvTimer = 999f;
		base.gameObject.SetActive(false);
	}

	// Token: 0x06000236 RID: 566 RVA: 0x000136D4 File Offset: 0x000118D4
	public float GetRenderSize()
	{
		if (this.m_stringPos != null)
		{
			float fluidRenderSize = this.m_stringPos.fluidString.GetFluidRenderSize(this.m_stringPos.tf);
			this.m_size = Mathf.Max(fluidRenderSize, 0.0045f);
			return fluidRenderSize / 0.006f;
		}
		return this.m_size / 0.006f;
	}

	// Token: 0x06000237 RID: 567 RVA: 0x0001372C File Offset: 0x0001192C
	public float GetRenderOffset()
	{
		if (this.m_stringPos != null)
		{
			if (this.m_stringPos.tf <= 0.2f && this.m_stringPos.fluidString.m_start.m_triPos != null)
			{
				return Mathf.InverseLerp(0f, 0.2f, this.m_stringPos.tf);
			}
			if (this.m_stringPos.tf >= 0.8f && this.m_stringPos.fluidString.m_end.m_triPos != null)
			{
				return Mathf.InverseLerp(1f, 0.8f, this.m_stringPos.tf);
			}
		}
		return 1f;
	}

	// Token: 0x06000238 RID: 568 RVA: 0x000137D1 File Offset: 0x000119D1
	public void FixedUpdate()
	{
		this.m_velocity = this.m_rigidbody.velocity;
	}

	// Token: 0x040001E3 RID: 483
	public SphereCollider m_collider;

	// Token: 0x040001E4 RID: 484
	public Rigidbody m_rigidbody;

	// Token: 0x040001E5 RID: 485
	public Renderer m_renderer;

	// Token: 0x040001E6 RID: 486
	public TrianglePos m_triPos;

	// Token: 0x040001E7 RID: 487
	public StringPos m_stringPos;

	// Token: 0x040001E8 RID: 488
	public List<FluidSmear> m_smears;

	// Token: 0x040001E9 RID: 489
	public float m_size = 0.005f;

	// Token: 0x040001EA RID: 490
	public float m_slideSpeed = 0.004f;

	// Token: 0x040001EB RID: 491
	public bool m_isFirstContact;

	// Token: 0x040001EC RID: 492
	public bool m_isFresh;

	// Token: 0x040001ED RID: 493
	public float m_timer;

	// Token: 0x040001EE RID: 494
	public float m_uvTimer;

	// Token: 0x040001EF RID: 495
	public Transform m_transform;

	// Token: 0x040001F0 RID: 496
	private Vector3 m_lastPos;

	// Token: 0x040001F1 RID: 497
	private ContactPoint[] m_contacts;

	// Token: 0x040001F2 RID: 498
	public Vector3 m_velocity;

	// Token: 0x040001F3 RID: 499
	public bool m_pooled;
}

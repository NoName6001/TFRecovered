using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine;

// Token: 0x0200004B RID: 75
public class FluidStringNode : MonoBehaviour
{
	// Token: 0x17000030 RID: 48
	// (get) Token: 0x06000251 RID: 593 RVA: 0x00014A2E File Offset: 0x00012C2E
	public Vector3 Velocity
	{
		get
		{
			return base.transform.position - this.m_lastPos;
		}
	}

	// Token: 0x17000031 RID: 49
	// (get) Token: 0x06000252 RID: 594 RVA: 0x00014A46 File Offset: 0x00012C46
	public bool IsMiddlePoint
	{
		get
		{
			return this.m_joint == null;
		}
	}

	// Token: 0x17000032 RID: 50
	// (get) Token: 0x06000253 RID: 595 RVA: 0x00014A54 File Offset: 0x00012C54
	public bool IsStartPoint
	{
		get
		{
			return this.m_joint == this.m_fluidString.m_start;
		}
	}

	// Token: 0x17000033 RID: 51
	// (get) Token: 0x06000254 RID: 596 RVA: 0x00014A6C File Offset: 0x00012C6C
	public bool IsEndPoint
	{
		get
		{
			return this.m_joint == this.m_fluidString.m_end;
		}
	}

	// Token: 0x17000034 RID: 52
	// (get) Token: 0x06000255 RID: 597 RVA: 0x00014A84 File Offset: 0x00012C84
	public Girl Girl
	{
		get
		{
			if (this.m_triPos != null)
			{
				return this.m_triPos.m_collider.m_girl;
			}
			if (this.m_hitPos != null)
			{
				return this.m_hitPos.m_collider.m_girl;
			}
			return null;
		}
	}

	// Token: 0x06000256 RID: 598 RVA: 0x00014ABC File Offset: 0x00012CBC
	public void Init(Vector3 position, FluidString fluidString)
	{
		this.m_fluidString = fluidString;
		Transform transform = base.transform;
		this.m_lastPos = position;
		transform.position = position;
		this.m_rigidbody.velocity = Vector3.zero;
		this.m_rigidbody.angularVelocity = Vector3.zero;
		this.AddToCollider(null, false);
		this.m_contacts = new ContactPoint[20];
		this.m_followFluid = null;
		this.m_hitPos = null;
	}

	// Token: 0x06000257 RID: 599 RVA: 0x00014B28 File Offset: 0x00012D28
	public void Pool()
	{
		this.m_collider.enabled = true;
		this.m_rigidbody.useGravity = true;
		Game.RemoveAnim(this, true);
	}

	// Token: 0x06000258 RID: 600 RVA: 0x00014B4C File Offset: 0x00012D4C
	public void UpdateStringEnd(float deltaTime)
	{
		if (this.m_fluidString.m_timer > 0.5f)
		{
			this.m_followFluid = null;
		}
		if (this.IsMiddlePoint)
		{
			float mass = Mathf.Lerp(0.045f, 0.8f, this.m_fluidString.m_weightFactor);
			this.m_rigidbody.mass = mass;
			return;
		}
		if (this.m_triPos != null)
		{
			bool flag;
			bool flag2;
			TrianglePos slidePos = this.m_triPos.m_collider.GetSlidePos(this.m_triPos, this.m_fluidString.m_slideSpeed * deltaTime, out flag, out flag2);
			if (!flag)
			{
				this.m_triPos = slidePos;
			}
		}
		if (this.m_triPos != null)
		{
			base.transform.position = this.m_triPos.GetWorldPos();
			this.g__setLock(true);
			return;
		}
		if (this.m_followFluid != null)
		{
			base.transform.position = this.m_followFluid.transform.position;
			this.g__setLock(true);
			return;
		}
		this.g__setLock(false);
	}

	// Token: 0x06000259 RID: 601 RVA: 0x00014C40 File Offset: 0x00012E40
	public void EndUpdate()
	{
		this.m_hitPos = null;
		this.m_lastPos = base.transform.position;
		this.m_canDripInto = false;
		if (!this.IsMiddlePoint && this.m_triPos != null)
		{
			Vector3 normalized = (this.m_fluidString.m_mid.transform.position - this.m_lastPos).normalized;
			this.m_canDripInto = (Vector3.Dot(normalized, Vector3.down) > 0.1f);
		}
	}

	// Token: 0x0600025A RID: 602 RVA: 0x00014CC0 File Offset: 0x00012EC0
	public void CheckAttachToMesh(FluidStringNode otherEnd)
	{
		if (this.m_triPos == null && this.m_hitPos != null && this.Girl != null && otherEnd.Girl != this.Girl)
		{
			this.AddToCollider(this.m_hitPos, true);
			Fluid fluid = Game.Instance.AddFluid(base.transform.position);
			if (fluid)
			{
				fluid.AddToCollider(this.m_triPos);
			}
		}
	}

	// Token: 0x0600025B RID: 603 RVA: 0x00014D38 File Offset: 0x00012F38
	public bool CanDripInto(Fluid fluid, out float distance)
	{
		if (this.m_triPos != null && this.m_canDripInto && fluid.m_triPos.m_collider == this.m_triPos.m_collider)
		{
			int num = this.IsStartPoint ? 0 : (this.m_fluidString.m_segments.Length - 1);
			if (this.m_fluidString.m_segments[num] < 5)
			{
				distance = Vector3.Distance(base.transform.position, fluid.transform.position);
				if (distance < 0.02f)
				{
					return true;
				}
			}
		}
		distance = 0f;
		return false;
	}

	// Token: 0x0600025C RID: 604 RVA: 0x00014DD0 File Offset: 0x00012FD0
	private void OnCollisionEnter(Collision collision)
	{
		if (this.m_hitPos != null)
		{
			return;
		}
		Collider collider = collision.collider;
		if (collider.tag == "AdvancedCollider")
		{
			Girl girl = Game.Instance.m_collidersDict[collider].m_girl;
			this.m_contacts = (this.m_contacts ?? new ContactPoint[20]);
			int contacts = collision.GetContacts(this.m_contacts);
			collision.GetContacts(this.m_contacts);
			List<ValueTuple<RaycastHit, ContactPoint>> list = new List<ValueTuple<RaycastHit, ContactPoint>>();
			for (int i = 0; i < contacts; i++)
			{
				ContactPoint item = this.m_contacts[i];
				Vector3 direction = (this.m_velocity != Vector3.zero) ? this.m_velocity : (-item.normal);
				Ray ray = new Ray(item.point - direction.normalized * 0.005f, direction);
				RaycastHit item2;
				if (collider.Raycast(ray, out item2, 0.1f))
				{
					list.Add(new ValueTuple<RaycastHit, ContactPoint>(item2, item));
				}
			}
			if (list.Count != 0)
			{
				list.Sort((ValueTuple<RaycastHit, ContactPoint> a, ValueTuple<RaycastHit, ContactPoint> b) => (a.Item1.point - base.transform.position).sqrMagnitude.CompareTo((b.Item1.point - base.transform.position).sqrMagnitude));
				AdvancedCollider collider2 = Game.Instance.m_collidersDict[(MeshCollider)collider];
				ValueTuple<RaycastHit, ContactPoint> valueTuple = list[0];
				int triangleIndex = valueTuple.Item1.triangleIndex;
				valueTuple = list[0];
				Vector3 barycentricCoordinate = valueTuple.Item1.barycentricCoordinate;
				valueTuple = list[0];
				TrianglePos hitPos = new TrianglePos(collider2, triangleIndex, barycentricCoordinate, valueTuple.Item2.normal);
				this.m_hitPos = hitPos;
				this.m_followFluid = null;
			}
			Array.Clear(this.m_contacts, 0, 20);
		}
	}

	// Token: 0x0600025D RID: 605 RVA: 0x00014F70 File Offset: 0x00013170
	public void AddToCollider(TrianglePos triPos, bool ignoreCollision = true)
	{
		if (triPos == null && this.m_triPos != null && ignoreCollision)
		{
			Girl girl = this.m_triPos.m_collider.m_girl;
			girl.IgnoreDynamicCollisions(true, new Collider[]
			{
				this.m_collider
			});
			Game.AddAnim(0.2f, delegate()
			{
				girl.IgnoreDynamicCollisions(false, new Collider[]
				{
					this.m_collider
				});
			}, true, this, true);
		}
		this.m_triPos = triPos;
	}

	// Token: 0x0600025E RID: 606 RVA: 0x00014FEF File Offset: 0x000131EF
	public void FixedUpdate()
	{
		this.m_velocity = this.m_rigidbody.velocity;
	}

	// Token: 0x06000260 RID: 608 RVA: 0x00015004 File Offset: 0x00013204
	[CompilerGenerated]
	private void g__setLock(bool locked)
	{
		if (locked)
		{
			float mass = 0.03f;
			if (this.m_fluidString.m_start.m_triPos == null || this.m_fluidString.m_end.m_triPos == null)
			{
				mass = Mathf.Lerp(0.2f, 0.03f, Mathf.InverseLerp(0.025f, 0.1f, this.m_fluidString.m_length));
			}
			this.m_rigidbody.mass = mass;
			this.m_rigidbody.constraints = RigidbodyConstraints.FreezePosition;
			this.m_rigidbody.useGravity = false;
			this.m_joint.linearLimit = new SoftJointLimit
			{
				limit = 0.005f
			};
			bool flag = this.m_followFluid;
			if (this.m_collider.enabled != flag)
			{
				this.m_collider.enabled = flag;
				return;
			}
		}
		else
		{
			this.m_rigidbody.constraints = RigidbodyConstraints.None;
			this.m_rigidbody.useGravity = true;
			this.m_rigidbody.mass = 0.03f;
			float limit = Mathf.Lerp(0.0075f, 0.04f, this.m_fluidString.m_weightFactor);
			this.m_joint.linearLimit = new SoftJointLimit
			{
				limit = limit
			};
			if (!this.m_collider.enabled)
			{
				this.m_collider.enabled = true;
			}
		}
	}

	// Token: 0x04000213 RID: 531
	public FluidString m_fluidString;

	// Token: 0x04000214 RID: 532
	public ConfigurableJoint m_joint;

	// Token: 0x04000215 RID: 533
	public Rigidbody m_rigidbody;

	// Token: 0x04000216 RID: 534
	public Collider m_collider;

	// Token: 0x04000217 RID: 535
	public TrianglePos m_triPos;

	// Token: 0x04000218 RID: 536
	public TrianglePos m_hitPos;

	// Token: 0x04000219 RID: 537
	public Fluid m_followFluid;

	// Token: 0x0400021A RID: 538
	private ContactPoint[] m_contacts;

	// Token: 0x0400021B RID: 539
	private Vector3 m_lastPos;

	// Token: 0x0400021C RID: 540
	public Vector3 m_velocity;

	// Token: 0x0400021D RID: 541
	private bool m_canDripInto;
}

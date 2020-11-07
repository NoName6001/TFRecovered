using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using FluffyUnderware.Curvy;
using UnityEngine;

// Token: 0x02000048 RID: 72
public class FluidString : MonoBehaviour
{
	// Token: 0x1700002E RID: 46
	// (get) Token: 0x0600023D RID: 573 RVA: 0x00013938 File Offset: 0x00011B38
	public int AttachCount
	{
		get
		{
			int num = 0;
			if (this.m_start.m_triPos != null)
			{
				num++;
			}
			if (this.m_end.m_triPos != null)
			{
				num++;
			}
			return num;
		}
	}

	// Token: 0x1700002F RID: 47
	// (get) Token: 0x0600023E RID: 574 RVA: 0x0001396A File Offset: 0x00011B6A
	public FluidStringNode AttachedEnd
	{
		get
		{
			if (this.m_start.m_triPos == null)
			{
				return this.m_end;
			}
			return this.m_start;
		}
	}

	// Token: 0x0600023F RID: 575 RVA: 0x00013988 File Offset: 0x00011B88
	public void Init(Vector3 startPos, Vector3 midPos, Vector3 endPos, float length = 0.1f, float timer = 0f, float breakLength = -1f)
	{
		base.gameObject.SetActive(false);
		this.m_length = length;
		this.m_breakLength = this.m_length * 1.35f;
		this.m_segments = new int[FluidString.LengthToSegmentCount(length)];
		this.m_nodes = new List<FluidStringNode>
		{
			this.m_start,
			this.m_end
		};
		this.m_start.Init(startPos, this);
		this.m_mid.Init(midPos, this);
		this.m_end.Init(endPos, this);
		this.m_spline.DoUpdate();
		base.gameObject.SetActive(true);
		this.m_timer = timer;
	}

	// Token: 0x06000240 RID: 576 RVA: 0x00013A38 File Offset: 0x00011C38
	public void Pool()
	{
		for (int i = Game.Instance.m_fluids.Count - 1; i >= 0; i--)
		{
			Fluid fluid = Game.Instance.m_fluids[i];
			if (fluid.m_stringPos != null && fluid.m_stringPos.fluidString == this)
			{
				Game.Instance.RemoveFluid(i);
			}
		}
		this.m_length = 0.1f;
		this.m_canAttach = false;
		this.m_canBreak = false;
		this.m_breakTime = -1f;
		this.m_instantDissolveTime = -1f;
		this.m_leakAttachTime = -1f;
		this.isLengthBreak = false;
		this.m_maxWeight = 3f;
		Game.RemoveAnim(this, false);
		this.m_start.Pool();
		this.m_mid.Pool();
		this.m_end.Pool();
		base.gameObject.SetActive(false);
	}

	// Token: 0x06000241 RID: 577 RVA: 0x00013B18 File Offset: 0x00011D18
	public bool UpdateFluidString(float deltaTime)
	{
		this.m_timer += deltaTime;
		this.m_weightFactor = 0f;
		if (this.m_segments[0] > 0 && this.m_segments[this.m_segments.Length - 1] > 0)
		{
			int num = 0;
			for (int i = 0; i < this.m_segments.Length; i++)
			{
				if ((this.m_start.m_triPos == null || (float)i >= (float)this.m_segments.Length * 0.4f) && (this.m_end.m_triPos == null || (float)i <= (float)this.m_segments.Length * 0.6f))
				{
					num += this.m_segments[i];
				}
			}
			this.m_weightFactor = Mathf.InverseLerp((float)this.m_segments.Length, (float)this.m_segments.Length * this.m_maxWeight, (float)num);
		}
		if (this.m_canAttach)
		{
			this.m_start.CheckAttachToMesh(this.m_end);
			this.m_end.CheckAttachToMesh(this.m_start);
		}
		this.m_start.UpdateStringEnd(deltaTime);
		this.m_mid.UpdateStringEnd(deltaTime);
		this.m_end.UpdateStringEnd(deltaTime);
		if (this.m_breakTime != -1f && this.m_timer - this.m_breakTime > 0.15f)
		{
			if (this.isLengthBreak)
			{
				this.m_canAttach = true;
				if (this.AttachCount > 0 && this.m_leakAttachTime == -1f)
				{
					this.m_leakAttachTime = this.m_timer;
				}
				if (this.m_leakAttachTime > 0f)
				{
					float num2 = Mathf.InverseLerp(0f, 0.4f, this.m_timer - this.m_leakAttachTime);
					for (int j = Game.Instance.m_fluids.Count - 1; j >= 0; j--)
					{
						Fluid fluid = Game.Instance.m_fluids[j];
						StringPos stringPos = fluid.m_stringPos;
						if (stringPos != null && stringPos.fluidString == this && stringPos.tf > 1f - num2)
						{
							fluid.gameObject.SetActive(true);
							fluid.transform.position = fluid.m_stringPos.GetWorldPos();
							fluid.m_stringPos = null;
							fluid.m_rigidbody.velocity = Vector3.zero;
						}
					}
					if (num2 >= 1f)
					{
						return true;
					}
				}
				return false;
			}
			this.Dissolve();
			return true;
		}
		else
		{
			if (this.AttachCount == 1)
			{
				FluidStringNode attachedEnd = this.AttachedEnd;
				if (attachedEnd.m_triPos.m_collider.name == "Penis")
				{
					Penis penis = attachedEnd.m_triPos.m_collider.m_girl.m_penis;
					if (!penis.IsFree)
					{
						float num3;
						Vector3 vector;
						float num4;
						penis.GetClosestPoint(attachedEnd.transform.position, out num3, out vector, out num4);
						float lipsDistance = penis.ConnectedGirl.LipsDistance;
						if (num4 > lipsDistance)
						{
							this.Dissolve();
							return true;
						}
					}
				}
			}
			else if (this.AttachCount == 2 && (this.m_start.m_triPos.m_collider.name == "Penis" || this.m_end.m_triPos.m_collider.name == "Penis"))
			{
				bool flag = this.m_start.m_triPos.m_collider.name == "Penis";
				FluidStringNode fluidStringNode = flag ? this.m_start : this.m_end;
				if (!flag)
				{
					FluidStringNode start = this.m_start;
				}
				else
				{
					FluidStringNode end = this.m_end;
				}
				Penis penis2 = fluidStringNode.m_triPos.m_collider.m_girl.m_penis;
				if (!penis2.IsFree)
				{
					float num5;
					Vector3 vector2;
					float num6;
					penis2.GetClosestPoint(fluidStringNode.transform.position, out num5, out vector2, out num6);
					float lipsDistance2 = penis2.ConnectedGirl.LipsDistance;
					if (num6 - lipsDistance2 > -0.01f)
					{
						this.SplitInHalf(flag ? UnityEngine.Random.Range(0.2f, 0.5f) : UnityEngine.Random.Range(0.5f, 0.8f));
					}
				}
			}
			if (this.m_timer > 15f || this.m_weightFactor > 0.3f)
			{
				this.m_canBreak = true;
			}
			if (this.m_timer >= 3f && this.m_segments[this.TfToSegmentId(0.2f)] == 0)
			{
				this.BreakOff();
				this.isLengthBreak = true;
			}
			if (this.m_mid.Girl != null && this.m_mid.Girl == this.m_start.Girl && this.m_mid.Girl == this.m_end.Girl && this.m_breakTime == -1f)
			{
				if (Vector3.Dot(((this.m_start.m_triPos != null) ? this.m_end : this.m_start).m_hitPos.impactNormal, Vector3.up) > 0.5f)
				{
					this.m_canBreak = true;
				}
				if (this.m_canBreak)
				{
					if (this.m_instantDissolveTime != -1f && this.m_timer - this.m_instantDissolveTime <= 0.4f)
					{
						this.Dissolve();
						return true;
					}
					this.BreakOff();
				}
			}
			if (this.m_timer > 30f)
			{
				this.BreakOff();
			}
			this.m_spline.DoUpdate();
			float breakLength = this.m_breakLength;
			float length = this.m_spline.Length;
			if (this.m_spline.Length > breakLength)
			{
				if (this.m_length <= this.m_minLength)
				{
					this.BreakOff();
					this.isLengthBreak = true;
				}
				else
				{
					this.SplitInHalf(UnityEngine.Random.Range(0.3f, 0.7f));
				}
			}
			if (this.m_timer > 25f && this.m_start.m_triPos != null && this.m_end.m_triPos != null)
			{
				this.SplitInHalf(UnityEngine.Random.Range(0.3f, 0.7f));
			}
			if (FluidString.g__outsideBox(this.m_start.transform.position) && FluidString.g__outsideBox(this.m_end.transform.position) && FluidString.g__outsideBox(this.m_mid.transform.position))
			{
				return true;
			}
			this.m_start.EndUpdate();
			this.m_mid.EndUpdate();
			this.m_end.EndUpdate();
			return false;
		}
	}

	// Token: 0x06000242 RID: 578 RVA: 0x00014160 File Offset: 0x00012360
	public bool TryDripIntoString(Fluid fluid)
	{
		foreach (FluidStringNode fluidStringNode in this.m_nodes)
		{
			float num;
			if (fluidStringNode.CanDripInto(fluid, out num))
			{
				int num2 = (fluidStringNode == this.m_start) ? 0 : 1;
				this.AddFluidToString((float)num2, fluid);
				return true;
			}
		}
		return false;
	}

	// Token: 0x06000243 RID: 579 RVA: 0x000141DC File Offset: 0x000123DC
	public void AddFluidToString(float tf, Fluid fluid = null)
	{
		fluid = (fluid ?? Game.Instance.AddFluid(Vector3.zero));
		fluid.m_stringPos = new StringPos
		{
			tf = tf,
			fluidString = this
		};
		int num = Mathf.RoundToInt(Mathf.Lerp(0f, (float)(this.m_segments.Length - 1), tf));
		this.m_segments[num]++;
		fluid.gameObject.SetActive(false);
	}

	// Token: 0x06000244 RID: 580 RVA: 0x00014254 File Offset: 0x00012454
	public void SlideOnString(Fluid fluid, float deltaTime)
	{
		StringPos stringPos = fluid.m_stringPos;
		int num = this.TfToSegmentId(stringPos.tf);
		if (this.m_segments[num] <= 1)
		{
			fluid.transform.position = fluid.m_stringPos.GetWorldPos();
			return;
		}
		int num2 = 1;
		float num3 = Vector3.Dot(this.m_spline.GetTangent(stringPos.tf), Vector3.down);
		if (num3 < 0f)
		{
			num2 = -num2;
			num3 = -num3;
		}
		float num4 = this.m_spline.TFToDistance(stringPos.tf);
		float num5 = Mathf.Lerp(0f, fluid.m_slideSpeed * 3f * deltaTime, num3) * (float)num2;
		float distance = num4 + num5;
		float tf = Mathf.Clamp01(this.m_spline.DistanceToTF(distance));
		int num6 = this.TfToSegmentId(tf);
		if (num6 == num)
		{
			fluid.m_stringPos.tf = tf;
			fluid.transform.position = fluid.m_stringPos.GetWorldPos();
			return;
		}
		bool flag = true;
		int num7 = num;
		int num8 = Mathf.FloorToInt((float)num / ((float)this.m_segments.Length * 0.2f));
		int num9 = num;
		while (this.m_segments[num9] != 0)
		{
			if (num9 == num6)
			{
				if (this.m_segments[0] > 0 && this.m_segments[this.m_segments.Length - 1] > 0)
				{
					int num10 = num6;
					for (;;)
					{
						if (Mathf.FloorToInt((float)num10 / ((float)this.m_segments.Length * 0.2f)) != num8)
						{
							if (this.m_segments[num10] <= this.m_segments[num])
							{
								num7 = num10;
								break;
							}
						}
						else if (this.m_segments[num10] < this.m_segments[num])
						{
							//goto Block_10;
							num7 = num10;
							break;
						}
						if (num10 == num)
						{
							//goto Block_11;
							flag = false;
							break;
						}
						num10 = (int)Mathf.MoveTowards((float)num10, (float)num, 1f);
					}
					//num7 = num10;
					//goto IL_1CC;
					//Block_10:
					//num7 = num10;
					//goto IL_1CC;
					//Block_11:
					//flag = false;
				}
				else
				{
					num7 = num6;
				}
				//IL_1CC:
				if (flag)
				{
					this.m_segments[num]--;
					this.m_segments[num7]++;
					if (num7 == num)
					{
						fluid.m_stringPos.tf = tf;
					}
					else
					{
						fluid.m_stringPos.tf = this.SegmentIdToTF(num7);
					}
				}
				fluid.transform.position = fluid.m_stringPos.GetWorldPos();
				return;
			}
			num9 = (int)Mathf.MoveTowards((float)num9, (float)num6, 1f);
		}
		num7 = num9;
		//goto IL_1CC;
		// Unreachable ?
	}

	// Token: 0x06000245 RID: 581 RVA: 0x00014491 File Offset: 0x00012691
	public int TfToSegmentId(float tf)
	{
		return Mathf.RoundToInt(Mathf.Lerp(0f, (float)(this.m_segments.Length - 1), tf));
	}

	// Token: 0x06000246 RID: 582 RVA: 0x000144AE File Offset: 0x000126AE
	public float SegmentIdToTF(int id)
	{
		return (float)id / (float)(this.m_segments.Length - 1);
	}

	// Token: 0x06000247 RID: 583 RVA: 0x000144BE File Offset: 0x000126BE
	public void BreakOff()
	{
		if (this.m_breakTime != -1f)
		{
			return;
		}
		this.m_start.AddToCollider(null, true);
		this.m_end.AddToCollider(null, true);
		this.m_breakTime = this.m_timer;
	}

	// Token: 0x06000248 RID: 584 RVA: 0x000144F4 File Offset: 0x000126F4
	public void SplitInHalf(float cutTF)
	{
		if (Game.Instance.m_fStringPool.Count == 0)
		{
			this.BreakOff();
			this.isLengthBreak = true;
			return;
		}
		float num = 0.8f;
		float breakLength = this.m_breakLength;
		float length = this.m_spline.Length;
		float num2 = cutTF * breakLength;
		float num3 = num2 * num;
		float num4 = length - (breakLength - num2) * num;
		Vector3 endPos = this.m_spline.InterpolateByDistance(num3);
		Vector3 startPos = this.m_spline.InterpolateByDistance(num4);
		Vector3 midPos = this.m_spline.InterpolateByDistance(num3 / 2f);
		Vector3 midPos2 = this.m_spline.InterpolateByDistance((length + num4) / 2f);
		float length2 = this.m_length * cutTF;
		float length3 = this.m_length * (1f - cutTF);
		FluidString fluidString = Game.Instance.AddFluidString(startPos, midPos2, this.m_end.transform.position, length3, false, -1f);
		fluidString.m_end.AddToCollider(this.m_end.m_triPos, false);
		fluidString.m_canBreak = true;
		fluidString.m_instantDissolveTime = this.m_timer;
		fluidString.m_timer = this.m_timer;
		fluidString.m_canAttach = false;
		TrianglePos triPos = this.m_start.m_triPos;
		this.Init(this.m_start.transform.position, midPos, endPos, length2, this.m_timer, -1f);
		this.m_canBreak = true;
		this.m_instantDissolveTime = this.m_timer;
		this.m_canAttach = false;
		this.m_start.AddToCollider(triPos, false);
		this.m_spline.DistanceToTF(num3);
		this.m_spline.DistanceToTF(num4);
		for (int i = Game.Instance.m_fluids.Count - 1; i >= 0; i--)
		{
			Fluid fluid = Game.Instance.m_fluids[i];
			StringPos stringPos = fluid.m_stringPos;
			if (stringPos != null && stringPos.fluidString == this)
			{
				if (stringPos.tf <= cutTF)
				{
					float tf = Mathf.InverseLerp(0f, cutTF - 0.01f, stringPos.tf);
					this.AddFluidToString(tf, fluid);
				}
				else
				{
					float tf2 = Mathf.InverseLerp(cutTF + 0.01f, 1f, stringPos.tf);
					fluidString.AddFluidToString(tf2, fluid);
				}
			}
		}
	}

	// Token: 0x06000249 RID: 585 RVA: 0x00014740 File Offset: 0x00012940
	public void Dissolve()
	{
		if (this.m_start.m_triPos == null && this.m_start.m_hitPos != null)
		{
			this.m_start.transform.position = this.m_start.m_hitPos.GetWorldPos();
		}
		if (this.m_mid.m_hitPos != null)
		{
			this.m_mid.transform.position = this.m_mid.m_hitPos.GetWorldPos();
		}
		if (this.m_end.m_triPos == null && this.m_end.m_hitPos != null)
		{
			this.m_end.transform.position = this.m_end.m_hitPos.GetWorldPos();
		}
		this.m_spline.DoUpdate();
		float tf = this.m_mid.GetComponent<CurvySplineSegment>().TF;
		Vector3 a = this.m_start.Velocity / Time.deltaTime;
		Vector3 vector = this.m_mid.Velocity / Time.deltaTime;
		Vector3 b = this.m_end.Velocity / Time.deltaTime;
		for (int i = Game.Instance.m_fluids.Count - 1; i >= 0; i--)
		{
			Fluid fluid = Game.Instance.m_fluids[i];
			if (fluid.m_stringPos != null && fluid.m_stringPos.fluidString == this)
			{
				float tf2 = fluid.m_stringPos.tf;
				Vector3 zero = Vector3.zero;
				if (tf2 <= tf)
				{
					Vector3.Lerp(a, vector, Mathf.InverseLerp(0f, tf, tf2));
				}
				else
				{
					Vector3.Lerp(vector, b, Mathf.InverseLerp(tf, 1f, tf2));
				}
				fluid.gameObject.SetActive(true);
				fluid.transform.position = fluid.m_stringPos.GetWorldPos();
				fluid.m_stringPos = null;
				fluid.m_rigidbody.velocity = Vector3.zero;
			}
		}
	}

	// Token: 0x0600024A RID: 586 RVA: 0x0001492B File Offset: 0x00012B2B
	public float GetFluidRenderSize(float tf)
	{
		return Mathf.Lerp(0.0035f, 0.006f, Mathf.InverseLerp(1f, 8f, (float)this.m_segments[this.TfToSegmentId(tf)]));
	}

	// Token: 0x0600024B RID: 587 RVA: 0x0001495A File Offset: 0x00012B5A
	public static int LengthToSegmentCount(float length)
	{
		return Mathf.CeilToInt(length * 1000f);
	}

	// Token: 0x0600024D RID: 589 RVA: 0x00014994 File Offset: 0x00012B94
	[CompilerGenerated]
	internal static bool g__outsideBox(Vector3 pos)
	{
		return pos.x < -1f || pos.x > 1f || pos.y < 0.01f || pos.y > 2f || pos.z < -1f || pos.z > 1f;
	}

	// Token: 0x040001FA RID: 506
	public CurvySpline m_spline;

	// Token: 0x040001FB RID: 507
	public FluidStringNode m_start;

	// Token: 0x040001FC RID: 508
	public FluidStringNode m_mid;

	// Token: 0x040001FD RID: 509
	public FluidStringNode m_end;

	// Token: 0x040001FE RID: 510
	public List<FluidStringNode> m_nodes;

	// Token: 0x040001FF RID: 511
	public int[] m_segments;

	// Token: 0x04000200 RID: 512
	public float m_timer;

	// Token: 0x04000201 RID: 513
	public float m_length = 0.1f;

	// Token: 0x04000202 RID: 514
	public float m_slideSpeed = 0.004f;

	// Token: 0x04000203 RID: 515
	public bool m_canAttach;

	// Token: 0x04000204 RID: 516
	public bool m_canBreak;

	// Token: 0x04000205 RID: 517
	public float m_breakTime;

	// Token: 0x04000206 RID: 518
	public float m_instantDissolveTime;

	// Token: 0x04000207 RID: 519
	public bool isLengthBreak;

	// Token: 0x04000208 RID: 520
	public float m_leakAttachTime;

	// Token: 0x04000209 RID: 521
	private float m_minLength = 0.06f;

	// Token: 0x0400020A RID: 522
	public float m_breakLength;

	// Token: 0x0400020B RID: 523
	public float m_weightFactor;

	// Token: 0x0400020C RID: 524
	public float m_maxWeight;
}

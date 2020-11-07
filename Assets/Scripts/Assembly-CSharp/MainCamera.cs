using System;
using MoonSharp.Interpreter;
using UnityEngine;

// Token: 0x02000051 RID: 81
[MoonSharpUserData]
public class MainCamera : MonoBehaviour
{
	// Token: 0x17000047 RID: 71
	// (get) Token: 0x060002C1 RID: 705 RVA: 0x0001B194 File Offset: 0x00019394
	public Ray Ray
	{
		get
		{
			return new Ray(base.transform.position, base.transform.forward);
		}
	}

	// Token: 0x17000048 RID: 72
	// (get) Token: 0x060002C2 RID: 706 RVA: 0x0001B1B1 File Offset: 0x000193B1
	public Ray MouseRay
	{
		get
		{
			return this.m_cam.ScreenPointToRay(Input.mousePosition);
		}
	}

	// Token: 0x17000049 RID: 73
	// (get) Token: 0x060002C3 RID: 707 RVA: 0x0001B1C3 File Offset: 0x000193C3
	public float DistanceMultiplier
	{
		get
		{
			return (this.m_distance - this.m_minDistance) / (this.m_maxDistance - this.m_minDistance);
		}
	}

	// Token: 0x060002C4 RID: 708 RVA: 0x0001B1E0 File Offset: 0x000193E0
	public void Init()
	{
		this.m_cam = base.GetComponent<Camera>();
		Vector3 vector = this.m_target.position - base.transform.position;
		this.m_base = new GameObject().transform;
		this.m_base.position = this.m_target.position - vector.normalized * this.m_maxDistance;
		this.m_distance = (this.m_distanceGoal = vector.magnitude);
	}

	// Token: 0x060002C5 RID: 709 RVA: 0x0001B268 File Offset: 0x00019468
	public void UpdateCamera(float deltaTime)
	{
		this.m_distance = Mathf.Lerp(this.m_distance, this.m_distanceGoal, deltaTime * this.zoomSpeed);
		base.transform.position = Vector3.Lerp(this.m_target.position, this.m_base.position, this.m_distance / this.m_maxDistance);
		base.transform.forward = this.m_target.position - base.transform.position;
		QualitySettings.shadowDistance = Mathf.Lerp(3f, 5.5f, Mathf.InverseLerp(this.m_minDistance, this.m_maxDistance, this.m_distance));
	}

	// Token: 0x060002C6 RID: 710 RVA: 0x0001B318 File Offset: 0x00019518
	public void Aim(float x, float y)
	{
		base.transform.Rotate(Vector3.up, x, Space.World);
		base.transform.Rotate(base.transform.right, y, Space.World);
		this.SetAimPoint(base.transform.position + base.transform.forward * this.m_distance);
	}

	// Token: 0x060002C7 RID: 711 RVA: 0x0001B37C File Offset: 0x0001957C
	public void SetAimPoint(Vector3 point)
	{
		this.m_target.position = point;
		Vector3 vector = this.m_target.position - base.transform.position;
		float num = vector.magnitude - this.m_distance;
		this.m_distance = vector.magnitude;
		this.m_distanceGoal += num;
		this.m_base.position = this.m_target.position - vector.normalized * this.m_maxDistance;
	}

	// Token: 0x060002C8 RID: 712 RVA: 0x0001B408 File Offset: 0x00019608
	public void RotateAroundTarget(float x = 0f, float y = 0f)
	{
		this.m_base.RotateAround(this.m_target.position, base.transform.up, x);
		this.m_base.RotateAround(this.m_target.position, base.transform.right, y);
		float num = Vector3.Angle(Vector3.up, this.m_base.position - this.m_target.position);
		if (num < 10f)
		{
			this.m_base.RotateAround(this.m_target.position, base.transform.right, -(10f - num));
			return;
		}
		if (num > 170f)
		{
			this.m_base.RotateAround(this.m_target.position, base.transform.right, num - 170f);
		}
	}

	// Token: 0x060002C9 RID: 713 RVA: 0x0001B4E4 File Offset: 0x000196E4
	public void MouseScroll(float value)
	{
		float num = this.DistanceMultiplier;
		num = Mathf.Max(num, 0.075f);
		if (value > 0f)
		{
			value = Mathf.Min(value, 1f);
			value *= Mathf.Pow(num, 1.05f);
			if (this.m_distanceGoal > this.m_distance)
			{
				this.m_distanceGoal = this.m_distance;
			}
		}
		else
		{
			value *= Mathf.Sqrt(num * 0.2f);
			if (this.m_distanceGoal < this.m_distance)
			{
				this.m_distanceGoal = this.m_distance;
			}
		}
		this.m_distanceGoal -= value;
		this.m_distanceGoal = Mathf.Clamp(this.m_distanceGoal, this.m_minDistance, this.m_maxDistance);
	}

	// Token: 0x040002D2 RID: 722
	public Camera m_cam;

	// Token: 0x040002D3 RID: 723
	public Transform m_base;

	// Token: 0x040002D4 RID: 724
	public Transform m_target;

	// Token: 0x040002D5 RID: 725
	public float m_distance;

	// Token: 0x040002D6 RID: 726
	public float m_distanceGoal;

	// Token: 0x040002D7 RID: 727
	public float m_maxDistance = 4f;

	// Token: 0x040002D8 RID: 728
	public float m_minDistance = 0.3f;

	// Token: 0x040002D9 RID: 729
	public float zoomSpeed = 1f;
}

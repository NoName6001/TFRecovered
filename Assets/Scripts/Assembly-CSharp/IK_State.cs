using System;
using MoonSharp.Interpreter;
using UnityEngine;

// Token: 0x02000050 RID: 80
[MoonSharpUserData]
public class IK_State : MonoBehaviour
{
	// Token: 0x17000044 RID: 68
	// (get) Token: 0x060002BA RID: 698 RVA: 0x0001AFFC File Offset: 0x000191FC
	// (set) Token: 0x060002BB RID: 699 RVA: 0x0001B004 File Offset: 0x00019204
	public bool Active { get; set; }

	// Token: 0x17000045 RID: 69
	// (get) Token: 0x060002BC RID: 700 RVA: 0x0001B00D File Offset: 0x0001920D
	public Transform Bone
	{
		get
		{
			return this.m_IK.m_bone;
		}
	}

	// Token: 0x17000046 RID: 70
	// (get) Token: 0x060002BD RID: 701 RVA: 0x0001B01A File Offset: 0x0001921A
	public float AngleLimit
	{
		get
		{
			return this.m_IK.m_angleLimit;
		}
	}

	// Token: 0x060002BE RID: 702 RVA: 0x0001B028 File Offset: 0x00019228
	public void UpdateState()
	{
		if (!this.Active)
		{
			this.m_IK.ResetPos(base.transform, false);
			return;
		}
		Vector3 aimPoint = base.transform.TransformPoint(this.Bone.InverseTransformPoint(this.m_aimPoint));
		Vector3 point = base.transform.TransformPoint(this.Bone.InverseTransformPoint(this.m_origin));
		base.transform.position = this.m_parent.position;
		Quaternion quaternion = Utils.GetTransformToAimAt(base.transform.position, base.transform.rotation, point, aimPoint, this.m_target, this.m_parent.up).rotation;
		float num = Quaternion.Angle(quaternion, this.Bone.parent.rotation);
		if (num - this.AngleLimit > 0f)
		{
			quaternion = Quaternion.Slerp(this.Bone.parent.rotation, quaternion, this.AngleLimit / num);
			if (this.m_limitWrap)
			{
				float t = Mathf.InverseLerp(this.AngleLimit, 180f, num);
				quaternion = Quaternion.Slerp(quaternion, this.Bone.parent.rotation, t);
			}
		}
		base.transform.rotation = Quaternion.Slerp(this.Bone.parent.rotation, quaternion, this.m_angleWeight);
	}

	// Token: 0x060002BF RID: 703 RVA: 0x0001B174 File Offset: 0x00019374
	public void AimAt(Vector3 point, Vector3 aimPoint)
	{
	}

	// Token: 0x040002C6 RID: 710
	public IK m_IK;

	// Token: 0x040002C7 RID: 711
	public Transform m_parent;

	// Token: 0x040002C8 RID: 712
	public Vector3 m_position;

	// Token: 0x040002C9 RID: 713
	public Vector3 m_target;

	// Token: 0x040002CA RID: 714
	public Vector3 m_origin;

	// Token: 0x040002CB RID: 715
	public Vector3 m_aimPoint;

	// Token: 0x040002CC RID: 716
	public float m_lerp;

	// Token: 0x040002CD RID: 717
	public bool m_limitWrap;

	// Token: 0x040002CE RID: 718
	public float m_angleWeight = 1f;

	// Token: 0x040002CF RID: 719
	public float m_distance;

	// Token: 0x040002D0 RID: 720
	public Vector3 m_angleOffset;
}

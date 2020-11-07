using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using MoonSharp.Interpreter;
using RootMotion.Dynamics;
using UnityEngine;

// Token: 0x0200004F RID: 79
[MoonSharpUserData]
public class IK : MonoBehaviour
{
	// Token: 0x17000041 RID: 65
	// (get) Token: 0x060002AE RID: 686 RVA: 0x0001A54C File Offset: 0x0001874C
	public bool IsHips
	{
		get
		{
			return this.m_bone == this.m_girl.m_rig.hips;
		}
	}

	// Token: 0x17000042 RID: 66
	// (get) Token: 0x060002AF RID: 687 RVA: 0x0001A569 File Offset: 0x00018769
	public Transform BoneParent
	{
		get
		{
			return this.m_bone.parent;
		}
	}

	// Token: 0x17000043 RID: 67
	// (get) Token: 0x060002B0 RID: 688 RVA: 0x0001A576 File Offset: 0x00018776
	// (set) Token: 0x060002B1 RID: 689 RVA: 0x0001A57E File Offset: 0x0001877E
	public Transform AttachPoint { get; set; }

	// Token: 0x060002B2 RID: 690 RVA: 0x0001A588 File Offset: 0x00018788
	public void Init(Transform bone, Girl girl, Transform bendBone = null, Vector3 bendVector = default(Vector3), Transform attachAnchor = null, Transform limbStart = null)
	{
		this.m_bone = bone;
		this.m_girl = girl;
		if (this.m_bone == null)
		{
			return;
		}
		this.m_states = new List<IK_State>
		{
			this.m_rest,
			this.m_enter,
			this.m_final
		};
		foreach (IK_State ik_State in this.m_states)
		{
			ik_State.m_IK = this;
		}
		if (bendBone)
		{
			this.m_bendBone = bendBone;
			this.m_bendTarget = this.m_offsetIK.GetChild(0);
			this.m_bendVectorLS = this.m_bendBone.InverseTransformDirection(bendVector);
		}
		Muscle muscle;
		if (this.m_girl.m_muscleDict.TryGetValue(this.m_bone, out muscle))
		{
			this.m_attachJoint = muscle.joint.gameObject.AddComponent<ConfigurableJoint>();
			this.m_attachJoint.autoConfigureConnectedAnchor = false;
			this.m_attachJoint.anchor = (attachAnchor ? this.m_bone.InverseTransformPoint(attachAnchor.position) : Vector3.zero);
		}
		this.m_limbStart = limbStart;
	}

	// Token: 0x060002B3 RID: 691 RVA: 0x0001A6CC File Offset: 0x000188CC
	public void AttachToPoint(Transform point)
	{
		this.AttachPoint = point;
		this.m_controlled = (this.m_attachJoint != null);
		if (this.AttachPoint == null)
		{
			this.m_attachJoint.connectedBody = null;
			this.m_attachJoint.xMotion = (this.m_attachJoint.yMotion = (this.m_attachJoint.zMotion = ConfigurableJointMotion.Free));
			return;
		}
		Muscle muscle;
		if (Game.Instance.m_attachDict.TryGetValue(this.AttachPoint, out muscle))
		{
			this.m_attachJoint.connectedBody = muscle.rigidbody;
			this.m_attachJoint.connectedAnchor = muscle.target.InverseTransformPoint(this.AttachPoint.position) * muscle.target.lossyScale.x;
			this.m_attachJoint.xMotion = (this.m_attachJoint.yMotion = (this.m_attachJoint.zMotion = ConfigurableJointMotion.Locked));
		}
	}

	// Token: 0x060002B4 RID: 692 RVA: 0x0001A7C0 File Offset: 0x000189C0
	public void UpdateAttachDisplay()
	{
		if (this.AttachPoint != null)
		{
			Vector3 forward = this.AttachPoint.position - this.m_limbStart.position;
			float t = Mathf.InverseLerp(0f, 0.15f, forward.magnitude - this.m_limbLimit * this.m_girl.Scale);
			this.m_offsetIK.position = (this.m_baseIK.position = this.AttachPoint.position);
			this.m_offsetIK.rotation = (this.m_baseIK.rotation = Quaternion.Slerp(this.AttachPoint.rotation, Quaternion.LookRotation(forward, this.m_offsetIK.up), t));
		}
	}

	// Token: 0x060002B5 RID: 693 RVA: 0x0001A884 File Offset: 0x00018A84
	public void UpdateIK(float deltaTime)
	{
		if (this.m_bone == null)
		{
			return;
		}
		base.transform.position = this.m_bone.position;
		if (!this.m_controlled)
		{
			foreach (IK_State ik_State in this.m_states)
			{
				ik_State.UpdateState();
			}
			IK_State ik_State2 = this.m_final.Active ? this.m_final : this.m_rest;
			if (this.m_snap)
			{
				this.m_baseIK.position = ik_State2.transform.position;
				this.m_baseIK.rotation = ik_State2.transform.rotation;
				this.m_snap = false;
			}
			else
			{
				this.m_baseIK.position = Vector3.Lerp(this.m_baseIK.position, ik_State2.transform.position, deltaTime * this.m_speed);
				this.m_baseIK.rotation = Quaternion.Slerp(this.m_baseIK.rotation, ik_State2.transform.rotation, deltaTime * this.m_speed);
			}
		}
		this.m_lastOffsetIK.position = this.m_offsetIK.position;
		this.m_lastOffsetIK.rotation = this.m_offsetIK.rotation;
		this.m_offsetIK.position = this.m_baseIK.position;
		this.m_offsetIK.rotation = this.m_baseIK.rotation;
		if (this.m_bendTarget != null && this.m_bendBone != null)
		{
			Vector3 vector = this.m_bendBone.TransformDirection(this.m_bendVectorLS);
			this.m_bendTarget.transform.position = this.m_bendBone.position + vector.normalized * 0.35f;
		}
		if (this.IsHips)
		{
			Vector3 position = this.m_offsetIK.position;
			Quaternion rotation = this.m_offsetIK.rotation;
			this.m_offsetIK.position = this.m_bone.position;
			this.m_offsetIK.rotation = this.m_bone.rotation;
			Transform lThigh = this.m_girl.m_rig.lThigh;
			Transform rThigh = this.m_girl.m_rig.rThigh;
			this.m_girl.m_lThighIK.transform.position = lThigh.position;
			this.m_girl.m_rThighIK.transform.position = rThigh.position;
			this.m_offsetIK.position = position;
			this.m_offsetIK.rotation = rotation;
		}
		if (this.m_controlled && this.m_controlTimer > 0f)
		{
			this.m_controlTimer -= deltaTime;
			if (this.m_controlTimer <= 0f)
			{
				this.m_controlled = false;
			}
		}
		if (this.m_isEye)
		{
			this.m_bone.rotation = this.m_offsetIK.rotation;
		}
		Muscle muscle;
		if (this.AttachPoint != null && Game.Instance.m_attachDict.TryGetValue(this.AttachPoint, out muscle))
		{
			this.m_attachJoint.connectedAnchor = muscle.target.InverseTransformPoint(this.AttachPoint.position) * muscle.target.lossyScale.x;
		}
	}

	// Token: 0x060002B6 RID: 694 RVA: 0x0001ABEC File Offset: 0x00018DEC
	public void ResetPos(Transform tf = null, bool keepRotation = false)
	{
		if (this.m_bone == null)
		{
			return;
		}
		tf = (tf ?? this.m_offsetIK);
		tf.position = this.m_bone.position;
		if (keepRotation)
		{
			this.m_bone.rotation = tf.rotation;
			return;
		}
		tf.rotation = this.m_bone.rotation;
	}

	// Token: 0x060002B7 RID: 695 RVA: 0x0001AC4C File Offset: 0x00018E4C
	public void MoveBase(Vector3 pos)
	{
		this.m_controlled = true;
		Vector3 vector = pos - base.transform.position;
		float num = Vector3.Dot(vector.normalized, base.transform.right);
		float num2 = Vector3.Dot(vector.normalized, base.transform.up);
		float num3 = Vector3.Dot(vector.normalized, base.transform.forward);
		float d = ((num > 0f) ? this.m_xLimit.x : (-this.m_xLimit.y)) * this.m_girl.Scale;
		float d2 = ((num2 > 0f) ? this.m_yLimit.x : (-this.m_yLimit.y)) * this.m_girl.Scale;
		float d3 = ((num3 > 0f) ? this.m_zLimit.x : (-this.m_zLimit.y)) * this.m_girl.Scale;
		Vector3 vector2 = base.transform.position + base.transform.right * d;
		Plane item = new Plane(base.transform.position - vector2, vector2);
		Vector3 vector3 = base.transform.position + base.transform.up * d2;
		Plane item2 = new Plane(base.transform.position - vector3, vector3);
		Vector3 vector4 = base.transform.position + base.transform.forward * d3;
		Plane item3 = new Plane(base.transform.position - vector4, vector4);
		List<ValueTuple<Plane, float>> list = new List<ValueTuple<Plane, float>>
		{
			new ValueTuple<Plane, float>(item, 999f),
			new ValueTuple<Plane, float>(item2, 999f),
			new ValueTuple<Plane, float>(item3, 999f)
		};
		for (int i = 0; i < list.Count; i++)
		{
			Plane item4 = list[i].Item1;
			float item5;
			if (item4.Raycast(new Ray(base.transform.position, vector.normalized), out item5))
			{
				list[i] = new ValueTuple<Plane, float>(item4, item5);
			}
		}
		list.Sort((ValueTuple<Plane, float> a, ValueTuple<Plane, float> b) => a.Item2.CompareTo(b.Item2));
		float item6 = list[0].Item2;
		if (vector.magnitude > item6)
		{
			pos = base.transform.position + vector.normalized * item6;
		}
		this.m_baseIK.position = pos;
	}

	// Token: 0x060002B8 RID: 696 RVA: 0x0001AF08 File Offset: 0x00019108
	public void ApplyRotationLimit()
	{
		this.m_bone.rotation = Utils.RotateToLimit(this.m_bone.rotation, this.BoneParent.rotation, this.m_angleLimit);
		this.m_baseIK.rotation = Utils.RotateToLimit(this.m_baseIK.rotation, this.BoneParent.rotation, this.m_angleLimit);
		this.m_offsetIK.rotation = Utils.RotateToLimit(this.m_offsetIK.rotation, this.BoneParent.rotation, this.m_angleLimit);
	}

	// Token: 0x040002AD RID: 685
	private Girl m_girl;

	// Token: 0x040002AE RID: 686
	public Transform m_bone;

	// Token: 0x040002AF RID: 687
	public IK_State m_rest;

	// Token: 0x040002B0 RID: 688
	public IK_State m_enter;

	// Token: 0x040002B1 RID: 689
	public IK_State m_final;

	// Token: 0x040002B2 RID: 690
	public Transform m_baseIK;

	// Token: 0x040002B3 RID: 691
	public Transform m_offsetIK;

	// Token: 0x040002B4 RID: 692
	public Transform m_lastOffsetIK;

	// Token: 0x040002B5 RID: 693
	public List<IK_State> m_states;

	// Token: 0x040002B6 RID: 694
	public float m_speed = 2f;

	// Token: 0x040002B7 RID: 695
	public Vector2 m_xLimit = Vector3.zero;

	// Token: 0x040002B8 RID: 696
	public Vector2 m_yLimit = Vector3.zero;

	// Token: 0x040002B9 RID: 697
	public Vector2 m_zLimit = Vector3.zero;

	// Token: 0x040002BA RID: 698
	public float m_angleLimit = 360f;

	// Token: 0x040002BB RID: 699
	public bool m_isEye;

	// Token: 0x040002BC RID: 700
	public float m_limbLimit;

	// Token: 0x040002BD RID: 701
	public Transform m_limbStart;

	// Token: 0x040002BE RID: 702
	public ConfigurableJoint m_attachJoint;

	// Token: 0x040002BF RID: 703
	[HideInInspector]
	public Transform m_bendBone;

	// Token: 0x040002C0 RID: 704
	[HideInInspector]
	public Transform m_bendTarget;

	// Token: 0x040002C1 RID: 705
	[HideInInspector]
	public Vector3 m_bendVectorLS;

	// Token: 0x040002C2 RID: 706
	public bool m_snap = true;

	// Token: 0x040002C3 RID: 707
	private float m_controlTimer;

	// Token: 0x040002C4 RID: 708
	public bool m_controlled;
}

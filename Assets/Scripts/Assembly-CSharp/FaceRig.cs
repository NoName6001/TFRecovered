using System;
using System.Collections.Generic;
using MoonSharp.Interpreter;
using UnityEngine;

// Token: 0x02000043 RID: 67
[ExecuteInEditMode]
[MoonSharpUserData]
public class FaceRig : MonoBehaviour
{
	// Token: 0x06000228 RID: 552 RVA: 0x0001280A File Offset: 0x00010A0A
	public void Init(Girl girl)
	{
		if (this.m_rig.head == null)
		{
			return;
		}
		this.m_boneList = new List<Transform>();
		this.SaveDefaultFace(this.m_rig.head);
		this.CacheBones();
		bool isPlaying = Application.isPlaying;
	}

	// Token: 0x06000229 RID: 553 RVA: 0x00012848 File Offset: 0x00010A48
	public void CacheBones()
	{
		if (!Application.isPlaying && (this.m_defaultPose == null || this.m_defaultPose.Count == 0))
		{
			this.m_defaultPose = new Dictionary<Transform, List<Vector3>>();
			this.SaveDefaultFace(this.m_rig.head);
		}
		this.m_boneList = new List<Transform>();
		foreach (FaceControl faceControl in this.controls)
		{
			foreach (FaceBone faceBone in faceControl.bones)
			{
				Transform transform = faceBone.transform;
				if (transform != null && !this.m_boneList.Contains(transform))
				{
					this.m_boneList.Add(transform);
				}
			}
		}
		this.m_defaultBones = new List<List<Vector3>>();
		this.m_boneControls = new List<List<int>>();
		foreach (Transform transform2 in this.m_boneList)
		{
			this.m_defaultBones.Add(this.m_defaultPose[transform2]);
			List<int> list = new List<int>();
			for (int i = 0; i < this.controls.Count; i++)
			{
				Vector3 localPosition = this.controls[i].transform.localPosition;
				for (int j = 0; j < this.controls[i].bones.Count; j++)
				{
					if (this.controls[i].bones[j].transform == transform2)
					{
						list.Add(i);
						list.Add(j);
					}
				}
			}
			this.m_boneControls.Add(list);
		}
	}

	// Token: 0x0600022A RID: 554 RVA: 0x00012A50 File Offset: 0x00010C50
	public void SaveDefaultFace(Transform tf)
	{
		if (this.m_defaultPose == null)
		{
			this.m_defaultPose = new Dictionary<Transform, List<Vector3>>();
		}
		if (!this.m_defaultPose.ContainsKey(tf))
		{
			this.m_defaultPose.Add(tf, new List<Vector3>
			{
				tf.localPosition,
				tf.localEulerAngles,
				tf.localScale
			});
		}
		foreach (object obj in tf)
		{
			Transform tf2 = (Transform)obj;
			this.SaveDefaultFace(tf2);
		}
	}

	// Token: 0x0600022B RID: 555 RVA: 0x00012AFC File Offset: 0x00010CFC
	public void UpdateFace()
	{
		if (!this.m_active)
		{
			return;
		}
		if (this.m_rigging)
		{
			this.CacheBones();
		}
		int count = this.m_boneList.Count;
		for (int i = 0; i < count; i++)
		{
			Transform transform = this.m_boneList[i];
			List<Vector3> list = this.m_defaultBones[i];
			List<int> list2 = this.m_boneControls[i];
			Vector3 vector = list[0];
			Vector3 vector2 = list[1];
			Vector3 vector3 = list[2];
			for (int j = 0; j < list2.Count; j += 2)
			{
				FaceControl faceControl = this.controls[list2[j]];
				FaceBone faceBone = faceControl.bones[list2[j + 1]];
				Vector3 vector4 = faceControl.transform.localPosition;
				if (this.m_offsetActive)
				{
					vector4 += faceControl.offset;
					Vector3 scale = faceControl.scale;
					vector4 = new Vector3(vector4.x * (1f + scale.x), vector4.y * (1f + scale.y), vector4.z * (1f + scale.z));
				}
				Vector3 vector5 = faceBone.xPosWeight / this.m_scale;
				Vector3 vector6 = faceBone.yPosWeight / this.m_scale;
				vector += new Vector3(vector5.x * vector4.x, vector5.y * vector4.x, vector5.z * vector4.x);
				vector2 += new Vector3(faceBone.xAngleWeight.x * vector4.x, faceBone.xAngleWeight.y * vector4.x, faceBone.xAngleWeight.z * vector4.x);
				vector3 = new Vector3(vector3.x * (1f + faceBone.xScaleWeight.x * vector4.x), vector3.y * (1f + faceBone.xScaleWeight.y * vector4.x), vector3.z * (1f + faceBone.xScaleWeight.z * vector4.x));
				vector += new Vector3(vector6.x * vector4.y, vector6.y * vector4.y, vector6.z * vector4.y);
				vector2 += new Vector3(faceBone.yAngleWeight.x * vector4.y, faceBone.yAngleWeight.y * vector4.y, faceBone.yAngleWeight.z * vector4.y);
				vector3 = new Vector3(vector3.x * (1f + faceBone.yScaleWeight.x * vector4.y), vector3.y * (1f + faceBone.yScaleWeight.y * vector4.y), vector3.z * (1f + faceBone.yScaleWeight.z * vector4.y));
			}
			transform.localPosition = vector;
			transform.localEulerAngles = vector2;
			transform.localScale = vector3;
		}
	}

	// Token: 0x040001CA RID: 458
	public Rig m_rig;

	// Token: 0x040001CB RID: 459
	public bool m_active;

	// Token: 0x040001CC RID: 460
	public bool m_reset;

	// Token: 0x040001CD RID: 461
	public bool m_rigging;

	// Token: 0x040001CE RID: 462
	public bool m_offsetActive;

	// Token: 0x040001CF RID: 463
	public bool m_saveDefault;

	// Token: 0x040001D0 RID: 464
	public float m_scale = 1f;

	// Token: 0x040001D1 RID: 465
	public List<FaceControl> controls;

	// Token: 0x040001D2 RID: 466
	private List<Transform> m_boneList;

	// Token: 0x040001D3 RID: 467
	private List<List<Vector3>> m_defaultBones;

	// Token: 0x040001D4 RID: 468
	private List<List<int>> m_boneControls;

	// Token: 0x040001D5 RID: 469
	private Dictionary<Transform, List<Vector3>> m_defaultPose;
}

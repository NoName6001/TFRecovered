using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using FluffyUnderware.Curvy;
using MoonSharp.Interpreter;
using RootMotion.Dynamics;
using UnityEngine;

// Token: 0x02000052 RID: 82
[MoonSharpUserData]
public class Penis : MonoBehaviour
{
	// Token: 0x1700004A RID: 74
	// (get) Token: 0x060002CB RID: 715 RVA: 0x0001B5C2 File Offset: 0x000197C2
	public bool IsShooting
	{
		get
		{
			return this.m_timer < this.m_stopTime;
		}
	}

	// Token: 0x1700004B RID: 75
	// (get) Token: 0x060002CC RID: 716 RVA: 0x0001B5D2 File Offset: 0x000197D2
	public bool IsFree
	{
		get
		{
			return this.m_spline.ControlPoints.Contains(this.m_tipIK);
		}
	}

	// Token: 0x1700004C RID: 76
	// (get) Token: 0x060002CD RID: 717 RVA: 0x0001B5EA File Offset: 0x000197EA
	public bool IsControlled
	{
		get
		{
			return this.m_colliders[0].GetComponent<Rigidbody>().isKinematic;
		}
	}

	// Token: 0x1700004D RID: 77
	// (get) Token: 0x060002CE RID: 718 RVA: 0x0001B602 File Offset: 0x00019802
	public float Scale
	{
		get
		{
			return base.transform.lossyScale.x;
		}
	}

	// Token: 0x1700004E RID: 78
	// (get) Token: 0x060002CF RID: 719 RVA: 0x0001B614 File Offset: 0x00019814
	public float Length
	{
		get
		{
			return this.m_length * this.Scale;
		}
	}

	// Token: 0x1700004F RID: 79
	// (get) Token: 0x060002D0 RID: 720 RVA: 0x0001B623 File Offset: 0x00019823
	// (set) Token: 0x060002D1 RID: 721 RVA: 0x0001B62B File Offset: 0x0001982B
	public List<float> BoneDistances { get; set; }

	// Token: 0x17000050 RID: 80
	// (get) Token: 0x060002D2 RID: 722 RVA: 0x0001B634 File Offset: 0x00019834
	public Rigidbody Base
	{
		get
		{
			return this.m_colliders[0].GetComponent<Rigidbody>();
		}
	}

	// Token: 0x17000051 RID: 81
	// (get) Token: 0x060002D3 RID: 723 RVA: 0x0001B647 File Offset: 0x00019847
	// (set) Token: 0x060002D4 RID: 724 RVA: 0x0001B64F File Offset: 0x0001984F
	public float InsideLength { get; set; }

	// Token: 0x17000052 RID: 82
	// (get) Token: 0x060002D5 RID: 725 RVA: 0x0001B658 File Offset: 0x00019858
	public float AverageVelocity
	{
		get
		{
			if (this.m_lengths.Count <= 0)
			{
				return 0f;
			}
			return Mathf.Abs(this.m_lengths[this.m_lengths.Count - 1].Item1 - this.m_lengths[0].Item1);
		}
	}

	// Token: 0x17000053 RID: 83
	// (get) Token: 0x060002D6 RID: 726 RVA: 0x0001B6B0 File Offset: 0x000198B0
	public Girl ConnectedGirl
	{
		get
		{
			Girl girl = this.m_spline[this.m_spline.Count - 1].m_girl;
			if (girl != this.m_girl)
			{
				return girl;
			}
			return null;
		}
	}

	// Token: 0x060002D7 RID: 727 RVA: 0x0001B6EC File Offset: 0x000198EC
	public void Init(Girl girl)
	{
		this.m_girl = girl;
		this.m_timer = this.m_stopTime;
		this.m_spline.m_girl = this.m_girl;
		Rig rig = this.m_girl.m_rig;
		this.m_bones = new List<Transform>(rig.penis);
		if (this.m_bones.Count == 0)
		{
			this.m_girl.m_penis = null;
			return;
		}
		if (this.m_bones.Count > 0)
		{
			this.m_defaultPose = new List<List<Vector3>>();
			this.m_boneDists = new List<float>();
			Transform transform = this.m_bones[0];
			for (int i = 0; i < this.m_bones.Count; i++)
			{
				Transform transform2 = this.m_bones[i];
				transform2.parent = transform.parent;
				List<Vector3> item = new List<Vector3>
				{
					transform2.localPosition,
					transform2.localEulerAngles,
					transform2.localScale / this.Scale,
					transform2.InverseTransformDirection(base.transform.forward)
				};
				this.m_boneDists.Add(Vector3.Distance(transform2.position, transform.position) / this.Scale);
				this.m_defaultPose.Add(item);
			}
			base.transform.parent = this.m_bones[0].parent;
			base.transform.localPosition = this.m_bones[0].localPosition;
			this.m_initScale = base.transform.localScale.x / this.m_girl.transform.localScale.x;
			this.m_tipIK.transform.position = rig.penisTip.position;
			this.m_midIK.transform.position = (this.m_tipIK.transform.position + this.m_rootIK.transform.position) / 2f;
			this.m_spline.DoUpdate();
			this.m_length = this.m_tipIK.Length / this.Scale;
			this.m_tipIK.m_girl = (this.m_rootIK.m_girl = (this.m_midIK.m_girl = this.m_girl));
			float num = Vector3.Distance(this.m_tipIK.transform.position, this.m_rootIK.transform.position);
			Rigidbody rigidbody = base.gameObject.AddComponent<Rigidbody>();
			rigidbody.isKinematic = true;
			float num2 = 6f;
			float num3 = 0.02f;
			this.m_colliders = new List<Collider>();
			this.m_colliderDists = new List<float>();
			this.m_joints = new List<CharacterJoint>();
			this.m_anchors = new List<Transform>();
			float num4 = num3;
			float num5 = num - num3;
			int num6 = 0;
			while ((float)num6 < num2)
			{
				float num7 = Mathf.Lerp(num4, num5, (float)num6 / num2);
				Vector3 position = Vector3.Lerp(this.m_rootIK.transform.position, this.m_tipIK.transform.position, num7 / num);
				this.m_colliderDists.Add(num7 / this.Scale);
				GameObject gameObject = new GameObject();
				gameObject.name = "PenisRagdoll_" + num6;
				gameObject.layer = LayerMask.NameToLayer("Ragdoll");
				gameObject.transform.parent = base.transform;
				gameObject.transform.position = position;
				gameObject.transform.rotation = this.m_tipIK.transform.rotation;
				CapsuleCollider capsuleCollider = gameObject.AddComponent<CapsuleCollider>();
				capsuleCollider.direction = 2;
				capsuleCollider.radius = num3;
				capsuleCollider.height = (num5 - num4) / num2 + num3 * 2f;
				capsuleCollider.center = new Vector3(0f, 0f, (capsuleCollider.height - num3 * 2f) / 2f);
				this.m_colliders.Add(capsuleCollider);
				gameObject.AddComponent<Rigidbody>().mass = 0.5f / num2;
				Rigidbody rigidbody2 = (num6 == 0) ? rigidbody : this.m_colliders[num6 - 1].attachedRigidbody;
				CharacterJoint characterJoint = gameObject.AddComponent<CharacterJoint>();
				characterJoint.connectedBody = rigidbody2;
				characterJoint.anchor = new Vector3(0f, 0f, 0f);
				CharacterJoint characterJoint2 = characterJoint;
				SoftJointLimit softJointLimit = new SoftJointLimit
				{
					limit = this.m_downAngle / num2
				};
				characterJoint2.lowTwistLimit = softJointLimit;
				CharacterJoint characterJoint3 = characterJoint;
				softJointLimit = new SoftJointLimit
				{
					limit = ((num6 == 0) ? 60f : (this.m_upAngle / num2))
				};
				characterJoint3.highTwistLimit = softJointLimit;
				CharacterJoint characterJoint4 = characterJoint;
				softJointLimit = new SoftJointLimit
				{
					limit = 0f
				};
				characterJoint4.swing1Limit = softJointLimit;
				CharacterJoint characterJoint5 = characterJoint;
				softJointLimit = new SoftJointLimit
				{
					limit = 0f
				};
				characterJoint5.swing2Limit = softJointLimit;
				characterJoint.autoConfigureConnectedAnchor = false;
				this.m_joints.Add(characterJoint);
				Transform transform3 = new GameObject().transform;
				transform3.parent = rigidbody2.transform;
				transform3.position = gameObject.transform.position;
				this.m_anchors.Add(transform3);
				num6++;
			}
			for (int j = 0; j < this.m_colliders.Count; j++)
			{
				Collider collider = this.m_colliders[j];
				collider.attachedRigidbody.solverIterations = 30;
				collider.attachedRigidbody.solverVelocityIterations = 30;
				foreach (Collider collider2 in this.m_colliders)
				{
					if (collider != collider2)
					{
						Physics.IgnoreCollision(collider, collider2, true);
					}
				}
				if (j < this.m_colliders.Count - 1)
				{
					Muscle[] muscles = this.m_girl.m_puppet.muscles;
					for (int k = 0; k < muscles.Length; k++)
					{
						foreach (Collider collider3 in muscles[k].colliders)
						{
							Physics.IgnoreCollision(collider, collider3, true);
						}
					}
				}
			}
			this.m_midIK.transform.parent = this.m_colliders[Mathf.FloorToInt((num2 - 1f) / 2f)].transform;
			this.m_tipIK.transform.parent = this.m_colliders[(int)num2 - 1].transform;
			List<ValueTuple<TrianglePos, float>> list = new List<ValueTuple<TrianglePos, float>>();
			foreach (AdvancedCollider advancedCollider in this.m_girl.m_colliders)
			{
				Transform penisTip = this.m_girl.m_rig.penisTip;
				Vector3 vector = penisTip.position + penisTip.forward * 0.01f;
				Ray ray = new Ray(vector, penisTip.position - vector);
				RaycastHit raycastHit;
				if (advancedCollider.m_meshCollider.Raycast(ray, out raycastHit, 0.05f))
				{
					list.Add(new ValueTuple<TrianglePos, float>(new TrianglePos(advancedCollider, raycastHit.triangleIndex, raycastHit.barycentricCoordinate, default(Vector3)), Vector3.Distance(raycastHit.point, vector)));
				}
			}
			list.Sort((ValueTuple<TrianglePos, float> a, ValueTuple<TrianglePos, float> b) => a.Item2.CompareTo(b.Item2));
			this.m_tipTriPos = list[0].Item1;
			this.m_lengths = new List<ValueTuple<float, float>>();
			this.m_AS = base.gameObject.AddComponent<AudioSource>();
			this.m_AS.clip = Resources.Load<AudioClip>("Sounds/Inside_Loop");
			this.m_AS.spatialBlend = 1f;
			this.m_AS.loop = true;
			this.m_AS.volume = 0f;
			this.m_AS.Play();
			foreach (AdvancedCollider advancedCollider2 in this.m_girl.m_colliders)
			{
				advancedCollider2.InitPenisSkinWrap();
			}
		}
	}

	// Token: 0x060002D8 RID: 728 RVA: 0x0001BF74 File Offset: 0x0001A174
	public void UpdateBones()
	{
		for (int i = 0; i < this.m_joints.Count; i++)
		{
			this.m_joints[i].connectedAnchor = this.m_anchors[i].localPosition;
		}
		if (this.m_bones.Count > 0)
		{
			this.UpdateSpline();
			List<List<Vector3>> list = new List<List<Vector3>>();
			List<Quaternion> list2 = new List<Quaternion>();
			for (int j = 0; j < this.m_bones.Count; j++)
			{
				Transform transform = this.m_bones[j];
				List<Vector3> list3 = this.m_defaultPose[j];
				list.Add(new List<Vector3>
				{
					transform.localPosition,
					transform.localScale
				});
				list2.Add(transform.localRotation);
				transform.localPosition = list3[0];
				transform.localEulerAngles = list3[1];
				transform.localScale = list3[2] * (base.transform.localScale.x / this.m_initScale);
			}
			Vector3 position = this.m_bones[0].position;
			List<Vector3> list4 = new List<Vector3>();
			float num = this.IsFree ? 1f : (1f + this.m_girl.MouthEnterDist / this.Length);
			float num2 = -1f;
			Girl connectedGirl = this.ConnectedGirl;
			if (connectedGirl != null)
			{
				num2 = connectedGirl.LipsDistance;
				Mathf.InverseLerp(0.8f, 0f, num2 / (this.Length * num));
			}
			this.BoneDistances = new List<float>();
			for (int k = 0; k < this.m_bones.Count; k++)
			{
				Transform transform2 = this.m_bones[k];
				float num3 = this.m_boneDists[k] * num * this.Scale;
				if (num2 != -1f && k < this.m_bones.Count - 1)
				{
					float t = Mathf.InverseLerp(connectedGirl.m_mouthSqueezeDist, 0f, Mathf.Abs(num3 - num2));
					num3 -= Mathf.Lerp(0f, connectedGirl.m_mouthSlide, t);
				}
				Vector3 item = this.m_spline.InterpolateByDistance(num3);
				list4.Add(item);
				this.BoneDistances.Add(num3);
			}
			Vector3 item2 = this.m_spline.InterpolateByDistance(this.m_length * num * this.Scale);
			list4.Add(item2);
			this.BoneDistances.Add(this.Length * num);
			for (int l = 0; l < list4.Count - 1; l++)
			{
				Transform transform3 = this.m_bones[l];
				Vector3 vector = list4[l];
				Vector3 a = list4[l + 1];
				Vector3 vector2 = transform3.TransformDirection(this.m_defaultPose[l][3]);
				Vector3 normalized = (a - vector).normalized;
				transform3.position = vector;
				transform3.rotation = Quaternion.FromToRotation(vector2.normalized, normalized) * transform3.rotation;
				if (num2 != -1f && l > 0)
				{
					float num4 = this.BoneDistances[l];
					float t2 = Mathf.InverseLerp(connectedGirl.m_mouthSqueezeDist, 0f, Mathf.Abs(num4 - num2));
					transform3.localScale *= Mathf.Lerp(1f, connectedGirl.m_mouthSqueeze, t2);
				}
			}
			for (int m = 0; m < this.m_bones.Count; m++)
			{
				Transform transform4 = this.m_bones[m];
				List<Vector3> list5 = list[m];
				Quaternion a2 = list2[m];
				transform4.localPosition = Vector3.Lerp(list5[0], transform4.localPosition, this.m_lerp);
				transform4.localRotation = Quaternion.Slerp(a2, transform4.localRotation, this.m_lerp);
				transform4.localScale = Vector3.Lerp(list5[1], transform4.localScale, this.m_lerp);
			}
		}
	}

	// Token: 0x060002D9 RID: 729 RVA: 0x0001C3AC File Offset: 0x0001A5AC
	public void ConnectTo(Girl girl = null)
	{
		if (girl != null)
		{
			this.g__removeAll();
			List<CurvySplineSegment> mouth = girl.m_mouth;
			for (int i = 0; i < mouth.Count; i++)
			{
				CurvySplineSegment cp = mouth[i];
				CurvySplineSegment controlPoint = (i == 0) ? this.m_rootIK : mouth[i - 1];
				this.m_spline.InsertAfter(controlPoint, cp);
			}
			foreach (Collider collider in this.m_colliders)
			{
				collider.enabled = false;
			}
			this.g__lerpPos();
			girl.m_headIK.m_controlled = true;
			this.m_girl.m_hipsIK.m_controlled = true;
		}
		else
		{
			for (int j = 0; j < this.m_colliders.Count; j++)
			{
				Collider collider2 = this.m_colliders[j];
				float z = this.m_colliderDists[j] * this.Scale;
				collider2.transform.localPosition = new Vector3(0f, 0f, z);
				collider2.transform.localEulerAngles = Vector3.zero;
				collider2.enabled = true;
			}
			for (int k = 0; k < this.m_colliders.Count; k++)
			{
				Collider collider3 = this.m_colliders[k];
				float distance = this.m_colliderDists[k] * this.Scale;
				collider3.transform.position = this.m_spline.InterpolateByDistance(distance);
				collider3.transform.forward = this.m_spline.GetTangentByDistance(distance);
			}
			this.g__removeAll();
			this.m_spline.InsertAfter(this.m_rootIK, this.m_midIK);
			this.m_spline.InsertAfter(this.m_midIK, this.m_tipIK);
			this.m_spline.InsertAfter(this.m_tipIK, this.m_tipEnd);
			this.g__lerpPos();
		}
		this.UpdateSpline();
	}

	// Token: 0x060002DA RID: 730 RVA: 0x0001C5B0 File Offset: 0x0001A7B0
	public void SaveInsideLength(float length)
	{
		this.m_lengths.RemoveAll((ValueTuple<float, float> a) => Time.time - a.Item2 > 0.5f);
		this.m_lengths.Add(new ValueTuple<float, float>(length, Time.time));
	}

	// Token: 0x060002DB RID: 731 RVA: 0x0001C600 File Offset: 0x0001A800
	public float GetSizeAtLength(float length, bool isInside)
	{
		float num = this.Length + (isInside ? this.m_girl.MouthEnterDist : 0f);
		float num2 = Mathf.Clamp01(length / num);
		for (int i = 0; i < this.m_sizes.Count - 1; i++)
		{
			Vector2 vector = this.m_sizes[i];
			Vector2 vector2 = this.m_sizes[i + 1];
			if (num2 >= vector.x && num2 <= vector2.x)
			{
				return Mathf.Lerp(vector.y, vector2.y, Mathf.InverseLerp(vector.x, vector2.x, num2)) * this.Scale;
			}
		}
		return 0f;
	}

	// Token: 0x060002DC RID: 732 RVA: 0x0001C6AD File Offset: 0x0001A8AD
	public void UpdateSpline()
	{
		this.m_spline.DoUpdate();
	}

	// Token: 0x060002DD RID: 733 RVA: 0x0001C6BA File Offset: 0x0001A8BA
	public float GetNearestPointDistance(Vector3 point)
	{
		return this.m_spline.TFToDistance(this.m_spline.GetNearestPointTF(point));
	}

	// Token: 0x060002DE RID: 734 RVA: 0x0001C6D4 File Offset: 0x0001A8D4
	public void StartShooting()
	{
		this.m_timer = 0f;
		this.m_emitTime = this.m_emitRange.GetRandom();
		this.m_force = this.m_forceRange.GetRandom();
		this.m_slideSpeed = this.m_slideSpdRange.GetRandom();
		this.m_lengthLeft = this.m_maxLength;
		this.m_angleUpTime = this.m_emitTime - 0.1f;
		this.m_fString = null;
		this.m_fStringTime = ((UnityEngine.Random.value > 0.7f) ? UnityEngine.Random.Range(0.1f, 0.2f) : 999f);
		if (this.m_stopTime < this.m_emitTime || this.m_stopTime < this.m_angleUpTime + this.m_angleDownTime)
		{
			this.m_stopTime = Mathf.Max(this.m_emitTime, this.m_angleUpTime + this.m_angleDownTime);
		}
		this.m_fluids = new List<Fluid>();
	}

	// Token: 0x060002DF RID: 735 RVA: 0x0001C7B8 File Offset: 0x0001A9B8
	public void UpdatePenis(float deltaTime)
	{
		float volume = 0f;
		float pitch = 1f;
		if (!this.IsFree)
		{
			float averageVelocity = this.AverageVelocity;
			volume = Mathf.InverseLerp(0f, 0.05f, averageVelocity);
			pitch = Mathf.Lerp(1f, 3f, Mathf.InverseLerp(0f, 0.05f, averageVelocity));
		}
		this.m_AS.pitch = pitch;
		this.m_AS.volume = volume;
		if (this.IsShooting)
		{
			float num;
			if (this.m_timer >= 0f && this.m_timer <= this.m_angleUpTime)
			{
				num = Mathf.InverseLerp(0f, this.m_angleUpTime, this.m_timer);
			}
			else
			{
				num = Mathf.InverseLerp(this.m_angleUpTime + this.m_angleDownTime, this.m_angleUpTime, this.m_timer);
			}
			num = Mathf.Sqrt(num);
			for (int i = 1; i < this.m_joints.Count; i++)
			{
				CharacterJoint characterJoint = this.m_joints[i];
				float b = (this.m_downAngle + this.m_upAngle) / 2f;
				float limit = Mathf.Lerp(this.m_downAngle, b, num * 0.9f) / (float)this.m_joints.Count;
				float limit2 = Mathf.Lerp(this.m_upAngle, b, num * 0.9f) / (float)this.m_joints.Count;
				characterJoint.lowTwistLimit = new SoftJointLimit
				{
					limit = limit
				};
				characterJoint.highTwistLimit = new SoftJointLimit
				{
					limit = limit2
				};
			}
			float num2 = Mathf.InverseLerp(0.1f, this.m_emitTime, this.m_timer);
			if (!this.IsFree && this.ConnectedGirl.LipsDistance <= this.Length * 0.95f)
			{
				num2 = -1f;
			}
			bool flag = num2 < 0f || num2 >= 1f;
			if (this.m_penisCollider.m_meshCollider.enabled != flag)
			{
				this.m_penisCollider.m_meshCollider.enabled = flag;
			}
			if (num2 >= 0f && Game.Instance.m_fluidPool.Count > 0)
			{
				bool flag2 = this.m_fluids.Count > 0;
				Transform penisBarrel = this.m_girl.m_rig.penisBarrel;
				float num3 = 0f;
				float num4 = 1f;
				float num5 = 1f;
				Vector3 vector = penisBarrel.forward * this.m_force;
				vector = Quaternion.AngleAxis(UnityEngine.Random.Range(-this.m_maxRdmAngle, this.m_maxRdmAngle), penisBarrel.up) * vector;
				Vector3 position = penisBarrel.position;
				Vector3 b2 = vector;
				if (flag2)
				{
					Fluid fluid = this.m_fluids[this.m_fluids.Count - 1];
					num3 = Vector3.Distance(fluid.transform.position, penisBarrel.position);
					num4 = num3 / Game.Instance.fluidSeparation;
					num5 = num4 * Mathf.Min(num3, this.m_lengthLeft) / num3;
					position = fluid.transform.position;
					b2 = fluid.Velocity.normalized * vector.magnitude;
				}
				int num6 = 0;
				while ((float)num6 < num5)
				{
					float num7 = 1f - (float)num6 / num4;
					float size = Mathf.Lerp(this.m_sizeRange.x, this.m_sizeRange.y, Mathf.Sqrt(UnityEngine.Random.value));
					Vector3 position2 = penisBarrel.position;
					Vector3 force = Vector3.Slerp(vector, b2, num7);
					if (flag2)
					{
						Vector3 vector2 = position - penisBarrel.position;
						Vector3 vector3 = penisBarrel.position + vector.normalized * vector2.magnitude;
						Vector3 a = Vector3.Lerp(penisBarrel.position, vector3, Mathf.Sqrt(num7));
						Vector3 b3 = Vector3.Lerp(vector3, position, num7);
						position2 = Vector3.Lerp(a, b3, num7);
					}
					Fluid fluid2 = Game.Instance.AddFluid(position2);
					if (fluid2 == null)
					{
						break;
					}
					fluid2.m_size = size;
					fluid2.m_slideSpeed = this.m_slideSpeed * UnityEngine.Random.Range(0.95f, 1.05f);
					fluid2.transform.localScale = Vector3.one * fluid2.m_size;
					fluid2.m_rigidbody.AddForce(force, ForceMode.Acceleration);
					this.m_fluids.Add(fluid2);
					if (UnityEngine.Random.value > 0.9f)
					{
						Fluid fluid3 = Game.Instance.AddFluid(this.m_girl.m_rig.penisTip.position);
						if (fluid3 != null)
						{
							fluid3.AddToCollider(this.m_tipTriPos);
						}
					}
					num6++;
				}
				int num8 = 200;
				if (this.m_fString == null && num2 >= this.m_fStringTime && Game.Instance.m_fStringPool.Count > 0 && Game.Instance.m_fluidPool.Count >= num8)
				{
					Vector3 position3 = this.m_girl.m_rig.penisTip.position;
					this.m_fString = Game.Instance.AddFluidString(position3, position3, position3, 0.13f, false, -1f);
					Fluid fluid4 = this.m_fluids[this.m_fluids.Count - 1];
					this.m_fString.m_start.transform.position = fluid4.transform.position;
					this.m_fString.m_start.m_followFluid = fluid4;
					this.m_fString.m_end.AddToCollider(this.m_tipTriPos, true);
					this.m_fString.m_slideSpeed = this.m_slideSpeed * UnityEngine.Random.Range(0.95f, 1.05f);
					this.m_fString.m_canAttach = true;
					for (float num9 = 0f; num9 < (float)num8; num9 += 1f)
					{
						float tf = num9 / (float)(num8 - 1);
						this.m_fString.AddFluidToString(tf, null);
					}
				}
				this.m_lengthLeft -= num3;
			}
			this.m_timer += deltaTime;
		}
	}

	// Token: 0x060002E0 RID: 736 RVA: 0x0001CDDC File Offset: 0x0001AFDC
	public Vector3 GetClosestPoint(Vector3 point, out float dist, out Vector3 pushVector, out float tf)
	{
		List<ValueTuple<Vector3, float, Vector3, float>> list = new List<ValueTuple<Vector3, float, Vector3, float>>();
		List<Transform> penis = this.m_girl.m_rig.penis;
		for (int i = 0; i < penis.Count; i++)
		{
			Vector3 position = penis[i].position;
			Vector3 vector = (i < penis.Count - 1) ? penis[i + 1].position : this.m_girl.m_rig.penisTip.position;
			Vector3 vector2 = point.ProjectOnSegment(position, vector);
			Vector3 item = Vector3.ProjectOnPlane(point - vector2, vector - position);
			float item2 = Vector3.Distance(point, vector2);
			float item3 = this.BoneDistances[i] + Vector3.Distance(position, vector2);
			list.Add(new ValueTuple<Vector3, float, Vector3, float>(vector2, item2, item, item3));
		}
		list.Sort((ValueTuple<Vector3, float, Vector3, float> a, ValueTuple<Vector3, float, Vector3, float> b) => a.Item2.CompareTo(b.Item2));
		dist = list[0].Item2;
		pushVector = list[0].Item3;
		tf = list[0].Item4;
		return list[0].Item1;
	}

	// Token: 0x060002E2 RID: 738 RVA: 0x0001CFE4 File Offset: 0x0001B1E4
	[CompilerGenerated]
	private void g__removeAll()
	{
		for (int i = this.m_spline.ControlPoints.Count - 1; i >= 1; i--)
		{
			CurvySplineSegment controlPoint = this.m_spline.ControlPoints[i];
			this.m_spline.Delete(controlPoint);
		}
	}

	// Token: 0x060002E3 RID: 739 RVA: 0x0001D02C File Offset: 0x0001B22C
	[CompilerGenerated]
	private void g__lerpPos()
	{
		this.m_lerp = 0.5f;
		Game.AddAnim(0f, 0.2f, delegate(float time)
		{
			this.m_lerp = Mathf.Lerp(0.5f, 1f, time);
		}, true, false, this.m_spline, false, false);
	}

	// Token: 0x040002DA RID: 730
	public Girl m_girl;

	// Token: 0x040002DB RID: 731
	public CurvySpline m_spline;

	// Token: 0x040002DC RID: 732
	public List<Transform> m_bones;

	// Token: 0x040002DD RID: 733
	public CurvySplineSegment m_rootIK;

	// Token: 0x040002DE RID: 734
	public CurvySplineSegment m_midIK;

	// Token: 0x040002DF RID: 735
	public CurvySplineSegment m_tipIK;

	// Token: 0x040002E0 RID: 736
	public CurvySplineSegment m_tipEnd;

	// Token: 0x040002E1 RID: 737
	public AdvancedCollider m_penisCollider;

	// Token: 0x040002E2 RID: 738
	public List<List<Vector3>> m_defaultPose;

	// Token: 0x040002E3 RID: 739
	private List<Collider> m_colliders;

	// Token: 0x040002E4 RID: 740
	private List<float> m_colliderDists;

	// Token: 0x040002E5 RID: 741
	private List<CharacterJoint> m_joints;

	// Token: 0x040002E6 RID: 742
	private List<Transform> m_anchors;

	// Token: 0x040002E7 RID: 743
	private List<float> m_boneDists;

	// Token: 0x040002E8 RID: 744
	public List<Vector2> m_sizes;

	// Token: 0x040002E9 RID: 745
	private float m_downAngle = 5f;

	// Token: 0x040002EA RID: 746
	private float m_upAngle = 50f;

	// Token: 0x040002EB RID: 747
	public float m_lerp = 1f;

	// Token: 0x040002EC RID: 748
	private float m_length = 0.15f;

	// Token: 0x040002ED RID: 749
	private float m_initScale = 1f;

	// Token: 0x040002EE RID: 750
	public Vector2 m_emitRange = new Vector2(0.4f, 0.6f);

	// Token: 0x040002EF RID: 751
	public Vector2 m_forceRange = new Vector2(80f, 200f);

	// Token: 0x040002F0 RID: 752
	public Vector2 m_sizeRange = new Vector2(0.003f, 0.006f);

	// Token: 0x040002F1 RID: 753
	public Vector2 m_slideSpdRange = new Vector2(0.0015f, 0.003f);

	// Token: 0x040002F2 RID: 754
	public float m_maxRdmAngle = 4f;

	// Token: 0x040002F3 RID: 755
	public float m_angleUpTime = 0.4f;

	// Token: 0x040002F4 RID: 756
	public float m_angleDownTime = 0.6f;

	// Token: 0x040002F5 RID: 757
	public float m_maxLength = 0.33f;

	// Token: 0x040002F6 RID: 758
	public float m_stopTime = 1.6f;

	// Token: 0x040002F7 RID: 759
	private float m_emitTime;

	// Token: 0x040002F8 RID: 760
	private float m_force;

	// Token: 0x040002F9 RID: 761
	private float m_slideSpeed;

	// Token: 0x040002FA RID: 762
	private float m_angle;

	// Token: 0x040002FB RID: 763
	private float m_lengthLeft;

	// Token: 0x040002FC RID: 764
	public float m_timer;

	// Token: 0x040002FD RID: 765
	public List<Fluid> m_fluids;

	// Token: 0x040002FE RID: 766
	public TrianglePos m_tipTriPos;

	// Token: 0x040002FF RID: 767
	public FluidString m_fString;

	// Token: 0x04000300 RID: 768
	public float m_fStringTime;

	// Token: 0x04000301 RID: 769
	private AudioSource m_AS;

	// Token: 0x04000302 RID: 770
	//[TupleElementNames(new string[]
	//{
	//	"length",
	//	"time"
	//})]
	private List<ValueTuple<float, float>> m_lengths;
}

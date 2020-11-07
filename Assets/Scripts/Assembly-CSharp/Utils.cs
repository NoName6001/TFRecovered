using System;
using System.Collections.Generic;
using MoonSharp.Interpreter;
using UnityEngine;

// Token: 0x02000040 RID: 64
[ExecuteInEditMode]
[MoonSharpUserData]
public class Utils : MonoBehaviour
{
	// Token: 0x1700002C RID: 44
	// (get) Token: 0x060001DB RID: 475 RVA: 0x00010673 File Offset: 0x0000E873
	public static Transform HelperT
	{
		get
		{
			return Utils.Instance.helperT;
		}
	}

	// Token: 0x060001DC RID: 476 RVA: 0x0001067F File Offset: 0x0000E87F
	private void Start()
	{
		Utils.Instance = this;
		if (Application.isPlaying && this.helperT == null)
		{
			this.helperT = new GameObject().transform;
		}
	}

	// Token: 0x060001DD RID: 477 RVA: 0x000106AC File Offset: 0x0000E8AC
	private void Update()
	{
		if (Application.isPlaying)
		{
			return;
		}
		if (this.copyPose)
		{
			this.copyPose = false;
			this.CopyPose();
		}
		if (this.disableRagdoll)
		{
			this.disableRagdoll = false;
			this.DisableRagdoll(this.ragdollTransform);
		}
		if (this.testMeshCollider)
		{
			this.testMeshCollider = false;
		}
	}

	// Token: 0x060001DE RID: 478 RVA: 0x00010700 File Offset: 0x0000E900
	public static Quaternion RotateToLimit(Quaternion rotation, Quaternion targetRotation, float limit)
	{
		float num = Quaternion.Angle(rotation, targetRotation);
		if (num > limit)
		{
			return Quaternion.Slerp(targetRotation, rotation, limit / num);
		}
		return rotation;
	}

	// Token: 0x060001DF RID: 479 RVA: 0x00010728 File Offset: 0x0000E928
	public static Transform GetTransformToAimAt(Vector3 position, Quaternion rotation, Vector3 point, Vector3 aimPoint, Vector3 target, Vector3 upVector)
	{
		Vector3 to = target - position;
		Vector3 from = target - point;
		Vector3 to2 = aimPoint - point;
		Vector3 axis = Vector3.Cross(to2.normalized, from.normalized);
		Utils.HelperT.position = position;
		Utils.HelperT.rotation = rotation;
		Utils.HelperT.RotateAround(point, axis, Vector3.Angle(from, to2));
		Vector3 from2 = target - Utils.HelperT.position;
		Vector3 axis2 = Vector3.Cross(from2.normalized, to.normalized);
		Utils.HelperT.RotateAround(target, axis2, Vector3.Angle(from2, to));
		Utils.HelperT.position = position;
		Utils.HelperT.rotation = Quaternion.LookRotation(Utils.HelperT.forward, upVector);
		return Utils.HelperT;
	}

	// Token: 0x060001E0 RID: 480 RVA: 0x000107F8 File Offset: 0x0000E9F8
	public void DisableRagdoll(Transform t)
	{
		Rigidbody component = t.GetComponent<Rigidbody>();
		if (component)
		{
			component.isKinematic = true;
		}
		foreach (object obj in t)
		{
			Transform t2 = (Transform)obj;
			this.DisableRagdoll(t2);
		}
	}

	// Token: 0x060001E1 RID: 481 RVA: 0x00010864 File Offset: 0x0000EA64
	public static void Debug(string name, Action<GameObject> action = null)
	{
		if (!Application.isEditor)
		{
			return;
		}
		GameObject gameObject;
		Utils.s_debugObjects.TryGetValue(name, out gameObject);
		if (gameObject == null)
		{
			gameObject = new GameObject();
			Utils.s_debugObjects.Add(name, gameObject);
		}
		gameObject.name = name;
		if (action != null)
		{
			action(gameObject);
		}
	}

	// Token: 0x060001E2 RID: 482 RVA: 0x000108B4 File Offset: 0x0000EAB4
	public static void Debug(string name, Vector3 pos, Vector3 forward = default(Vector3))
	{
		Utils.Debug(name, delegate(GameObject obj)
		{
			obj.transform.position = pos;
			if (forward != default(Vector3))
			{
				obj.transform.forward = forward;
			}
		});
	}

	// Token: 0x060001E3 RID: 483 RVA: 0x000108E8 File Offset: 0x0000EAE8
	public static void Debug(string name, object value)
	{
		Utils.Debug(name, delegate(GameObject obj)
		{
			obj.name = obj.name + " " + value.ToString();
		});
	}

	// Token: 0x060001E4 RID: 484 RVA: 0x00010914 File Offset: 0x0000EB14
	public void CopyPose()
	{
		if (this.fromTransfrom && this.targetTransform)
		{
			this.CopySearchAll(this.fromTransfrom, this.targetTransform, true);
		}
	}

	// Token: 0x060001E5 RID: 485 RVA: 0x00010944 File Offset: 0x0000EB44
	private void Copy(Transform f, Transform t)
	{
		if (this.excludeTransforms.Contains(t))
		{
			return;
		}
		if (f.name == t.name)
		{
			t.localPosition = f.localPosition;
			t.localEulerAngles = f.localEulerAngles;
			t.localScale = f.localScale;
			foreach (object obj in f)
			{
				Transform transform = (Transform)obj;
				Transform transform2 = t.Find(transform.name);
				if (transform2)
				{
					this.Copy(transform, transform2);
				}
			}
		}
	}

	// Token: 0x060001E6 RID: 486 RVA: 0x000109F4 File Offset: 0x0000EBF4
	private void CopySearchAll(Transform from, Transform to, bool ignoreRoot = false)
	{
		if (this.excludeTransforms.Contains(to))
		{
			return;
		}
		Transform transform = this.SearchPoseRecursive(from, to);
		if (transform && !ignoreRoot)
		{
			to.position = transform.position;
			to.eulerAngles = transform.eulerAngles;
		}
		foreach (object obj in to)
		{
			Transform to2 = (Transform)obj;
			this.CopySearchAll(from, to2, false);
		}
	}

	// Token: 0x060001E7 RID: 487 RVA: 0x00010A88 File Offset: 0x0000EC88
	private Transform SearchPoseRecursive(Transform from, Transform to)
	{
		if (to.name == from.name)
		{
			return from;
		}
		foreach (object obj in from)
		{
			Transform from2 = (Transform)obj;
			Transform transform = this.SearchPoseRecursive(from2, to);
			if (transform)
			{
				return transform;
			}
		}
		return null;
	}

	// Token: 0x060001E8 RID: 488 RVA: 0x00010B08 File Offset: 0x0000ED08
	public static void DebugDrawPoint(Vector3 point)
	{
		UnityEngine.Debug.DrawLine(point - new Vector3(0f, 0f, 0.2f), point + new Vector3(0f, 0f, 0.2f));
		UnityEngine.Debug.DrawLine(point - new Vector3(0f, 0.2f, 0f), point + new Vector3(0f, 0.2f, 0f));
	}

	// Token: 0x060001E9 RID: 489 RVA: 0x00010B88 File Offset: 0x0000ED88
	public static bool CalculateLineLineIntersection(Vector3 line1Point1, Vector3 line1Point2, Vector3 line2Point1, Vector3 line2Point2, out Vector3 resultSegmentPoint1, out Vector3 resultSegmentPoint2)
	{
		resultSegmentPoint1 = Vector3.zero;
		resultSegmentPoint2 = Vector3.zero;
		Vector3 vector = line1Point1 - line2Point1;
		Vector3 vector2 = line2Point2 - line2Point1;
		if (vector2.sqrMagnitude < Mathf.Epsilon)
		{
			return false;
		}
		Vector3 vector3 = line1Point2 - line1Point1;
		if (vector3.sqrMagnitude < Mathf.Epsilon)
		{
			return false;
		}
		double num = (double)vector.x * (double)vector2.x + (double)vector.y * (double)vector2.y + (double)vector.z * (double)vector2.z;
		double num2 = (double)vector2.x * (double)vector3.x + (double)vector2.y * (double)vector3.y + (double)vector2.z * (double)vector3.z;
		double num3 = (double)vector.x * (double)vector3.x + (double)vector.y * (double)vector3.y + (double)vector.z * (double)vector3.z;
		double num4 = (double)vector2.x * (double)vector2.x + (double)vector2.y * (double)vector2.y + (double)vector2.z * (double)vector2.z;
		double num5 = ((double)vector3.x * (double)vector3.x + (double)vector3.y * (double)vector3.y + (double)vector3.z * (double)vector3.z) * num4 - num2 * num2;
		if (Math.Abs(num5) < (double)Mathf.Epsilon)
		{
			return false;
		}
		double num6 = (num * num2 - num3 * num4) / num5;
		double num7 = (num + num2 * num6) / num4;
		resultSegmentPoint1.x = (float)((double)line1Point1.x + num6 * (double)vector3.x);
		resultSegmentPoint1.y = (float)((double)line1Point1.y + num6 * (double)vector3.y);
		resultSegmentPoint1.z = (float)((double)line1Point1.z + num6 * (double)vector3.z);
		resultSegmentPoint2.x = (float)((double)line2Point1.x + num7 * (double)vector2.x);
		resultSegmentPoint2.y = (float)((double)line2Point1.y + num7 * (double)vector2.y);
		resultSegmentPoint2.z = (float)((double)line2Point1.z + num7 * (double)vector2.z);
		return true;
	}

	// Token: 0x060001EA RID: 490 RVA: 0x00010DD4 File Offset: 0x0000EFD4
	public static Vector3 GetBaryCentricCoords(Vector3 point, Vector3 p1, Vector3 p2, Vector3 p3)
	{
		if (p1 == p2 || p1 == p3 || p2 == p3)
		{
			return new Vector3(1f, 0f, 0f);
		}
		float x = (point.x * p2.y - point.x * p3.y - p2.x * point.y + p2.x * p3.y + p3.x * point.y - p3.x * p2.y) / (p1.x * p2.y - p1.x * p3.y - p2.x * p1.y + p2.x * p3.y + p3.x * p1.y - p3.x * p2.y);
		float y = (p1.x * point.y - p1.x * p3.y - point.x * p1.y + point.x * p3.y + p3.x * p1.y - p3.x * point.y) / (p1.x * p2.y - p1.x * p3.y - p2.x * p1.y + p2.x * p3.y + p3.x * p1.y - p3.x * p2.y);
		float z = (p1.x * p2.y - p1.x * point.y - p2.x * p1.y + p2.x * point.y + point.x * p1.y - point.x * p2.y) / (p1.x * p2.y - p1.x * p3.y - p2.x * p1.y + p2.x * p3.y + p3.x * p1.y - p3.x * p2.y);
		return new Vector3(x, y, z);
	}

	// Token: 0x060001EB RID: 491 RVA: 0x00011010 File Offset: 0x0000F210
	public static float FindDistanceToSegment(Vector3 pt, Vector3 p1, Vector3 p2, out Vector3 closest)
	{
		float num = p2.x - p1.x;
		float num2 = p2.y - p1.y;
		if (num == 0f && num2 == 0f)
		{
			closest = p1;
			num = pt.x - p1.x;
			num2 = pt.y - p1.y;
			return Mathf.Sqrt(num * num + num2 * num2);
		}
		float num3 = ((pt.x - p1.x) * num + (pt.y - p1.y) * num2) / (num * num + num2 * num2);
		if (num3 < 0f)
		{
			closest = new Vector3(p1.x, p1.y);
			num = pt.x - p1.x;
			num2 = pt.y - p1.y;
		}
		else if (num3 > 1f)
		{
			closest = new Vector3(p2.x, p2.y);
			num = pt.x - p2.x;
			num2 = pt.y - p2.y;
		}
		else
		{
			closest = new Vector3(p1.x + num3 * num, p1.y + num3 * num2);
			num = pt.x - closest.x;
			num2 = pt.y - closest.y;
		}
		return Mathf.Sqrt(num * num + num2 * num2);
	}

	// Token: 0x060001EC RID: 492 RVA: 0x00011162 File Offset: 0x0000F362
	public static float SphereVolume(float radius)
	{
		return Mathf.Pow(radius, 3f) * 3.14159274f * 4f / 3f;
	}

	// Token: 0x060001ED RID: 493 RVA: 0x00011184 File Offset: 0x0000F384
	public static Vector3 RandomBarycentricCoords()
	{
		float value = UnityEngine.Random.value;
		float value2 = UnityEngine.Random.value;
		float value3 = UnityEngine.Random.value;
		if (value != 0f || value2 != 0f || value3 != 0f)
		{
			float num = 1f / (value + value2 + value3);
			return new Vector3(value * num, value2 * num, value3 * num);
		}
		float value4 = UnityEngine.Random.value;
		if (value4 < 0.33f)
		{
			return new Vector3(1f, 0f, 0f);
		}
		if (value4 < 0.66f)
		{
			return new Vector3(0f, 1f, 0f);
		}
		return new Vector3(0f, 0f, 1f);
	}

	// Token: 0x060001EE RID: 494 RVA: 0x00011230 File Offset: 0x0000F430
	public static AudioSource PlayClipAt(AudioClip clip, Vector3 pos, float volume = 1f, float pitch = 1f)
	{
		AudioSource audioSource = new GameObject("TempAudio").AddComponent<AudioSource>();
		audioSource.transform.position = pos;
		audioSource.clip = clip;
		audioSource.volume = volume;
		audioSource.pitch = pitch;
		audioSource.spatialBlend = 1f;
		audioSource.Play();
		Destroy(audioSource.gameObject, clip.length);
		return audioSource;
	}

	// Token: 0x040001B3 RID: 435
	public static Utils Instance;

	// Token: 0x040001B4 RID: 436
	public Transform fromTransfrom;

	// Token: 0x040001B5 RID: 437
	public Transform targetTransform;

	// Token: 0x040001B6 RID: 438
	public List<Transform> excludeTransforms;

	// Token: 0x040001B7 RID: 439
	public bool copyPose;

	// Token: 0x040001B8 RID: 440
	public Transform ragdollTransform;

	// Token: 0x040001B9 RID: 441
	public bool disableRagdoll;

	// Token: 0x040001BA RID: 442
	public Girl girl;

	// Token: 0x040001BB RID: 443
	public bool matchVertices;

	// Token: 0x040001BC RID: 444
	public MeshCollider meshCollider;

	// Token: 0x040001BD RID: 445
	public bool testMeshCollider;

	// Token: 0x040001BE RID: 446
	public static GameObject debugGO;

	// Token: 0x040001BF RID: 447
	public static Dictionary<string, GameObject> s_debugObjects = new Dictionary<string, GameObject>();

	// Token: 0x040001C0 RID: 448
	public bool m_noDebug;

	// Token: 0x040001C1 RID: 449
	public Transform helperT;
}

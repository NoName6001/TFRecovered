//using System;
using UnityEngine;

// Token: 0x02000041 RID: 65
public static class ExtensionMethods
{
	// Token: 0x060001F1 RID: 497 RVA: 0x0001129C File Offset: 0x0000F49C
	public static bool BaryCentricIsInside(this Vector3 vector)
	{
		return vector.x >= 0f && vector.x <= 1f && vector.y >= 0f && vector.y <= 1f && vector.z >= 0f && vector.z <= 1f;
	}

	// Token: 0x060001F2 RID: 498 RVA: 0x000112FC File Offset: 0x0000F4FC
	public static bool BaryCentricIsOutside(this Vector3 vector)
	{
		return vector.x < 0f || vector.y < 0f || vector.z < 0f;
	}

	// Token: 0x060001F3 RID: 499 RVA: 0x00011328 File Offset: 0x0000F528
	public static Vector2 NormalizeUV(this Vector2 vector)
	{
		if (vector.x < 0f)
		{
			vector.x += (float)(1 + Mathf.CeilToInt(Mathf.Abs(vector.x)));
		}
		if (vector.x > 1f)
		{
			vector.x -= (float)Mathf.FloorToInt(vector.x);
		}
		if (vector.y < 0f)
		{
			vector.y += (float)(1 + Mathf.CeilToInt(Mathf.Abs(vector.y)));
		}
		if (vector.y > 1f)
		{
			vector.y -= (float)Mathf.FloorToInt(vector.y);
		}
		return vector;
	}

	// Token: 0x060001F4 RID: 500 RVA: 0x000113D4 File Offset: 0x0000F5D4
	public static Vector3 RandomTangent(this Vector3 vector)
	{
		return Quaternion.FromToRotation(Vector3.forward, vector) * (Quaternion.AngleAxis(Random.Range(0f, 360f), Vector3.forward) * Vector3.right);
	}

	// Token: 0x060001F5 RID: 501 RVA: 0x0001140C File Offset: 0x0000F60C
	public static Vector3 ProjectOnSegment(this Vector3 point, Vector3 startPoint, Vector3 endPoint)
	{
		Vector3 vector = endPoint - startPoint;
		Vector3 vector2 = point - startPoint;
		Vector3 b = vector2 - vector * Vector3.Dot(vector2, vector) / vector.sqrMagnitude;
		Vector3 vector3 = point - b;
		if (Vector3.Dot(vector, vector3 - startPoint) <= 0f)
		{
			return startPoint;
		}
		if (Vector3.Dot(-vector, vector3 - endPoint) <= 0f)
		{
			return endPoint;
		}
		return vector3;
	}

	// Token: 0x060001F6 RID: 502 RVA: 0x00011483 File Offset: 0x0000F683
	public static float GetRandom(this Vector2 vector)
	{
		if (vector.y <= vector.x)
		{
			return vector.x;
		}
		return Random.Range(vector.x, vector.y);
	}

	// Token: 0x060001F7 RID: 503 RVA: 0x000114AC File Offset: 0x0000F6AC
	public static void ChangeScale(this Transform tf, float factor)
	{
		Vector3 startScale = tf.localScale;
		Game.AddAnim(0f, 0.27f, delegate(float time)
		{
			tf.localScale = startScale * (1f + Mathf.SmoothStep(0f, factor, time));
		}, true, false, tf, false, false);
	}
}

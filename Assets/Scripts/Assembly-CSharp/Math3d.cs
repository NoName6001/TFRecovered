using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000042 RID: 66
public class Math3d
{
	// Token: 0x060001F8 RID: 504 RVA: 0x00011504 File Offset: 0x0000F704
	public static void Init()
	{
		Math3d.tempChild = new GameObject("Math3d_TempChild").transform;
		Math3d.tempParent = new GameObject("Math3d_TempParent").transform;
		Math3d.tempChild.gameObject.hideFlags = HideFlags.HideAndDontSave;
		UnityEngine.Object.DontDestroyOnLoad(Math3d.tempChild.gameObject);
		Math3d.tempParent.gameObject.hideFlags = HideFlags.HideAndDontSave;
		UnityEngine.Object.DontDestroyOnLoad(Math3d.tempParent.gameObject);
		Math3d.tempChild.parent = Math3d.tempParent;
	}

	// Token: 0x060001F9 RID: 505 RVA: 0x00011588 File Offset: 0x0000F788
	public static Vector2 GetPointOnSpline(float percentage, Vector2[] cPoints)
	{
		if (cPoints.Length >= 4)
		{
			int num = cPoints.Length - 3;
			int num2 = Mathf.Min(Mathf.FloorToInt(percentage * (float)num), num - 1);
			float num3 = percentage * (float)num - (float)num2;
			Vector2 a = cPoints[num2];
			Vector2 a2 = cPoints[num2 + 1];
			Vector2 vector = cPoints[num2 + 2];
			Vector2 b = cPoints[num2 + 3];
			Vector2 vector2 = 0.5f * (2f * a2 + (-a + vector) * num3 + (2f * a - 5f * a2 + 4f * vector - b) * (num3 * num3) + (-a + 3f * a2 - 3f * vector + b) * (num3 * num3 * num3));
			return new Vector2(vector2.x, vector2.y);
		}
		return new Vector2(0f, 0f);
	}

	// Token: 0x060001FA RID: 506 RVA: 0x000116BC File Offset: 0x0000F8BC
	public static float[] GetLineSplineIntersections(Vector2[] linePoints, Vector2[] cPoints)
	{
		List<float> list = new List<float>();
		int num = cPoints.Length - 3;
		for (int i = 0; i < num; i++)
		{
			Vector2 vector = cPoints[i];
			Vector2 vector2 = cPoints[i + 1];
			Vector2 vector3 = cPoints[i + 2];
			Vector2 vector4 = cPoints[i + 3];
			float num2 = 0.5f * (-vector.x + 3f * vector2.x - 3f * vector3.x + vector4.x);
			float num3 = 0.5f * (-vector.y + 3f * vector2.y - 3f * vector3.y + vector4.y);
			float num4 = 0.5f * (2f * vector.x - 5f * vector2.x + 4f * vector3.x - vector4.x);
			float num5 = 0.5f * (2f * vector.y - 5f * vector2.y + 4f * vector3.y - vector4.y);
			float num6 = 0.5f * (-vector.x + vector3.x);
			float num7 = 0.5f * (-vector.y + vector3.y);
			float num8 = 0.5f * (2f * vector2.x);
			float num9 = 0.5f * (2f * vector2.y);
			float num10 = linePoints[0].y - linePoints[1].y;
			float num11 = linePoints[1].x - linePoints[0].x;
			float num12 = (linePoints[0].x - linePoints[1].x) * linePoints[0].y + (linePoints[1].y - linePoints[0].y) * linePoints[0].x;
			float a = num10 * num2 + num11 * num3;
			float b = num10 * num4 + num11 * num5;
			float c = num10 * num6 + num11 * num7;
			float d = num10 * num8 + num11 * num9 + num12;
			int num13;
			float num14;
			float num15;
			float num16;
			Math3d.SolveCubic(out num13, out num14, out num15, out num16, a, b, c, d);
			float num17 = (float)i / (float)num;
			float num18 = ((float)i + 1f) / (float)num - num17;
			if (num14 >= 0f && num14 <= 1f)
			{
				float item = num14 * num18 + num17;
				list.Add(item);
			}
			if (num15 >= 0f && num15 <= 1f)
			{
				float item = num15 * num18 + num17;
				list.Add(item);
			}
			if (num16 >= 0f && num16 <= 1f)
			{
				float item = num16 * num18 + num17;
				list.Add(item);
			}
		}
		return list.ToArray();
	}

	// Token: 0x060001FB RID: 507 RVA: 0x00011994 File Offset: 0x0000FB94
	private static void SolveCubic(out int nRoots, out float x1, out float x2, out float x3, float a, float b, float c, float d)
	{
		float num = 6.28318548f;
		float num2 = 12.566371f;
		float num3 = a;
		a = b / num3;
		b = c / num3;
		c = d / num3;
		float num4 = a / 3f;
		float num5 = (3f * b - a * a) / 9f;
		float num6 = num5 * num5 * num5;
		float num7 = (9f * a * b - 27f * c - 2f * a * a * a) / 54f;
		float num8 = num7 * num7;
		float num9 = num6 + num8;
		if (num9 < 0f)
		{
			nRoots = 3;
			float num10 = Mathf.Acos(num7 / Mathf.Sqrt(-num6));
			float num11 = Mathf.Sqrt(-num5);
			x1 = 2f * num11 * Mathf.Cos(num10 / 3f) - num4;
			x2 = 2f * num11 * Mathf.Cos((num10 + num) / 3f) - num4;
			x3 = 2f * num11 * Mathf.Cos((num10 + num2) / 3f) - num4;
			return;
		}
		if (num9 > 0f)
		{
			nRoots = 1;
			float num12 = Mathf.Sqrt(num9);
			float num13 = Math3d.CubeRoot(num7 + num12);
			float num14 = Math3d.CubeRoot(num7 - num12);
			x1 = num13 + num14 - num4;
			x2 = float.NaN;
			x3 = float.NaN;
			return;
		}
		nRoots = 3;
		float num15 = Math3d.CubeRoot(num7);
		x1 = 2f * num15 - num4;
		x2 = num15 - num4;
		x3 = x2;
	}

	// Token: 0x060001FC RID: 508 RVA: 0x00011B06 File Offset: 0x0000FD06
	private static float CubeRoot(float d)
	{
		if (d < 0f)
		{
			return -Mathf.Pow(-d, 0.333333343f);
		}
		return Mathf.Pow(d, 0.333333343f);
	}

	// Token: 0x060001FD RID: 509 RVA: 0x00011B2C File Offset: 0x0000FD2C
	public static Vector3 AddVectorLength(Vector3 vector, float size)
	{
		float num = Vector3.Magnitude(vector);
		float d = (num + size) / num;
		return vector * d;
	}

	// Token: 0x060001FE RID: 510 RVA: 0x00011B4D File Offset: 0x0000FD4D
	public static Vector3 SetVectorLength(Vector3 vector, float size)
	{
		return Vector3.Normalize(vector) * size;
	}

	// Token: 0x060001FF RID: 511 RVA: 0x00011B5B File Offset: 0x0000FD5B
	public static Quaternion SubtractRotation(Quaternion B, Quaternion A)
	{
		return Quaternion.Inverse(A) * B;
	}

	// Token: 0x06000200 RID: 512 RVA: 0x00011B69 File Offset: 0x0000FD69
	public static Quaternion AddRotation(Quaternion A, Quaternion B)
	{
		return A * B;
	}

	// Token: 0x06000201 RID: 513 RVA: 0x00011B72 File Offset: 0x0000FD72
	public static Vector3 TransformDirectionMath(Quaternion rotation, Vector3 vector)
	{
		return rotation * vector;
	}

	// Token: 0x06000202 RID: 514 RVA: 0x00011B7B File Offset: 0x0000FD7B
	public static Vector3 InverseTransformDirectionMath(Quaternion rotation, Vector3 vector)
	{
		return Quaternion.Inverse(rotation) * vector;
	}

	// Token: 0x06000203 RID: 515 RVA: 0x00011B8C File Offset: 0x0000FD8C
	public static Vector3 RotateVectorFromTo(Quaternion from, Quaternion to, Vector3 vector)
	{
		Quaternion rotation = Math3d.SubtractRotation(to, from);
		Vector3 point = Math3d.InverseTransformDirectionMath(from, vector);
		Vector3 vector2 = rotation * point;
		return Math3d.TransformDirectionMath(from, vector2);
	}

	// Token: 0x06000204 RID: 516 RVA: 0x00011BB8 File Offset: 0x0000FDB8
	public static bool PlanePlaneIntersection(out Vector3 linePoint, out Vector3 lineVec, Vector3 plane1Normal, Vector3 plane1Position, Vector3 plane2Normal, Vector3 plane2Position)
	{
		linePoint = Vector3.zero;
		lineVec = Vector3.zero;
		lineVec = Vector3.Cross(plane1Normal, plane2Normal);
		Vector3 vector = Vector3.Cross(plane2Normal, lineVec);
		float num = Vector3.Dot(plane1Normal, vector);
		if (Mathf.Abs(num) > 0.006f)
		{
			Vector3 rhs = plane1Position - plane2Position;
			float d = Vector3.Dot(plane1Normal, rhs) / num;
			linePoint = plane2Position + d * vector;
			return true;
		}
		return false;
	}

	// Token: 0x06000205 RID: 517 RVA: 0x00011C38 File Offset: 0x0000FE38
	public static bool LinePlaneIntersection(out Vector3 intersection, Vector3 linePoint, Vector3 lineVec, Vector3 planeNormal, Vector3 planePoint)
	{
		intersection = Vector3.zero;
		float num = Vector3.Dot(planePoint - linePoint, planeNormal);
		float num2 = Vector3.Dot(lineVec, planeNormal);
		if (num2 != 0f)
		{
			float size = num / num2;
			Vector3 b = Math3d.SetVectorLength(lineVec, size);
			intersection = linePoint + b;
			return true;
		}
		return false;
	}

	// Token: 0x06000206 RID: 518 RVA: 0x00011C8C File Offset: 0x0000FE8C
	public static bool LineLineIntersection(out Vector3 intersection, Vector3 linePoint1, Vector3 lineVec1, Vector3 linePoint2, Vector3 lineVec2)
	{
		Vector3 lhs = linePoint2 - linePoint1;
		Vector3 rhs = Vector3.Cross(lineVec1, lineVec2);
		Vector3 lhs2 = Vector3.Cross(lhs, lineVec2);
		if (Mathf.Abs(Vector3.Dot(lhs, rhs)) < 0.0001f && rhs.sqrMagnitude > 0.0001f)
		{
			float d = Vector3.Dot(lhs2, rhs) / rhs.sqrMagnitude;
			intersection = linePoint1 + lineVec1 * d;
			return true;
		}
		intersection = Vector3.zero;
		return false;
	}

	// Token: 0x06000207 RID: 519 RVA: 0x00011D04 File Offset: 0x0000FF04
	public static bool ClosestPointsOnTwoLines(out Vector3 closestPointLine1, out Vector3 closestPointLine2, Vector3 linePoint1, Vector3 lineVec1, Vector3 linePoint2, Vector3 lineVec2)
	{
		closestPointLine1 = Vector3.zero;
		closestPointLine2 = Vector3.zero;
		float num = Vector3.Dot(lineVec1, lineVec1);
		float num2 = Vector3.Dot(lineVec1, lineVec2);
		float num3 = Vector3.Dot(lineVec2, lineVec2);
		float num4 = num * num3 - num2 * num2;
		if (num4 != 0f)
		{
			Vector3 rhs = linePoint1 - linePoint2;
			float num5 = Vector3.Dot(lineVec1, rhs);
			float num6 = Vector3.Dot(lineVec2, rhs);
			float d = (num2 * num6 - num5 * num3) / num4;
			float d2 = (num * num6 - num5 * num2) / num4;
			closestPointLine1 = linePoint1 + lineVec1 * d;
			closestPointLine2 = linePoint2 + lineVec2 * d2;
			return true;
		}
		return false;
	}

	// Token: 0x06000208 RID: 520 RVA: 0x00011DB8 File Offset: 0x0000FFB8
	public static Vector3 ProjectPointOnLine(Vector3 linePoint, Vector3 lineVec, Vector3 point)
	{
		float d = Vector3.Dot(point - linePoint, lineVec);
		return linePoint + lineVec * d;
	}

	// Token: 0x06000209 RID: 521 RVA: 0x00011DE0 File Offset: 0x0000FFE0
	public static Vector3 ProjectPointOnLineSegment(Vector3 linePoint1, Vector3 linePoint2, Vector3 point)
	{
		Vector3 vector = Math3d.ProjectPointOnLine(linePoint1, (linePoint2 - linePoint1).normalized, point);
		int num = Math3d.PointOnWhichSideOfLineSegment(linePoint1, linePoint2, vector);
		if (num == 0)
		{
			return vector;
		}
		if (num == 1)
		{
			return linePoint1;
		}
		if (num == 2)
		{
			return linePoint2;
		}
		return Vector3.zero;
	}

	// Token: 0x0600020A RID: 522 RVA: 0x00011E24 File Offset: 0x00010024
	public static Vector3 ProjectPointOnPlane(Vector3 planeNormal, Vector3 planePoint, Vector3 point)
	{
		float num = Math3d.SignedDistancePlanePoint(planeNormal, planePoint, point);
		num *= -1f;
		Vector3 b = Math3d.SetVectorLength(planeNormal, num);
		return point + b;
	}

	// Token: 0x0600020B RID: 523 RVA: 0x00011E51 File Offset: 0x00010051
	public static Vector3 ProjectVectorOnPlane(Vector3 planeNormal, Vector3 vector)
	{
		return vector - Vector3.Dot(vector, planeNormal) * planeNormal;
	}

	// Token: 0x0600020C RID: 524 RVA: 0x00011E66 File Offset: 0x00010066
	public static float SignedDistancePlanePoint(Vector3 planeNormal, Vector3 planePoint, Vector3 point)
	{
		return Vector3.Dot(planeNormal, point - planePoint);
	}

	// Token: 0x0600020D RID: 525 RVA: 0x00011E75 File Offset: 0x00010075
	public static float SignedDotProduct(Vector3 vectorA, Vector3 vectorB, Vector3 normal)
	{
		return Vector3.Dot(Vector3.Cross(normal, vectorA), vectorB);
	}

	// Token: 0x0600020E RID: 526 RVA: 0x00011E84 File Offset: 0x00010084
	public static float SignedVectorAngle(Vector3 referenceVector, Vector3 otherVector, Vector3 normal)
	{
		Vector3 lhs = Vector3.Cross(normal, referenceVector);
		return Vector3.Angle(referenceVector, otherVector) * Mathf.Sign(Vector3.Dot(lhs, otherVector));
	}

	// Token: 0x0600020F RID: 527 RVA: 0x00011EB0 File Offset: 0x000100B0
	public static float AngleVectorPlane(Vector3 vector, Vector3 normal)
	{
		float num = (float)Math.Acos((double)Vector3.Dot(vector, normal));
		return 1.57079637f - num;
	}

	// Token: 0x06000210 RID: 528 RVA: 0x00011ED4 File Offset: 0x000100D4
	public static float DotProductAngle(Vector3 vec1, Vector3 vec2)
	{
		double num = (double)Vector3.Dot(vec1, vec2);
		if (num < -1.0)
		{
			num = -1.0;
		}
		if (num > 1.0)
		{
			num = 1.0;
		}
		return (float)Math.Acos(num);
	}

	// Token: 0x06000211 RID: 529 RVA: 0x00011F20 File Offset: 0x00010120
	public static void PlaneFrom3Points(out Vector3 planeNormal, out Vector3 planePoint, Vector3 pointA, Vector3 pointB, Vector3 pointC)
	{
		planeNormal = Vector3.zero;
		planePoint = Vector3.zero;
		Vector3 vector = pointB - pointA;
		Vector3 vector2 = pointC - pointA;
		planeNormal = Vector3.Normalize(Vector3.Cross(vector, vector2));
		Vector3 vector3 = pointA + vector / 2f;
		Vector3 vector4 = pointA + vector2 / 2f;
		Vector3 lineVec = pointC - vector3;
		Vector3 lineVec2 = pointB - vector4;
		Vector3 vector5;
		Math3d.ClosestPointsOnTwoLines(out planePoint, out vector5, vector3, lineVec, vector4, lineVec2);
	}

	// Token: 0x06000212 RID: 530 RVA: 0x00011FAC File Offset: 0x000101AC
	public static Vector3 GetForwardVector(Quaternion q)
	{
		return q * Vector3.forward;
	}

	// Token: 0x06000213 RID: 531 RVA: 0x00011FB9 File Offset: 0x000101B9
	public static Vector3 GetUpVector(Quaternion q)
	{
		return q * Vector3.up;
	}

	// Token: 0x06000214 RID: 532 RVA: 0x00011FC6 File Offset: 0x000101C6
	public static Vector3 GetRightVector(Quaternion q)
	{
		return q * Vector3.right;
	}

	// Token: 0x06000215 RID: 533 RVA: 0x00011FD3 File Offset: 0x000101D3
	public static Quaternion QuaternionFromMatrix(Matrix4x4 m)
	{
		return Quaternion.LookRotation(m.GetColumn(2), m.GetColumn(1));
	}

	// Token: 0x06000216 RID: 534 RVA: 0x00011FF4 File Offset: 0x000101F4
	public static Vector3 PositionFromMatrix(Matrix4x4 m)
	{
		Vector4 column = m.GetColumn(3);
		return new Vector3(column.x, column.y, column.z);
	}

	// Token: 0x06000217 RID: 535 RVA: 0x00012024 File Offset: 0x00010224
	public static void LookRotationExtended(ref GameObject gameObjectInOut, Vector3 alignWithVector, Vector3 alignWithNormal, Vector3 customForward, Vector3 customUp)
	{
		Quaternion lhs = Quaternion.LookRotation(alignWithVector, alignWithNormal);
		Quaternion rotation = Quaternion.LookRotation(customForward, customUp);
		gameObjectInOut.transform.rotation = lhs * Quaternion.Inverse(rotation);
	}

	// Token: 0x06000218 RID: 536 RVA: 0x0001205C File Offset: 0x0001025C
	public static void TransformWithParent(out Quaternion childRotation, out Vector3 childPosition, Quaternion parentRotation, Vector3 parentPosition, Quaternion startParentRotation, Vector3 startParentPosition, Quaternion startChildRotation, Vector3 startChildPosition)
	{
		childRotation = Quaternion.identity;
		childPosition = Vector3.zero;
		Math3d.tempParent.rotation = startParentRotation;
		Math3d.tempParent.position = startParentPosition;
		Math3d.tempParent.localScale = Vector3.one;
		Math3d.tempChild.rotation = startChildRotation;
		Math3d.tempChild.position = startChildPosition;
		Math3d.tempChild.localScale = Vector3.one;
		Math3d.tempParent.rotation = parentRotation;
		Math3d.tempParent.position = parentPosition;
		childRotation = Math3d.tempChild.rotation;
		childPosition = Math3d.tempChild.position;
	}

	// Token: 0x06000219 RID: 537 RVA: 0x00012104 File Offset: 0x00010304
	public static void PreciseAlign(ref GameObject gameObjectInOut, Vector3 alignWithVector, Vector3 alignWithNormal, Vector3 alignWithPosition, Vector3 triangleForward, Vector3 triangleNormal, Vector3 trianglePosition)
	{
		Math3d.LookRotationExtended(ref gameObjectInOut, alignWithVector, alignWithNormal, triangleForward, triangleNormal);
		Vector3 b = gameObjectInOut.transform.TransformPoint(trianglePosition);
		Vector3 translation = alignWithPosition - b;
		gameObjectInOut.transform.Translate(translation, Space.World);
	}

	// Token: 0x0600021A RID: 538 RVA: 0x00012142 File Offset: 0x00010342
	public static void VectorsToTransform(ref GameObject gameObjectInOut, Vector3 positionVector, Vector3 directionVector, Vector3 normalVector)
	{
		gameObjectInOut.transform.position = positionVector;
		gameObjectInOut.transform.rotation = Quaternion.LookRotation(directionVector, normalVector);
	}

	// Token: 0x0600021B RID: 539 RVA: 0x00012164 File Offset: 0x00010364
	public static int PointOnWhichSideOfLineSegment(Vector3 linePoint1, Vector3 linePoint2, Vector3 point)
	{
		Vector3 rhs = linePoint2 - linePoint1;
		Vector3 lhs = point - linePoint1;
		if (Vector3.Dot(lhs, rhs) <= 0f)
		{
			return 1;
		}
		if (lhs.magnitude <= rhs.magnitude)
		{
			return 0;
		}
		return 2;
	}

	// Token: 0x0600021C RID: 540 RVA: 0x000121A4 File Offset: 0x000103A4
	public static float MouseDistanceToLine(Vector3 linePoint1, Vector3 linePoint2)
	{
		Camera main = Camera.main;
		Vector3 mousePosition = Input.mousePosition;
		Vector3 linePoint3 = main.WorldToScreenPoint(linePoint1);
		Vector3 linePoint4 = main.WorldToScreenPoint(linePoint2);
		Vector3 vector = Math3d.ProjectPointOnLineSegment(linePoint3, linePoint4, mousePosition);
		vector = new Vector3(vector.x, vector.y, 0f);
		return (vector - mousePosition).magnitude;
	}

	// Token: 0x0600021D RID: 541 RVA: 0x000121FC File Offset: 0x000103FC
	public static float MouseDistanceToCircle(Vector3 point, float radius)
	{
		Camera main = Camera.main;
		Vector3 mousePosition = Input.mousePosition;
		Vector3 vector = main.WorldToScreenPoint(point);
		vector = new Vector3(vector.x, vector.y, 0f);
		return (vector - mousePosition).magnitude - radius;
	}

	// Token: 0x0600021E RID: 542 RVA: 0x00012244 File Offset: 0x00010444
	public static bool IsLineInRectangle(Vector3 linePoint1, Vector3 linePoint2, Vector3 rectA, Vector3 rectB, Vector3 rectC, Vector3 rectD)
	{
		bool flag = false;
		bool flag2 = Math3d.IsPointInRectangle(linePoint1, rectA, rectC, rectB, rectD);
		if (!flag2)
		{
			flag = Math3d.IsPointInRectangle(linePoint2, rectA, rectC, rectB, rectD);
		}
		if (!flag2 && !flag)
		{
			bool flag3 = Math3d.AreLineSegmentsCrossing(linePoint1, linePoint2, rectA, rectB);
			bool flag4 = Math3d.AreLineSegmentsCrossing(linePoint1, linePoint2, rectB, rectC);
			bool flag5 = Math3d.AreLineSegmentsCrossing(linePoint1, linePoint2, rectC, rectD);
			bool flag6 = Math3d.AreLineSegmentsCrossing(linePoint1, linePoint2, rectD, rectA);
			return flag3 || flag4 || flag5 || flag6;
		}
		return true;
	}

	// Token: 0x0600021F RID: 543 RVA: 0x000122AC File Offset: 0x000104AC
	public static bool IsPointInRectangle(Vector3 point, Vector3 rectA, Vector3 rectC, Vector3 rectB, Vector3 rectD)
	{
		Vector3 vector = rectC - rectA;
		float size = -(vector.magnitude / 2f);
		vector = Math3d.AddVectorLength(vector, size);
		Vector3 linePoint = rectA + vector;
		Vector3 vector2 = rectB - rectA;
		float num = vector2.magnitude / 2f;
		Vector3 vector3 = rectD - rectA;
		float num2 = vector3.magnitude / 2f;
		float magnitude = (Math3d.ProjectPointOnLine(linePoint, vector2.normalized, point) - point).magnitude;
		return (Math3d.ProjectPointOnLine(linePoint, vector3.normalized, point) - point).magnitude <= num && magnitude <= num2;
	}

	// Token: 0x06000220 RID: 544 RVA: 0x00012354 File Offset: 0x00010554
	public static bool AreLineSegmentsCrossing(Vector3 pointA1, Vector3 pointA2, Vector3 pointB1, Vector3 pointB2)
	{
		Vector3 vector = pointA2 - pointA1;
		Vector3 vector2 = pointB2 - pointB1;
		Vector3 point;
		Vector3 point2;
		if (Math3d.ClosestPointsOnTwoLines(out point, out point2, pointA1, vector.normalized, pointB1, vector2.normalized))
		{
			bool flag = Math3d.PointOnWhichSideOfLineSegment(pointA1, pointA2, point) != 0;
			int num = Math3d.PointOnWhichSideOfLineSegment(pointB1, pointB2, point2);
			return !flag && num == 0;
		}
		return false;
	}

	// Token: 0x06000221 RID: 545 RVA: 0x000123A8 File Offset: 0x000105A8
	public static bool LinearAcceleration(out Vector3 vector, Vector3 position, int samples)
	{
		Vector3 a = Vector3.zero;
		vector = Vector3.zero;
		if (samples < 3)
		{
			samples = 3;
		}
		if (Math3d.positionRegister == null)
		{
			Math3d.positionRegister = new Vector3[samples];
			Math3d.posTimeRegister = new float[samples];
		}
		for (int i = 0; i < Math3d.positionRegister.Length - 1; i++)
		{
			Math3d.positionRegister[i] = Math3d.positionRegister[i + 1];
			Math3d.posTimeRegister[i] = Math3d.posTimeRegister[i + 1];
		}
		Math3d.positionRegister[Math3d.positionRegister.Length - 1] = position;
		Math3d.posTimeRegister[Math3d.posTimeRegister.Length - 1] = Time.time;
		Math3d.positionSamplesTaken++;
		if (Math3d.positionSamplesTaken >= samples)
		{
			for (int j = 0; j < Math3d.positionRegister.Length - 2; j++)
			{
				Vector3 a2 = Math3d.positionRegister[j + 1] - Math3d.positionRegister[j];
				float num = Math3d.posTimeRegister[j + 1] - Math3d.posTimeRegister[j];
				if (num == 0f)
				{
					return false;
				}
				Vector3 b = a2 / num;
				a2 = Math3d.positionRegister[j + 2] - Math3d.positionRegister[j + 1];
				num = Math3d.posTimeRegister[j + 2] - Math3d.posTimeRegister[j + 1];
				if (num == 0f)
				{
					return false;
				}
				Vector3 a3 = a2 / num;
				a += a3 - b;
			}
			a /= (float)(Math3d.positionRegister.Length - 2);
			float d = Math3d.posTimeRegister[Math3d.posTimeRegister.Length - 1] - Math3d.posTimeRegister[0];
			vector = a / d;
			return true;
		}
		return false;
	}

	// Token: 0x06000222 RID: 546 RVA: 0x00012568 File Offset: 0x00010768
	public static bool AngularAcceleration(out Vector3 vector, Quaternion rotation, int samples)
	{
		Vector3 a = Vector3.zero;
		vector = Vector3.zero;
		if (samples < 3)
		{
			samples = 3;
		}
		if (Math3d.rotationRegister == null)
		{
			Math3d.rotationRegister = new Quaternion[samples];
			Math3d.rotTimeRegister = new float[samples];
		}
		for (int i = 0; i < Math3d.rotationRegister.Length - 1; i++)
		{
			Math3d.rotationRegister[i] = Math3d.rotationRegister[i + 1];
			Math3d.rotTimeRegister[i] = Math3d.rotTimeRegister[i + 1];
		}
		Math3d.rotationRegister[Math3d.rotationRegister.Length - 1] = rotation;
		Math3d.rotTimeRegister[Math3d.rotTimeRegister.Length - 1] = Time.time;
		Math3d.rotationSamplesTaken++;
		if (Math3d.rotationSamplesTaken >= samples)
		{
			for (int j = 0; j < Math3d.rotationRegister.Length - 2; j++)
			{
				Quaternion rotation2 = Math3d.SubtractRotation(Math3d.rotationRegister[j + 1], Math3d.rotationRegister[j]);
				float num = Math3d.rotTimeRegister[j + 1] - Math3d.rotTimeRegister[j];
				if (num == 0f)
				{
					return false;
				}
				Vector3 b = Math3d.RotDiffToSpeedVec(rotation2, num);
				rotation2 = Math3d.SubtractRotation(Math3d.rotationRegister[j + 2], Math3d.rotationRegister[j + 1]);
				num = Math3d.rotTimeRegister[j + 2] - Math3d.rotTimeRegister[j + 1];
				if (num == 0f)
				{
					return false;
				}
				Vector3 a2 = Math3d.RotDiffToSpeedVec(rotation2, num);
				a += a2 - b;
			}
			a /= (float)(Math3d.rotationRegister.Length - 2);
			float d = Math3d.rotTimeRegister[Math3d.rotTimeRegister.Length - 1] - Math3d.rotTimeRegister[0];
			vector = a / d;
			return true;
		}
		return false;
	}

	// Token: 0x06000223 RID: 547 RVA: 0x00012726 File Offset: 0x00010926
	public static float LinearFunction2DBasic(float x, float Qx, float Qy)
	{
		return x * (Qy / Qx);
	}

	// Token: 0x06000224 RID: 548 RVA: 0x00012730 File Offset: 0x00010930
	public static float LinearFunction2DFull(float x, float Px, float Py, float Qx, float Qy)
	{
		float num = Qy - Py;
		float num2 = Qx - Px;
		float num3 = num / num2;
		return Py + num3 * (x - Px);
	}

	// Token: 0x06000225 RID: 549 RVA: 0x00012750 File Offset: 0x00010950
	private static Vector3 RotDiffToSpeedVec(Quaternion rotation, float deltaTime)
	{
		float num;
		if (rotation.eulerAngles.x <= 180f)
		{
			num = rotation.eulerAngles.x;
		}
		else
		{
			num = rotation.eulerAngles.x - 360f;
		}
		float num2;
		if (rotation.eulerAngles.y <= 180f)
		{
			num2 = rotation.eulerAngles.y;
		}
		else
		{
			num2 = rotation.eulerAngles.y - 360f;
		}
		float num3;
		if (rotation.eulerAngles.z <= 180f)
		{
			num3 = rotation.eulerAngles.z;
		}
		else
		{
			num3 = rotation.eulerAngles.z - 360f;
		}
		return new Vector3(num / deltaTime, num2 / deltaTime, num3 / deltaTime);
	}

	// Token: 0x040001C2 RID: 450
	private static Transform tempChild;

	// Token: 0x040001C3 RID: 451
	private static Transform tempParent;

	// Token: 0x040001C4 RID: 452
	private static Vector3[] positionRegister;

	// Token: 0x040001C5 RID: 453
	private static float[] posTimeRegister;

	// Token: 0x040001C6 RID: 454
	private static int positionSamplesTaken;

	// Token: 0x040001C7 RID: 455
	private static Quaternion[] rotationRegister;

	// Token: 0x040001C8 RID: 456
	private static float[] rotTimeRegister;

	// Token: 0x040001C9 RID: 457
	private static int rotationSamplesTaken;
}

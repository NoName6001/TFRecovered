using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000030 RID: 48
public class TrianglePos
{
	// Token: 0x1700001E RID: 30
	// (get) Token: 0x06000146 RID: 326 RVA: 0x0000C7C3 File Offset: 0x0000A9C3
	public List<string> Triggers
	{
		get
		{
			return this.m_collider.m_triangleCache[this.triId].triggers;
		}
	}

	// Token: 0x06000147 RID: 327 RVA: 0x0000C7E0 File Offset: 0x0000A9E0
	public TrianglePos(AdvancedCollider collider, int triId, Vector3 baryCoords, Vector3 impactNormal = default(Vector3))
	{
		this.triId = triId;
		this.baryCoords = baryCoords;
		this.m_collider = collider;
		this.impactNormal = impactNormal;
	}

	// Token: 0x06000148 RID: 328 RVA: 0x0000C808 File Offset: 0x0000AA08
	public static TrianglePos Random(AdvancedCollider collider, int triId)
	{
		return new TrianglePos(collider, triId, Utils.RandomBarycentricCoords(), default(Vector3));
	}

	// Token: 0x06000149 RID: 329 RVA: 0x0000C82A File Offset: 0x0000AA2A
	public Vector3 GetVertexIds(List<int> triangles)
	{
		return new Vector3((float)triangles[this.triId * 3], (float)triangles[this.triId * 3 + 1], (float)triangles[this.triId * 3 + 2]);
	}

	// Token: 0x0600014A RID: 330 RVA: 0x0000C864 File Offset: 0x0000AA64
	public Vector3 GetWorldPos()
	{
		this.m_collider.RecheckMeshData();
		Vector3 vertexWorldPos = this.m_collider.GetVertexWorldPos(this.m_collider.m_triangles[this.triId * 3]);
		Vector3 vertexWorldPos2 = this.m_collider.GetVertexWorldPos(this.m_collider.m_triangles[this.triId * 3 + 1]);
		Vector3 vertexWorldPos3 = this.m_collider.GetVertexWorldPos(this.m_collider.m_triangles[this.triId * 3 + 2]);
		return vertexWorldPos * this.baryCoords.x + vertexWorldPos2 * this.baryCoords.y + vertexWorldPos3 * this.baryCoords.z;
	}

	// Token: 0x0600014B RID: 331 RVA: 0x0000C91B File Offset: 0x0000AB1B
	public Vector3 GetWorldPos(Vector3 p1, Vector3 p2, Vector3 p3)
	{
		return p1 * this.baryCoords.x + p2 * this.baryCoords.y + p3 * this.baryCoords.z;
	}

	// Token: 0x0600014C RID: 332 RVA: 0x0000C95C File Offset: 0x0000AB5C
	public Vector3 GetWorldPos(Transform collider, int[] triangles, Vector3[] vertices)
	{
		Vector3 a = collider.transform.TransformPoint(vertices[triangles[this.triId * 3]]);
		Vector3 a2 = collider.transform.TransformPoint(vertices[triangles[this.triId * 3 + 1]]);
		Vector3 a3 = collider.transform.TransformPoint(vertices[triangles[this.triId * 3 + 2]]);
		return a * this.baryCoords.x + a2 * this.baryCoords.y + a3 * this.baryCoords.z;
	}

	// Token: 0x0600014D RID: 333 RVA: 0x0000C9FC File Offset: 0x0000ABFC
	public Vector3 GetWorldPos(Transform collider, int[] triangles, Vector3[] vertices, out Vector3 normal)
	{
		Vector3 vector = collider.transform.TransformPoint(vertices[triangles[this.triId * 3]]);
		Vector3 a = collider.transform.TransformPoint(vertices[triangles[this.triId * 3 + 1]]);
		Vector3 a2 = collider.transform.TransformPoint(vertices[triangles[this.triId * 3 + 2]]);
		normal = Vector3.Cross((a - vector).normalized, (a2 - vector).normalized);
		return vector * this.baryCoords.x + a * this.baryCoords.y + a2 * this.baryCoords.z;
	}

	// Token: 0x0600014E RID: 334 RVA: 0x0000CAC8 File Offset: 0x0000ACC8
	public Vector3 GetTriangleNormal()
	{
		return this.m_collider.GetTriangleNormal(this.triId);
	}

	// Token: 0x0600014F RID: 335 RVA: 0x0000CADC File Offset: 0x0000ACDC
	public Vector2 CalculateUVPos()
	{
		this.m_collider.RecheckMeshData();
		int index = this.m_collider.m_triangles[this.triId * 3];
		int index2 = this.m_collider.m_triangles[this.triId * 3 + 1];
		int index3 = this.m_collider.m_triangles[this.triId * 3 + 2];
		Vector2 a = this.m_collider.m_uvCache[index];
		Vector2 a2 = this.m_collider.m_uvCache[index2];
		Vector2 a3 = this.m_collider.m_uvCache[index3];
		return a * this.baryCoords.x + a2 * this.baryCoords.y + a3 * this.baryCoords.z;
	}

	// Token: 0x06000150 RID: 336 RVA: 0x0000C7C3 File Offset: 0x0000A9C3
	public List<string> GetTriggers()
	{
		return this.m_collider.m_triangleCache[this.triId].triggers;
	}

	// Token: 0x04000145 RID: 325
	public int triId;

	// Token: 0x04000146 RID: 326
	public Vector3 baryCoords;

	// Token: 0x04000147 RID: 327
	public AdvancedCollider m_collider;

	// Token: 0x04000148 RID: 328
	public Vector3 impactNormal;
}

using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000031 RID: 49
public class BoundsOctree<T>
{
	// Token: 0x1700001F RID: 31
	// (get) Token: 0x06000151 RID: 337 RVA: 0x0000CBAA File Offset: 0x0000ADAA
	// (set) Token: 0x06000152 RID: 338 RVA: 0x0000CBB2 File Offset: 0x0000ADB2
	public int Count { get; private set; }

	// Token: 0x06000153 RID: 339 RVA: 0x0000CBBC File Offset: 0x0000ADBC
	public BoundsOctree(float initialWorldSize, Vector3 initialWorldPos, float minNodeSize, float loosenessVal)
	{
		if (minNodeSize > initialWorldSize)
		{
			Debug.LogWarning(string.Concat(new object[]
			{
				"Minimum node size must be at least as big as the initial world size. Was: ",
				minNodeSize,
				" Adjusted to: ",
				initialWorldSize
			}));
			minNodeSize = initialWorldSize;
		}
		this.Count = 0;
		this.initialSize = initialWorldSize;
		this.minSize = minNodeSize;
		this.looseness = Mathf.Clamp(loosenessVal, 1f, 2f);
		this.rootNode = new BoundsOctreeNode<T>(this.initialSize, this.minSize, this.looseness, initialWorldPos);
	}

	// Token: 0x06000154 RID: 340 RVA: 0x0000CC54 File Offset: 0x0000AE54
	public void Add(T obj, Bounds objBounds)
	{
		int num = 0;
		while (!this.rootNode.Add(obj, objBounds))
		{
			this.Grow(objBounds.center - this.rootNode.Center);
			if (++num > 20)
			{
				Debug.LogError("Aborted Add operation as it seemed to be going on forever (" + (num - 1) + ") attempts at growing the octree.");
				return;
			}
		}
		int count = this.Count;
		this.Count = count + 1;
	}

	// Token: 0x06000155 RID: 341 RVA: 0x0000CCC8 File Offset: 0x0000AEC8
	public bool Remove(T obj)
	{
		bool flag = this.rootNode.Remove(obj);
		if (flag)
		{
			int count = this.Count;
			this.Count = count - 1;
			this.Shrink();
		}
		return flag;
	}

	// Token: 0x06000156 RID: 342 RVA: 0x0000CCFC File Offset: 0x0000AEFC
	public bool Remove(T obj, Bounds objBounds)
	{
		bool flag = this.rootNode.Remove(obj, objBounds);
		if (flag)
		{
			int count = this.Count;
			this.Count = count - 1;
			this.Shrink();
		}
		return flag;
	}

	// Token: 0x06000157 RID: 343 RVA: 0x0000CD2F File Offset: 0x0000AF2F
	public bool IsColliding(Bounds checkBounds)
	{
		return this.rootNode.IsColliding(ref checkBounds);
	}

	// Token: 0x06000158 RID: 344 RVA: 0x0000CD3E File Offset: 0x0000AF3E
	public bool IsColliding(Ray checkRay, float maxDistance)
	{
		return this.rootNode.IsColliding(ref checkRay, maxDistance);
	}

	// Token: 0x06000159 RID: 345 RVA: 0x0000CD4E File Offset: 0x0000AF4E
	public void GetColliding(List<T> collidingWith, Bounds checkBounds)
	{
		this.rootNode.GetColliding(ref checkBounds, collidingWith);
	}

	// Token: 0x0600015A RID: 346 RVA: 0x0000CD5E File Offset: 0x0000AF5E
	public void GetColliding(List<T> collidingWith, Ray checkRay, float maxDistance = float.PositiveInfinity)
	{
		this.rootNode.GetColliding(ref checkRay, collidingWith, maxDistance);
	}

	// Token: 0x0600015B RID: 347 RVA: 0x0000CD70 File Offset: 0x0000AF70
	public List<T> GetWithinFrustum(Camera cam)
	{
		Plane[] planes = GeometryUtility.CalculateFrustumPlanes(cam);
		List<T> result = new List<T>();
		this.rootNode.GetWithinFrustum(planes, result);
		return result;
	}

	// Token: 0x0600015C RID: 348 RVA: 0x0000CD98 File Offset: 0x0000AF98
	public Bounds GetMaxBounds()
	{
		return this.rootNode.GetBounds();
	}

	// Token: 0x0600015D RID: 349 RVA: 0x0000CDA5 File Offset: 0x0000AFA5
	public void DrawAllBounds()
	{
		this.rootNode.DrawAllBounds(0f);
	}

	// Token: 0x0600015E RID: 350 RVA: 0x0000CDB7 File Offset: 0x0000AFB7
	public void DrawAllObjects()
	{
		this.rootNode.DrawAllObjects();
	}

	// Token: 0x0600015F RID: 351 RVA: 0x0000CDC4 File Offset: 0x0000AFC4
	private void Grow(Vector3 direction)
	{
		int num = (direction.x >= 0f) ? 1 : -1;
		int num2 = (direction.y >= 0f) ? 1 : -1;
		int num3 = (direction.z >= 0f) ? 1 : -1;
		BoundsOctreeNode<T> boundsOctreeNode = this.rootNode;
		float num4 = this.rootNode.BaseLength / 2f;
		float baseLengthVal = this.rootNode.BaseLength * 2f;
		Vector3 vector = this.rootNode.Center + new Vector3((float)num * num4, (float)num2 * num4, (float)num3 * num4);
		this.rootNode = new BoundsOctreeNode<T>(baseLengthVal, this.minSize, this.looseness, vector);
		if (boundsOctreeNode.HasAnyObjects())
		{
			int num5 = this.rootNode.BestFitChild(boundsOctreeNode.Center);
			BoundsOctreeNode<T>[] array = new BoundsOctreeNode<T>[8];
			for (int i = 0; i < 8; i++)
			{
				if (i == num5)
				{
					array[i] = boundsOctreeNode;
				}
				else
				{
					num = ((i % 2 == 0) ? -1 : 1);
					num2 = ((i > 3) ? -1 : 1);
					num3 = ((i < 2 || (i > 3 && i < 6)) ? -1 : 1);
					array[i] = new BoundsOctreeNode<T>(boundsOctreeNode.BaseLength, this.minSize, this.looseness, vector + new Vector3((float)num * num4, (float)num2 * num4, (float)num3 * num4));
				}
			}
			this.rootNode.SetChildren(array);
		}
	}

	// Token: 0x06000160 RID: 352 RVA: 0x0000CF26 File Offset: 0x0000B126
	private void Shrink()
	{
		this.rootNode = this.rootNode.ShrinkIfPossible(this.initialSize);
	}

	// Token: 0x0400014A RID: 330
	private BoundsOctreeNode<T> rootNode;

	// Token: 0x0400014B RID: 331
	private readonly float looseness;

	// Token: 0x0400014C RID: 332
	private readonly float initialSize;

	// Token: 0x0400014D RID: 333
	private readonly float minSize;
}

using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000039 RID: 57
public class PointOctree<T>
{
	// Token: 0x17000028 RID: 40
	// (get) Token: 0x0600019E RID: 414 RVA: 0x0000EFEB File Offset: 0x0000D1EB
	// (set) Token: 0x0600019F RID: 415 RVA: 0x0000EFF3 File Offset: 0x0000D1F3
	public int Count { get; private set; }

	// Token: 0x060001A0 RID: 416 RVA: 0x0000EFFC File Offset: 0x0000D1FC
	public PointOctree(float initialWorldSize, Vector3 initialWorldPos, float minNodeSize)
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
		this.rootNode = new PointOctreeNode<T>(this.initialSize, this.minSize, initialWorldPos);
	}

	// Token: 0x060001A1 RID: 417 RVA: 0x0000F078 File Offset: 0x0000D278
	public void Add(T obj, Vector3 objPos)
	{
		int num = 0;
		while (!this.rootNode.Add(obj, objPos))
		{
			this.Grow(objPos - this.rootNode.Center);
			if (++num > 20)
			{
				Debug.LogError("Aborted Add operation as it seemed to be going on forever (" + (num - 1) + ") attempts at growing the octree.");
				return;
			}
		}
		int count = this.Count;
		this.Count = count + 1;
	}

	// Token: 0x060001A2 RID: 418 RVA: 0x0000F0E8 File Offset: 0x0000D2E8
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

	// Token: 0x060001A3 RID: 419 RVA: 0x0000F11C File Offset: 0x0000D31C
	public bool Remove(T obj, Vector3 objPos)
	{
		bool flag = this.rootNode.Remove(obj, objPos);
		if (flag)
		{
			int count = this.Count;
			this.Count = count - 1;
			this.Shrink();
		}
		return flag;
	}

	// Token: 0x060001A4 RID: 420 RVA: 0x0000F14F File Offset: 0x0000D34F
	public bool GetNearbyNonAlloc(Ray ray, float maxDistance, List<T> nearBy)
	{
		nearBy.Clear();
		this.rootNode.GetNearby(ref ray, maxDistance, nearBy);
		return nearBy.Count > 0;
	}

	// Token: 0x060001A5 RID: 421 RVA: 0x0000F174 File Offset: 0x0000D374
	public T[] GetNearby(Ray ray, float maxDistance)
	{
		List<T> list = new List<T>();
		this.rootNode.GetNearby(ref ray, maxDistance, list);
		return list.ToArray();
	}

	// Token: 0x060001A6 RID: 422 RVA: 0x0000F19C File Offset: 0x0000D39C
	public T[] GetNearby(Vector3 position, float maxDistance)
	{
		List<T> list = new List<T>();
		this.rootNode.GetNearby(ref position, maxDistance, list);
		return list.ToArray();
	}

	// Token: 0x060001A7 RID: 423 RVA: 0x0000F1C4 File Offset: 0x0000D3C4
	public bool GetNearbyNonAlloc(Vector3 position, float maxDistance, List<T> nearBy)
	{
		nearBy.Clear();
		this.rootNode.GetNearby(ref position, maxDistance, nearBy);
		return nearBy.Count > 0;
	}

	// Token: 0x060001A8 RID: 424 RVA: 0x0000F1E8 File Offset: 0x0000D3E8
	public ICollection<T> GetAll()
	{
		List<T> result = new List<T>(this.Count);
		this.rootNode.GetAll(result);
		return result;
	}

	// Token: 0x060001A9 RID: 425 RVA: 0x0000F20E File Offset: 0x0000D40E
	public void DrawAllBounds()
	{
		this.rootNode.DrawAllBounds(0f);
	}

	// Token: 0x060001AA RID: 426 RVA: 0x0000F220 File Offset: 0x0000D420
	public void DrawAllObjects()
	{
		this.rootNode.DrawAllObjects();
	}

	// Token: 0x060001AB RID: 427 RVA: 0x0000F230 File Offset: 0x0000D430
	private void Grow(Vector3 direction)
	{
		int num = (direction.x >= 0f) ? 1 : -1;
		int num2 = (direction.y >= 0f) ? 1 : -1;
		int num3 = (direction.z >= 0f) ? 1 : -1;
		PointOctreeNode<T> pointOctreeNode = this.rootNode;
		float num4 = this.rootNode.SideLength / 2f;
		float baseLengthVal = this.rootNode.SideLength * 2f;
		Vector3 vector = this.rootNode.Center + new Vector3((float)num * num4, (float)num2 * num4, (float)num3 * num4);
		this.rootNode = new PointOctreeNode<T>(baseLengthVal, this.minSize, vector);
		if (pointOctreeNode.HasAnyObjects())
		{
			int num5 = this.rootNode.BestFitChild(pointOctreeNode.Center);
			PointOctreeNode<T>[] array = new PointOctreeNode<T>[8];
			for (int i = 0; i < 8; i++)
			{
				if (i == num5)
				{
					array[i] = pointOctreeNode;
				}
				else
				{
					num = ((i % 2 == 0) ? -1 : 1);
					num2 = ((i > 3) ? -1 : 1);
					num3 = ((i < 2 || (i > 3 && i < 6)) ? -1 : 1);
					array[i] = new PointOctreeNode<T>(pointOctreeNode.SideLength, this.minSize, vector + new Vector3((float)num * num4, (float)num2 * num4, (float)num3 * num4));
				}
			}
			this.rootNode.SetChildren(array);
		}
	}

	// Token: 0x060001AC RID: 428 RVA: 0x0000F386 File Offset: 0x0000D586
	private void Shrink()
	{
		this.rootNode = this.rootNode.ShrinkIfPossible(this.initialSize);
	}

	// Token: 0x0400018E RID: 398
	private PointOctreeNode<T> rootNode;

	// Token: 0x0400018F RID: 399
	private readonly float initialSize;

	// Token: 0x04000190 RID: 400
	private readonly float minSize;
}

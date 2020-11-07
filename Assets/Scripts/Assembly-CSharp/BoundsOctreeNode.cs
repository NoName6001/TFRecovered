using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x02000032 RID: 50
public class BoundsOctreeNode<T>
{
	// Token: 0x17000020 RID: 32
	// (get) Token: 0x06000161 RID: 353 RVA: 0x0000CF3F File Offset: 0x0000B13F
	// (set) Token: 0x06000162 RID: 354 RVA: 0x0000CF47 File Offset: 0x0000B147
	public Vector3 Center { get; private set; }

	// Token: 0x17000021 RID: 33
	// (get) Token: 0x06000163 RID: 355 RVA: 0x0000CF50 File Offset: 0x0000B150
	// (set) Token: 0x06000164 RID: 356 RVA: 0x0000CF58 File Offset: 0x0000B158
	public float BaseLength { get; private set; }

	// Token: 0x17000022 RID: 34
	// (get) Token: 0x06000165 RID: 357 RVA: 0x0000CF61 File Offset: 0x0000B161
	private bool HasChildren
	{
		get
		{
			return this.children != null;
		}
	}

	// Token: 0x06000166 RID: 358 RVA: 0x0000CF6C File Offset: 0x0000B16C
	public BoundsOctreeNode(float baseLengthVal, float minSizeVal, float loosenessVal, Vector3 centerVal)
	{
		this.SetValues(baseLengthVal, minSizeVal, loosenessVal, centerVal);
	}

	// Token: 0x06000167 RID: 359 RVA: 0x0000CF8A File Offset: 0x0000B18A
	public bool Add(T obj, Bounds objBounds)
	{
		if (!BoundsOctreeNode<T>.Encapsulates(this.bounds, objBounds))
		{
			return false;
		}
		this.SubAdd(obj, objBounds);
		return true;
	}

	// Token: 0x06000168 RID: 360 RVA: 0x0000CFA8 File Offset: 0x0000B1A8
	public bool Remove(T obj)
	{
		bool flag = false;
		for (int i = 0; i < this.objects.Count; i++)
		{
			if (this.objects[i].Obj.Equals(obj))
			{
				flag = this.objects.Remove(this.objects[i]);
				break;
			}
		}
		if (!flag && this.children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				flag = this.children[j].Remove(obj);
				if (flag)
				{
					break;
				}
			}
		}
		if (flag && this.children != null && this.ShouldMerge())
		{
			this.Merge();
		}
		return flag;
	}

	// Token: 0x06000169 RID: 361 RVA: 0x0000D051 File Offset: 0x0000B251
	public bool Remove(T obj, Bounds objBounds)
	{
		return BoundsOctreeNode<T>.Encapsulates(this.bounds, objBounds) && this.SubRemove(obj, objBounds);
	}

	// Token: 0x0600016A RID: 362 RVA: 0x0000D06C File Offset: 0x0000B26C
	public bool IsColliding(ref Bounds checkBounds)
	{
		if (!this.bounds.Intersects(checkBounds))
		{
			return false;
		}
		for (int i = 0; i < this.objects.Count; i++)
		{
			if (this.objects[i].Bounds.Intersects(checkBounds))
			{
				return true;
			}
		}
		if (this.children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				if (this.children[j].IsColliding(ref checkBounds))
				{
					return true;
				}
			}
		}
		return false;
	}

	// Token: 0x0600016B RID: 363 RVA: 0x0000D0F0 File Offset: 0x0000B2F0
	public bool IsColliding(ref Ray checkRay, float maxDistance = float.PositiveInfinity)
	{
		float num;
		if (!this.bounds.IntersectRay(checkRay, out num) || num > maxDistance)
		{
			return false;
		}
		for (int i = 0; i < this.objects.Count; i++)
		{
			if (this.objects[i].Bounds.IntersectRay(checkRay, out num) && num <= maxDistance)
			{
				return true;
			}
		}
		if (this.children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				if (this.children[j].IsColliding(ref checkRay, maxDistance))
				{
					return true;
				}
			}
		}
		return false;
	}

	// Token: 0x0600016C RID: 364 RVA: 0x0000D180 File Offset: 0x0000B380
	public void GetColliding(ref Bounds checkBounds, List<T> result)
	{
		if (!this.bounds.Intersects(checkBounds))
		{
			return;
		}
		for (int i = 0; i < this.objects.Count; i++)
		{
			if (this.objects[i].Bounds.Intersects(checkBounds))
			{
				result.Add(this.objects[i].Obj);
			}
		}
		if (this.children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				this.children[j].GetColliding(ref checkBounds, result);
			}
		}
	}

	// Token: 0x0600016D RID: 365 RVA: 0x0000D214 File Offset: 0x0000B414
	public void GetColliding(ref Ray checkRay, List<T> result, float maxDistance = float.PositiveInfinity)
	{
		float num;
		if (!this.bounds.IntersectRay(checkRay, out num) || num > maxDistance)
		{
			return;
		}
		for (int i = 0; i < this.objects.Count; i++)
		{
			if (this.objects[i].Bounds.IntersectRay(checkRay, out num) && num <= maxDistance)
			{
				result.Add(this.objects[i].Obj);
			}
		}
		if (this.children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				this.children[j].GetColliding(ref checkRay, result, maxDistance);
			}
		}
	}

	// Token: 0x0600016E RID: 366 RVA: 0x0000D2B4 File Offset: 0x0000B4B4
	public void GetWithinFrustum(Plane[] planes, List<T> result)
	{
		if (!GeometryUtility.TestPlanesAABB(planes, this.bounds))
		{
			return;
		}
		for (int i = 0; i < this.objects.Count; i++)
		{
			if (GeometryUtility.TestPlanesAABB(planes, this.objects[i].Bounds))
			{
				result.Add(this.objects[i].Obj);
			}
		}
		if (this.children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				this.children[j].GetWithinFrustum(planes, result);
			}
		}
	}

	// Token: 0x0600016F RID: 367 RVA: 0x0000D339 File Offset: 0x0000B539
	public void SetChildren(BoundsOctreeNode<T>[] childOctrees)
	{
		if (childOctrees.Length != 8)
		{
			Debug.LogError("Child octree array must be length 8. Was length: " + childOctrees.Length);
			return;
		}
		this.children = childOctrees;
	}

	// Token: 0x06000170 RID: 368 RVA: 0x0000D360 File Offset: 0x0000B560
	public Bounds GetBounds()
	{
		return this.bounds;
	}

	// Token: 0x06000171 RID: 369 RVA: 0x0000D368 File Offset: 0x0000B568
	public void DrawAllBounds(float depth = 0f)
	{
		float num = depth / 7f;
		Gizmos.color = new Color(num, 0f, 1f - num);
		Bounds bounds = new Bounds(this.Center, new Vector3(this.adjLength, this.adjLength, this.adjLength));
		Gizmos.DrawWireCube(bounds.center, bounds.size);
		if (this.children != null)
		{
			depth += 1f;
			for (int i = 0; i < 8; i++)
			{
				this.children[i].DrawAllBounds(depth);
			}
		}
		Gizmos.color = Color.white;
	}

	// Token: 0x06000172 RID: 370 RVA: 0x0000D400 File Offset: 0x0000B600
	public void DrawAllObjects()
	{
		float num = this.BaseLength / 20f;
		Gizmos.color = new Color(0f, 1f - num, num, 0.25f);
		foreach (BoundsOctreeNode<T>.OctreeObject octreeObject in this.objects)
		{
			Bounds bounds = octreeObject.Bounds;
			Vector3 center = bounds.center;
			bounds = octreeObject.Bounds;
			Gizmos.DrawCube(center, bounds.size);
		}
		if (this.children != null)
		{
			for (int i = 0; i < 8; i++)
			{
				this.children[i].DrawAllObjects();
			}
		}
		Gizmos.color = Color.white;
	}

	// Token: 0x06000173 RID: 371 RVA: 0x0000D4C8 File Offset: 0x0000B6C8
	public BoundsOctreeNode<T> ShrinkIfPossible(float minLength)
	{
		if (this.BaseLength < 2f * minLength)
		{
			return this;
		}
		if (this.objects.Count == 0 && (this.children == null || this.children.Length == 0))
		{
			return this;
		}
		int num = -1;
		for (int i = 0; i < this.objects.Count; i++)
		{
			BoundsOctreeNode<T>.OctreeObject octreeObject = this.objects[i];
			int num2 = this.BestFitChild(octreeObject.Bounds.center);
			if (i != 0 && num2 != num)
			{
				return this;
			}
			if (!BoundsOctreeNode<T>.Encapsulates(this.childBounds[num2], octreeObject.Bounds))
			{
				return this;
			}
			if (num < 0)
			{
				num = num2;
			}
		}
		if (this.children != null)
		{
			bool flag = false;
			for (int j = 0; j < this.children.Length; j++)
			{
				if (this.children[j].HasAnyObjects())
				{
					if (flag)
					{
						return this;
					}
					if (num >= 0 && num != j)
					{
						return this;
					}
					flag = true;
					num = j;
				}
			}
		}
		if (this.children == null)
		{
			this.SetValues(this.BaseLength / 2f, this.minSize, this.looseness, this.childBounds[num].center);
			return this;
		}
		if (num == -1)
		{
			return this;
		}
		return this.children[num];
	}

	// Token: 0x06000174 RID: 372 RVA: 0x0000D5FC File Offset: 0x0000B7FC
	public int BestFitChild(Vector3 objBoundsCenter)
	{
		return ((objBoundsCenter.x <= this.Center.x) ? 0 : 1) + ((objBoundsCenter.y >= this.Center.y) ? 0 : 4) + ((objBoundsCenter.z <= this.Center.z) ? 0 : 2);
	}

	// Token: 0x06000175 RID: 373 RVA: 0x0000D650 File Offset: 0x0000B850
	public bool HasAnyObjects()
	{
		if (this.objects.Count > 0)
		{
			return true;
		}
		if (this.children != null)
		{
			for (int i = 0; i < 8; i++)
			{
				if (this.children[i].HasAnyObjects())
				{
					return true;
				}
			}
		}
		return false;
	}

	// Token: 0x06000176 RID: 374 RVA: 0x0000D694 File Offset: 0x0000B894
	private void SetValues(float baseLengthVal, float minSizeVal, float loosenessVal, Vector3 centerVal)
	{
		this.BaseLength = baseLengthVal;
		this.minSize = minSizeVal;
		this.looseness = loosenessVal;
		this.Center = centerVal;
		this.adjLength = this.looseness * baseLengthVal;
		Vector3 size = new Vector3(this.adjLength, this.adjLength, this.adjLength);
		this.bounds = new Bounds(this.Center, size);
		float num = this.BaseLength / 4f;
		float num2 = this.BaseLength / 2f * this.looseness;
		Vector3 size2 = new Vector3(num2, num2, num2);
		this.childBounds = new Bounds[8];
		this.childBounds[0] = new Bounds(this.Center + new Vector3(-num, num, -num), size2);
		this.childBounds[1] = new Bounds(this.Center + new Vector3(num, num, -num), size2);
		this.childBounds[2] = new Bounds(this.Center + new Vector3(-num, num, num), size2);
		this.childBounds[3] = new Bounds(this.Center + new Vector3(num, num, num), size2);
		this.childBounds[4] = new Bounds(this.Center + new Vector3(-num, -num, -num), size2);
		this.childBounds[5] = new Bounds(this.Center + new Vector3(num, -num, -num), size2);
		this.childBounds[6] = new Bounds(this.Center + new Vector3(-num, -num, num), size2);
		this.childBounds[7] = new Bounds(this.Center + new Vector3(num, -num, num), size2);
	}

	// Token: 0x06000177 RID: 375 RVA: 0x0000D864 File Offset: 0x0000BA64
	private void SubAdd(T obj, Bounds objBounds)
	{
		if (!this.HasChildren)
		{
			if (this.objects.Count < 8 || this.BaseLength / 2f < this.minSize)
			{
				BoundsOctreeNode<T>.OctreeObject item = new BoundsOctreeNode<T>.OctreeObject
				{
					Obj = obj,
					Bounds = objBounds
				};
				this.objects.Add(item);
				return;
			}
			if (this.children == null)
			{
				this.Split();
				if (this.children == null)
				{
					Debug.LogError("Child creation failed for an unknown reason. Early exit.");
					return;
				}
				for (int i = this.objects.Count - 1; i >= 0; i--)
				{
					BoundsOctreeNode<T>.OctreeObject octreeObject = this.objects[i];
					int num = this.BestFitChild(octreeObject.Bounds.center);
					if (BoundsOctreeNode<T>.Encapsulates(this.children[num].bounds, octreeObject.Bounds))
					{
						this.children[num].SubAdd(octreeObject.Obj, octreeObject.Bounds);
						this.objects.Remove(octreeObject);
					}
				}
			}
		}
		int num2 = this.BestFitChild(objBounds.center);
		if (BoundsOctreeNode<T>.Encapsulates(this.children[num2].bounds, objBounds))
		{
			this.children[num2].SubAdd(obj, objBounds);
			return;
		}
		BoundsOctreeNode<T>.OctreeObject item2 = new BoundsOctreeNode<T>.OctreeObject
		{
			Obj = obj,
			Bounds = objBounds
		};
		this.objects.Add(item2);
	}

	// Token: 0x06000178 RID: 376 RVA: 0x0000D9C8 File Offset: 0x0000BBC8
	private bool SubRemove(T obj, Bounds objBounds)
	{
		bool flag = false;
		for (int i = 0; i < this.objects.Count; i++)
		{
			if (this.objects[i].Obj.Equals(obj))
			{
				flag = this.objects.Remove(this.objects[i]);
				break;
			}
		}
		if (!flag && this.children != null)
		{
			int num = this.BestFitChild(objBounds.center);
			flag = this.children[num].SubRemove(obj, objBounds);
		}
		if (flag && this.children != null && this.ShouldMerge())
		{
			this.Merge();
		}
		return flag;
	}

	// Token: 0x06000179 RID: 377 RVA: 0x0000DA74 File Offset: 0x0000BC74
	private void Split()
	{
		float num = this.BaseLength / 4f;
		float baseLengthVal = this.BaseLength / 2f;
		this.children = new BoundsOctreeNode<T>[8];
		this.children[0] = new BoundsOctreeNode<T>(baseLengthVal, this.minSize, this.looseness, this.Center + new Vector3(-num, num, -num));
		this.children[1] = new BoundsOctreeNode<T>(baseLengthVal, this.minSize, this.looseness, this.Center + new Vector3(num, num, -num));
		this.children[2] = new BoundsOctreeNode<T>(baseLengthVal, this.minSize, this.looseness, this.Center + new Vector3(-num, num, num));
		this.children[3] = new BoundsOctreeNode<T>(baseLengthVal, this.minSize, this.looseness, this.Center + new Vector3(num, num, num));
		this.children[4] = new BoundsOctreeNode<T>(baseLengthVal, this.minSize, this.looseness, this.Center + new Vector3(-num, -num, -num));
		this.children[5] = new BoundsOctreeNode<T>(baseLengthVal, this.minSize, this.looseness, this.Center + new Vector3(num, -num, -num));
		this.children[6] = new BoundsOctreeNode<T>(baseLengthVal, this.minSize, this.looseness, this.Center + new Vector3(-num, -num, num));
		this.children[7] = new BoundsOctreeNode<T>(baseLengthVal, this.minSize, this.looseness, this.Center + new Vector3(num, -num, num));
	}

	// Token: 0x0600017A RID: 378 RVA: 0x0000DC1C File Offset: 0x0000BE1C
	private void Merge()
	{
		for (int i = 0; i < 8; i++)
		{
			BoundsOctreeNode<T> boundsOctreeNode = this.children[i];
			for (int j = boundsOctreeNode.objects.Count - 1; j >= 0; j--)
			{
				BoundsOctreeNode<T>.OctreeObject item = boundsOctreeNode.objects[j];
				this.objects.Add(item);
			}
		}
		this.children = null;
	}

	// Token: 0x0600017B RID: 379 RVA: 0x0000DC76 File Offset: 0x0000BE76
	private static bool Encapsulates(Bounds outerBounds, Bounds innerBounds)
	{
		return outerBounds.Contains(innerBounds.min) && outerBounds.Contains(innerBounds.max);
	}

	// Token: 0x0600017C RID: 380 RVA: 0x0000DC98 File Offset: 0x0000BE98
	private bool ShouldMerge()
	{
		int num = this.objects.Count;
		if (this.children != null)
		{
			foreach (BoundsOctreeNode<T> boundsOctreeNode in this.children)
			{
				if (boundsOctreeNode.children != null)
				{
					return false;
				}
				num += boundsOctreeNode.objects.Count;
			}
		}
		return num <= 8;
	}

	// Token: 0x04000150 RID: 336
	private float looseness;

	// Token: 0x04000151 RID: 337
	private float minSize;

	// Token: 0x04000152 RID: 338
	private float adjLength;

	// Token: 0x04000153 RID: 339
	private Bounds bounds;

	// Token: 0x04000154 RID: 340
	private readonly List<BoundsOctreeNode<T>.OctreeObject> objects = new List<BoundsOctreeNode<T>.OctreeObject>();

	// Token: 0x04000155 RID: 341
	private BoundsOctreeNode<T>[] children;

	// Token: 0x04000156 RID: 342
	private Bounds[] childBounds;

	// Token: 0x04000157 RID: 343
	private const int NUM_OBJECTS_ALLOWED = 8;

	// Token: 0x02000202 RID: 514
	private struct OctreeObject
	{
		// Token: 0x040008C1 RID: 2241
		public T Obj;

		// Token: 0x040008C2 RID: 2242
		public Bounds Bounds;
	}
}

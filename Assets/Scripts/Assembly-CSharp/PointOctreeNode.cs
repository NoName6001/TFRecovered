using System;
using System.Collections.Generic;
using UnityEngine;

// Token: 0x0200003A RID: 58
public class PointOctreeNode<T>
{
	// Token: 0x17000029 RID: 41
	// (get) Token: 0x060001AD RID: 429 RVA: 0x0000F39F File Offset: 0x0000D59F
	// (set) Token: 0x060001AE RID: 430 RVA: 0x0000F3A7 File Offset: 0x0000D5A7
	public Vector3 Center { get; private set; }

	// Token: 0x1700002A RID: 42
	// (get) Token: 0x060001AF RID: 431 RVA: 0x0000F3B0 File Offset: 0x0000D5B0
	// (set) Token: 0x060001B0 RID: 432 RVA: 0x0000F3B8 File Offset: 0x0000D5B8
	public float SideLength { get; private set; }

	// Token: 0x1700002B RID: 43
	// (get) Token: 0x060001B1 RID: 433 RVA: 0x0000F3C1 File Offset: 0x0000D5C1
	private bool HasChildren
	{
		get
		{
			return this.children != null;
		}
	}

	// Token: 0x060001B2 RID: 434 RVA: 0x0000F3CC File Offset: 0x0000D5CC
	public PointOctreeNode(float baseLengthVal, float minSizeVal, Vector3 centerVal)
	{
		this.SetValues(baseLengthVal, minSizeVal, centerVal);
	}

	// Token: 0x060001B3 RID: 435 RVA: 0x0000F3E8 File Offset: 0x0000D5E8
	public bool Add(T obj, Vector3 objPos)
	{
		if (!PointOctreeNode<T>.Encapsulates(this.bounds, objPos))
		{
			return false;
		}
		this.SubAdd(obj, objPos);
		return true;
	}

	// Token: 0x060001B4 RID: 436 RVA: 0x0000F404 File Offset: 0x0000D604
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

	// Token: 0x060001B5 RID: 437 RVA: 0x0000F4AA File Offset: 0x0000D6AA
	public bool Remove(T obj, Vector3 objPos)
	{
		return PointOctreeNode<T>.Encapsulates(this.bounds, objPos) && this.SubRemove(obj, objPos);
	}

	// Token: 0x060001B6 RID: 438 RVA: 0x0000F4C4 File Offset: 0x0000D6C4
	public void GetNearby(ref Ray ray, float maxDistance, List<T> result)
	{
		this.bounds.Expand(new Vector3(maxDistance * 2f, maxDistance * 2f, maxDistance * 2f));
		bool flag = this.bounds.IntersectRay(ray);
		this.bounds.size = this.actualBoundsSize;
		if (!flag)
		{
			return;
		}
		for (int i = 0; i < this.objects.Count; i++)
		{
			if (PointOctreeNode<T>.SqrDistanceToRay(ray, this.objects[i].Pos) <= maxDistance * maxDistance)
			{
				result.Add(this.objects[i].Obj);
			}
		}
		if (this.children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				this.children[j].GetNearby(ref ray, maxDistance, result);
			}
		}
	}

	// Token: 0x060001B7 RID: 439 RVA: 0x0000F590 File Offset: 0x0000D790
	public void GetNearby(ref Vector3 position, float maxDistance, List<T> result)
	{
		float num = maxDistance * maxDistance;
		if ((this.bounds.ClosestPoint(position) - position).sqrMagnitude > num)
		{
			return;
		}
		for (int i = 0; i < this.objects.Count; i++)
		{
			if ((position - this.objects[i].Pos).sqrMagnitude <= num)
			{
				result.Add(this.objects[i].Obj);
			}
		}
		if (this.children != null)
		{
			for (int j = 0; j < 8; j++)
			{
				this.children[j].GetNearby(ref position, maxDistance, result);
			}
		}
	}

	// Token: 0x060001B8 RID: 440 RVA: 0x0000F644 File Offset: 0x0000D844
	public void GetAll(List<T> result)
	{
		foreach (PointOctreeNode<T>.OctreeObject octreeObject in this.objects)
		{
			result.Add(octreeObject.Obj);
		}
		if (this.children != null)
		{
			for (int i = 0; i < 8; i++)
			{
				this.children[i].GetAll(result);
			}
		}
	}

	// Token: 0x060001B9 RID: 441 RVA: 0x0000F6C0 File Offset: 0x0000D8C0
	public void SetChildren(PointOctreeNode<T>[] childOctrees)
	{
		if (childOctrees.Length != 8)
		{
			Debug.LogError("Child octree array must be length 8. Was length: " + childOctrees.Length);
			return;
		}
		this.children = childOctrees;
	}

	// Token: 0x060001BA RID: 442 RVA: 0x0000F6E8 File Offset: 0x0000D8E8
	public void DrawAllBounds(float depth = 0f)
	{
		float num = depth / 7f;
		Gizmos.color = new Color(num, 0f, 1f - num);
		Bounds bounds = new Bounds(this.Center, new Vector3(this.SideLength, this.SideLength, this.SideLength));
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

	// Token: 0x060001BB RID: 443 RVA: 0x0000F780 File Offset: 0x0000D980
	public void DrawAllObjects()
	{
		float num = this.SideLength / 20f;
		Gizmos.color = new Color(0f, 1f - num, num, 0.25f);
		foreach (PointOctreeNode<T>.OctreeObject octreeObject in this.objects)
		{
			Gizmos.DrawIcon(octreeObject.Pos, "marker.tif", true);
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

	// Token: 0x060001BC RID: 444 RVA: 0x0000F830 File Offset: 0x0000DA30
	public PointOctreeNode<T> ShrinkIfPossible(float minLength)
	{
		if (this.SideLength < 2f * minLength)
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
			PointOctreeNode<T>.OctreeObject octreeObject = this.objects[i];
			int num2 = this.BestFitChild(octreeObject.Pos);
			if (i != 0 && num2 != num)
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
			this.SetValues(this.SideLength / 2f, this.minSize, this.childBounds[num].center);
			return this;
		}
		return this.children[num];
	}

	// Token: 0x060001BD RID: 445 RVA: 0x0000F938 File Offset: 0x0000DB38
	public int BestFitChild(Vector3 objPos)
	{
		return ((objPos.x <= this.Center.x) ? 0 : 1) + ((objPos.y >= this.Center.y) ? 0 : 4) + ((objPos.z <= this.Center.z) ? 0 : 2);
	}

	// Token: 0x060001BE RID: 446 RVA: 0x0000F98C File Offset: 0x0000DB8C
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

	// Token: 0x060001BF RID: 447 RVA: 0x0000F9D0 File Offset: 0x0000DBD0
	private void SetValues(float baseLengthVal, float minSizeVal, Vector3 centerVal)
	{
		this.SideLength = baseLengthVal;
		this.minSize = minSizeVal;
		this.Center = centerVal;
		this.actualBoundsSize = new Vector3(this.SideLength, this.SideLength, this.SideLength);
		this.bounds = new Bounds(this.Center, this.actualBoundsSize);
		float num = this.SideLength / 4f;
		float num2 = this.SideLength / 2f;
		Vector3 size = new Vector3(num2, num2, num2);
		this.childBounds = new Bounds[8];
		this.childBounds[0] = new Bounds(this.Center + new Vector3(-num, num, -num), size);
		this.childBounds[1] = new Bounds(this.Center + new Vector3(num, num, -num), size);
		this.childBounds[2] = new Bounds(this.Center + new Vector3(-num, num, num), size);
		this.childBounds[3] = new Bounds(this.Center + new Vector3(num, num, num), size);
		this.childBounds[4] = new Bounds(this.Center + new Vector3(-num, -num, -num), size);
		this.childBounds[5] = new Bounds(this.Center + new Vector3(num, -num, -num), size);
		this.childBounds[6] = new Bounds(this.Center + new Vector3(-num, -num, num), size);
		this.childBounds[7] = new Bounds(this.Center + new Vector3(num, -num, num), size);
	}

	// Token: 0x060001C0 RID: 448 RVA: 0x0000FB8C File Offset: 0x0000DD8C
	private void SubAdd(T obj, Vector3 objPos)
	{
		if (!this.HasChildren)
		{
			if (this.objects.Count < 8 || this.SideLength / 2f < this.minSize)
			{
				PointOctreeNode<T>.OctreeObject item = new PointOctreeNode<T>.OctreeObject
				{
					Obj = obj,
					Pos = objPos
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
					PointOctreeNode<T>.OctreeObject octreeObject = this.objects[i];
					int num = this.BestFitChild(octreeObject.Pos);
					this.children[num].SubAdd(octreeObject.Obj, octreeObject.Pos);
					this.objects.Remove(octreeObject);
				}
			}
		}
		int num2 = this.BestFitChild(objPos);
		this.children[num2].SubAdd(obj, objPos);
	}

	// Token: 0x060001C1 RID: 449 RVA: 0x0000FC7C File Offset: 0x0000DE7C
	private bool SubRemove(T obj, Vector3 objPos)
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
			int num = this.BestFitChild(objPos);
			flag = this.children[num].SubRemove(obj, objPos);
		}
		if (flag && this.children != null && this.ShouldMerge())
		{
			this.Merge();
		}
		return flag;
	}

	// Token: 0x060001C2 RID: 450 RVA: 0x0000FD1C File Offset: 0x0000DF1C
	private void Split()
	{
		float num = this.SideLength / 4f;
		float baseLengthVal = this.SideLength / 2f;
		this.children = new PointOctreeNode<T>[8];
		this.children[0] = new PointOctreeNode<T>(baseLengthVal, this.minSize, this.Center + new Vector3(-num, num, -num));
		this.children[1] = new PointOctreeNode<T>(baseLengthVal, this.minSize, this.Center + new Vector3(num, num, -num));
		this.children[2] = new PointOctreeNode<T>(baseLengthVal, this.minSize, this.Center + new Vector3(-num, num, num));
		this.children[3] = new PointOctreeNode<T>(baseLengthVal, this.minSize, this.Center + new Vector3(num, num, num));
		this.children[4] = new PointOctreeNode<T>(baseLengthVal, this.minSize, this.Center + new Vector3(-num, -num, -num));
		this.children[5] = new PointOctreeNode<T>(baseLengthVal, this.minSize, this.Center + new Vector3(num, -num, -num));
		this.children[6] = new PointOctreeNode<T>(baseLengthVal, this.minSize, this.Center + new Vector3(-num, -num, num));
		this.children[7] = new PointOctreeNode<T>(baseLengthVal, this.minSize, this.Center + new Vector3(num, -num, num));
	}

	// Token: 0x060001C3 RID: 451 RVA: 0x0000FE94 File Offset: 0x0000E094
	private void Merge()
	{
		for (int i = 0; i < 8; i++)
		{
			PointOctreeNode<T> pointOctreeNode = this.children[i];
			for (int j = pointOctreeNode.objects.Count - 1; j >= 0; j--)
			{
				PointOctreeNode<T>.OctreeObject item = pointOctreeNode.objects[j];
				this.objects.Add(item);
			}
		}
		this.children = null;
	}

	// Token: 0x060001C4 RID: 452 RVA: 0x0000FEEE File Offset: 0x0000E0EE
	private static bool Encapsulates(Bounds outerBounds, Vector3 point)
	{
		return outerBounds.Contains(point);
	}

	// Token: 0x060001C5 RID: 453 RVA: 0x0000FEF8 File Offset: 0x0000E0F8
	private bool ShouldMerge()
	{
		int num = this.objects.Count;
		if (this.children != null)
		{
			foreach (PointOctreeNode<T> pointOctreeNode in this.children)
			{
				if (pointOctreeNode.children != null)
				{
					return false;
				}
				num += pointOctreeNode.objects.Count;
			}
		}
		return num <= 8;
	}

	// Token: 0x060001C6 RID: 454 RVA: 0x0000FF54 File Offset: 0x0000E154
	public static float SqrDistanceToRay(Ray ray, Vector3 point)
	{
		return Vector3.Cross(ray.direction, point - ray.origin).sqrMagnitude;
	}

	// Token: 0x04000193 RID: 403
	private float minSize;

	// Token: 0x04000194 RID: 404
	private Bounds bounds;

	// Token: 0x04000195 RID: 405
	private readonly List<PointOctreeNode<T>.OctreeObject> objects = new List<PointOctreeNode<T>.OctreeObject>();

	// Token: 0x04000196 RID: 406
	private PointOctreeNode<T>[] children;

	// Token: 0x04000197 RID: 407
	private Bounds[] childBounds;

	// Token: 0x04000198 RID: 408
	private const int NUM_OBJECTS_ALLOWED = 8;

	// Token: 0x04000199 RID: 409
	private Vector3 actualBoundsSize;

	// Token: 0x02000204 RID: 516
	private class OctreeObject
	{
		// Token: 0x040008C9 RID: 2249
		public T Obj;

		// Token: 0x040008CA RID: 2250
		public Vector3 Pos;
	}
}

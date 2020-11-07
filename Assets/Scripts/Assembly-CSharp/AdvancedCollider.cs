using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using FluffyUnderware.Curvy;
using MoonSharp.Interpreter;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Serialization;

// Token: 0x0200002D RID: 45
[ExecuteInEditMode]
[MoonSharpUserData]
public class AdvancedCollider : MonoBehaviour
{
	// Token: 0x1700001C RID: 28
	// (get) Token: 0x0600012B RID: 299 RVA: 0x00008BD2 File Offset: 0x00006DD2
	// (set) Token: 0x0600012C RID: 300 RVA: 0x00008BDC File Offset: 0x00006DDC
	public bool Active
	{
		get
		{
			return base.enabled;
		}
		set
		{
			base.enabled = value;
			this.m_skinMesh.enabled = value;
			this.m_meshCollider.enabled = value;
			AdvancedCollider setCollider = this.m_setCollider;
			if (setCollider != null)
			{
				setCollider.SetBlendShape(this.m_setShapeName, (float)(value ? 100 : 0));
			}
			for (int i = Game.Instance.m_fluids.Count - 1; i >= 0; i--)
			{
				Fluid fluid = Game.Instance.m_fluids[i];
				if (fluid.m_triPos != null && fluid.m_triPos.m_collider == this)
				{
					Game.Instance.RemoveFluid(i);
				}
			}
		}
	}

	// Token: 0x0600012D RID: 301 RVA: 0x00008C7C File Offset: 0x00006E7C
	public void Init(Girl girl = null)
	{
		this.m_girl = girl;
		this.m_collisionMesh = Instantiate<Mesh>(this.m_meshCollider.sharedMesh);
		this.m_collisionMesh.MarkDynamic();
		this.m_meshCollider.sharedMesh = this.m_collisionMesh;
		this.m_meshCollider.contactOffset = 0.005f;
		this.m_vertices = this.m_collisionMesh.vertices;
		int[] array = null;
		Transform transform = new GameObject().transform;
		transform.parent = this.m_skinMesh.transform;
		transform.localPosition = Vector3.zero;
		transform.localEulerAngles = Vector3.zero;
		transform.localScale = Vector3.one;
		transform.gameObject.layer = transform.parent.gameObject.layer;
		transform.tag = "AdvancedCollider";
		transform.name = "AdvancedCollider";
		if (base.gameObject.name == "Penis")
		{
			transform.gameObject.layer = LayerMask.NameToLayer("Penis");
		}
		Mesh sharedMesh = this.m_skinMesh.sharedMesh;
		Mesh mesh = Instantiate<Mesh>(this.m_meshCollider.sharedMesh);
		float[] array2 = new float[this.m_skinMesh.sharedMesh.blendShapeCount];
		for (int i = 0; i < sharedMesh.blendShapeCount; i++)
		{
			array2[i] = this.m_skinMesh.GetBlendShapeWeight(i);
			this.m_skinMesh.SetBlendShapeWeight(i, 0f);
		}
		Vector3[] vertices = sharedMesh.vertices;
		int vertexCount = this.m_collisionMesh.vertexCount;
		for (int j = 0; j < vertexCount; j++)
		{
			this.m_vertices[j] = vertices[this.m_matchVertices[j]];
		}
		mesh.vertices = this.m_vertices;
		BoneWeight[] boneWeights = sharedMesh.boneWeights;
		BoneWeight[] array3 = new BoneWeight[mesh.vertexCount];
		for (int k = 0; k < mesh.vertexCount; k++)
		{
			array3[k] = boneWeights[this.m_matchVertices[k]];
		}
		mesh.boneWeights = array3;
		mesh.bindposes = sharedMesh.bindposes;
		for (int l = 0; l < sharedMesh.blendShapeCount; l++)
		{
			Vector3[] array4 = new Vector3[sharedMesh.vertexCount];
			Vector3[] array5 = new Vector3[sharedMesh.vertexCount];
			Vector3[] array6 = new Vector3[sharedMesh.vertexCount];
			Vector3[] array7 = new Vector3[mesh.vertexCount];
			Vector3[] array8 = new Vector3[mesh.vertexCount];
			Vector3[] array9 = new Vector3[mesh.vertexCount];
			sharedMesh.GetBlendShapeFrameVertices(l, 0, array4, array5, array6);
			for (int m = 0; m < mesh.vertexCount; m++)
			{
				array7[m] = array4[this.m_matchVertices[m]];
				if (array5 != null)
				{
					array8[m] = array5[this.m_matchVertices[m]];
				}
				if (array5 != null)
				{
					array9[m] = array6[this.m_matchVertices[m]];
				}
			}
			if (array5 == null)
			{
				array8 = null;
			}
			if (array6 == null)
			{
				array9 = null;
			}
			mesh.AddBlendShapeFrame(sharedMesh.GetBlendShapeName(l), 100f, array7, array8, array9);
		}
		this.m_skinConvert = transform.gameObject.AddComponent<SkinnedMeshRenderer>();
		this.m_skinConvert.bones = this.m_skinMesh.bones;
		this.m_skinConvert.rootBone = this.m_skinMesh.rootBone;
		this.m_skinConvert.sharedMesh = mesh;
		this.m_skinConvert.enabled = false;
		this.m_meshCollider.enabled = false;
		this.m_meshCollider = transform.gameObject.AddComponent<MeshCollider>();
		this.m_meshCollider.cookingOptions = MeshColliderCookingOptions.None;
		this.m_meshCollider.sharedMesh = mesh;
		Rigidbody rigidbody = transform.gameObject.AddComponent<Rigidbody>();
		rigidbody.isKinematic = true;
		rigidbody.useGravity = false;
		if (!string.IsNullOrEmpty(this.m_defaultName))
		{
			foreach (TriangleCache triangleCache in this.m_triangleCache)
			{
				triangleCache.triggers.Add(this.m_defaultName);
			}
		}
		if (this.m_attachments.Count > 0)
		{
			this.m_attachTris = new List<TrianglePos>();
			for (int n = this.m_attachments.Count - 1; n >= 0; n--)
			{
				Transform transform2 = this.m_attachments[n];
				RaycastHit raycastHit;
				if (this.m_meshCollider.Raycast(new Ray(transform2.position, transform2.forward), out raycastHit, 0.1f))
				{
					Transform transform3 = new GameObject().transform;
					transform3.parent = transform2.parent;
					transform3.position = raycastHit.point;
					transform3.forward = raycastHit.normal;
					transform2.parent = transform3;
					TrianglePos item = new TrianglePos(this, raycastHit.triangleIndex, raycastHit.barycentricCoordinate, default(Vector3));
					this.m_attachTris.Add(item);
					this.m_attachments[n] = transform3;
				}
				else
				{
					this.m_attachments.RemoveAt(n);
				}
			}
		}
		if (this.m_skinFixes.Count > 0)
		{
			int num = vertexCount;
			foreach (MeshRenderer meshRenderer in this.m_skinFixes)
			{
				MeshFilter component = meshRenderer.GetComponent<MeshFilter>();
				Mesh mesh2 = Instantiate<Mesh>(component.sharedMesh);
				Vector3[] vertices2 = mesh2.vertices;
				int vertexCount2 = mesh2.vertexCount;
				for (int num2 = 0; num2 < vertexCount2; num2++)
				{
					Vector3 vector = vertices[this.m_matchVertices[num + num2]];
					vertices2[num2] = vector;
				}
				mesh2.vertices = vertices2;
				BoneWeight[] array10 = new BoneWeight[vertexCount2];
				for (int num3 = 0; num3 < vertexCount2; num3++)
				{
					array10[num3] = boneWeights[this.m_matchVertices[num + num3]];
				}
				mesh2.boneWeights = array10;
				mesh2.bindposes = sharedMesh.bindposes;
				GameObject gameObject = meshRenderer.gameObject;
				Material[] materials = meshRenderer.materials;
				ShadowCastingMode shadowCastingMode = meshRenderer.shadowCastingMode;
				DestroyImmediate(meshRenderer);
				DestroyImmediate(component);
				SkinnedMeshRenderer skinnedMeshRenderer = gameObject.AddComponent<SkinnedMeshRenderer>();
				skinnedMeshRenderer.bones = this.m_skinMesh.bones;
				skinnedMeshRenderer.rootBone = this.m_skinMesh.rootBone;
				skinnedMeshRenderer.sharedMesh = mesh2;
				skinnedMeshRenderer.updateWhenOffscreen = true;
				skinnedMeshRenderer.materials = materials;
				skinnedMeshRenderer.shadowCastingMode = shadowCastingMode;
				num += vertexCount2;
			}
		}
		if (this.m_skinWraps.Count > 0)
		{
			this.m_colSameArray = this.GetSameVertsArray(this.m_colSameVerts, this.m_vertices.Length);
			this.m_skinMesh.sharedMesh = Instantiate<Mesh>(this.m_skinMesh.sharedMesh);
			Mesh sharedMesh2 = this.m_skinMesh.sharedMesh;
			mesh.RecalculateNormals();
			Vector3[] normals = mesh.normals;
			foreach (int[] array11 in this.m_colSameArray)
			{
				if (array11 != null && array11.Length != 0)
				{
					Vector3 vector2 = Vector3.zero;
					for (int num5 = 0; num5 < array11.Length; num5++)
					{
						vector2 += normals[array11[num5]];
					}
					vector2 /= (float)array11.Length;
					for (int num6 = 0; num6 < array11.Length; num6++)
					{
						normals[array11[num6]] = vector2;
					}
				}
			}
			mesh.normals = normals;
			mesh.RecalculateTangents();
			Vector4[] tangents = mesh.tangents;
			List<Transform> list = new List<Transform>(this.m_skinMesh.bones);
			BoneWeight[] boneWeights2 = sharedMesh2.boneWeights;
			List<Matrix4x4> list2 = new List<Matrix4x4>(sharedMesh2.bindposes);
			int[][] sameVertsArray = this.GetSameVertsArray(this.m_skinSameVerts, vertices.Length);
			List<int>[] array12 = new List<int>[vertices.Length];
			int[] triangles = sharedMesh2.triangles;
			array = (array ?? mesh.triangles);
			for (int num7 = 0; num7 < array12.Length; num7++)
			{
				array12[num7] = new List<int>();
			}
			for (int num8 = 0; num8 < triangles.Length; num8 += 3)
			{
				int num9 = triangles[num8];
				int num10 = triangles[num8 + 1];
				int num11 = triangles[num8 + 2];
				array12[num9].Add(num10);
				array12[num9].Add(num11);
				array12[num10].Add(num9);
				array12[num10].Add(num11);
				array12[num11].Add(num9);
				array12[num11].Add(num10);
			}
			for (int num12 = 0; num12 < array12.Length; num12++)
			{
				array12[num12] = array12[num12].Distinct<int>().ToList<int>();
			}
			//AdvancedCollider.<>c__DisplayClass37_0 CS$<>8__locals1;
			//CS$<>8__locals1.boneStrengths = new List<ValueTuple<int, float, List<int>>>[boneWeights2.Length];
			List<ValueTuple<int, float, List<int>>>[] boneStrengths = new List<ValueTuple<int, float, List<int>>>[boneWeights2.Length];
			int num13 = this.m_skinMesh.bones.Length;
			BoneWeight[] boneWeights3 = this.m_skinConvert.sharedMesh.boneWeights;
			foreach (SkinWrap skinWrap in this.m_skinWraps)
			{
				Transform[] array13 = new Transform[this.m_vertices.Length];
				List<int>[] array14 = new List<int>[this.m_vertices.Length];
				int[] array15 = new int[this.m_vertices.Length];
				bool[] array16 = new bool[this.m_vertices.Length];
				skinWrap.bones = new List<Transform>();
				skinWrap.boneVerts = new List<List<int>>();
				skinWrap.isHardVerts = new List<bool>();
				skinWrap.girl = this.m_girl;
				for (int num14 = 0; num14 < skinWrap.triangleIds.Count; num14++)
				{
					int num15 = skinWrap.triangleIds[num14];
					int item2 = array[num15 * 3];
					int item3 = array[num15 * 3 + 1];
					int item4 = array[num15 * 3 + 2];
					List<int> list3 = new List<int>
					{
						item2,
						item3,
						item4
					};
					for (int num16 = 0; num16 < list3.Count; num16++)
					{
						int num17 = list3[num16];
						int[] array17 = this.m_colSameArray[num17];
						if (array17 != null)
						{
							list3[num16] = array17[0];
						}
					}
					float num18 = skinWrap.wrapCage * girl.Scale;
					float a2 = skinWrap.wrapSaveDistance * girl.Scale;
					List<int> list4 = new List<int>();
					Transform[] array18 = new Transform[3];
					int[] array19 = new int[3];
					bool[] array20 = new bool[3];
					for (int num19 = 0; num19 < list3.Count; num19++)
					{
						int num20 = list3[num19];
						Transform transform4 = array13[num20];
						if (transform4 == null)
						{
							Vector3 position = this.m_meshCollider.transform.TransformPoint(this.m_vertices[num20]);
							Vector3 vector3 = this.m_meshCollider.transform.TransformDirection(normals[num20]);
							Vector3 upwards = this.m_meshCollider.transform.TransformDirection(tangents[num20]);
							transform4 = new GameObject().transform;
							transform4.name = "Bone_" + num20;
							transform4.parent = this.m_skinMesh.transform;
							transform4.position = position;
							if (vector3 != Vector3.zero)
							{
								transform4.rotation = Quaternion.LookRotation(vector3, upwards);
							}
							Matrix4x4 item5 = transform4.worldToLocalMatrix * this.m_skinMesh.transform.localToWorldMatrix;
							list.Add(transform4);
							list2.Add(item5);
							skinWrap.bones.Add(transform4);
							skinWrap.vertexIds.Add(num20);
							List<int> list5 = new List<int>();
							skinWrap.boneVerts.Add(list5);
							bool flag = skinWrap.hardVerts.Contains(num20);
							skinWrap.isHardVerts.Add(flag);
							array13[num20] = transform4;
							array15[num20] = list.Count - 1;
							array14[num20] = list5;
							array16[num20] = flag;
						}
						array18[num19] = transform4;
						array19[num19] = array15[num20];
						array20[num19] = array16[num20];
						List<int> connectedVerts = AdvancedCollider.GetConnectedVerts(this.m_matchVertices[num20], skinWrap.wrapDepth, array12, sameVertsArray);
						list4.AddRange(connectedVerts);
					}
					list4 = list4.Distinct<int>().ToList<int>();
					Vector3 position2 = array18[0].position;
					Vector3 position3 = array18[1].position;
					Vector3 position4 = array18[2].position;
					Vector3 forward = array18[0].forward;
					Vector3 forward2 = array18[1].forward;
					Vector3 forward3 = array18[2].forward;
					Plane plane = new Plane(position2, position3, position4);
					foreach (int num21 in list4)
					{
						Vector3 vector4 = this.m_skinMesh.transform.TransformPoint(vertices[num21]);
						Vector3 vector5;
						Math3d.LinePlaneIntersection(out vector5, position2, forward, plane.normal, vector4);
						Vector3 p;
						Math3d.LinePlaneIntersection(out p, position3, forward2, plane.normal, vector4);
						Vector3 p2;
						Math3d.LinePlaneIntersection(out p2, position4, forward3, plane.normal, vector4);
						Vector3 baryCentricCoords = Utils.GetBaryCentricCoords(vector4, vector5, p, p2);
						if (baryCentricCoords.BaryCentricIsInside())
						{
							float value = Vector3.Distance(vector5, position2);
							float num22 = Mathf.InverseLerp(num18 * 2f, num18, value);
							AdvancedCollider.g__addBoneStrength(num21, array19[0], baryCentricCoords.x * num22, skinWrap.boneVerts[array19[0] - num13], ref boneStrengths);
							AdvancedCollider.g__addBoneStrength(num21, array19[1], baryCentricCoords.y * num22, skinWrap.boneVerts[array19[1] - num13], ref boneStrengths);
							AdvancedCollider.g__addBoneStrength(num21, array19[2], baryCentricCoords.z * num22, skinWrap.boneVerts[array19[2] - num13], ref boneStrengths);
						}
						else if (baryCentricCoords.x >= -skinWrap.wrapThreshold && baryCentricCoords.y > -skinWrap.wrapThreshold && baryCentricCoords.z > -skinWrap.wrapThreshold)
						{
							float value2 = Vector3.Distance(vector5, position2);
							float num23 = Mathf.InverseLerp(num18 * 2f, num18, value2);
							float num24 = baryCentricCoords.x;
							float num25 = baryCentricCoords.y;
							float num26 = baryCentricCoords.z;
							if (baryCentricCoords.x < 0f)
							{
								num25 -= baryCentricCoords.x / 2f;
								num26 -= baryCentricCoords.x / 2f;
							}
							if (baryCentricCoords.y < 0f)
							{
								num24 -= baryCentricCoords.y / 2f;
								num26 -= baryCentricCoords.y / 2f;
							}
							if (baryCentricCoords.z < 0f)
							{
								num24 -= baryCentricCoords.z / 2f;
								num25 -= baryCentricCoords.z / 2f;
							}
							if (num24 > 1f)
							{
								num24 -= (num24 - 1f) * 2f;
							}
							if (num25 > 1f)
							{
								num25 -= (num25 - 1f) * 2f;
							}
							if (num26 > 1f)
							{
								num26 -= (num26 - 1f) * 2f;
							}
							if (!array20[0])
							{
								AdvancedCollider.g__addBoneStrength(num21, array19[0], num24 * num23, skinWrap.boneVerts[array19[0] - num13], ref boneStrengths);
							}
							if (!array20[1])
							{
								AdvancedCollider.g__addBoneStrength(num21, array19[1], num25 * num23, skinWrap.boneVerts[array19[1] - num13], ref boneStrengths);
							}
							if (!array20[2])
							{
								AdvancedCollider.g__addBoneStrength(num21, array19[2], num26 * num23, skinWrap.boneVerts[array19[2] - num13], ref boneStrengths);
							}
						}
						else
						{
							if (!array20[0])
							{
								AdvancedCollider.g__addBoneStrength(num21, array19[0], skinWrap.wrapSaveWeight * Mathf.InverseLerp(a2, 0f, Vector3.Distance(vector4, position2)), skinWrap.boneVerts[array19[0] - num13], ref boneStrengths);
							}
							if (!array20[1])
							{
								AdvancedCollider.g__addBoneStrength(num21, array19[1], skinWrap.wrapSaveWeight * Mathf.InverseLerp(a2, 0f, Vector3.Distance(vector4, position3)), skinWrap.boneVerts[array19[1] - num13], ref boneStrengths);
							}
							if (!array20[2])
							{
								AdvancedCollider.g__addBoneStrength(num21, array19[2], skinWrap.wrapSaveWeight * Mathf.InverseLerp(a2, 0f, Vector3.Distance(vector4, position4)), skinWrap.boneVerts[array19[2] - num13], ref boneStrengths);
							}
						}
					}
				}
				num13 += skinWrap.bones.Count;
				skinWrap.wetVertDists = new float[this.m_vertices.Length];
			}
			BoneWeight[] array21 = boneWeights2.Clone() as BoneWeight[];
			List<int> list6 = new List<int>();
			for (int num27 = 0; num27 < boneStrengths.Length; num27++)
			{
				List<ValueTuple<int, float, List<int>>> list7 = boneStrengths[num27];
				int[] array22 = sameVertsArray[num27];
				if (array22 != null && array22.Length != 0 && num27 != array22[0])
				{
					array21[num27] = array21[array22[0]];
				}
				else if (list7 != null && list7.Count > 0)
				{
					list7.Sort((ValueTuple<int, float, List<int>> a, ValueTuple<int, float, List<int>> b) => b.Item2.CompareTo(a.Item2));
					if (list7.Count > 4)
					{
						list7.RemoveRange(4, list7.Count - 4);
					}
					float num28 = 0f;
					for (int num29 = 0; num29 < list7.Count; num29++)
					{
						num28 += list7[num29].Item2;
					}
					float num30 = 1f / num28;
					for (int num31 = 0; num31 < list7.Count; num31++)
					{
						ValueTuple<int, float, List<int>> value3 = list7[num31];
						value3.Item2 *= num30;
						list7[num31] = value3;
					}
					BoneWeight boneWeight = default(BoneWeight);
					boneWeight.boneIndex0 = list7[0].Item1;
					boneWeight.weight0 = list7[0].Item2;
					list7[0].Item3.Add(num27);
					if (list7.Count > 1)
					{
						boneWeight.boneIndex1 = list7[1].Item1;
						boneWeight.weight1 = list7[1].Item2;
						list7[1].Item3.Add(num27);
					}
					if (list7.Count > 2)
					{
						boneWeight.boneIndex2 = list7[2].Item1;
						boneWeight.weight2 = list7[2].Item2;
						list7[2].Item3.Add(num27);
					}
					if (list7.Count > 3)
					{
						boneWeight.boneIndex3 = list7[3].Item1;
						boneWeight.weight3 = list7[3].Item2;
						list7[3].Item3.Add(num27);
					}
					array21[num27] = boneWeight;
					list6.Add(num27);
				}
			}
			sharedMesh2.boneWeights = array21;
			sharedMesh2.bindposes = list2.ToArray();
			this.m_skinMesh.bones = list.ToArray();
			List<string> list8 = new List<string>();
			List<Vector3[]> list9 = new List<Vector3[]>();
			List<Vector3[]> list10 = new List<Vector3[]>();
			List<Vector3[]> list11 = new List<Vector3[]>();
			for (int num32 = 0; num32 < sharedMesh2.blendShapeCount; num32++)
			{
				Vector3[] array23 = new Vector3[sharedMesh2.vertexCount];
				Vector3[] array24 = new Vector3[sharedMesh2.vertexCount];
				Vector3[] array25 = new Vector3[sharedMesh2.vertexCount];
				sharedMesh2.GetBlendShapeFrameVertices(num32, 0, array23, array24, array25);
				list9.Add(array23);
				list10.Add(array24);
				list11.Add(array25);
				list8.Add(sharedMesh2.GetBlendShapeName(num32));
				foreach (int num33 in list6)
				{
					array23[num33] = Vector3.zero;
					array24[num33] = Vector3.zero;
					array25[num33] = Vector3.zero;
				}
			}
			sharedMesh2.ClearBlendShapes();
			for (int num34 = 0; num34 < list8.Count; num34++)
			{
				sharedMesh2.AddBlendShapeFrame(list8[num34], 100f, list9[num34], list10[num34], list11[num34]);
			}
		}
		for (int num35 = 0; num35 < sharedMesh.blendShapeCount; num35++)
		{
			this.m_skinMesh.SetBlendShapeWeight(num35, array2[num35]);
			this.m_skinConvert.SetBlendShapeWeight(num35, array2[num35]);
		}
		this.m_uvCache = new List<Vector2>();
		List<Vector2> list12 = new List<Vector2>();
		sharedMesh.GetUVs(this.uvChannel, list12);
		for (int num36 = 0; num36 < vertexCount; num36++)
		{
			this.m_uvCache.Add(list12[this.m_matchVertices[num36]].NormalizeUV());
		}
		Material[] sharedMaterials = this.m_skinMesh.sharedMaterials;
		for (int num37 = 0; num37 < this.m_triangleCache.Count; num37++)
		{
			TriangleCache triangleCache2 = this.m_triangleCache[num37];
			Material x = sharedMaterials[triangleCache2.subMeshId];
			foreach (RenderMaterial renderMaterial in this.m_girl.m_renderMaterials)
			{
				if (x == renderMaterial.material)
				{
					triangleCache2.RenderMat = renderMaterial;
					break;
				}
			}
		}
		array = (array ?? mesh.triangles);
		this.m_hasVert = new bool[this.m_vertices.Length];
		this.m_vertPositions = new Vector3[this.m_vertices.Length];
		this.hasNormal = new bool[array.Length / 3];
		this.triNormals = new Vector3[array.Length / 3];
		this.m_meshTransform = this.m_meshCollider.transform;
		if (Application.isEditor && this.m_drawDebug)
		{
			this.m_debugFilter = this.m_skinConvert.gameObject.AddComponent<MeshFilter>();
			this.m_debugFilter.sharedMesh = this.m_collisionMesh;
			this.m_skinConvert.gameObject.AddComponent<MeshRenderer>().sharedMaterials = this.m_skinMesh.sharedMaterials;
			this.m_skinMesh.enabled = false;
		}
	}

	// Token: 0x0600012E RID: 302 RVA: 0x0000A380 File Offset: 0x00008580
	public void InitPenisSkinWrap()
	{
		foreach (SkinWrap skinWrap in this.m_skinWraps)
		{
			if (skinWrap.name == "Skin_Penis")
			{
				CurvySpline spline = this.m_girl.m_penis.m_spline;
				spline.DoUpdate();
				skinWrap.boneParents = new Transform[skinWrap.bones.Count];
				skinWrap.baseTFs = new float[skinWrap.bones.Count];
				skinWrap.lastPoses = new Vector3[skinWrap.bones.Count][];
				skinWrap.lastRots = new Quaternion[skinWrap.bones.Count];
				for (int i = 0; i < skinWrap.bones.Count; i++)
				{
					Transform transform = skinWrap.bones[i];
					Vector3 position;
					float nearestPointTF = spline.GetNearestPointTF(transform.position, out position);
					Vector3 tangent = spline.GetTangent(nearestPointTF);
					Transform transform2 = new GameObject().transform;
					transform2.position = position;
					//transform2.rotation = Quaternion.LookRotation(tangent, spline.GetRotatedUp(nearestPointTF, 0f));
					transform2.rotation = Quaternion.LookRotation(tangent, spline.GetOrientationUpFast(nearestPointTF));
					transform2.parent = this.m_girl.m_penis.transform;
					transform2.localScale = Vector3.one;
					transform.parent = transform2;
					skinWrap.boneParents[i] = transform2;
					float num = spline.TFToDistance(nearestPointTF) / this.m_girl.Scale;
					skinWrap.baseTFs[i] = num;
					skinWrap.lastPoses[i] = new Vector3[2];
				}
			}
		}
	}

	// Token: 0x0600012F RID: 303 RVA: 0x0000A53C File Offset: 0x0000873C
	public void UpdateCollider(float deltaTime)
	{
		if (!this.Active)
		{
			return;
		}
		this.m_skinConvert.BakeMesh(this.m_collisionMesh);
		this.m_vertices = null;
		this.m_triangles = null;
		if (this.m_skinWraps.Count > 0)
		{
			this.RecheckMeshData();
			bool flag = false;
			foreach (SkinWrap skinWrap in this.m_skinWraps)
			{
				Girl mouthFucker = skinWrap.girl.MouthFucker;
				Girl girl = skinWrap.girl;
				bool flag2 = false;
				if (skinWrap.name == "Skin_Mouth" && mouthFucker != null)
				{
					Penis penis = mouthFucker.m_penis;
					float lipsDistance = skinWrap.girl.LipsDistance;
					skinWrap.wetFactor = Mathf.Lerp(0.2f, 1f, Mathf.InverseLerp(0f, 0.05f, mouthFucker.m_penis.AverageVelocity));
					skinWrap.wetDistance = girl.MouthSize / 2f + Game.Instance.m_mouthWetRadius;
					flag2 = true;
					for (int i = 0; i < skinWrap.vertexIds.Count; i++)
					{
						int num = skinWrap.vertexIds[i];
						Vector3 vector = this.m_skinConvert.transform.TransformPoint(this.m_vertices[num]);
						float num2;
						Vector3 vector2;
						float num3;
						penis.GetClosestPoint(vector, out num2, out vector2, out num3);
						float num4 = num3 - lipsDistance;
						float t = Mathf.InverseLerp(0f, skinWrap.insidePushSmooth, num4);
						float num5 = mouthFucker.m_penis.GetSizeAtLength(num3, true) + Mathf.Lerp(skinWrap.maxDistance, skinWrap.insideMaxDistance, t);
						if (num2 < num5)
						{
							float d = Mathf.LerpUnclamped(Mathf.Lerp(skinWrap.maxPushFactor, skinWrap.insidePushFactor, t), 0f, Mathf.Sqrt(num2 / num5)) * num5;
							Vector3 b = vector2.normalized * d;
							vector += b;
							this.m_vertices[num] = this.m_skinConvert.transform.InverseTransformPoint(vector);
							flag = true;
						}
						float num6 = skinWrap.wetDistance * Mathf.Lerp(0.8f, 1f, skinWrap.wetFactor);
						bool flag3 = Mathf.Abs(num4) <= 0.03f && num2 <= num6;
						skinWrap.wetVertDists[num] = (flag3 ? num2 : 999f);
					}
				}
				if (skinWrap.name == "Skin_Penis")
				{
					Penis penis2 = this.m_girl.m_penis;
					CurvySpline spline = penis2.m_spline;
					Girl connectedGirl = penis2.ConnectedGirl;
					float num7 = connectedGirl ? connectedGirl.LipsDistance : 0f;
					float num8 = 1f + ((connectedGirl != null) ? (connectedGirl.MouthEnterDist / penis2.Length) : 0f);
					Plane plane = (connectedGirl != null) ? new Plane(connectedGirl.m_rig.Mouth.forward, connectedGirl.m_rig.Mouth.position) : default(Plane);
					for (int j = 0; j < skinWrap.boneParents.Length; j++)
					{
						Transform transform = skinWrap.boneParents[j];
						float num9 = skinWrap.baseTFs[j] * this.m_girl.Scale * num8;
						Vector3 tangentByDistance = spline.GetTangentByDistance(num9);
						//Vector3 vector3 = spline.GetRotatedUp(num9, 0f);
						Vector3 vector3 = spline.GetOrientationUpFast(num9);
						float num10 = Vector3.Dot(tangentByDistance, penis2.transform.forward);
						float num11 = Vector3.Dot(tangentByDistance, penis2.transform.up);
						if (num10 > 0f)
						{
							if (num11 > 0f)
							{
								vector3 = Vector3.Slerp(-penis2.transform.forward, penis2.transform.up, Mathf.InverseLerp(0f, 1f, num10));
							}
							else
							{
								vector3 = Vector3.Slerp(penis2.transform.up, penis2.transform.forward, Mathf.InverseLerp(1f, 0f, num10));
							}
						}
						else if (num11 > 0f)
						{
							vector3 = Vector3.Slerp(-penis2.transform.up, -penis2.transform.forward, Mathf.InverseLerp(-1f, 0f, num10));
						}
						else
						{
							vector3 = Vector3.Slerp(penis2.transform.forward, -penis2.transform.up, Mathf.InverseLerp(0f, -1f, num10));
						}
						if (tangentByDistance != Vector3.zero)
						{
							transform.rotation = Quaternion.LookRotation(tangentByDistance, vector3);
						}
						transform.position = spline.InterpolateByDistance(num9);
						if (j == 50)
						{
							Debug.DrawRay(transform.position, vector3, Color.red, 0.4f);
							Debug.DrawRay(transform.position, tangentByDistance, Color.blue, 0.4f);
						}
						if (connectedGirl != null)
						{
							float distanceToPoint = plane.GetDistanceToPoint(transform.position);
							float num12 = Mathf.InverseLerp(connectedGirl.m_mouthSqueezeDist, 0f, Mathf.Abs(distanceToPoint));
							num12 *= Mathf.InverseLerp(connectedGirl.m_mouthSqueezeDist, 0f, Mathf.Abs(num9 - num7));
							transform.localScale = Vector3.one * Mathf.Lerp(1f, connectedGirl.m_mouthSqueeze, Mathf.Sqrt(num12));
							int num13 = skinWrap.vertexIds[j];
							float num14 = num9 - num7;
							skinWrap.wetVertDists[num13] = ((num14 >= 0f) ? num14 : 999f);
						}
						else
						{
							transform.localScale = Vector3.one;
						}
						float t2 = penis2.m_lerp * deltaTime * 10f;
						transform.localPosition = Vector3.Lerp(skinWrap.lastPoses[j][0], transform.localPosition, penis2.m_lerp);
						transform.localRotation = Quaternion.Slerp(skinWrap.lastRots[j], transform.localRotation, penis2.m_lerp);
						transform.localScale = Vector3.Lerp(skinWrap.lastPoses[j][1], transform.localScale, t2);
						skinWrap.lastPoses[j][0] = transform.localPosition;
						skinWrap.lastPoses[j][1] = transform.localScale;
						skinWrap.lastRots[j] = transform.localRotation;
					}
					skinWrap.wetFactor = Mathf.Lerp(0.2f, 1f, Mathf.InverseLerp(0f, 0.05f, this.m_girl.m_penis.AverageVelocity));
					skinWrap.wetDistance = 10f;
					flag2 = true;
				}
				if (flag2)
				{
					skinWrap.wetTris = new List<int>();
					skinWrap.wetTriDists = new List<float>();
					foreach (int num15 in skinWrap.triangleIds)
					{
						float num16 = skinWrap.wetVertDists[this.m_triangles[num15 * 3]];
						float num17 = skinWrap.wetVertDists[this.m_triangles[num15 * 3 + 1]];
						float num18 = skinWrap.wetVertDists[this.m_triangles[num15 * 3 + 2]];
						if (num16 <= skinWrap.wetDistance && num17 <= skinWrap.wetDistance && num18 <= skinWrap.wetDistance)
						{
							skinWrap.wetTris.Add(num15);
							skinWrap.wetTriDists.Add((num16 + num17 + num18) / 3f);
						}
					}
				}
			}
			if (flag)
			{
				this.m_collisionMesh.vertices = this.m_vertices;
			}
		}
		if (this.m_attachments.Count > 0)
		{
			this.RecheckMeshData();
			for (int k = 0; k < this.m_attachments.Count; k++)
			{
				Transform transform2 = this.m_attachments[k];
				Vector3 forward;
				Vector3 worldPos = this.m_attachTris[k].GetWorldPos(this.m_skinConvert.transform, this.m_triangles, this.m_vertices, out forward);
				transform2.position = worldPos;
				transform2.forward = forward;
			}
		}
		float x = this.m_skinMesh.transform.lossyScale.x;
		Vector3 vector4 = new Vector3(1f / x, 1f / x, 1f / x);
		if (this.m_meshCollider.transform.localScale != vector4)
		{
			this.m_meshCollider.transform.localScale = vector4;
		}
		this.m_meshCollider.sharedMesh = null;
		this.m_meshCollider.sharedMesh = this.m_collisionMesh;
		if (this.m_skinWraps.Count > 0 && !this.pauseSkinwrap)
		{
			Vector3[] normals = this.m_collisionMesh.normals;
			Vector4[] tangents = this.m_collisionMesh.tangents;
			foreach (SkinWrap skinWrap2 in this.m_skinWraps)
			{
				if (!(skinWrap2.name == "Skin_Penis"))
				{
					for (int l = 0; l < skinWrap2.vertexIds.Count; l++)
					{
						int num19 = skinWrap2.vertexIds[l];
						Transform transform3 = skinWrap2.bones[l];
						Vector3 position = this.m_meshTransform.TransformPoint(this.m_vertices[num19]);
						Vector3 vector5 = this.m_meshTransform.TransformDirection(normals[num19]);
						Vector3 upwards = this.m_meshTransform.TransformDirection(tangents[num19]);
						transform3.position = position;
						if (vector5 != Vector3.zero)
						{
							transform3.rotation = Quaternion.LookRotation(vector5, upwards);
						}
					}
				}
			}
		}
		if (Application.isEditor && this.m_drawDebug)
		{
			this.m_debugFilter.sharedMesh = this.m_collisionMesh;
		}
	}

	// Token: 0x06000130 RID: 304 RVA: 0x0000AFC0 File Offset: 0x000091C0
	public void UpdateSkinWrapWetness(float deltaTime)
	{
		if (this.m_skinWraps.Count > 0)
		{
			foreach (SkinWrap skinWrap in this.m_skinWraps)
			{
				float num = Game.Instance.m_girl.m_juiceAmount * skinWrap.wetFactor * deltaTime;
				float num2 = 0.1f;
				if (skinWrap.wetTris != null && skinWrap.wetTris.Count > 0)
				{
					if (skinWrap.name == "Skin_Penis")
					{
						num *= 10f;
					}
					int num3 = 0;
					while ((float)num3 < num)
					{
						int index = UnityEngine.Random.Range(0, skinWrap.wetTris.Count - 1);
						int triId = skinWrap.wetTris[index];
						float value = skinWrap.wetTriDists[index];
						Vector3 baryCoords = Utils.RandomBarycentricCoords();
						TrianglePos trianglePos = new TrianglePos(this, triId, baryCoords, default(Vector3));
						RenderMaterial renderMaterial = Game.Instance.GetRenderMaterial(this.GetMaterial(triId));
						if (renderMaterial != null)
						{
							float a = num2;
							if (skinWrap.name == "Skin_Mouth")
							{
								a = Mathf.Lerp(0f, num2, Mathf.InverseLerp(skinWrap.wetDistance, 0f, value));
							}
							renderMaterial.DrawUV(0, new Color(1f, 1f, 1f, a), trianglePos.CalculateUVPos(), 1f, null);
						}
						if (skinWrap.name == "Skin_Mouth" && UnityEngine.Random.value <= 0.0025f)
						{
							Vector3 worldPos = trianglePos.GetWorldPos();
							Fluid fluid = Game.Instance.AddFluid(worldPos);
							if (fluid != null)
							{
								fluid.m_isFresh = false;
								fluid.m_size = 0.005f;
								fluid.m_slideSpeed = 0.004f;
								fluid.transform.localScale = Vector3.one * fluid.m_size;
								fluid.AddToCollider(trianglePos);
							}
						}
						num3++;
					}
				}
			}
		}
	}

	// Token: 0x06000131 RID: 305 RVA: 0x0000B1E8 File Offset: 0x000093E8
	public void RecheckMeshData()
	{
		if (this.m_vertices == null)
		{
			this.m_vertices = this.m_collisionMesh.vertices;
			this.m_triangles = this.m_collisionMesh.triangles;
			Array.Clear(this.m_hasVert, 0, this.m_hasVert.Length);
			Array.Clear(this.m_vertPositions, 0, this.m_vertPositions.Length);
			Array.Clear(this.hasNormal, 0, this.hasNormal.Length);
			Array.Clear(this.triNormals, 0, this.triNormals.Length);
		}
	}

	// Token: 0x06000132 RID: 306 RVA: 0x0000B270 File Offset: 0x00009470
	public TrianglePos GetSlidePos(TrianglePos startPos, float speed, out bool exit, out bool exitGravity)
	{
		this.RecheckMeshData();
		exit = false;
		exitGravity = false;
		Vector3 vertexWorldPos = this.GetVertexWorldPos(this.m_triangles[startPos.triId * 3]);
		Vector3 vertexWorldPos2 = this.GetVertexWorldPos(this.m_triangles[startPos.triId * 3 + 1]);
		Vector3 vertexWorldPos3 = this.GetVertexWorldPos(this.m_triangles[startPos.triId * 3 + 2]);
		Vector3 normal = this.GetTriangleNormal(startPos.triId);
		float num = Vector3.Dot(normal, Vector3.down);
		if (num >= 0.5f)
		{
			exit = true;
			exitGravity = true;
			return startPos;
		}
		float num2 = Mathf.Lerp(0.2f, 1f, num + 1f);
		Vector3 a2 = Vector3.SlerpUnclamped(normal, Vector3.down, 90f / Vector3.Angle(normal, Vector3.down));
		float d = speed * this.m_slideSpeed * num2;
		Vector3 b2 = a2 * d;
		Vector3 point = startPos.GetWorldPos(vertexWorldPos, vertexWorldPos2, vertexWorldPos3) + b2;
		Vector3 baryCentricCoords = Utils.GetBaryCentricCoords(point, vertexWorldPos, vertexWorldPos2, vertexWorldPos3);
		TrianglePos result = new TrianglePos(this, startPos.triId, baryCentricCoords, default(Vector3));
		if (baryCentricCoords.BaryCentricIsOutside())
		{
			List<int> triangleIds = this.m_triangleCache[startPos.triId].triangleIds;
			List<ValueTuple<int, Vector3, Vector3>> list = new List<ValueTuple<int, Vector3, Vector3>>();
			foreach (int num3 in triangleIds)
			{
				Vector3 vertexWorldPos4 = this.GetVertexWorldPos(this.m_triangles[num3 * 3]);
				Vector3 vertexWorldPos5 = this.GetVertexWorldPos(this.m_triangles[num3 * 3 + 1]);
				Vector3 vertexWorldPos6 = this.GetVertexWorldPos(this.m_triangles[num3 * 3 + 2]);
				Vector3 baryCentricCoords2 = Utils.GetBaryCentricCoords(point, vertexWorldPos4, vertexWorldPos5, vertexWorldPos6);
				if (baryCentricCoords2.BaryCentricIsInside())
				{
					Vector3 triangleNormal = this.GetTriangleNormal(num3);
					list.Add(new ValueTuple<int, Vector3, Vector3>(num3, triangleNormal, baryCentricCoords2));
				}
			}
			if (list.Count == 0)
			{
				exit = true;
				exitGravity = (num >= 0f);
				return result;
			}
			list.Sort((ValueTuple<int, Vector3, Vector3> a, ValueTuple<int, Vector3, Vector3> b) => Vector3.Dot(b.Item2, normal).CompareTo(Vector3.Dot(a.Item2, normal)));
			result = new TrianglePos(this, list[0].Item1, list[0].Item3, default(Vector3));
		}
		return result;
	}

	// Token: 0x06000133 RID: 307 RVA: 0x0000B4D0 File Offset: 0x000096D0
	public Vector3 GetVertexWorldPos(int vertId)
	{
		if (!this.m_hasVert[vertId])
		{
			this.m_hasVert[vertId] = true;
			this.m_vertPositions[vertId] = this.m_meshTransform.TransformPoint(this.m_vertices[vertId]);
		}
		return this.m_vertPositions[vertId];
	}

	// Token: 0x06000134 RID: 308 RVA: 0x0000B520 File Offset: 0x00009720
	public Vector3 GetTriangleNormal(int triId)
	{
		if (!this.hasNormal[triId])
		{
			this.RecheckMeshData();
			Vector3 vertexWorldPos = this.GetVertexWorldPos(this.m_triangles[triId * 3]);
			Vector3 vertexWorldPos2 = this.GetVertexWorldPos(this.m_triangles[triId * 3 + 1]);
			Vector3 vertexWorldPos3 = this.GetVertexWorldPos(this.m_triangles[triId * 3 + 2]);
			if (vertexWorldPos == vertexWorldPos2 || vertexWorldPos == vertexWorldPos3 || vertexWorldPos2 == vertexWorldPos3)
			{
				return Vector3.down;
			}
			this.triNormals[triId] = Vector3.Cross((vertexWorldPos2 - vertexWorldPos).normalized, (vertexWorldPos3 - vertexWorldPos).normalized);
			this.hasNormal[triId] = true;
		}
		return this.triNormals[triId];
	}

	// Token: 0x06000135 RID: 309 RVA: 0x0000B5DC File Offset: 0x000097DC
	public void Update()
	{
		if (Application.isPlaying)
		{
			return;
		}
		if (this.prepareMesh)
		{
			this.prepareMesh = false;
			this.PrepareMesh();
		}
		if (this.matchVertices)
		{
			this.matchVertices = false;
			this.MatchVertices();
		}
	}

	// Token: 0x06000136 RID: 310 RVA: 0x0000B610 File Offset: 0x00009810
	public void SetBlendShape(string name, float weight)
	{
		int blendShapeIndex = this.m_skinMesh.sharedMesh.GetBlendShapeIndex(name);
		this.m_skinMesh.SetBlendShapeWeight(blendShapeIndex, weight);
		this.m_skinConvert.SetBlendShapeWeight(blendShapeIndex, weight);
	}

	// Token: 0x06000137 RID: 311 RVA: 0x0000B64C File Offset: 0x0000984C
	public void MatchVertices()
	{
		if (this.m_skinMesh == null)
		{
			foreach (SkinnedMeshRenderer skinnedMeshRenderer in base.transform.parent.parent.GetComponentsInChildren<SkinnedMeshRenderer>())
			{
				if (skinnedMeshRenderer.name == base.name)
				{
					this.m_skinMesh = skinnedMeshRenderer;
					break;
				}
			}
			if (this.m_skinMesh == null)
			{
				Debug.Log(base.name + " couldn't find skinned mesh renderer!");
				return;
			}
		}
		this.m_matchVertices = new List<int>();
		Mesh sharedMesh = this.m_skinMesh.sharedMesh;
		float[] array = new float[sharedMesh.blendShapeCount];
		for (int j = 0; j < sharedMesh.blendShapeCount; j++)
		{
			array[j] = this.m_skinMesh.GetBlendShapeWeight(j);
			this.m_skinMesh.SetBlendShapeWeight(j, 0f);
		}
		Mesh mesh = new Mesh();
		this.m_skinMesh.BakeMesh(mesh);
		Vector3[] vertices = mesh.vertices;
		List<Vector3> list = new List<Vector3>();
		this.m_meshCollider.sharedMesh.GetVertices(list);
		int count = list.Count;
		PointOctree<ValueTuple<int, Vector3>> pointOctree = new PointOctree<ValueTuple<int, Vector3>>(2f, this.m_skinMesh.bounds.center, 0.1f);
		for (int k = 0; k < vertices.Length; k++)
		{
			Vector3 a2 = vertices[k];
			Vector3 vector = this.m_skinMesh.transform.TransformPoint(a2 / this.m_skinMesh.transform.lossyScale.x);
			pointOctree.Add(new ValueTuple<int, Vector3>(k, vector), vector);
		}
		List<Vector2> list2 = new List<Vector2>();
		List<Vector2> uvs = new List<Vector2>();
		List<Vector2> list3 = new List<Vector2>();
		new List<Vector2>();
		sharedMesh.GetUVs(0, list2);
		sharedMesh.GetUVs(1, uvs);
		this.m_meshCollider.sharedMesh.GetUVs(0, list3);
		if (this.m_skinFixes.Count > 0)
		{
			foreach (MeshRenderer meshRenderer in this.m_skinFixes)
			{
				Vector3[] vertices2 = meshRenderer.GetComponent<MeshFilter>().sharedMesh.vertices;
				list.AddRange(vertices2);
			}
		}
		for (int l = 0; l < list.Count; l++)
		{
			Vector3 position = list[l];
			Vector3 vector2 = this.m_meshCollider.transform.TransformPoint(position);
			ValueTuple<int, Vector3>[] nearby = pointOctree.GetNearby(vector2, 0.1f);
			List<ValueTuple<int, float>> distanceList = new List<ValueTuple<int, float>>();
			foreach (ValueTuple<int, Vector3> valueTuple in nearby)
			{
				int item = valueTuple.Item1;
				Vector3 item2 = valueTuple.Item2;
				distanceList.Add(new ValueTuple<int, float>(item, (vector2 - item2).magnitude));
			}
			distanceList.Sort((ValueTuple<int, float> a, ValueTuple<int, float> b) => a.Item2.CompareTo(b.Item2));
			if (l < count)
			{
				List<ValueTuple<int, float>> list4 = distanceList.FindAll((ValueTuple<int, float> a) => Mathf.Abs(a.Item2 - distanceList[0].Item2) <= 0.001f);
				List<ValueTuple<int, float>> list5 = new List<ValueTuple<int, float>>();
				foreach (ValueTuple<int, float> valueTuple2 in list4)
				{
					int item3 = valueTuple2.Item1;
					float item4 = Vector2.Distance(list2[item3], list3[l]);
					list5.Add(new ValueTuple<int, float>(item3, item4));
				}
				list5.Sort((ValueTuple<int, float> a, ValueTuple<int, float> b) => a.Item2.CompareTo(b.Item2));
				this.m_matchVertices.Add(list5[0].Item1);
			}
			else
			{
				this.m_matchVertices.Add(distanceList[0].Item1);
			}
		}
		if (this.m_skinWraps.Count > 0)
		{
			this.m_skinSameVerts = this.GetSameVerts(vertices, 0f);
		}
		for (int n = 0; n < sharedMesh.blendShapeCount; n++)
		{
			this.m_skinMesh.SetBlendShapeWeight(n, array[n]);
		}
	}

	// Token: 0x06000138 RID: 312 RVA: 0x0000BAA4 File Offset: 0x00009CA4
	public void PrepareMesh()
	{
		if (this.m_meshCollider == null)
		{
			this.m_meshCollider = base.GetComponent<MeshCollider>();
		}
		//AdvancedCollider.<>c__DisplayClass48_0 __locals1;
		//__locals1.subMeshIndices = new List<int>();
		List<int> subMeshIndices = new List<int>();
		int num = 0;
		for (int i = 0; i < this.m_meshCollider.sharedMesh.subMeshCount; i++)
		{
			num += (int)(this.m_meshCollider.sharedMesh.GetIndexCount(i) / 3U);
			subMeshIndices.Add(num);
		}
		List<Collider> list = new List<Collider>();
		List<Collider> list2 = new List<Collider>();
		foreach (object obj in base.transform)
		{
			Collider component = ((Transform)obj).GetComponent<Collider>();
			if (component != null)
			{
				if (component.name.StartsWith("Skin_"))
				{
					list2.Add(component);
				}
				else
				{
					list.Add(component);
				}
			}
		}
		this.m_triangleCache = new List<TriangleCache>();
		int[] triangles = this.m_meshCollider.sharedMesh.triangles;
		Vector3[] vertices = this.m_meshCollider.sharedMesh.vertices;
		for (int j = 0; j < triangles.Length; j += 3)
		{
			TriangleCache triangleCache = new TriangleCache();
			int triangleId = j / 3;
			int num2 = triangles[j];
			int num3 = triangles[j + 1];
			int num4 = triangles[j + 2];
			List<int> list3 = new List<int>
			{
				num2,
				num3,
				num4
			};
			for (int k = 0; k < triangles.Length; k += 3)
			{
				int item = k / 3;
				int item2 = triangles[k];
				int item3 = triangles[k + 1];
				int item4 = triangles[k + 2];
				List<int> list4 = new List<int>
				{
					item2,
					item3,
					item4
				};
				foreach (int item5 in list3)
				{
					if (list4.Contains(item5))
					{
						triangleCache.triangleIds.Add(item);
						break;
					}
				}
			}
			int num5 = AdvancedCollider.g__getSubmeshIndex(triangleId, ref subMeshIndices);
			if (num5 < this.m_submeshIdOverride.Count)
			{
				num5 = this.m_submeshIdOverride[num5];
			}
			triangleCache.subMeshId = num5;
			this.m_triangleCache.Add(triangleCache);
			if (list.Count > 0)
			{
				Vector3 vector = this.m_meshCollider.transform.TransformPoint(vertices[num2]);
				Vector3 vector2 = this.m_meshCollider.transform.TransformPoint(vertices[num3]);
				Vector3 vector3 = this.m_meshCollider.transform.TransformPoint(vertices[num4]);
				foreach (Collider collider in list)
				{
					collider.gameObject.SetActive(true);
					if (collider.bounds.Contains(vector) && collider.bounds.Contains(vector2) && collider.bounds.Contains(vector3))
					{
						Vector3 lhs = collider.ClosestPoint(vector);
						Vector3 lhs2 = collider.ClosestPoint(vector2);
						Vector3 lhs3 = collider.ClosestPoint(vector3);
						if (lhs == vector && lhs2 == vector2 && lhs3 == vector3)
						{
							triangleCache.triggers.Add(collider.name);
						}
					}
					collider.gameObject.SetActive(false);
				}
			}
		}
		if (list2.Count > 0)
		{
			this.m_colSameVerts = this.GetSameVerts(vertices, 0f);
			foreach (SkinWrap skinWrap in this.m_skinWraps)
			{
				skinWrap.vertexIds = new List<int>();
				skinWrap.triangleIds = new List<int>();
			}
			for (int l = 0; l < triangles.Length; l += 3)
			{
				int item6 = l / 3;
				int item7 = triangles[l];
				int item8 = triangles[l + 1];
				int item9 = triangles[l + 2];
				foreach (int num6 in new List<int>
				{
					item7,
					item8,
					item9
				})
				{
					Vector3 vector4 = this.m_meshCollider.transform.TransformPoint(vertices[num6]);
					bool flag = false;
					foreach (Collider collider2 in list2)
					{
						collider2.gameObject.SetActive(true);
						if (collider2.ClosestPoint(vector4) == vector4)
						{
							flag = true;
							bool flag2 = false;
							foreach (SkinWrap skinWrap2 in this.m_skinWraps)
							{
								if (skinWrap2.name == collider2.name)
								{
									skinWrap2.triangleIds.Add(item6);
									flag2 = true;
									break;
								}
							}
							if (!flag2)
							{
								SkinWrap item10 = new SkinWrap
								{
									name = collider2.name,
									triangleIds = new List<int>
									{
										l
									}
								};
								this.m_skinWraps.Add(item10);
							}
							collider2.gameObject.SetActive(false);
							break;
						}
						collider2.gameObject.SetActive(false);
					}
					if (flag)
					{
						break;
					}
				}
			}
			foreach (SkinWrap skinWrap3 in this.m_skinWraps)
			{
				List<Vector2Int> list5 = new List<Vector2Int>();
				for (int m = 0; m < skinWrap3.triangleIds.Count; m++)
				{
					int num7 = triangles[m * 3];
					int num8 = triangles[m * 3 + 1];
					int num9 = triangles[m * 3 + 2];
					list5.Add(new Vector2Int(num7, num8));
					list5.Add(new Vector2Int(num8, num9));
					list5.Add(new Vector2Int(num9, num7));
				}
				List<Vector2Int> list6 = new List<Vector2Int>(list5);
				bool[] array = new bool[list5.Count];
				this.m_colSameArray = this.GetSameVertsArray(this.m_colSameVerts, vertices.Length);
				for (int n = 0; n < list6.Count; n++)
				{
					Vector2Int value = list6[n];
					int[] array2 = this.m_colSameArray[value.x];
					int[] array3 = this.m_colSameArray[value.y];
					if (array2 != null)
					{
						value.x = array2[0];
					}
					if (array3 != null)
					{
						value.y = array3[0];
					}
					if (value.y < value.x)
					{
						value = new Vector2Int(value.y, value.x);
					}
					list6[n] = value;
				}
				bool[] array4 = new bool[list6.Count];
				for (int num10 = 0; num10 < list6.Count; num10++)
				{
					if (!array4[num10])
					{
						Vector2Int lhs4 = list6[num10];
						bool flag3 = false;
						for (int num11 = 0; num11 < list6.Count; num11++)
						{
							Vector2Int rhs = list6[num11];
							if (num10 != num11 && lhs4 == rhs)
							{
								array4[num11] = true;
								flag3 = true;
							}
						}
						if (!flag3)
						{
							array[num10] = true;
						}
						array4[num10] = true;
					}
				}
				skinWrap3.hardVerts = new List<int>();
				for (int num12 = 0; num12 < list5.Count; num12++)
				{
					if (array[num12])
					{
						Vector2Int vector2Int = list5[num12];
						skinWrap3.hardVerts.Add(vector2Int.x);
						skinWrap3.hardVerts.Add(vector2Int.y);
					}
				}
				skinWrap3.hardVerts = skinWrap3.hardVerts.Distinct<int>().ToList<int>();
			}
		}
		MeshRenderer component2 = base.GetComponent<MeshRenderer>();
		if (component2)
		{
			component2.enabled = false;
		}
	}

	// Token: 0x06000139 RID: 313 RVA: 0x0000C388 File Offset: 0x0000A588
	public static List<int> GetConnectedVerts(int startId, int depth, List<int>[] vertexCache, int[][] sameArray)
	{
		bool[] searchedIndexes = new bool[vertexCache.Length];
		List<int> list = new List<int>();
		AdvancedCollider.RecursiveGetVert(startId, depth, list, vertexCache, sameArray, searchedIndexes);
		return list;
	}

	// Token: 0x0600013A RID: 314 RVA: 0x0000C3B0 File Offset: 0x0000A5B0
	public static void RecursiveGetVert(int id, int depth, List<int> list, List<int>[] vertexCache, int[][] sameArray, bool[] searchedIndexes)
	{
		int[] array = sameArray[id];
		if (array == null)
		{
			array = new int[]
			{
				id
			};
		}
		foreach (int num in array)
		{
			list.AddRange(vertexCache[num]);
			searchedIndexes[num] = true;
			if (depth > 0)
			{
				foreach (int num2 in vertexCache[num])
				{
					if (!searchedIndexes[num2])
					{
						AdvancedCollider.RecursiveGetVert(num2, depth - 1, list, vertexCache, sameArray, searchedIndexes);
					}
				}
			}
		}
	}

	// Token: 0x0600013B RID: 315 RVA: 0x0000C44C File Offset: 0x0000A64C
	public int[][] GetSameVertsArray(List<int> list, int count)
	{
		int[][] array = new int[count][];
		List<int> list2 = new List<int>();
		foreach (int num in list)
		{
			if (num == -1)
			{
				if (list2.Count > 0)
				{
					int[] array2 = list2.ToArray();
					foreach (int num2 in list2)
					{
						array[num2] = array2;
					}
					list2 = new List<int>();
				}
			}
			else
			{
				list2.Add(num);
			}
		}
		return array;
	}

	// Token: 0x0600013C RID: 316 RVA: 0x0000C504 File Offset: 0x0000A704
	public List<int> GetSameVerts(Vector3[] verts, float dist = 0f)
	{
		List<int> list = new List<int>();
		PointOctree<ValueTuple<int, Vector3>> pointOctree = new PointOctree<ValueTuple<int, Vector3>>(2f, verts[0], 0.05f);
		for (int i = 0; i < verts.Length; i++)
		{
			Vector3 vector = verts[i];
			pointOctree.Add(new ValueTuple<int, Vector3>(i, vector), vector);
		}
		List<ValueTuple<int, Vector3>> list2 = pointOctree.GetAll().ToList<ValueTuple<int, Vector3>>();
		for (int j = 0; j < list2.Count; j++)
		{
			Vector3 item = list2[j].Item2;
			ValueTuple<int, Vector3>[] nearby = pointOctree.GetNearby(item, dist);
			if (nearby.Length > 1)
			{
				for (int k = 0; k < nearby.Length; k++)
				{
					ValueTuple<int, Vector3> valueTuple = nearby[k];
					int item2 = valueTuple.Item1;
					Vector3 item3 = valueTuple.Item2;
					list.Add(item2);
					pointOctree.Remove(new ValueTuple<int, Vector3>(item2, item3));
					if (k == nearby.Length - 1)
					{
						list.Add(-1);
					}
				}
			}
		}
		return list;
	}

	// Token: 0x0600013D RID: 317 RVA: 0x0000C5EF File Offset: 0x0000A7EF
	public Material GetMaterial(int triId)
	{
		return this.m_skinMesh.sharedMaterials[this.m_triangleCache[triId].subMeshId];
	}

	// Token: 0x0600013E RID: 318 RVA: 0x0000C60E File Offset: 0x0000A80E
	public List<string> GetTriangleTriggers(RaycastHit hit)
	{
		return new List<string>(this.m_triangleCache[hit.triangleIndex].triggers);
	}

	// Token: 0x06000140 RID: 320 RVA: 0x0000C640 File Offset: 0x0000A840
	[CompilerGenerated]
	internal static void g__addBoneStrength(int vertId, int boneId, float strength, List<int> boneVerts, ref List<ValueTuple<int, float, List<int>>>[] boneStrengths)
	{
		if (strength <= 0f)
		{
			return;
		}
		List<ValueTuple<int, float, List<int>>> list = boneStrengths[vertId];
		if (list == null)
		{
			list = new List<ValueTuple<int, float, List<int>>>();
			boneStrengths[vertId] = list;
		}
		bool flag = false;
		for (int i = 0; i < list.Count; i++)
		{
			ValueTuple<int, float, List<int>> valueTuple = list[i];
			if (valueTuple.Item1 == boneId)
			{
				valueTuple.Item2 += strength;
				list[i] = valueTuple;
				float item = valueTuple.Item2;
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			list.Add(new ValueTuple<int, float, List<int>>(boneId, strength, boneVerts));
		}
	}

	// Token: 0x06000141 RID: 321 RVA: 0x0000C6CC File Offset: 0x0000A8CC
	[CompilerGenerated]
	internal static int g__getSubmeshIndex(int triangleId, ref List<int> subMeshIndices)
	{
		for (int i = 0; i < subMeshIndices.Count; i++)
		{
			if (triangleId < subMeshIndices[i])
			{
				return i;
			}
		}
		return 0;
	}

	// Token: 0x040000FD RID: 253
	public SkinnedMeshRenderer m_skinMesh;

	// Token: 0x040000FE RID: 254
	public MeshCollider m_meshCollider;

	// Token: 0x040000FF RID: 255
	private SkinnedMeshRenderer m_skinConvert;

	// Token: 0x04000100 RID: 256
	public string m_defaultName;

	// Token: 0x04000101 RID: 257
	public float m_slideSpeed = 1f;

	// Token: 0x04000102 RID: 258
	public List<Transform> m_attachments;

	// Token: 0x04000103 RID: 259
	private List<TrianglePos> m_attachTris;

	// Token: 0x04000104 RID: 260
	public List<MeshRenderer> m_skinFixes;

	// Token: 0x04000105 RID: 261
	public AdvancedCollider m_setCollider;

	// Token: 0x04000106 RID: 262
	public string m_setShapeName;

	// Token: 0x04000107 RID: 263
	private Mesh m_collisionMesh;

	// Token: 0x04000108 RID: 264
	public Vector3[] m_vertices;

	// Token: 0x04000109 RID: 265
	public int[] m_triangles;

	// Token: 0x0400010A RID: 266
	public List<Vector2> m_uvCache;

	// Token: 0x0400010B RID: 267
	public Girl m_girl;

	// Token: 0x0400010C RID: 268
	public List<int> m_submeshIdOverride;

	// Token: 0x0400010D RID: 269
	public List<int> m_matchVertices;

	// Token: 0x0400010E RID: 270
	public List<int> m_skinSameVerts;

	// Token: 0x0400010F RID: 271
	public List<int> m_colSameVerts;

	// Token: 0x04000110 RID: 272
	private int[][] m_colSameArray;

	// Token: 0x04000111 RID: 273
	private List<int>[] m_vertexCache;

	// Token: 0x04000112 RID: 274
	private Transform m_meshTransform;

	// Token: 0x04000113 RID: 275
	private bool[] m_hasVert;

	// Token: 0x04000114 RID: 276
	private Vector3[] m_vertPositions;

	// Token: 0x04000115 RID: 277
	private bool[] hasNormal;

	// Token: 0x04000116 RID: 278
	private Vector3[] triNormals;

	// Token: 0x04000117 RID: 279
	[FormerlySerializedAs("m_triToTriCache")]
	public List<TriangleCache> m_triangleCache;

	// Token: 0x04000118 RID: 280
	public List<SkinWrap> m_skinWraps;

	// Token: 0x04000119 RID: 281
	private MeshFilter m_debugFilter;

	// Token: 0x0400011A RID: 282
	public bool m_drawDebug;

	// Token: 0x0400011B RID: 283
	public bool matchVertices;

	// Token: 0x0400011C RID: 284
	public int uvChannel;

	// Token: 0x0400011D RID: 285
	public bool pauseSkinwrap;

	// Token: 0x0400011E RID: 286
	public bool prepareMesh;
}

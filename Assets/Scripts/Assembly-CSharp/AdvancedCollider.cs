using UnityEngine;
using System.Collections.Generic;

public class AdvancedCollider : MonoBehaviour
{
	public SkinnedMeshRenderer m_skinMesh;
	public MeshCollider m_meshCollider;
	public string m_defaultName;
	public float m_slideSpeed;
	public List<Transform> m_attachments;
	public List<MeshRenderer> m_skinFixes;
	public AdvancedCollider m_setCollider;
	public string m_setShapeName;
	public Vector3[] m_vertices;
	public int[] m_triangles;
	public List<Vector2> m_uvCache;
	public Girl m_girl;
	public List<int> m_submeshIdOverride;
	public List<int> m_matchVertices;
	public List<int> m_skinSameVerts;
	public List<int> m_colSameVerts;
	public List<TriangleCache> m_triangleCache;
	public List<SkinWrap> m_skinWraps;
	public bool m_drawDebug;
	public bool matchVertices;
	public int uvChannel;
	public bool pauseSkinwrap;
	public bool prepareMesh;
}

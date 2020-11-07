using UnityEngine;
using System.Collections.Generic;

public class Utils : MonoBehaviour
{
	public Transform fromTransfrom;
	public Transform targetTransform;
	public List<Transform> excludeTransforms;
	public bool copyPose;
	public Transform ragdollTransform;
	public bool disableRagdoll;
	public Girl girl;
	public bool matchVertices;
	public MeshCollider meshCollider;
	public bool testMeshCollider;
	public bool m_noDebug;
	public Transform helperT;
}

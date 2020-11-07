using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class SkinWrap
{
	public string name;
	public List<int> vertexIds;
	public List<Transform> bones;
	public List<int> triangleIds;
	public List<int> hardVerts;
	public List<bool> isHardVerts;
	public bool noHardVerts;
	public Transform[] boneParents;
	public float[] baseTFs;
	public float[] lastTFs;
	public Quaternion[] lastRots;
	public float[] wetVertDists;
	public List<int> wetTris;
	public List<float> wetTriDists;
	public float wetFactor;
	public float wetDistance;
	public bool wetStrings;
	public Girl girl;
	public int wrapDepth;
	public float wrapThreshold;
	public float wrapCage;
	public float wrapSaveDistance;
	public float wrapSaveWeight;
	public float maxDistance;
	public float maxPushFactor;
	public float insideMaxDistance;
	public float insidePushFactor;
	public float insidePushSmooth;
	public float maxHolePush;
	public float maxHoleDistance;
	public float maxHolePow;
	public float holeOffset;
}

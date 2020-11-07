using UnityEngine;

public class OVRLipSyncContextMorphTarget : MonoBehaviour
{
	public SkinnedMeshRenderer skinnedMeshRenderer;
	public int[] visemeToBlendTargets;
	public bool enableVisemeTestKeys;
	public KeyCode[] visemeTestKeys;
	public KeyCode laughterKey;
	public int laughterBlendTarget;
	public float laughterThreshold;
	public float laughterMultiplier;
	public int smoothAmount;
}

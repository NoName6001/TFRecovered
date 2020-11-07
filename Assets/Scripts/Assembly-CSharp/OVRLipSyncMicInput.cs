using UnityEngine;

public class OVRLipSyncMicInput : MonoBehaviour
{
	public enum micActivation
	{
		HoldToSpeak = 0,
		PushToSpeak = 1,
		ConstantSpeak = 2,
	}

	public AudioSource audioSource;
	public bool enableMicSelectionGUI;
	public KeyCode micSelectionGUIKey;
	[SerializeField]
	private float micInputVolume;
	[SerializeField]
	private int micFrequency;
	public micActivation micControl;
	public KeyCode micActivationKey;
	public string selectedDevice;
}

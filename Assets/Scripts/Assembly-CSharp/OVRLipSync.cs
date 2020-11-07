using UnityEngine;
using System;

public class OVRLipSync : MonoBehaviour
{
	[Serializable]
	public class Frame
	{
		public int frameNumber;
		public int frameDelay;
		public float[] Visemes;
		public float laughterScore;
	}

	public enum ContextProviders
	{
		Original = 0,
		Enhanced = 1,
		Enhanced_with_Laughter = 2,
	}

}

using System;
using UnityEngine;

namespace FluffyUnderware.DevTools
{
	[Serializable]
	public class PoolSettings
	{
		[SerializeField]
		private bool m_Prewarm;
		[SerializeField]
		private bool m_AutoCreate;
		[SerializeField]
		private bool m_AutoEnableDisable;
		[SerializeField]
		private int m_MinItems;
		[SerializeField]
		private int m_Threshold;
		[SerializeField]
		private float m_Speed;
		public bool Debug;
	}
}

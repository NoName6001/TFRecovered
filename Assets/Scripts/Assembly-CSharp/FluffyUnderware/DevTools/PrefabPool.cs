using UnityEngine;
using System.Collections.Generic;

namespace FluffyUnderware.DevTools
{
	public class PrefabPool : MonoBehaviour
	{
		[SerializeField]
		private string m_Identifier;
		[SerializeField]
		private List<GameObject> m_Prefabs;
		[SerializeField]
		private PoolSettings m_Settings;
	}
}

using System;
using UnityEngine;

namespace RootMotion.FinalIK
{
	public class GenericPoser : Poser
	{
		[Serializable]
		public class Map
		{
			public Transform bone;
			public Transform target;
		}

		public Map[] maps;
	}
}

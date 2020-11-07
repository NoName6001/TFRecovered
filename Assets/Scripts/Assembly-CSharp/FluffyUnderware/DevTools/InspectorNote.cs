using UnityEngine;

namespace FluffyUnderware.DevTools
{
	public class InspectorNote : MonoBehaviour
	{
		[TextAreaAttribute]
		[SerializeField]
		private string m_Note;
	}
}

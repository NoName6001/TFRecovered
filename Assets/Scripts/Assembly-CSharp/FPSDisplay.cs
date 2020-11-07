using System;
using UnityEngine;

// Token: 0x0200002A RID: 42
public class FPSDisplay : MonoBehaviour
{
	// Token: 0x06000117 RID: 279 RVA: 0x0000850C File Offset: 0x0000670C
	private void Update()
	{
		this.deltaTime += (Time.unscaledDeltaTime - this.deltaTime) * 0.1f;
	}

	// Token: 0x06000118 RID: 280 RVA: 0x00008530 File Offset: 0x00006730
	private void OnGUI()
	{
		int width = Screen.width;
		int height = Screen.height;
		GUIStyle guistyle = new GUIStyle();
		Rect position = new Rect(0f, 0f, (float)width, (float)(height * 2 / 100));
		guistyle.alignment = TextAnchor.UpperLeft;
		guistyle.fontSize = height * 5 / 100;
		guistyle.normal.textColor = new Color(0f, 0f, 0.5f, 1f);
		float num = this.deltaTime * 1000f;
		float num2 = 1f / this.deltaTime;
		string text = string.Format("{0:0.0} ms ({1:0.} fps)", num, num2);
		GUI.Label(position, text, guistyle);
	}

	// Token: 0x040000F8 RID: 248
	private float deltaTime;
}

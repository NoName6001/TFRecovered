using System;
using System.Collections.Generic;
using MoonSharp.Interpreter;
using RootMotion.Dynamics;
using UnityEngine;

// Token: 0x02000036 RID: 54
[MoonSharpUserData]
public static class Lua
{
	// Token: 0x17000024 RID: 36
	// (get) Token: 0x0600018D RID: 397 RVA: 0x0000E59F File Offset: 0x0000C79F
	// (set) Token: 0x0600018E RID: 398 RVA: 0x0000E5A6 File Offset: 0x0000C7A6
	public static Script Script { get; set; }

	// Token: 0x17000025 RID: 37
	// (get) Token: 0x0600018F RID: 399 RVA: 0x0000E5AE File Offset: 0x0000C7AE
	// (set) Token: 0x06000190 RID: 400 RVA: 0x0000E5B5 File Offset: 0x0000C7B5
	public static Dictionary<KeyCode, DynValue> Binds { get; set; }

	// Token: 0x17000026 RID: 38
	// (get) Token: 0x06000191 RID: 401 RVA: 0x0000E5BD File Offset: 0x0000C7BD
	// (set) Token: 0x06000192 RID: 402 RVA: 0x0000E5C4 File Offset: 0x0000C7C4
	public static Dictionary<KeyCode, IntervalFunction> IntervalFuncs { get; set; }

	// Token: 0x06000193 RID: 403 RVA: 0x0000E5CC File Offset: 0x0000C7CC
	public static DynValue Call(DynValue function)
	{
		Lua.Script.Globals["game"] = Game.Instance;
		Lua.Script.Globals["girl"] = Game.Instance.m_girl;
		Lua.Script.Globals["guy"] = Game.Instance.m_male;
		Lua.Script.Globals["penis"] = Game.Instance.m_male.m_penis;
		Lua.Script.Globals["fluid"] = Game.Instance.m_camera.GetComponent<FluidRenderer>();
		Lua.Script.Globals["Color"] = new Func<float, float, float, float, Color>((float r, float g, float b, float a) => new Color(r, g, b, a));
		Lua.Script.Globals["Vector2"] = new Func<float, float, Vector2>((float x, float y) => new Vector2(x, y));
		Lua.Script.Globals["Vector3"] = new Func<float, float, float, Vector3>((float x, float y, float z) => new Vector3(x, y, z));
		return Lua.Script.Call(function);
	}

	// Token: 0x06000194 RID: 404 RVA: 0x0000E718 File Offset: 0x0000C918
	public static DynValue Call(string function)
	{
		return Lua.Call(Lua.Script.LoadString(function, null, null));
	}

	// Token: 0x06000195 RID: 405 RVA: 0x0000E72C File Offset: 0x0000C92C
	public static void Init()
	{
		if (Lua.Script != null)
		{
			return;
		}
		UserData.RegisterAssembly(null, false);
		UserData.RegisterType<Behaviour>(InteropAccessMode.Default, null);
		UserData.RegisterType<MonoBehaviour>(InteropAccessMode.Default, null);
		UserData.RegisterType<AnimationState>(InteropAccessMode.Default, null);
		UserData.RegisterType<Animator>(InteropAccessMode.Default, null);
		UserData.RegisterType<Animation>(InteropAccessMode.Default, null);
		UserData.RegisterType<Transform>(InteropAccessMode.Default, null);
		UserData.RegisterType<Vector2>(InteropAccessMode.Default, null);
		UserData.RegisterType<Vector3>(InteropAccessMode.Default, null);
		UserData.RegisterType<Color>(InteropAccessMode.Default, null);
		UserData.RegisterType<Material>(InteropAccessMode.Default, null);
		UserData.RegisterType<FluidSmear>(InteropAccessMode.Default, null);
		UserData.RegisterType<SkinWrap>(InteropAccessMode.Default, null);
		UserData.RegisterType<TriangleCache>(InteropAccessMode.Default, null);
		UserData.RegisterType<TrianglePos>(InteropAccessMode.Default, null);
		UserData.RegisterType<AnimationStep>(InteropAccessMode.Default, null);
		UserData.RegisterType<MeshRenderer>(InteropAccessMode.Default, null);
		UserData.RegisterType<SkinnedMeshRenderer>(InteropAccessMode.Default, null);
		UserData.RegisterType<GameObject>(InteropAccessMode.Default, null);
		UserData.RegisterType<Collider>(InteropAccessMode.Default, null);
		UserData.RegisterType<AnimationClip>(InteropAccessMode.Default, null);
		UserData.RegisterType<Type>(InteropAccessMode.Default, null);
		UserData.RegisterType<PuppetMaster>(InteropAccessMode.Default, null);
		UserData.RegisterType<Mathf>(InteropAccessMode.Default, null);
		UserData.RegisterExtensionType(typeof(ExtensionMethods), InteropAccessMode.Default);
		Lua.Script = new Script();
		Lua.Binds = new Dictionary<KeyCode, DynValue>();
		Lua.IntervalFuncs = new Dictionary<KeyCode, IntervalFunction>();
		Lua.Script.Globals["bind"] = new Action<string, DynValue>(delegate(string key, DynValue function)
		{
			try
			{
				KeyCode key2 = (KeyCode)Enum.Parse(typeof(KeyCode), key);
				DynValue dynValue;
				if (Lua.Binds.TryGetValue(key2, out dynValue))
				{
					Lua.Binds[key2] = function;
				}
				else
				{
					Lua.Binds.Add(key2, function);
				}
			}
			catch
			{
			}
		});
		Lua.Script.Globals["toggleRepeat"] = new Action<string, float, DynValue>(delegate(string key, float interval, DynValue function)
		{
			KeyCode key2 = (KeyCode)Enum.Parse(typeof(KeyCode), key);
			IntervalFunction value = new IntervalFunction
			{
				interval = interval,
				function = function
			};
			IntervalFunction intervalFunction;
			if (Lua.IntervalFuncs.TryGetValue(key2, out intervalFunction))
			{
				Lua.IntervalFuncs[key2] = value;
				return;
			}
			Lua.IntervalFuncs.Add(key2, value);
		});
	}

	// Token: 0x06000196 RID: 406 RVA: 0x0000E894 File Offset: 0x0000CA94
	public static void UpdateLua(float deltaTime)
	{
		foreach (IntervalFunction intervalFunction in Lua.IntervalFuncs.Values)
		{
			intervalFunction.Update(deltaTime);
		}
	}
}

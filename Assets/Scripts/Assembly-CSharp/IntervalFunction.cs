using System;
using MoonSharp.Interpreter;

// Token: 0x02000037 RID: 55
[MoonSharpUserData]
public class IntervalFunction
{
	// Token: 0x06000197 RID: 407 RVA: 0x0000E8EC File Offset: 0x0000CAEC
	public void Update(float deltaTime)
	{
		if (!this.active)
		{
			return;
		}
		this.timer += deltaTime;
		if (this.timer >= this.interval)
		{
			this.timer = 0f;
			Lua.Call(this.function);
		}
	}

	// Token: 0x0400016E RID: 366
	public float interval = 10f;

	// Token: 0x0400016F RID: 367
	public float timer;

	// Token: 0x04000170 RID: 368
	public DynValue function;

	// Token: 0x04000171 RID: 369
	public bool active;
}

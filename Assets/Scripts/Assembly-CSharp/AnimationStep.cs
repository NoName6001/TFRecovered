using System;

// Token: 0x0200004D RID: 77
public class AnimationStep
{
	// Token: 0x06000276 RID: 630 RVA: 0x0001716C File Offset: 0x0001536C
	public AnimationStep(float m_delay, float m_duration, bool m_isLogic, Action m_action, Action<float> m_update, bool m_overShoot, object identifier, bool constantFPS)
	{
		this.m_isLogic = m_isLogic;
		this.m_delay = m_delay;
		this.m_duration = m_duration;
		this.m_action = m_action;
		this.m_update = m_update;
		this.m_overShoot = m_overShoot;
		this.m_identifier = identifier;
		this.m_constantFPS = constantFPS;
	}

	// Token: 0x04000259 RID: 601
	public bool m_isLogic;

	// Token: 0x0400025A RID: 602
	public float m_delay;

	// Token: 0x0400025B RID: 603
	public float m_delayTimer;

	// Token: 0x0400025C RID: 604
	public float m_duration;

	// Token: 0x0400025D RID: 605
	public float m_durationTimer;

	// Token: 0x0400025E RID: 606
	public Action m_action;

	// Token: 0x0400025F RID: 607
	public Action<float> m_update;

	// Token: 0x04000260 RID: 608
	public object m_identifier;

	// Token: 0x04000261 RID: 609
	public bool m_constantFPS;

	// Token: 0x04000262 RID: 610
	public bool m_overShoot;
}

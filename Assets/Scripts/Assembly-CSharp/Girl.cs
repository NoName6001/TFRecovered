using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using FluffyUnderware.Curvy;
using MoonSharp.Interpreter;
using RootMotion.Dynamics;
using RootMotion.FinalIK;
using UnityEngine;

// Token: 0x0200004E RID: 78
[ExecuteInEditMode]
[MoonSharpUserData]
public class Girl : MonoBehaviour
{
	// Token: 0x17000035 RID: 53
	// (get) Token: 0x06000277 RID: 631 RVA: 0x000171BC File Offset: 0x000153BC
	public bool CanShoot
	{
		get
		{
			return this.m_penis != null && !this.m_penis.IsShooting;
		}
	}

	// Token: 0x17000036 RID: 54
	// (get) Token: 0x06000278 RID: 632 RVA: 0x000171DC File Offset: 0x000153DC
	// (set) Token: 0x06000279 RID: 633 RVA: 0x000171E4 File Offset: 0x000153E4
	public float MouthSize { get; set; }

	// Token: 0x17000037 RID: 55
	// (get) Token: 0x0600027A RID: 634 RVA: 0x000171ED File Offset: 0x000153ED
	// (set) Token: 0x0600027B RID: 635 RVA: 0x000171F5 File Offset: 0x000153F5
	public float LipsDistance { get; set; }

	// Token: 0x17000038 RID: 56
	// (get) Token: 0x0600027C RID: 636 RVA: 0x00017200 File Offset: 0x00015400
	public Girl MouthFucker
	{
		get
		{
			if (this.m_mouth.Count <= 0)
			{
				return null;
			}
			if (!this.m_mouth[0].Spline)
			{
				return null;
			}
			return this.m_mouth[0].Spline.m_girl;
		}
	}

	// Token: 0x17000039 RID: 57
	// (get) Token: 0x0600027D RID: 637 RVA: 0x0001724D File Offset: 0x0001544D
	public Penis FreePenis
	{
		get
		{
			if (this.m_penis != null && this.m_penis.IsFree)
			{
				return this.m_penis;
			}
			return null;
		}
	}

	// Token: 0x1700003A RID: 58
	// (get) Token: 0x0600027E RID: 638 RVA: 0x00017272 File Offset: 0x00015472
	public float PenisLength
	{
		get
		{
			if (!this.m_penis)
			{
				return 0f;
			}
			return this.m_penis.Length;
		}
	}

	// Token: 0x1700003B RID: 59
	// (get) Token: 0x0600027F RID: 639 RVA: 0x00017292 File Offset: 0x00015492
	public float Scale
	{
		get
		{
			return base.transform.localScale.x;
		}
	}

	// Token: 0x1700003C RID: 60
	// (get) Token: 0x06000280 RID: 640 RVA: 0x000172A4 File Offset: 0x000154A4
	public bool IsPenisControlled
	{
		get
		{
			return this.m_penis && this.m_penis.IsControlled;
		}
	}

	// Token: 0x1700003D RID: 61
	// (get) Token: 0x06000281 RID: 641 RVA: 0x000172C0 File Offset: 0x000154C0
	// (set) Token: 0x06000282 RID: 642 RVA: 0x000172C8 File Offset: 0x000154C8
	public float MouthEnterDist { get; set; } = 0.021f;

	// Token: 0x1700003E RID: 62
	// (get) Token: 0x06000283 RID: 643 RVA: 0x000172D1 File Offset: 0x000154D1
	// (set) Token: 0x06000284 RID: 644 RVA: 0x000172D9 File Offset: 0x000154D9
	public float MouthExitDist { get; set; } = 0.013f;

	// Token: 0x1700003F RID: 63
	// (get) Token: 0x06000285 RID: 645 RVA: 0x000172E2 File Offset: 0x000154E2
	public bool IsSpeaking
	{
		get
		{
			return this.m_voiceAS.isPlaying;
		}
	}

	// Token: 0x17000040 RID: 64
	// (get) Token: 0x06000286 RID: 646 RVA: 0x000172EF File Offset: 0x000154EF
	public float ThroatDistance
	{
		get
		{
			return this.m_throatDistance * this.Scale;
		}
	}

	// Token: 0x06000287 RID: 647 RVA: 0x00017300 File Offset: 0x00015500
	public void Init()
	{
		if (this.m_colliders.Count == 0)
		{
			this.m_colliders = new List<AdvancedCollider>();
			foreach (AdvancedCollider advancedCollider in base.gameObject.GetComponentsInChildren<AdvancedCollider>())
			{
				if (advancedCollider.gameObject.activeSelf)
				{
					this.m_colliders.Add(advancedCollider);
				}
			}
		}
		foreach (AdvancedCollider advancedCollider2 in this.m_colliders)
		{
			advancedCollider2.Init(this);
			Game.Instance.m_collidersDict.Add(advancedCollider2.m_meshCollider, advancedCollider2);
		}
		this.m_jiggleBones = new List<SoxAtkJiggleBoneSimple>();
		foreach (SoxAtkJiggleBoneSimple soxAtkJiggleBoneSimple in base.gameObject.GetComponentsInChildren<SoxAtkJiggleBoneSimple>())
		{
			if (soxAtkJiggleBoneSimple.GetComponentsInParent<SoxAtkJiggleBoneSimple>().Length <= 1)
			{
				this.m_jiggleBones.Add(soxAtkJiggleBoneSimple);
			}
		}
		if (this.m_rig != null)
		{
			this.m_rig.Init(this);
			this.m_rig.transform.parent = null;
			this.m_animator = this.m_rig.gameObject.AddComponent<Animator>();
			this.m_animator.avatar = this.m_rig.GetAvatar();
			this.m_animator.runtimeAnimatorController = this.m_controller;
			this.m_animator.applyRootMotion = false;
			this.m_animator.updateMode = AnimatorUpdateMode.Normal;
			this.m_overrideController = new AnimatorOverrideController(this.m_animator.runtimeAnimatorController);
			this.m_animator.runtimeAnimatorController = this.m_overrideController;
			this.m_animator.enabled = false;
			this.m_rig.transform.parent = base.transform;
		}
		if (this.m_animator != null)
		{
			BipedRagdollReferences r = this.m_puppetRig.SetUpRagdollReferences(this.m_rig);
			BipedRagdollCreator.Options options = BipedRagdollCreator.AutodetectOptions(r);
			BipedRagdollCreator.Create(r, options);
			this.m_puppetRig.SetUpPuppet(this.m_puppet, this.m_rig);
			this.m_puppet.targetAnimator = this.m_animator;
			this.m_puppet.mode = PuppetMaster.Mode.Active;
			this.m_puppet.fixTargetTransforms = false;
			this.m_puppet.visualizeTargetPose = false;
			this.m_puppet.solverIterationCount = 10;
			this.m_puppet.supportTranslationAnimation = true;
			this.m_puppet.Initiate();
			this.m_muscleDict = new Dictionary<Transform, Muscle>();
			foreach (Muscle muscle in this.m_puppet.muscles)
			{
				muscle.rigidbody.interpolation = RigidbodyInterpolation.Interpolate;
				this.m_muscleDict.Add(muscle.target, muscle);
			}
			foreach (Girl girl in Game.Instance.m_humans)
			{
				if (girl != this)
				{
					foreach (Muscle muscle2 in this.m_puppet.muscles)
					{
						Muscle.Group group = muscle2.props.group;
						foreach (Muscle muscle3 in girl.m_puppet.muscles)
						{
							Muscle.Group group2 = muscle3.props.group;
							bool ignore = true;
							if ((group == Muscle.Group.Head && (group2 == Muscle.Group.Hips || group2 == Muscle.Group.Spine || group2 == Muscle.Group.Head)) || (group2 == Muscle.Group.Head && (group == Muscle.Group.Hips || group == Muscle.Group.Spine || group == Muscle.Group.Head)))
							{
								ignore = false;
							}
							muscle2.IgnoreCollisions(muscle3, ignore);
						}
					}
				}
			}
		}
		if (this.m_bipedIK == null)
		{
			this.m_bipedIK = base.gameObject.AddComponent<FullBodyBipedIK>();
			this.m_bipedIK.SetReferences(this.m_rig.GetBipedReferences(), this.m_rig.hips);
			this.m_bipedIK.enabled = false;
			this.m_headEffector.ik = this.m_bipedIK;
			this.m_headEffector.rotationWeight = 1f;
			this.m_headEffector.handsPullBody = true;
			this.m_headEffector.Init();
			this.m_headIK.Init(this.m_rig.head, this, null, default(Vector3), null, null);
			this.m_lEyeIK.Init(this.m_rig.lEye, this, null, default(Vector3), null, null);
			this.m_rEyeIK.Init(this.m_rig.rEye, this, null, default(Vector3), null, null);
			this.m_lHandIK.Init(this.m_rig.lHand, this, this.m_rig.lForearm, -base.transform.forward, null, this.m_rig.lUpperArm);
			this.m_rHandIK.Init(this.m_rig.rHand, this, this.m_rig.rForearm, -base.transform.forward, null, this.m_rig.rUpperArm);
			this.m_lHandIK.m_limbLimit = (Vector3.Distance(this.m_rig.lHand.position, this.m_rig.lUpperArm.position) - 0.01f) / this.Scale;
			this.m_rHandIK.m_limbLimit = (Vector3.Distance(this.m_rig.rHand.position, this.m_rig.rUpperArm.position) - 0.01f) / this.Scale;
			this.m_hipsIK.Init(this.m_rig.hips, this, null, default(Vector3), null, null);
			this.m_lFootIK.Init(this.m_rig.lFoot, this, this.m_rig.lCalf, base.transform.forward, null, null);
			this.m_rFootIK.Init(this.m_rig.rFoot, this, this.m_rig.rCalf, base.transform.forward, null, null);
			IKSolverFullBodyBiped solver = this.m_bipedIK.solver;
			solver.leftHandEffector.target = this.m_lHandIK.m_offsetIK;
			solver.leftHandEffector.positionWeight = 1f;
			solver.leftHandEffector.rotationWeight = 1f;
			solver.GetChain(FullBodyBipedChain.LeftArm).bendConstraint.weight = 1f;
			solver.GetChain(FullBodyBipedChain.LeftArm).bendConstraint.bendGoal = this.m_lHandIK.m_offsetIK.GetChild(0);
			solver.rightHandEffector.target = this.m_rHandIK.m_offsetIK;
			solver.rightHandEffector.positionWeight = 1f;
			solver.rightHandEffector.rotationWeight = 1f;
			solver.GetChain(FullBodyBipedChain.RightArm).bendConstraint.weight = 1f;
			solver.GetChain(FullBodyBipedChain.RightArm).bendConstraint.bendGoal = this.m_rHandIK.m_offsetIK.GetChild(0);
			solver.bodyEffector.target = this.m_hipsIK.m_offsetIK;
			solver.bodyEffector.positionWeight = 1f;
			solver.bodyEffector.rotationWeight = 1f;
			solver.leftFootEffector.target = this.m_lFootIK.m_offsetIK;
			solver.leftFootEffector.positionWeight = 1f;
			solver.leftFootEffector.rotationWeight = 1f;
			solver.rightFootEffector.target = this.m_rFootIK.m_offsetIK;
			solver.rightFootEffector.positionWeight = 1f;
			solver.rightFootEffector.rotationWeight = 1f;
			solver.leftThighEffector.target = this.m_lThighIK;
			solver.leftThighEffector.positionWeight = 1f;
			solver.rightThighEffector.target = this.m_rThighIK;
			solver.rightThighEffector.positionWeight = 1f;
			this.m_bodyIKs = new List<global::IK>
			{
				this.m_headIK,
				this.m_hipsIK,
				this.m_lHandIK,
				this.m_rHandIK,
				this.m_lFootIK,
				this.m_rFootIK
			};
		}
		if (this.m_penis)
		{
			this.m_penis.Init(this);
		}
		if (this.m_face)
		{
			this.m_face.m_active = true;
			this.m_face.m_offsetActive = true;
			this.m_face.m_rigging = false;
			this.m_face.Init(this);
		}
		if (this.m_rig.lEye != null)
		{
			this.m_eyeDownRot = this.m_rig.lEye.localRotation * Quaternion.AngleAxis(-90f, this.m_rig.lEye.InverseTransformDirection(base.transform.right));
		}
		if (this.m_rig.mouth.Count > 0)
		{
			this.m_mouth = new List<CurvySplineSegment>();
			for (int k = 0; k < this.m_rig.mouth.Count; k++)
			{
				CurvySplineSegment curvySplineSegment = this.m_rig.mouth[k].gameObject.AddComponent<CurvySplineSegment>();
				curvySplineSegment.enabled = false;
				curvySplineSegment.OrientationAnchor = false;
				curvySplineSegment.AutoHandleDistance = 0.2f;
				curvySplineSegment.m_girl = this;
				this.m_mouth.Add(curvySplineSegment);
			}
		}
		int num = 0;
		int num2 = -1;
		this.m_visemes = new List<AnimationState>();
		foreach (object obj in this.m_anim)
		{
			AnimationState animationState = (AnimationState)obj;
			animationState.enabled = true;
			animationState.layer = num;
			animationState.wrapMode = WrapMode.Loop;
			animationState.blendMode = AnimationBlendMode.Blend;
			if (animationState.name == "Face_Base" || animationState.name == "Face_Demo")
			{
				animationState.weight = 1f;
			}
			if (animationState.name == "Face_Blowjob_Wide")
			{
				animationState.layer = this.m_anim["Face_Blowjob_Small"].layer;
			}
			if (animationState.name.StartsWith("Viseme"))
			{
				if (num2 == -1)
				{
					num2 = num;
				}
				animationState.layer = num2;
				this.m_visemes.Add(animationState);
			}
			num++;
		}
		this.m_voiceAS = ((this.m_mouth.Count > 0) ? this.m_mouth[0].transform : this.m_rig.head).gameObject.AddComponent<AudioSource>();
		this.m_voiceAS.loop = false;
		this.m_voiceAS.playOnAwake = false;
		this.m_voiceAS.spatialBlend = 1f;
		this.m_voiceAS.volume = this.m_voiceVolume;
		this.m_lipsyncDict = new Dictionary<string, OVRLipSyncSequence>();
		foreach (OVRLipSyncSequence ovrlipSyncSequence in this.m_lipsyncs)
		{
			this.m_lipsyncDict.Add(ovrlipSyncSequence.name.Replace("_lipSync", ""), ovrlipSyncSequence);
		}
		foreach (SoxAtkJiggleBoneSimple soxAtkJiggleBoneSimple2 in this.m_jiggleBones)
		{
			SoxAtkJiggleBoneSimple[] array = soxAtkJiggleBoneSimple2.m_tree;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].enabled = false;
			}
			soxAtkJiggleBoneSimple2.OnAwake();
		}
		this.m_timers = new Dictionary<string, float>();
		if (this.m_music != null)
		{
			AudioSource musicAS = Game.Instance.m_musicAS;
			musicAS.clip = this.m_music;
			musicAS.volume = this.m_musicVolume;
			musicAS.Play();
		}
	}

	// Token: 0x06000288 RID: 648 RVA: 0x00017F0C File Offset: 0x0001610C
	public void UpdateGirl(float deltaTime)
	{
		foreach (string text in new List<string>(this.m_timers.Keys))
		{
			Dictionary<string, float> timers = this.m_timers;
			string key = text;
			timers[key] -= deltaTime;
			if (this.m_timers[text] <= 0f)
			{
				this.m_timers.Remove(text);
			}
		}
		if (this.m_animator && this.m_updateAnim)
		{
			this.m_animator.Update(deltaTime);
		}
		this.m_anim.Sample();
		if (!this.m_headIK.m_controlled)
		{
			this.m_headIK.m_final.Active = true;
			this.m_headIK.m_final.m_aimPoint = (this.m_rig.lEye.position + this.m_rig.rEye.position) / 2f;
			this.m_headIK.m_final.m_origin = (this.m_rig.lEye.position + this.m_rig.rEye.position) / 2f - this.m_rig.head.forward * 0.1f;
			this.m_headIK.m_final.m_position = this.m_headIK.m_rest.transform.position;
			this.m_headIK.m_final.m_parent = this.m_headIK.m_rest.transform;
			this.m_headIK.m_final.m_limitWrap = true;
			this.m_headIK.m_final.m_angleWeight = 0.85f;
			if (this == Game.Instance.m_girl)
			{
				this.m_headIK.m_final.m_target = Game.Instance.m_camera.transform.position;
			}
			else if (this == Game.Instance.m_male)
			{
				this.m_headIK.m_angleLimit = 30f;
				this.m_headIK.m_final.m_target = Game.Instance.m_girl.m_rig.lEye.position;
			}
		}
		else
		{
			this.m_headIK.m_final.Active = false;
		}
		if (!this.m_headLock && this.MouthFucker != null && this.m_autoSpeed > 0f)
		{
			Girl mouthFucker = this.MouthFucker;
			float penisLength = mouthFucker.PenisLength;
			float d = Vector3.Distance(this.m_rig.head.position, this.m_rig.Mouth.position) * 0.8f;
			Vector3 position = mouthFucker.m_penis.transform.position;
			Vector3 position2 = this.m_headIK.m_baseIK.position;
			Vector3 vector = position2 - position;
			Vector3 b = position + vector.normalized * (1f - this.m_autoDepth) * penisLength;
			Vector3 a = position + vector.normalized * penisLength * 0.8f;
			this.m_autoTime = Mathf.Clamp01(this.m_autoTime + (float)(this.m_autoInPhase ? 1 : -1) * this.m_autoSpeed * deltaTime);
			if (this.m_autoTime == 0f || this.m_autoTime == 1f)
			{
				this.m_autoInPhase = !this.m_autoInPhase;
			}
			float t = Mathf.SmoothStep(0f, 1f, this.m_autoTime);
			Vector3 b2 = Vector3.Lerp(a, b, t) + vector.normalized * d;
			Vector3 pos = Vector3.Lerp(position2, b2, deltaTime * 5f);
			this.m_headIK.MoveBase(pos);
		}
		if (!this.m_hipsLock && this.m_penis != null && this.FreePenis == null && this.m_autoSpeed > 0f)
		{
			this.m_autoTime = Mathf.Clamp01(this.m_autoTime + (float)(this.m_autoInPhase ? 1 : -1) * this.m_autoSpeed * deltaTime);
			if (this.m_autoTime == 0f || this.m_autoTime == 1f)
			{
				this.m_autoInPhase = !this.m_autoInPhase;
			}
			float t2 = Mathf.SmoothStep(0f, 1f, this.m_autoTime);
			Girl connectedGirl = this.m_penis.ConnectedGirl;
			float penisLength2 = this.PenisLength;
			float num = Vector3.Distance(this.m_rig.hips.position, this.m_penis.transform.position) * 0.85f;
			float num2 = Vector3.Distance(connectedGirl.m_rig.Throat.position, connectedGirl.m_rig.Mouth.position) * 0.85f;
			Vector3 position3 = connectedGirl.m_rig.Mouth.position;
			Vector3 position4 = this.m_hipsIK.m_baseIK.position;
			Vector3 vector2 = position4 - position3;
			Vector3 b3 = position3 + vector2.normalized * (1f - this.m_autoDepth) * penisLength2;
			Vector3 b4 = Vector3.Lerp(position3 + vector2.normalized * (penisLength2 * 0.85f), b3, t2) + vector2.normalized * (num + num2);
			Vector3 pos2 = Vector3.Lerp(position4, b4, deltaTime * 5f);
			this.m_hipsIK.MoveBase(pos2);
		}
		foreach (global::IK ik in this.m_bodyIKs)
		{
			ik.UpdateIK(deltaTime);
		}
		IKSolverFullBodyBiped solver = this.m_bipedIK.solver;
		this.m_hipsWeight = Mathf.Clamp01(this.m_hipsWeight);
		if (solver.bodyEffector.positionWeight != this.m_hipsWeight)
		{
			solver.bodyEffector.positionWeight = this.m_hipsWeight;
			solver.leftThighEffector.positionWeight = this.m_hipsWeight;
			solver.rightThighEffector.positionWeight = this.m_hipsWeight;
		}
		this.m_bipedIK.solver.Update();
		if (!this.m_puppet.enabled)
		{
			this.m_puppet.Update();
			this.m_puppet.LateUpdate();
		}
		if (this.m_penis != null)
		{
			this.m_penis.UpdateSpline();
		}
		this.m_hipsIK.ResetPos(null, false);
		this.m_headIK.ResetPos(this.m_headIK.m_offsetIK, true);
		this.m_lHandIK.ResetPos(this.m_lHandIK.m_offsetIK, true);
		this.m_rHandIK.ResetPos(this.m_rHandIK.m_offsetIK, true);
		this.m_lFootIK.ResetPos(this.m_lFootIK.m_offsetIK, true);
		this.m_rFootIK.ResetPos(this.m_rFootIK.m_offsetIK, true);
		if (this.m_headIK.m_controlled)
		{
			Vector3 vector3 = this.m_headIK.m_offsetIK.position - this.m_headIK.m_baseIK.position;
			if (vector3.magnitude > 0.1f)
			{
				this.m_headIK.m_baseIK.position = this.m_headIK.m_offsetIK.position - vector3.normalized * 0.1f;
			}
		}
	}

	// Token: 0x06000289 RID: 649 RVA: 0x000186B4 File Offset: 0x000168B4
	public void LateUpdateGirl(float deltaTime)
	{
		this.MouthSize = 0f;
		float num = 0f;
		if (this.m_mouth.Count > 0)
		{
			Transform lips = this.m_rig.lips;
			if (this.MouthFucker == null)
			{
				foreach (Girl girl in Game.Instance.m_humans)
				{
					if (girl.FreePenis != null && Vector3.Distance(lips.position, girl.m_rig.penisTip.position) <= this.MouthEnterDist)
					{
						girl.ConnectPenis(this);
						this.m_mouthEnterTime = Time.time;
						break;
					}
				}
			}
			if (this.MouthFucker != null)
			{
				Girl mouthFucker = this.MouthFucker;
				Transform transform = mouthFucker.m_rig.penisTip.transform;
				Transform transform2 = this.m_mouth[0].transform;
				Penis penis = mouthFucker.m_penis;
				float penisLength = mouthFucker.PenisLength;
				this.LipsDistance = penis.GetNearestPointDistance(lips.position);
				float num2 = penisLength - this.LipsDistance;
				if (num2 > 0f)
				{
					Transform transform3 = this.m_mouth[2].transform;
					float throatDistance = this.ThroatDistance;
					float d = this.m_cheekDistance * this.Scale;
					float t = Mathf.InverseLerp(this.m_throatDistance, this.m_throatDistance * 1.5f, num2);
					float t2 = Mathf.InverseLerp(0f, throatDistance, num2);
					Quaternion rotation = this.m_headIK.m_offsetIK.rotation;
					Vector3 forward = this.m_headIK.m_offsetIK.forward;
					Transform transformToAimAt = Utils.GetTransformToAimAt(this.m_headIK.m_offsetIK.position, this.m_headIK.m_offsetIK.rotation, transform3.position, transform2.position, penis.transform.position, this.m_headIK.m_baseIK.up);
					Vector3 forward2 = transformToAimAt.forward;
					Vector3 vector = Vector3.ProjectOnPlane(forward, this.m_headIK.BoneParent.up);
					Vector3 vector2 = Vector3.ProjectOnPlane(forward2, this.m_headIK.BoneParent.up);
					float num3 = Vector3.Angle(vector, vector2);
					if (num3 > 50f)
					{
						vector = Vector3.Slerp(vector2, vector, 50f / num3);
					}
					Quaternion b = Quaternion.FromToRotation(vector2, vector) * transformToAimAt.rotation;
					Quaternion quaternion = Quaternion.Slerp(rotation, b, t2);
					Quaternion b2 = Quaternion.FromToRotation(vector, vector2) * quaternion;
					quaternion = Quaternion.Slerp(quaternion, b2, t);
					float num4 = Quaternion.Angle(quaternion, rotation);
					float num5 = Mathf.Lerp(this.m_headFreeMax, this.m_headFreeMin, t2);
					if (num4 > num5)
					{
						Vector3 up = this.m_headIK.m_baseIK.up;
						Quaternion b3 = Quaternion.Slerp(quaternion, rotation, num5 / num4);
						this.m_headIK.m_baseIK.rotation = Quaternion.Slerp(this.m_headIK.m_baseIK.rotation, b3, deltaTime * 4f);
						this.m_headIK.m_baseIK.rotation = Quaternion.LookRotation(this.m_headIK.m_baseIK.forward, up);
					}
					this.m_headIK.m_offsetIK.rotation = quaternion;
					this.m_bipedIK.solver.Update();
					//this.m_puppet.muscles[2].ManualRead();
					this.m_puppet.muscles[2].Read();
					this.LipsDistance = penis.GetNearestPointDistance(lips.position);
					num2 = penisLength - this.LipsDistance;
					Vector3 vector3 = transform2.position - penis.transform.position;
					float t3 = Mathf.InverseLerp(this.m_mouthLimitFade.x, this.m_mouthLimitFade.y, num2);
					Vector2 limits = new Vector2(Mathf.Lerp(this.m_mouthLimit.x, 0f, t3), Mathf.Lerp(this.m_mouthLimit.y, 0f, t3));
					Vector2 projectedAngles = this.GetProjectedAngles(transform2, vector3.normalized, limits);
					Vector3 vector4 = Quaternion.AngleAxis(-projectedAngles.y, -transform2.right) * (Quaternion.AngleAxis(projectedAngles.x, transform2.up) * -transform2.forward);
					this.m_mouth[1].transform.position = transform2.position + vector4.normalized * d;
					if (num2 > 0.12f)
					{
						this.m_deepthroated = true;
					}
					if (num2 > 0.02f && penis.IsShooting && !this.m_timers.ContainsKey("Swallowing"))
					{
						this.m_timers.Add("Swallowing", 2f);
						this.StopTalking();
						bool swallowed = false;
						float swallowTime = UnityEngine.Random.Range(0.35f, 0.6f);
						float duration = UnityEngine.Random.Range(3f, 5f);
						this.Animate("Face_Swallow", duration, 1f, -1, 1f, delegate(float sTime)
						{
							if (sTime >= swallowTime && !swallowed)
							{
								swallowed = true;
								Utils.PlayClipAt(Game.Instance.m_swallowSounds[UnityEngine.Random.Range(0, Game.Instance.m_swallowSounds.Count)], this.m_rig.Throat.position, 0.3f, 1f);
							}
						});
					}
				}
				if (num2 <= -this.MouthExitDist)
				{
					mouthFucker.ConnectPenis(null);
					if (this.m_deepthroated)
					{
						this.m_deepthroated = false;
						if (!this.IsSpeaking && Time.time - this.m_mouthEnterTime > 3f)
						{
							this.Say(new string[]
							{
								"Breath"
							});
						}
					}
				}
				num = Mathf.Lerp(0.2f, 1f, Mathf.InverseLerp(-0.04f, 0f, num2));
				this.MouthSize = penis.GetSizeAtLength(this.LipsDistance, true);
				penis.SaveInsideLength(num2);
			}
		}
		this.m_headIK.m_offsetIK.rotation = Quaternion.Slerp(this.m_headIK.m_lastOffsetIK.rotation, this.m_headIK.m_offsetIK.rotation, deltaTime * (float)(this.MouthFucker ? 7 : 12));
		foreach (global::IK ik in this.m_bodyIKs)
		{
			ik.ApplyRotationLimit();
		}
		bool flag = false;
		foreach (global::IK ik2 in this.m_bodyIKs)
		{
			if (ik2.AttachPoint != null)
			{
				flag = true;
				ik2.UpdateAttachDisplay();
			}
		}
		if (flag)
		{
			this.m_bipedIK.solver.Update();
		}
		if (this.m_face)
		{
			if (num < 1f)
			{
				float mouthLerpSpeed = this.m_mouthLerpSpeed;
			}
			float num6 = this.m_maxMouthSize * this.Scale;
			this.SetStateWeight("Face_Blowjob_Base", num, this.m_mouthLerpSpeed, -1, -1f);
			this.SetStateWeight("Face_Blowjob_Small", num * Mathf.InverseLerp(num6, 0f, this.MouthSize), this.m_mouthLerpSpeed, -1, 11f);
			this.SetStateWeight("Face_Blowjob_Wide", num * Mathf.InverseLerp(0f, num6, this.MouthSize), this.m_mouthLerpSpeed, -1, 11f);
			this.m_face.UpdateFace();
		}
		if (this.m_penis == null)
		{
			this.m_lEyeIK.m_final.Active = true;
			this.m_rEyeIK.m_final.Active = true;
			this.m_lEyeIK.m_final.m_target = Game.Instance.m_camera.transform.position;
			this.m_rEyeIK.m_final.m_target = Game.Instance.m_camera.transform.position;
			this.m_lEyeIK.m_final.m_aimPoint = this.m_rig.lEye.position + this.m_rig.lEye.forward * 0.1f;
			this.m_rEyeIK.m_final.m_aimPoint = this.m_rig.rEye.position + this.m_rig.rEye.forward * 0.1f;
			this.m_lEyeIK.m_final.m_origin = this.m_rig.lEye.position;
			this.m_rEyeIK.m_final.m_origin = this.m_rig.rEye.position;
			this.m_lEyeIK.m_final.m_position = this.m_rig.lEye.position;
			this.m_rEyeIK.m_final.m_position = this.m_rig.rEye.position;
			this.m_lEyeIK.m_final.m_parent = this.m_lEyeIK.BoneParent;
			this.m_rEyeIK.m_final.m_parent = this.m_rEyeIK.BoneParent;
			this.m_lEyeIK.m_speed = 4f;
			this.m_rEyeIK.m_speed = 4f;
		}
		foreach (global::IK ik3 in new List<global::IK>
		{
			this.m_lEyeIK,
			this.m_rEyeIK
		})
		{
			ik3.UpdateIK(deltaTime);
		}
		if (this.m_rig.lEye != null)
		{
			float value = Vector3.Angle(this.m_rig.lEye.forward, -this.m_lEyeIK.BoneParent.up);
			float num7 = Mathf.InverseLerp(90f, 90f - this.m_lEyeIK.m_angleLimit, value);
			this.m_anim["Face_EyeClosed"].weight = num7 * 0.95f;
			this.m_anim.Sample();
		}
		if (this.m_mouth.Count > 0)
		{
			Transform transform4 = this.m_mouth[0].transform;
			Transform transform5 = this.m_mouth[2].transform;
			transform4.position = (this.m_rig.mouthUpper.position + this.m_rig.mouthLower.position) / 2f;
			transform4.position -= transform5.position;
		}
		foreach (SoxAtkJiggleBoneSimple soxAtkJiggleBoneSimple in this.m_jiggleBones)
		{
			soxAtkJiggleBoneSimple.UpdateBone();
		}
		if (this.m_penis)
		{
			this.m_penis.UpdateBones();
			this.m_penis.UpdatePenis(deltaTime);
		}
	}

	// Token: 0x0600028A RID: 650 RVA: 0x000191C4 File Offset: 0x000173C4
	public void UpdateAdvancedColliders(float deltaTime)
	{
		foreach (AdvancedCollider advancedCollider in this.m_colliders)
		{
			advancedCollider.UpdateCollider(deltaTime);
		}
	}

	// Token: 0x0600028B RID: 651 RVA: 0x00019218 File Offset: 0x00017418
	public void UpdateSkinWrapWetness(float deltaTime)
	{
		foreach (AdvancedCollider advancedCollider in this.m_colliders)
		{
			advancedCollider.UpdateSkinWrapWetness(deltaTime);
		}
	}

	// Token: 0x0600028C RID: 652 RVA: 0x0001926C File Offset: 0x0001746C
	public void ConnectPenis(Girl girl = null)
	{
		Penis penis = this.m_penis;
		if (penis == null)
		{
			return;
		}
		penis.ConnectTo(girl);
	}

	// Token: 0x0600028D RID: 653 RVA: 0x00019280 File Offset: 0x00017480
	public void Update()
	{
		if (Application.isPlaying)
		{
			return;
		}
		FaceRig face = this.m_face;
		if (face != null)
		{
			face.UpdateFace();
		}
		foreach (AdvancedCollider advancedCollider in this.m_colliders)
		{
			if (advancedCollider != null && advancedCollider.prepareMesh)
			{
				advancedCollider.prepareMesh = false;
				advancedCollider.PrepareMesh();
			}
		}
		if (this.m_convertSkin)
		{
			this.m_convertSkin = false;
			if (this.m_convertRenderer)
			{
				this.m_convertRenderer.rootBone = base.transform;
				Transform[] bones = this.m_convertRenderer.bones;
				this.BoneSearch(bones, base.transform);
				this.m_convertRenderer.bones = bones;
			}
		}
	}

	// Token: 0x0600028E RID: 654 RVA: 0x00019358 File Offset: 0x00017558
	public void BoneSearch(Transform[] bones, Transform tf)
	{
		for (int i = 0; i < bones.Length; i++)
		{
			Transform transform = bones[i];
			if (tf.name == transform.name)
			{
				bones[i] = tf;
			}
		}
		foreach (object obj in tf)
		{
			Transform tf2 = (Transform)obj;
			this.BoneSearch(bones, tf2);
		}
	}

	// Token: 0x0600028F RID: 655 RVA: 0x000193DC File Offset: 0x000175DC
	public void RotateHead(Vector2 delta)
	{
		this.m_headIK.m_controlled = true;
		Transform transform = Game.Instance.m_camera.transform;
		this.m_headIK.m_baseIK.Rotate(transform.up, -delta.x * 10f, Space.World);
		this.m_headIK.m_baseIK.Rotate(transform.right, delta.y * 10f, Space.World);
		this.m_headLock = true;
	}

	// Token: 0x06000290 RID: 656 RVA: 0x00019454 File Offset: 0x00017654
	public void MoveHead(Vector2 delta)
	{
		Transform transform = Game.Instance.m_camera.transform;
		Vector3 vector = transform.up * delta.y + transform.right * delta.x;
		vector = Vector3.ProjectOnPlane(vector, this.m_headIK.transform.right);
		this.m_headIK.MoveBase(this.m_headIK.m_baseIK.position + vector * this.m_hipsSpeed);
		this.m_headLock = true;
	}

	// Token: 0x06000291 RID: 657 RVA: 0x000194E4 File Offset: 0x000176E4
	public void MoveHips(Vector2 delta)
	{
		Transform transform = Game.Instance.m_camera.transform;
		Vector3 vector = transform.up * delta.y + transform.right * delta.x;
		List<ValueTuple<Vector3, float, Vector3>> list = new List<ValueTuple<Vector3, float, Vector3>>
		{
			new ValueTuple<Vector3, float, Vector3>(this.m_hipsIK.transform.up, 0f, Vector3.zero),
			new ValueTuple<Vector3, float, Vector3>(this.m_hipsIK.transform.right, 0f, Vector3.zero),
			new ValueTuple<Vector3, float, Vector3>(this.m_hipsIK.transform.forward, 0f, Vector3.zero)
		};
		for (int i = 0; i < list.Count; i++)
		{
			ValueTuple<Vector3, float, Vector3> valueTuple = list[i];
			Vector3 item = valueTuple.Item1;
			float item2 = valueTuple.Item2;
			Vector3 item3 = valueTuple.Item3;
			item3 = Vector3.ProjectOnPlane(vector, item);
			item2 = Mathf.Abs(Vector3.Dot(item, transform.forward));
			list[i] = new ValueTuple<Vector3, float, Vector3>(item, item2, item3);
		}
		list.Sort((ValueTuple<Vector3, float, Vector3> a, ValueTuple<Vector3, float, Vector3> b) => b.Item2.CompareTo(a.Item2));
		vector = list[0].Item3;
		this.m_hipsIK.MoveBase(this.m_hipsIK.m_baseIK.position + vector * this.m_hipsSpeed);
		this.m_hipsLock = true;
	}

	// Token: 0x06000292 RID: 658 RVA: 0x00019664 File Offset: 0x00017864
	public void StopHips()
	{
		this.m_hipsLock = false;
		this.m_autoInPhase = true;
		if (this.m_penis.ConnectedGirl != null)
		{
			this.m_autoTime = Mathf.InverseLerp(this.PenisLength, 0f, Vector3.Distance(this.m_penis.transform.position, this.m_penis.ConnectedGirl.m_rig.Mouth.position));
		}
	}

	// Token: 0x06000293 RID: 659 RVA: 0x000196D8 File Offset: 0x000178D8
	public void StopHead()
	{
		this.m_headLock = false;
		this.m_autoInPhase = true;
		if (this.MouthFucker != null)
		{
			this.m_autoTime = Mathf.InverseLerp(this.MouthFucker.PenisLength, 0f, Vector3.Distance(this.MouthFucker.m_penis.transform.position, this.m_rig.Mouth.position));
		}
	}

	// Token: 0x06000294 RID: 660 RVA: 0x00019748 File Offset: 0x00017948
	public void ThrustPenis(Vector2 delta)
	{
		Transform transform = Game.Instance.m_camera.transform;
		Vector3 vector = transform.up * delta.y + transform.right * delta.x;
		vector = Vector3.ProjectOnPlane(vector, this.m_hipsIK.transform.right);
		this.m_hipsIK.MoveBase(this.m_hipsIK.m_baseIK.position + vector * this.m_hipsSpeed);
		this.m_hipsLock = true;
	}

	// Token: 0x06000295 RID: 661 RVA: 0x000197D8 File Offset: 0x000179D8
	public void RotatePenis(Vector2 delta)
	{
		Rigidbody @base = this.m_penis.Base;
		if (@base != null)
		{
			@base.isKinematic = true;
			@base.transform.Rotate(this.m_penis.transform.up, delta.x * this.m_penisRotSpd);
			@base.transform.Rotate(this.m_penis.transform.right, -delta.y * this.m_penisRotSpd);
			float num = Quaternion.Angle(@base.transform.rotation, this.m_penis.transform.rotation);
			if (num >= 75f)
			{
				@base.transform.rotation = Quaternion.Slerp(this.m_penis.transform.rotation, @base.transform.rotation, 75f / num);
			}
		}
	}

	// Token: 0x06000296 RID: 662 RVA: 0x000198B0 File Offset: 0x00017AB0
	public void AimPenis(Vector3 point)
	{
		Rigidbody @base = this.m_penis.Base;
		if (@base != null)
		{
			@base.isKinematic = true;
			Quaternion b = Quaternion.LookRotation(point - @base.transform.position, this.m_penis.transform.up);
			@base.transform.rotation = Quaternion.Slerp(@base.transform.rotation, b, this.m_penisAimSpd * Time.deltaTime);
			float num = Quaternion.Angle(@base.transform.rotation, this.m_penis.transform.rotation);
			if (num >= 75f)
			{
				@base.transform.rotation = Quaternion.Slerp(this.m_penis.transform.rotation, @base.transform.rotation, 75f / num);
			}
		}
	}

	// Token: 0x06000297 RID: 663 RVA: 0x00019988 File Offset: 0x00017B88
	public void StopPenisMove()
	{
		Rigidbody @base = this.m_penis.Base;
		if (@base != null)
		{
			@base.isKinematic = false;
		}
	}

	// Token: 0x06000298 RID: 664 RVA: 0x000199B4 File Offset: 0x00017BB4
	public void ToggleMaleBody()
	{
		bool flag = true;
		foreach (AdvancedCollider advancedCollider in this.m_colliders)
		{
			foreach (Material material in advancedCollider.m_skinMesh.materials)
			{
				if (material.HasProperty("_Mask") && material.name.Contains("Penis"))
				{
					flag = (material.GetFloat("_Mask") != 1f);
				}
			}
		}
		flag = !flag;
		foreach (AdvancedCollider advancedCollider2 in this.m_colliders)
		{
			Material[] materials = advancedCollider2.m_skinMesh.materials;
			foreach (Material material2 in materials)
			{
				if (material2.HasProperty("_Mask"))
				{
					if (material2.name.Contains("Penis"))
					{
						material2.SetFloat("_Mask", (float)(flag ? 0 : 1));
					}
					else
					{
						material2.SetFloat("_Mask", (float)(flag ? 0 : 2));
					}
				}
			}
			advancedCollider2.m_skinMesh.materials = materials;
			if (!advancedCollider2.name.Contains("Penis"))
			{
				advancedCollider2.m_meshCollider.enabled = flag;
			}
		}
		MeshRenderer[] componentsInChildren = this.m_rig.head.GetComponentsInChildren<MeshRenderer>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].enabled = flag;
		}
	}

	// Token: 0x06000299 RID: 665 RVA: 0x00019B68 File Offset: 0x00017D68
	public void IgnoreDynamicCollisions(bool ignore, params Collider[] colliders)
	{
		foreach (AdvancedCollider advancedCollider in this.m_colliders)
		{
			foreach (Collider collider in colliders)
			{
				Physics.IgnoreCollision(advancedCollider.m_meshCollider, collider, ignore);
			}
		}
	}

	// Token: 0x0600029A RID: 666 RVA: 0x00019BD8 File Offset: 0x00017DD8
	public void Shoot()
	{
		this.m_penis.StartShooting();
	}

	// Token: 0x0600029B RID: 667 RVA: 0x00019BE5 File Offset: 0x00017DE5
	public void Say(params string[] searchTerms)
	{
		this.SpeakLine(this.GetVoiceLine(searchTerms));
	}

	// Token: 0x0600029C RID: 668 RVA: 0x00019BF4 File Offset: 0x00017DF4
	public void Say(AudioClip clip)
	{
		this.SpeakLine(clip);
	}

	// Token: 0x0600029D RID: 669 RVA: 0x00019C00 File Offset: 0x00017E00
	public void SpeakLine(AudioClip clip)
	{
		if (this.m_visemes.Count == 0 || clip == null || !this.m_voiceAS.enabled)
		{
			return;
		}
		this.m_voiceAS.clip = clip;
		this.m_voiceAS.Play();
		List<float> startWeights = new List<float>();
		foreach (AnimationState animationState in this.m_visemes)
		{
			startWeights.Add(animationState.weight);
		}
		startWeights.Add(this.m_anim["Base_Lipsync"].weight);
		OVRLipSyncSequence lipsync;
		if (this.m_lipsyncDict.TryGetValue(clip.name, out lipsync))
		{
			float num = Mathf.Min(0.2f, clip.length * 0.2f);
			float num2 = Mathf.Min(0.2f, clip.length * 0.2f);
			float length = clip.length;
			float fadeInT = num / length;
			float fadeOutT = 1f - num2 / length;
			Game.AddAnim(0f, length, delegate(float time)
			{
				float time2 = this.m_voiceAS.isPlaying ? this.m_voiceAS.time : 999f;
				OVRLipSync.Frame frameAtTime = lipsync.GetFrameAtTime(time2);
				if (!this.m_voiceAS.isPlaying && time < fadeOutT)
				{
					fadeOutT = time;
				}
				if (time <= fadeInT)
				{
					float num3 = Mathf.InverseLerp(0f, fadeInT, time);
					for (int i = 0; i < this.m_visemes.Count; i++)
					{
						this.m_visemes[i].weight = Mathf.Lerp(startWeights[i], frameAtTime.Visemes[i], num3);
					}
					this.m_anim["Base_Lipsync"].weight = num3;
				}
				else if (time >= fadeOutT)
				{
					float num4 = Mathf.InverseLerp(1f, fadeOutT, time);
					for (int j = 0; j < this.m_visemes.Count; j++)
					{
						this.m_visemes[j].weight = Mathf.Lerp(0f, frameAtTime.Visemes[j], num4);
					}
					this.m_anim["Base_Lipsync"].weight = num4;
				}
				else
				{
					for (int k = 0; k < this.m_visemes.Count; k++)
					{
						this.m_visemes[k].weight = frameAtTime.Visemes[k];
					}
					this.m_anim["Base_Lipsync"].weight = 1f;
				}
				if (time == 1f)
				{
					Game.RemoveAnim(this.m_voiceAS, false);
				}
			}, true, false, this.m_voiceAS, false, false);
			return;
		}
		this.FadeOutLipsync();
	}

	// Token: 0x0600029E RID: 670 RVA: 0x00019D78 File Offset: 0x00017F78
	public void StopTalking()
	{
		this.m_voiceAS.Stop();
		this.FadeOutLipsync();
	}

	// Token: 0x0600029F RID: 671 RVA: 0x00019D8C File Offset: 0x00017F8C
	public void FadeOutLipsync()
	{
		List<float> startWeights = new List<float>();
		foreach (AnimationState animationState in this.m_visemes)
		{
			startWeights.Add(animationState.weight);
		}
		Game.AddAnim(0f, 0.25f, delegate(float time)
		{
			for (int i = 0; i < this.m_visemes.Count; i++)
			{
				this.m_visemes[i].weight = Mathf.SmoothStep(startWeights[i], 0f, time);
			}
			this.m_anim["Base_Lipsync"].weight = Mathf.SmoothStep(startWeights[startWeights.Count - 1], 0f, time);
		}, true, false, this.m_voiceAS, false, false);
	}

	// Token: 0x060002A0 RID: 672 RVA: 0x00019E28 File Offset: 0x00018028
	public void EyeShot(bool isLeft = true)
	{
		string name = isLeft ? "Face_L_Eye_Shot" : "Face_R_Eye_Shot";
		float startWeight = this.m_anim[name].weight;
		float targetWeight = startWeight + 1.2f;
		float reachTime = 1.2f;
		float duration = reachTime + targetWeight * 4.5f;
		Game.AddAnim(0f, duration, delegate(float time)
		{
			float num = reachTime / duration;
			float weight;
			if (time <= num)
			{
				weight = Mathf.Lerp(startWeight, targetWeight, time / num);
			}
			else
			{
				weight = Mathf.Lerp(targetWeight, 0f, (time - num) / (1f - num));
			}
			this.SetStateWeight(name, weight, -1f, -1, -1f);
		}, true, false, this.m_anim[name], false, false);
	}

	// Token: 0x060002A1 RID: 673 RVA: 0x00019EDB File Offset: 0x000180DB
	public void OpenMouth(float maxWeight)
	{
		this.Animate("Face_Mouth_OpenTongue", 8f, 1f, 5, maxWeight, delegate(float time)
		{
			if (time == 1f)
			{
				bool swallowed = false;
				this.Animate("Face_Swallow", 3.5f, 1f, 6, 1f, delegate(float sTime)
				{
					if (sTime >= 0.5f && !swallowed)
					{
						swallowed = true;
						Vector3 vector = (this.m_rig.Mouth.position + this.m_rig.Throat.position) / 2f;
						float num = Vector3.Distance(this.m_rig.Mouth.position, vector) * 0.9f;
						for (int i = Game.Instance.m_fluids.Count - 1; i >= 0; i--)
						{
							Fluid fluid = Game.Instance.m_fluids[i];
							if (fluid.m_stringPos == null && Vector3.Distance(vector, fluid.transform.position) < num)
							{
								Game.Instance.RemoveFluid(fluid);
							}
						}
						Utils.PlayClipAt(Game.Instance.m_swallowSounds[UnityEngine.Random.Range(0, Game.Instance.m_swallowSounds.Count)], this.m_rig.Throat.position, 0.3f, 1f);
					}
				});
			}
		});
	}

	// Token: 0x060002A2 RID: 674 RVA: 0x00019F00 File Offset: 0x00018100
	public void Animate(string name, float duration, float fadeTime = -1f, int layer = -1, float maxWeight = 1f, Action<float> callback = null)
	{
		AnimationState animationState = this.m_anim[name];
		if (fadeTime == -1f)
		{
			fadeTime = Mathf.Min(1f, duration * 0.2f);
		}
		float blendT = fadeTime / duration;
		float startWeight = animationState.weight;
		Game.AddAnim(0f, duration, delegate(float time)
		{
			float weight = maxWeight;
			if (time <= blendT)
			{
				weight = Mathf.SmoothStep(startWeight, maxWeight, time / blendT);
			}
			else if (time >= 1f - blendT)
			{
				weight = Mathf.SmoothStep(0f, maxWeight, (1f - time) / blendT);
			}
			this.SetStateWeight(name, weight, -1f, layer, -1f);
			Action<float> callback2 = callback;
			if (callback2 == null)
			{
				return;
			}
			callback2(time);
		}, true, false, animationState, false, false);
	}

	// Token: 0x060002A3 RID: 675 RVA: 0x00019F98 File Offset: 0x00018198
	public void StopAnimate(string name, float fadeTime = 0.5f)
	{
		AnimationState animationState = this.m_anim[name];
		float startWeight = animationState.weight;
		Game.AddAnim(0f, fadeTime, delegate(float time)
		{
			this.SetStateWeight(name, Mathf.SmoothStep(startWeight, 0f, time), -1f, -1, -1f);
		}, true, false, animationState, false, false);
	}

	// Token: 0x060002A4 RID: 676 RVA: 0x00019FF4 File Offset: 0x000181F4
	public void SetStateWeight(string name, float weight, float lerpSpeed = -1f, int layer = -1, float lerpSpeedUp = -1f)
	{
		AnimationState animationState = this.m_anim[name];
		if (layer >= 0)
		{
			animationState.layer = layer;
		}
		if (lerpSpeed > 0f)
		{
			if (lerpSpeedUp > 0f)
			{
				if (weight > animationState.weight)
				{
					weight = Mathf.Lerp(animationState.weight, weight, Time.deltaTime * lerpSpeedUp);
				}
				else
				{
					weight = Mathf.Lerp(animationState.weight, weight, Time.deltaTime * lerpSpeed);
				}
			}
			else
			{
				weight = Mathf.Lerp(animationState.weight, weight, Time.deltaTime * lerpSpeed);
			}
		}
		animationState.weight = weight;
	}

	// Token: 0x060002A5 RID: 677 RVA: 0x0001A080 File Offset: 0x00018280
	public AnimationState GetState(string name)
	{
		return this.m_anim[name];
	}

	// Token: 0x060002A6 RID: 678 RVA: 0x0001A090 File Offset: 0x00018290
	public AudioClip GetVoiceLine(params string[] searchTerms)
	{
		List<AudioClip> list = new List<AudioClip>(this.m_voiceLines);
		if (searchTerms.Length != 0)
		{
			list = list.FindAll(delegate(AudioClip clip)
			{
				foreach (string value in searchTerms)
				{
					if (clip.name.Contains(value))
					{
						return true;
					}
				}
				return false;
			});
		}
		if (list.Count > 0)
		{
			return list[UnityEngine.Random.Range(0, list.Count - 1)];
		}
		return null;
	}

	// Token: 0x060002A7 RID: 679 RVA: 0x0001A0F4 File Offset: 0x000182F4
	public Vector2 GetProjectedAngles(Transform hole, Vector3 vector, Vector2 limits)
	{
		Vector3 vector2 = Vector3.ProjectOnPlane(vector, hole.up);
		Vector3 vector3 = Vector3.ProjectOnPlane(vector, -hole.right);
		float num = Vector3.Dot(vector2, -hole.right);
		float num2 = Vector3.Dot(vector3, hole.up);
		float value = Vector3.Angle(vector2, -hole.forward) * (float)((num > 0f) ? 1 : -1);
		float num3 = Vector3.Angle(vector3, -hole.forward) * (float)((num2 > 0f) ? 1 : -1);
		float x = Mathf.Clamp(value, -limits.x, limits.x);
		num3 = Mathf.Clamp(num3, -limits.y, limits.y);
		return new Vector2(x, num3);
	}

	// Token: 0x060002A8 RID: 680 RVA: 0x0001A1A8 File Offset: 0x000183A8
	public void OnTriangleImpact(Fluid fluid, List<string> triggers)
	{
		if (triggers.Contains("L_Eye"))
		{
			if (!this.m_timers.ContainsKey("EyeShot_L"))
			{
				this.m_timers.Add("EyeShot_L", 1f);
				this.EyeShot(true);
			}
			fluid.AddSmear(Game.Instance.m_mascaraSmear.Randomized());
		}
		if (triggers.Contains("R_Eye"))
		{
			if (!this.m_timers.ContainsKey("EyeShot_R"))
			{
				this.m_timers.Add("EyeShot_R", 1f);
				this.EyeShot(false);
			}
			fluid.AddSmear(Game.Instance.m_mascaraSmear.Randomized());
		}
		if (triggers.Contains("Lips") && !this.m_timers.ContainsKey("OpenMouth"))
		{
			this.m_timers.Add("OpenMouth", 10f);
			this.OpenMouth(this.m_openMouthWeight);
		}
		if (triggers.Contains("Head"))
		{
			this.SayGeneric();
		}
	}

	// Token: 0x060002A9 RID: 681 RVA: 0x0001A2A8 File Offset: 0x000184A8
	public void SayGeneric()
	{
		if (!this.m_timers.ContainsKey("Saying"))
		{
			float num = this.m_anim["Face_Demo"].normalizedTime % 1f;
			AudioClip clip = this.GetVoiceLine(new string[]
			{
				"Like"
			});
			if (num >= 0.41f && num < 0.88f)
			{
				clip = this.GetVoiceLine(new string[]
				{
					"Dislike"
				});
			}
			if (clip != null)
			{
				Game.AddAnim(0.5f, delegate()
				{
					this.Say(clip);
				}, true, this.m_face, false);
				this.m_timers.Add("Saying", Mathf.Max(this.m_speakFrequency, clip.length));
			}
		}
	}

	// Token: 0x060002AA RID: 682 RVA: 0x0001A38A File Offset: 0x0001858A
	public void OnPenisMouthOut()
	{
		this.SayGeneric();
	}

	// Token: 0x060002AB RID: 683 RVA: 0x0001A392 File Offset: 0x00018592
	public void SetBodyAnim(int clip)
	{
		this.m_overrideController["Idle"] = Game.Instance.clips[clip];
	}

	// Token: 0x04000263 RID: 611
	public List<AdvancedCollider> m_colliders = new List<AdvancedCollider>();

	// Token: 0x04000264 RID: 612
	public List<SoxAtkJiggleBoneSimple> m_jiggleBones;

	// Token: 0x04000265 RID: 613
	public List<GirlToggle> m_toggles;

	// Token: 0x04000266 RID: 614
	public Rig m_rig;

	// Token: 0x04000267 RID: 615
	public FaceRig m_face;

	// Token: 0x04000268 RID: 616
	public RuntimeAnimatorController m_controller;

	// Token: 0x04000269 RID: 617
	public Animation m_anim;

	// Token: 0x0400026A RID: 618
	public Animator m_animator;

	// Token: 0x0400026B RID: 619
	public AnimatorOverrideController m_overrideController;

	// Token: 0x0400026C RID: 620
	public List<CurvySplineSegment> m_mouth;

	// Token: 0x0400026D RID: 621
	public FullBodyBipedIK m_bipedIK;

	// Token: 0x0400026E RID: 622
	public global::IK m_headIK;

	// Token: 0x0400026F RID: 623
	public global::IK m_lEyeIK;

	// Token: 0x04000270 RID: 624
	public global::IK m_rEyeIK;

	// Token: 0x04000271 RID: 625
	public global::IK m_lHandIK;

	// Token: 0x04000272 RID: 626
	public global::IK m_rHandIK;

	// Token: 0x04000273 RID: 627
	public global::IK m_hipsIK;

	// Token: 0x04000274 RID: 628
	public global::IK m_lFootIK;

	// Token: 0x04000275 RID: 629
	public global::IK m_rFootIK;

	// Token: 0x04000276 RID: 630
	public Transform m_lThighIK;

	// Token: 0x04000277 RID: 631
	public Transform m_rThighIK;

	// Token: 0x04000278 RID: 632
	public FBBIKHeadEffector m_headEffector;

	// Token: 0x04000279 RID: 633
	public float m_hipsWeight = 1f;

	// Token: 0x0400027A RID: 634
	public PuppetMaster m_puppet;

	// Token: 0x0400027B RID: 635
	public Penis m_penis;

	// Token: 0x0400027C RID: 636
	public Rig m_puppetRig;

	// Token: 0x0400027D RID: 637
	public Dictionary<Transform, Muscle> m_muscleDict;

	// Token: 0x0400027E RID: 638
	private List<global::IK> m_bodyIKs;

	// Token: 0x0400027F RID: 639
	private AudioSource m_voiceAS;

	// Token: 0x04000280 RID: 640
	private List<AnimationState> m_visemes;

	// Token: 0x04000281 RID: 641
	private Dictionary<string, OVRLipSyncSequence> m_lipsyncDict;

	// Token: 0x04000282 RID: 642
	private Quaternion m_eyeDownRot;

	// Token: 0x04000283 RID: 643
	public List<RenderMaterial> m_renderMaterials;

	// Token: 0x04000284 RID: 644
	public FluidSmear mascaraSmear;

	// Token: 0x04000285 RID: 645
	public Dictionary<string, float> m_timers;

	// Token: 0x04000286 RID: 646
	public float m_openMouthWeight = 1f;

	// Token: 0x04000287 RID: 647
	public float m_eyeDownWeight = 1f;

	// Token: 0x04000288 RID: 648
	public Vector2 m_mouthLimit = new Vector2(30f, 5f);

	// Token: 0x04000289 RID: 649
	public Vector2 m_mouthLimitFade = new Vector2(0.05f, 0.1f);

	// Token: 0x0400028A RID: 650
	public float m_speakFrequency = 10f;

	// Token: 0x0400028B RID: 651
	public float m_juiceAmount = 100f;

	// Token: 0x0400028C RID: 652
	public float m_hipsSpeed = 0.03f;

	// Token: 0x0400028D RID: 653
	public bool m_updateAnim = true;

	// Token: 0x0400028E RID: 654
	public AudioClip m_music;

	// Token: 0x0400028F RID: 655
	public float m_musicVolume;

	// Token: 0x04000290 RID: 656
	public float m_voiceVolume = 1f;

	// Token: 0x04000291 RID: 657
	public List<AudioClip> m_voiceLines;

	// Token: 0x04000292 RID: 658
	public List<OVRLipSyncSequence> m_lipsyncs;

	// Token: 0x04000293 RID: 659
	public float m_throatDistance = 0.1f;

	// Token: 0x04000294 RID: 660
	private float m_headFreeMin = 20f;

	// Token: 0x04000295 RID: 661
	private float m_headFreeMax = 50f;

	// Token: 0x04000296 RID: 662
	public float m_cheekDistance = 0.05f;

	// Token: 0x04000297 RID: 663
	public float m_mouthLerpSpeed = 5f;

	// Token: 0x04000298 RID: 664
	public float m_maxMouthSize = 0.054f;

	// Token: 0x04000299 RID: 665
	public float m_penisRotSpd = 7f;

	// Token: 0x0400029A RID: 666
	public float m_penisAimSpd = 3f;

	// Token: 0x0400029B RID: 667
	public float m_autoSpeed;

	// Token: 0x0400029C RID: 668
	public float m_autoDepth = 1f;

	// Token: 0x0400029D RID: 669
	public float m_autoTime;

	// Token: 0x0400029E RID: 670
	public bool m_autoInPhase = true;

	// Token: 0x0400029F RID: 671
	public bool m_headLock;

	// Token: 0x040002A0 RID: 672
	public bool m_hipsLock;

	// Token: 0x040002A1 RID: 673
	private float m_mouthEnterTime;

	// Token: 0x040002A2 RID: 674
	private bool m_deepthroated;

	// Token: 0x040002A3 RID: 675
	public SkinnedMeshRenderer m_convertRenderer;

	// Token: 0x040002A4 RID: 676
	public bool m_convertSkin;

	// Token: 0x040002A9 RID: 681
	public float m_mouthSqueezeDist = 0.08f;

	// Token: 0x040002AA RID: 682
	public float m_mouthSqueeze = 0.85f;

	// Token: 0x040002AB RID: 683
	public float m_mouthSlide;

	// Token: 0x040002AC RID: 684
	public Vector2 m_hackHeadLimit = new Vector2(0.3f, 0.3f);
}

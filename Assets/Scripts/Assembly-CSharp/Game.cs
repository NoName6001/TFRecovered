using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using MoonSharp.Interpreter;
using RootMotion.Dynamics;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

// Token: 0x0200004C RID: 76
[MoonSharpUserData]
public class Game : MonoBehaviour
{
	// Token: 0x06000262 RID: 610 RVA: 0x000151C0 File Offset: 0x000133C0
	private void Awake()
	{
		Game.Instance = this;
		Application.targetFrameRate = 60;
		Shader.SetGlobalFloat(Shader.PropertyToID("TessellationQuality"), 1f);
		Game.s_sceneId = SceneManager.GetActiveScene().buildIndex;
		if (!Application.isEditor && Game.s_girlId == -1)
		{
			Game.s_girlId = 0;
		}
		if (this.m_girl == null && Game.s_girlId == -1)
		{
			Game.s_girlId = 0;
		}
		if (Game.s_girlId >= 0)
		{
			if (this.m_girl != null)
			{
				Destroy(this.m_girl.gameObject);
			}
			this.m_girl = Instantiate<GameObject>(Resources.Load<GameObject>("Girls/" + this.m_girls[Game.s_girlId])).GetComponent<Girl>();
			this.m_girl.transform.position = Vector3.zero;
			this.m_girl.transform.localEulerAngles = new Vector3(0f, -180f, 0f);
		}
		this.m_girl.m_headIK.m_yLimit = this.m_girl.m_hackHeadLimit;
		if (!Application.isEditor && this.m_male != null)
		{
			DestroyImmediate(this.m_male.gameObject);
		}
		if (this.m_male == null)
		{
			this.m_male = Instantiate<GameObject>(Resources.Load<GameObject>("Male")).GetComponent<Girl>();
			this.m_male.transform.position = new Vector3(0f, 0f, -0.347f);
			this.m_male.transform.localEulerAngles = Vector3.zero;
		}
		this.m_collidersDict = new Dictionary<Collider, AdvancedCollider>();
		this.m_humans = new List<Girl>
		{
			this.m_girl,
			this.m_male
		};
		foreach (Girl girl in this.m_humans)
		{
			girl.Init();
		}
		this.m_girl.SetBodyAnim(0);
		this.m_male.SetBodyAnim(1);
		this.m_girl.m_hipsWeight = 0f;
		this.m_girl.m_lHandIK.AttachToPoint(this.m_male.m_rig.rThighGrab);
		this.m_girl.m_rHandIK.AttachToPoint(this.m_male.m_rig.lThighGrab);
		this.m_male.m_lHandIK.AttachToPoint(this.m_male.m_rig.lPelvisHandPos);
		this.m_male.m_rHandIK.AttachToPoint(this.m_male.m_rig.rPelvisHandPos);
		Lua.Init();
		this.m_consoleIF.gameObject.SetActive(false);
		this.m_fluidPool = new List<Fluid>();
		this.m_uvFluidPool = new List<Fluid_UV>();
		for (int i = 0; i < this.m_fluidMax; i++)
		{
			Fluid component = ((GameObject)Instantiate(Resources.Load("Prefab_Fluid"))).GetComponent<Fluid>();
			component.m_transform = component.transform;
			component.name = "Fluid_" + i;
			component.Pool();
			this.m_fluidPool.Add(component);
			Fluid_UV component2 = ((GameObject)Instantiate(Resources.Load("Prefab_Fluid_UV"), this.m_uvCamera.transform)).GetComponent<Fluid_UV>();
			component2.transform.position = new Vector3(0f, 0f, -10f);
			this.m_uvFluidPool.Add(component2);
		}
		for (int j = 0; j < this.m_fStringMax; j++)
		{
			FluidString component3 = ((GameObject)Instantiate(Resources.Load("FluidString"))).GetComponent<FluidString>();
			component3.name = "FluidString_" + j;
			component3.Init(Vector3.zero, new Vector3(0f, 0f, 0.5f), new Vector3(0f, 0f, 0.1f), 0.1f, 0f, -1f);
			component3.Pool();
			this.m_fStringPool.Add(component3);
		}
		this.m_uvCamera.enabled = false;
		this.m_uvCamera.clearFlags = CameraClearFlags.Nothing;
		this.m_hasUVFluid = new bool[Game.m_uvTextureRows * Game.m_uvTextureRows];
		this.m_renderMats = new Dictionary<Material, RenderMaterial>();
		List<RenderMaterial> list = new List<RenderMaterial>();
		foreach (Girl girl2 in this.m_humans)
		{
			list.AddRange(girl2.m_renderMaterials);
		}
		for (int k = 0; k < list.Count; k++)
		{
			RenderMaterial renderMaterial = list[k];
			renderMaterial.Init();
			this.m_renderMats.Add(renderMaterial.material, renderMaterial);
		}
		this.m_depthTexture = new RenderTexture(this.renderTextureSize, this.renderTextureSize, 16, RenderTextureFormat.Depth);
		this.m_depthTexture.Create();
		this.m_camera.Init();
		this.m_aimPoint = this.m_male.m_rig.penisTip.position;
		this.m_notes.gameObject.SetActive(false);
		this.m_notes.color = new Color(1f, 1f, 1f, 0f);
		this.m_male.m_autoSpeed = this.m_autoSettings[0].x;
		this.m_male.m_autoDepth = this.m_autoSettings[0].y;
		this.m_girl.m_autoSpeed = this.m_autoSettings[0].x;
		this.m_girl.m_autoDepth = this.m_autoSettings[0].y;
		this.blackscreen.Play("Blackscreen_FadeOut");
		Game.AddAnim(1.1f, delegate()
		{
			this.m_girl.Say(new string[]
			{
				"Greeting"
			});
		}, true, null, false);
		this.UpdateShotPreset();
	}

	// Token: 0x06000263 RID: 611 RVA: 0x000157F0 File Offset: 0x000139F0
	private void Update()
	{
		float deltaTime = Time.deltaTime;
		List<GirlToggle> toggles = this.m_girl.m_toggles;
		if (Input.GetKeyUp(KeyCode.Alpha1) && toggles.Count > 0 && toggles[0] != null)
		{
			toggles[0].Toggle();
		}
		if (Input.GetKeyUp(KeyCode.Alpha2) && toggles.Count > 1 && toggles[1] != null)
		{
			toggles[1].Toggle();
		}
		if (Input.GetKeyUp(KeyCode.Alpha3) && toggles.Count > 2 && toggles[2] != null)
		{
			toggles[2].Toggle();
		}
		if (Input.GetKeyUp(KeyCode.Alpha4) && toggles.Count > 3 && toggles[3] != null)
		{
			toggles[3].Toggle();
		}
		if (Input.GetKeyDown(KeyCode.U))
		{
			if (this.m_male.m_rHandIK.AttachPoint != this.m_girl.m_rig.lHeadGrab)
			{
				this.m_male.m_rHandIK.AttachToPoint(this.m_girl.m_rig.lHeadGrab);
			}
			else
			{
				this.m_male.m_rHandIK.AttachToPoint(this.m_male.m_rig.rPelvisHandPos);
			}
		}
		if (Input.GetKeyDown(KeyCode.I))
		{
			if (this.m_male.m_lHandIK.AttachPoint != this.m_girl.m_rig.rHeadGrab)
			{
				this.m_male.m_lHandIK.AttachToPoint(this.m_girl.m_rig.rHeadGrab);
			}
			else
			{
				this.m_male.m_lHandIK.AttachToPoint(this.m_male.m_rig.lPelvisHandPos);
			}
		}
		if (Input.GetKeyDown(KeyCode.O))
		{
			if (this.m_girl.m_rHandIK.AttachPoint != this.m_male.m_rig.lThighGrab)
			{
				this.m_girl.m_rHandIK.AttachToPoint(this.m_male.m_rig.lThighGrab);
			}
			else
			{
				this.m_girl.m_rHandIK.AttachToPoint(this.m_girl.m_rig.rThighHandRest);
			}
		}
		if (Input.GetKeyDown(KeyCode.P))
		{
			if (this.m_girl.m_lHandIK.AttachPoint != this.m_male.m_rig.rThighGrab)
			{
				this.m_girl.m_lHandIK.AttachToPoint(this.m_male.m_rig.rThighGrab);
			}
			else
			{
				this.m_girl.m_lHandIK.AttachToPoint(this.m_girl.m_rig.lThighHandRest);
			}
		}
		if (Vector3.Dot(this.m_girl.transform.forward, this.m_male.transform.forward) > -0.7f)
		{
			if (this.m_girl.m_rHandIK.AttachPoint == this.m_male.m_rig.lThighGrab)
			{
				this.m_girl.m_rHandIK.AttachToPoint(this.m_girl.m_rig.rThighHandRest);
			}
			if (this.m_girl.m_lHandIK.AttachPoint == this.m_male.m_rig.rThighGrab)
			{
				this.m_girl.m_lHandIK.AttachToPoint(this.m_girl.m_rig.lThighHandRest);
			}
		}
		if (Vector3.Dot(this.m_girl.transform.forward, this.m_male.transform.forward) > -0.15f)
		{
			if (this.m_male.m_rHandIK.AttachPoint == this.m_girl.m_rig.lHeadGrab)
			{
				this.m_male.m_rHandIK.AttachToPoint(this.m_male.m_rig.rPelvisHandPos);
			}
			if (this.m_male.m_lHandIK.AttachPoint == this.m_girl.m_rig.rHeadGrab)
			{
				this.m_male.m_lHandIK.AttachToPoint(this.m_male.m_rig.lPelvisHandPos);
			}
		}
		if (Input.GetKeyDown(KeyCode.M))
		{
			this.m_musicAS.mute = !this.m_musicAS.mute;
		}
		Vector3 mousePosition = Input.mousePosition;
		float num = Input.GetAxis("Mouse X");
		float num2 = Input.GetAxis("Mouse Y");
		if (Input.GetButtonDown("RIGHT_MOUSE") || Input.GetButton("RIGHT_MOUSE"))
		{
			if (Input.GetButtonDown("RIGHT_MOUSE"))
			{
				num2 = (num = 0f);
				Game.RemoveAnim(this.m_camera, false);
			}
			this.m_camera.Aim(num, -num2);
			bool flag = false;
			RaycastHit raycastHit;
			if (Physics.Raycast(this.m_camera.Ray, out raycastHit, 10f, LayerMask.GetMask(new string[]
			{
				"Default"
			})))
			{
				if (raycastHit.collider.tag == "AdvancedCollider")
				{
					this.m_aimPoint = raycastHit.point;
					if (this.m_collidersDict[raycastHit.collider].m_girl != this.m_male)
					{
						flag = true;
					}
				}
			}
			else
			{
				float d = Vector3.Distance(this.m_aimPoint, this.m_camera.transform.position);
				this.m_aimPoint = this.m_camera.transform.position + this.m_camera.transform.forward * d;
			}
			this.m_camera.SetAimPoint(this.m_aimPoint);
			if (this.m_male.FreePenis)
			{
				Vector3 point = this.m_aimPoint;
				if (!flag)
				{
					float d2 = Vector3.Distance(this.m_male.m_rig.penisTip.position, this.m_camera.transform.position);
					point = this.m_camera.transform.position + this.m_camera.transform.forward * d2;
				}
				this.m_male.AimPenis(point);
			}
			if (Input.GetButtonDown("LEFT_MOUSE") && this.m_male.CanShoot)
			{
				this.m_male.Shoot();
			}
		}
		else if (Input.GetButtonUp("RIGHT_MOUSE"))
		{
			if (this.m_male.IsPenisControlled)
			{
				this.m_male.StopPenisMove();
			}
			this.m_isDragging = false;
		}
		else
		{
			if (Input.GetButtonDown("LEFT_MOUSE"))
			{
				this.m_startMousePos = mousePosition;
				RaycastHit hit;
				if (Physics.Raycast(this.m_camera.MouseRay, out hit, 10f, LayerMask.GetMask(new string[]
				{
					"Default",
					"Penis"
				})) && hit.collider.tag == "AdvancedCollider")
				{
					this.m_collider = this.m_collidersDict[hit.collider];
					this.m_triggers = this.m_collider.GetTriangleTriggers(hit);
				}
				Game.RemoveAnim(this.m_camera, false);
				this.m_isDragging = false;
			}
			if (Input.GetButton("LEFT_MOUSE"))
			{
				if ((mousePosition - this.m_startMousePos).magnitude >= (float)Screen.height * 0.01f)
				{
					this.m_isDragging = true;
				}
				if (this.m_isDragging)
				{
					Vector3 v = new Vector3(num, num2, 0f);
					bool flag2 = true;
					if (this.m_collider != null && !this.m_pause)
					{
						if (this.m_triggers.Contains("Face"))
						{
							flag2 = false;
							this.m_girl.RotateHead(v);
						}
						else if (this.m_triggers.Contains("Head"))
						{
							flag2 = false;
							this.m_girl.MoveHead(v);
						}
						else if (this.m_triggers.Contains("Penis"))
						{
							flag2 = false;
							this.m_male.ThrustPenis(v);
						}
						else if (this.m_triggers.Contains("Hips"))
						{
							flag2 = false;
							this.m_male.MoveHips(v);
						}
						else if (this.m_triggers.Contains("Chest"))
						{
							flag2 = false;
							this.m_girl.transform.Rotate(Vector3.up, -num);
						}
					}
					if (flag2)
					{
						this.m_camera.RotateAroundTarget(num, -num2);
					}
				}
			}
			if (Input.GetButtonUp("LEFT_MOUSE"))
			{
				if (!this.m_isDragging)
				{
					if (this.m_male.CanShoot)
					{
						this.m_male.Shoot();
					}
				}
				else
				{
					if (this.m_male.IsPenisControlled)
					{
						this.m_male.StopPenisMove();
					}
					if (this.m_triggers.Contains("Hips"))
					{
						this.m_male.StopHips();
					}
					if (this.m_triggers.Contains("Head") || this.m_triggers.Contains("Face"))
					{
						this.m_girl.StopHead();
					}
				}
				this.m_collider = null;
				this.m_triggers = new List<string>();
				this.m_isDragging = false;
			}
		}
		if (Input.GetButtonDown("MIDDLE_MOUSE"))
		{
			this.m_shotPresetId = ((this.m_shotPresetId == this.m_shotPresets.Count - 1) ? 0 : (this.m_shotPresetId + 1));
			this.UpdateShotPreset();
			this.ShowNote("Shot type " + this.m_shotPresetId);
		}
		float axis = Input.GetAxis("Mouse ScrollWheel");
		if (axis == 0f)
		{
			axis = Input.GetAxis("Zoom");
		}
		if (axis != 0f)
		{
			this.m_camera.MouseScroll(axis);
		}
		this.m_camera.UpdateCamera(deltaTime);
		if (this.m_pause)
		{
			return;
		}
		this.UpdateAnimationSystem();
		foreach (Girl girl in this.m_humans)
		{
			girl.UpdateGirl(deltaTime);
		}
		foreach (Girl girl2 in this.m_humans)
		{
			girl2.LateUpdateGirl(deltaTime);
		}
		foreach (Girl girl3 in this.m_humans)
		{
			girl3.UpdateAdvancedColliders(deltaTime);
		}
		foreach (Girl girl4 in this.m_humans)
		{
			girl4.UpdateSkinWrapWetness(deltaTime);
		}
		for (int i = this.m_fluidStrings.Count - 1; i >= 0; i--)
		{
			FluidString fluidString = this.m_fluidStrings[i];
			if (fluidString.UpdateFluidString(deltaTime))
			{
				fluidString.Pool();
				this.m_fStringPool.Add(fluidString);
				this.m_fluidStrings.RemoveAt(i);
			}
		}
		for (int j = this.m_fluids.Count - 1; j >= 0; j--)
		{
			if (this.m_fluids[j].UpdateFluid(deltaTime))
			{
				this.RemoveFluid(j);
			}
		}
		foreach (RenderMaterial renderMaterial in this.m_renderMats.Values)
		{
			renderMaterial.AddTextureToStack(this.m_uvRenderStack);
		}
		if (this.m_uvRenderStack.Count > 0)
		{
			int num3 = 0;
			while (this.m_uvRenderStack.Count > 0 && num3 < 3)
			{
				this.m_uvRenderStack[0].Render(this.m_uvCamera);
				this.m_uvRenderStack.RemoveAt(0);
				num3++;
			}
		}
		if (Input.GetKeyUp(KeyCode.LeftShift))
		{
			this.blackscreen.Play("Blackscreen_FadeIn");
			Game.AddAnim(1f, delegate()
			{
				Game.s_sceneId = ((Game.s_sceneId >= 1) ? 0 : (Game.s_sceneId + 1));
				if (Game.s_girlId == -1)
				{
					Game.s_girlId = 0;
				}
				SceneManager.LoadScene(Game.s_sceneId);
			}, true, null, false);
		}
		if (Input.GetKeyUp(KeyCode.Tab))
		{
			Game.s_girlId = ((Game.s_girlId >= this.m_girls.Count - 1) ? 0 : (Game.s_girlId + 1));
			this.g__changeGirl();
		}
		if (Input.GetKeyDown(KeyCode.F1))
		{
			Game.s_girlId = 0;
			this.g__changeGirl();
		}
		if (Input.GetKeyDown(KeyCode.F2))
		{
			Game.s_girlId = 1;
			this.g__changeGirl();
		}
		if (Input.GetKeyDown(KeyCode.F3))
		{
			Game.s_girlId = 2;
			this.g__changeGirl();
		}
		if (Input.GetKeyDown(KeyCode.F4))
		{
			Game.s_girlId = 3;
			this.g__changeGirl();
		}
		if (Input.GetKeyDown(KeyCode.F5))
		{
			Game.s_girlId = 4;
			this.g__changeGirl();
		}
		if (Input.GetKeyDown(KeyCode.F6))
		{
			Game.s_girlId = 5;
			this.g__changeGirl();
		}
		if (Input.GetKeyDown(KeyCode.F7))
		{
			Game.s_girlId = 6;
			this.g__changeGirl();
		}
		if (Input.GetKeyDown(KeyCode.F8))
		{
			Game.s_girlId = 7;
			this.g__changeGirl();
		}
		if (Input.GetKeyDown(KeyCode.A))
		{
			this.m_male.ToggleMaleBody();
		}
		if (Input.GetKeyDown(KeyCode.Q))
		{
			int num4 = this.m_autoSettings.IndexOf(new Vector2(this.m_male.m_autoSpeed, this.m_male.m_autoDepth));
			num4 = Mathf.Max(0, num4 - 1);
			this.m_male.m_autoSpeed = this.m_autoSettings[num4].x;
			this.m_male.m_autoDepth = this.m_autoSettings[num4].y;
			if (this.m_girl.m_autoSpeed > 0f)
			{
				this.m_male.StopHips();
			}
			this.m_girl.m_autoSpeed = this.m_autoSettings[0].x;
			this.m_girl.m_autoDepth = this.m_autoSettings[0].y;
		}
		if (Input.GetKeyDown(KeyCode.W))
		{
			int num5 = this.m_autoSettings.IndexOf(new Vector2(this.m_male.m_autoSpeed, this.m_male.m_autoDepth));
			num5 = Mathf.Min(this.m_autoSettings.Count - 1, num5 + 1);
			this.m_male.m_autoSpeed = this.m_autoSettings[num5].x;
			this.m_male.m_autoDepth = this.m_autoSettings[num5].y;
			if (this.m_girl.m_autoSpeed > 0f)
			{
				this.m_male.StopHips();
			}
			this.m_girl.m_autoSpeed = this.m_autoSettings[0].x;
			this.m_girl.m_autoDepth = this.m_autoSettings[0].y;
		}
		if (Input.GetKeyDown(KeyCode.E))
		{
			int num6 = this.m_autoSettings.IndexOf(new Vector2(this.m_girl.m_autoSpeed, this.m_girl.m_autoDepth));
			num6 = Mathf.Max(0, num6 - 1);
			this.m_girl.m_autoSpeed = this.m_autoSettings[num6].x;
			this.m_girl.m_autoDepth = this.m_autoSettings[num6].y;
			if (this.m_male.m_autoSpeed > 0f)
			{
				this.m_girl.StopHead();
			}
			this.m_male.m_autoSpeed = this.m_autoSettings[0].x;
			this.m_male.m_autoDepth = this.m_autoSettings[0].y;
		}
		if (Input.GetKeyDown(KeyCode.R))
		{
			int num7 = this.m_autoSettings.IndexOf(new Vector2(this.m_girl.m_autoSpeed, this.m_girl.m_autoDepth));
			num7 = Mathf.Min(this.m_autoSettings.Count - 1, num7 + 1);
			this.m_girl.m_autoSpeed = this.m_autoSettings[num7].x;
			this.m_girl.m_autoDepth = this.m_autoSettings[num7].y;
			if (this.m_male.m_autoSpeed > 0f)
			{
				this.m_girl.StopHead();
			}
			this.m_male.m_autoSpeed = this.m_autoSettings[0].x;
			this.m_male.m_autoDepth = this.m_autoSettings[0].y;
		}
		if (Input.GetKeyDown(KeyCode.Space))
		{
			this.m_instruction.SetActive(!this.m_instruction.activeSelf);
		}
		if (Input.GetKeyDown(KeyCode.Escape))
		{
			Application.Quit();
		}
	}

	// Token: 0x06000264 RID: 612 RVA: 0x0001688C File Offset: 0x00014A8C
	public void FixedUpdate()
	{
		foreach (Girl girl in this.m_humans)
		{
			if (!girl.m_puppet.enabled)
			{
				girl.m_puppet.FixedUpdate();
			}
		}
	}

	// Token: 0x06000265 RID: 613 RVA: 0x000168F0 File Offset: 0x00014AF0
	public RenderMaterial GetRenderMaterial(Material mat)
	{
		if (mat == null)
		{
			return null;
		}
		RenderMaterial result;
		if (this.m_renderMats.TryGetValue(mat, out result))
		{
			return result;
		}
		return null;
	}

	// Token: 0x06000266 RID: 614 RVA: 0x0001691C File Offset: 0x00014B1C
	public Fluid AddFluid(Vector3 position)
	{
		if (this.m_fluidPool.Count == 0)
		{
			return null;
		}
		int index = this.m_fluidPool.Count - 1;
		Fluid fluid = this.m_fluidPool[index];
		fluid.Init(position);
		this.m_fluidPool.RemoveAt(index);
		this.m_fluids.Add(fluid);
		return fluid;
	}

	// Token: 0x06000267 RID: 615 RVA: 0x00016973 File Offset: 0x00014B73
	public void RemoveFluid(Fluid fluid)
	{
		this.RemoveFluid(this.m_fluids.IndexOf(fluid));
	}

	// Token: 0x06000268 RID: 616 RVA: 0x00016988 File Offset: 0x00014B88
	public void RemoveFluid(int id)
	{
		Fluid fluid = this.m_fluids[id];
		this.m_fluids.RemoveAt(id);
		fluid.Pool();
		this.m_fluidPool.Add(fluid);
	}

	// Token: 0x06000269 RID: 617 RVA: 0x000169C0 File Offset: 0x00014BC0
	public FluidString AddFluidString(Vector3 startPos, Vector3 midPos, Vector3 endPos, float length = 0.1f, bool fillWithFluids = false, float breakLength = -1f)
	{
		if (this.m_fStringPool.Count == 0)
		{
			return null;
		}
		int index = this.m_fStringPool.Count - 1;
		FluidString fluidString = this.m_fStringPool[index];
		fluidString.Init(startPos, midPos, endPos, length, 0f, breakLength);
		this.m_fStringPool.RemoveAt(index);
		this.m_fluidStrings.Add(fluidString);
		if (fillWithFluids)
		{
			int num = FluidString.LengthToSegmentCount(length);
			for (float num2 = 0f; num2 < (float)num; num2 += 1f)
			{
				float tf = num2 / (float)(num - 1);
				fluidString.AddFluidToString(tf, null);
			}
		}
		return fluidString;
	}

	// Token: 0x0600026A RID: 618 RVA: 0x00016A54 File Offset: 0x00014C54
	public bool CanAddFluidString(float length)
	{
		return this.m_fStringPool.Count > 0 && this.m_fluidPool.Count > FluidString.LengthToSegmentCount(length);
	}

	// Token: 0x0600026B RID: 619 RVA: 0x00016A7C File Offset: 0x00014C7C
	public void UpdateAnimationSystem()
	{
		for (int i = 0; i < this.m_animList.Count; i++)
		{
			AnimationStep animationStep = this.m_animList[i];
			if (animationStep.m_delayTimer < animationStep.m_delay)
			{
				animationStep.m_delayTimer += Time.deltaTime;
			}
			else
			{
				if (animationStep.m_durationTimer == 0f && animationStep.m_update != null)
				{
					animationStep.m_update(0f);
				}
				float num = Time.deltaTime;
				if (animationStep.m_constantFPS)
				{
					float num2 = (float)Application.targetFrameRate;
					if (num > num2)
					{
						num = num2;
					}
				}
				animationStep.m_durationTimer += num;
				float num3 = (animationStep.m_duration <= 0.01f) ? 1f : (animationStep.m_durationTimer / animationStep.m_duration);
				if (!animationStep.m_overShoot)
				{
					num3 = Mathf.Clamp01(num3);
				}
				if (animationStep.m_action != null)
				{
					animationStep.m_action();
					animationStep.m_action = null;
				}
				Action<float> update = animationStep.m_update;
				if (update != null)
				{
					update(num3);
				}
			}
		}
		for (int j = this.m_animList.Count - 1; j >= 0; j--)
		{
			AnimationStep animationStep2 = this.m_animList[j];
			if (animationStep2.m_delayTimer >= animationStep2.m_delay && animationStep2.m_durationTimer >= animationStep2.m_duration)
			{
				this.m_animList.RemoveAt(j);
			}
		}
	}

	// Token: 0x0600026C RID: 620 RVA: 0x00016BE0 File Offset: 0x00014DE0
	public void ShowNote(string note)
	{
		this.m_notes.gameObject.SetActive(true);
		this.m_notes.text = note;
		float startAlpha = this.m_notes.color.a;
		Game.AddAnim(0f, 2f, delegate(float time)
		{
			float a = 1f;
			if (time <= 0.25f)
			{
				a = Mathf.Lerp(startAlpha, 1f, Mathf.InverseLerp(0f, 0.25f, time));
			}
			else if (time > 0.75f)
			{
				a = Mathf.InverseLerp(1f, 0.75f, time);
			}
			this.m_notes.color = new Color(1f, 1f, 1f, a);
			if (time == 1f)
			{
				this.m_notes.gameObject.SetActive(false);
			}
		}, true, false, this.m_notes, false, false);
	}

	// Token: 0x0600026D RID: 621 RVA: 0x00016C54 File Offset: 0x00014E54
	public static AnimationStep AddAnim(float delay, float duration, Action<float> update, bool isLogic = true, bool overShoot = false, object identifier = null, bool constantFPS = false, bool finishFirst = false)
	{
		return Game.AddAnimationStep(delay, duration, isLogic, null, update, overShoot, identifier, constantFPS, finishFirst);
	}

	// Token: 0x0600026E RID: 622 RVA: 0x00016C74 File Offset: 0x00014E74
	public static AnimationStep AddAnim(float delay, Action action, bool isLogic = true, object identifier = null, bool finishFirst = false)
	{
		return Game.AddAnimationStep(delay, 0.1f, isLogic, action, null, false, identifier, finishFirst, false);
	}

	// Token: 0x0600026F RID: 623 RVA: 0x00016C94 File Offset: 0x00014E94
	public static AnimationStep AddAnimationStep(float delay, float duration, bool isLogic, Action action, Action<float> update, bool overShoot, object identifier = null, bool constantFPS = false, bool finishFirst = false)
	{
		AnimationStep animationStep = new AnimationStep(delay, duration, isLogic, action, update, overShoot, identifier, constantFPS);
		Game.RemoveAnim(identifier, finishFirst);
		Game.Instance.m_animList.Add(animationStep);
		return animationStep;
	}

	// Token: 0x06000270 RID: 624 RVA: 0x00016CD0 File Offset: 0x00014ED0
	public static void RemoveAnim(object identifier, bool finishFirst = false)
	{
		for (int i = Game.Instance.m_animList.Count - 1; i >= 0; i--)
		{
			AnimationStep animationStep = Game.Instance.m_animList[i];
			if (animationStep.m_identifier == identifier)
			{
				if (finishFirst)
				{
					Action action = animationStep.m_action;
					if (action != null)
					{
						action();
					}
					Action<float> update = animationStep.m_update;
					if (update != null)
					{
						update(1f);
					}
				}
				Game.Instance.m_animList.RemoveAt(i);
				return;
			}
		}
	}

	// Token: 0x06000271 RID: 625 RVA: 0x00016D50 File Offset: 0x00014F50
	public void UpdateShotPreset()
	{
		this.m_male.m_penis.m_emitRange = new Vector2(Mathf.Max(0f, this.m_shotPresets[this.m_shotPresetId][0] - 0.1f), Mathf.Max(0f, this.m_shotPresets[this.m_shotPresetId][0] + 0.1f));
		this.m_male.m_penis.m_forceRange = new Vector2(Mathf.Max(0f, this.m_shotPresets[this.m_shotPresetId][1] - 10f), Mathf.Max(0f, this.m_shotPresets[this.m_shotPresetId][1] + 10f));
		this.m_male.m_penis.m_slideSpdRange = new Vector2(Mathf.Max(0f, this.m_shotPresets[this.m_shotPresetId][2] - 0.002f), Mathf.Max(0f, this.m_shotPresets[this.m_shotPresetId][2] + 0.002f));
		this.m_male.m_penis.m_maxRdmAngle = Mathf.Max(0f, this.m_shotPresets[this.m_shotPresetId][3]);
	}

	// Token: 0x06000275 RID: 629 RVA: 0x0001712A File Offset: 0x0001532A
	[CompilerGenerated]
	private void g__changeGirl()
	{
		this.blackscreen.Play("Blackscreen_FadeIn");
		Game.AddAnim(1f, delegate()
		{
			if (Game.s_sceneId == -1)
			{
				Game.s_sceneId = 0;
			}
			SceneManager.LoadScene(Game.s_sceneId);
		}, true, null, false);
	}

	// Token: 0x0400021E RID: 542
	public static Game Instance;

	// Token: 0x0400021F RID: 543
	public static int s_girlId = -1;

	// Token: 0x04000220 RID: 544
	public static int s_sceneId = -1;

	// Token: 0x04000221 RID: 545
	public static int s_poseId = 0;

	// Token: 0x04000222 RID: 546
	public List<string> m_girls;

	// Token: 0x04000223 RID: 547
	public Girl m_girl;

	// Token: 0x04000224 RID: 548
	public Girl m_male;

	// Token: 0x04000225 RID: 549
	public List<Girl> m_humans;

	// Token: 0x04000226 RID: 550
	public Dictionary<Transform, Muscle> m_attachDict = new Dictionary<Transform, Muscle>();

	// Token: 0x04000227 RID: 551
	public MainCamera m_camera;

	// Token: 0x04000228 RID: 552
	public AdvancedCollider m_collider;

	// Token: 0x04000229 RID: 553
	public List<string> m_triggers;

	// Token: 0x0400022A RID: 554
	public SoxAtkJiggleBoneSimple m_jiggleControl;

	// Token: 0x0400022B RID: 555
	public bool m_isDragging;

	// Token: 0x0400022C RID: 556
	public float m_clickTimer;

	// Token: 0x0400022D RID: 557
	public Vector3 m_aimPoint = Vector3.zero;

	// Token: 0x0400022E RID: 558
	private Vector3 m_startMousePos = Vector3.zero;

	// Token: 0x0400022F RID: 559
	public Camera m_uvCamera;

	// Token: 0x04000230 RID: 560
	public List<RenderMatTexture> m_uvRenderStack = new List<RenderMatTexture>();

	// Token: 0x04000231 RID: 561
	public Dictionary<Material, RenderMaterial> m_renderMats;

	// Token: 0x04000232 RID: 562
	public Dictionary<Collider, AdvancedCollider> m_collidersDict;

	// Token: 0x04000233 RID: 563
	public Dictionary<Collider, Girl> m_ragdollsDict;

	// Token: 0x04000234 RID: 564
	public RenderTexture m_depthTexture;

	// Token: 0x04000235 RID: 565
	public Animation blackscreen;

	// Token: 0x04000236 RID: 566
	public List<Material> m_materials;

	// Token: 0x04000237 RID: 567
	public List<AnimationClip> clips;

	// Token: 0x04000238 RID: 568
	public List<AudioClip> m_swallowSounds;

	// Token: 0x04000239 RID: 569
	public Mesh m_gizmoMesh;

	// Token: 0x0400023A RID: 570
	private List<AnimationStep> m_animList = new List<AnimationStep>();

	// Token: 0x0400023B RID: 571
	public List<Fluid> m_fluids = new List<Fluid>();

	// Token: 0x0400023C RID: 572
	public List<Fluid> m_fluidPool = new List<Fluid>();

	// Token: 0x0400023D RID: 573
	public List<FluidString> m_fluidStrings = new List<FluidString>();

	// Token: 0x0400023E RID: 574
	public List<FluidString> m_fStringPool = new List<FluidString>();

	// Token: 0x0400023F RID: 575
	public List<Fluid_UV> m_uvFluidPool = new List<Fluid_UV>();

	// Token: 0x04000240 RID: 576
	public FluidSmear m_mascaraSmear;

	// Token: 0x04000241 RID: 577
	[NonSerialized]
	public bool[] m_hasUVFluid;

	// Token: 0x04000242 RID: 578
	public static int m_uvTextureRows = 2048;

	// Token: 0x04000243 RID: 579
	public InputField m_consoleIF;

	// Token: 0x04000244 RID: 580
	public AudioSource m_musicAS;

	// Token: 0x04000245 RID: 581
	public GameObject m_instruction;

	// Token: 0x04000246 RID: 582
	public TextMeshPro m_notes;

	// Token: 0x04000247 RID: 583
	public Material defaultParticleUV;

	// Token: 0x04000248 RID: 584
	public int renderTextureSize = 1024;

	// Token: 0x04000249 RID: 585
	public int m_fluidMax = 5000;

	// Token: 0x0400024A RID: 586
	public int m_fStringMax = 100;

	// Token: 0x0400024B RID: 587
	public float fluidSeparation = 0.001f;

	// Token: 0x0400024C RID: 588
	public float fluidDestroyTime = 20f;

	// Token: 0x0400024D RID: 589
	public float fluidUVTime = 0.1f;

	// Token: 0x0400024E RID: 590
	public bool fluidSpheres = true;

	// Token: 0x0400024F RID: 591
	public static float m_controlResetTime = 120f;

	// Token: 0x04000250 RID: 592
	public int m_fluidRenderTextureSize = -1;

	// Token: 0x04000251 RID: 593
	public float m_mouthWetRadius = 0.0088f;

	// Token: 0x04000252 RID: 594
	public float m_stringMinLength = 0.03f;

	// Token: 0x04000253 RID: 595
	public float m_stringEndIgnore = 0.02f;

	// Token: 0x04000254 RID: 596
	public bool clearUV = true;

	// Token: 0x04000255 RID: 597
	public bool m_pause;

	// Token: 0x04000256 RID: 598
	private List<Vector2> m_autoSettings = new List<Vector2>
	{
		new Vector2(0f, 0f),
		new Vector2(0.65f, 0.8f),
		new Vector2(1f, 1f),
		new Vector2(1.5f, 1.1f),
		new Vector2(2f, 1.2f),
		new Vector2(3f, 1.3f)
	};

	// Token: 0x04000257 RID: 599
	public List<List<float>> m_shotPresets = new List<List<float>>
	{
		new List<float>
		{
			0.5f,
			50f,
			0.004f,
			4f
		},
		new List<float>
		{
			0.9f,
			40f,
			0.008f,
			10f
		},
		new List<float>
		{
			0.6f,
			60f,
			0.02f,
			5f
		}
	};

	// Token: 0x04000258 RID: 600
	public int m_shotPresetId;
}

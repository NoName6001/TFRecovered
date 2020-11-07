using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using MoonSharp.Interpreter;
using RootMotion;
using RootMotion.Dynamics;
using UnityEngine;

// Token: 0x02000053 RID: 83
[ExecuteInEditMode]
[MoonSharpUserData]
public class Rig : MonoBehaviour
{
	// Token: 0x17000054 RID: 84
	// (get) Token: 0x060002E5 RID: 741 RVA: 0x0001D077 File Offset: 0x0001B277
	public Transform Mouth
	{
		get
		{
			if (this.mouth.Count <= 0)
			{
				return null;
			}
			return this.mouth[0];
		}
	}

	// Token: 0x17000055 RID: 85
	// (get) Token: 0x060002E6 RID: 742 RVA: 0x0001D095 File Offset: 0x0001B295
	public Transform Throat
	{
		get
		{
			if (this.mouth.Count <= 2)
			{
				return null;
			}
			return this.mouth[2];
		}
	}

	// Token: 0x060002E7 RID: 743 RVA: 0x0001D0B4 File Offset: 0x0001B2B4
	public void Init(Girl girl)
	{
		this.m_girl = girl;
		if (this.lPelvisHandPos != null)
		{
			this.lPelvisHandPos.parent = (this.rPelvisHandPos.parent = this.hips);
			this.lThighHandRest.parent = (this.lThighGrab.parent = this.lThigh);
			this.rThighHandRest.parent = (this.rThighGrab.parent = this.rThigh);
			this.lHeadGrab.parent = (this.rHeadGrab.parent = this.head);
		}
		this.m_attachPoints = new List<Transform>
		{
			this.lPelvisHandPos,
			this.rPelvisHandPos,
			this.lThighHandRest,
			this.rThighHandRest,
			this.lHeadGrab,
			this.rHeadGrab,
			this.lThighGrab,
			this.rThighGrab
		};
		this.ReplaceTransform(ref this.head, base.transform.rotation, default(Vector3));
		this.ReplaceTransform(ref this.lEye, base.transform.rotation, default(Vector3));
		this.ReplaceTransform(ref this.rEye, base.transform.rotation, default(Vector3));
		this.ReplaceTransform(ref this.hips, base.transform.rotation, this.hipsOffset);
		this.ReplaceTransform(ref this.lHand, Quaternion.LookRotation(this.lMiddleKnuckles.position - this.lHand.position, base.transform.up), default(Vector3));
		this.ReplaceTransform(ref this.rHand, Quaternion.LookRotation(this.rMiddleKnuckles.position - this.rHand.position, base.transform.up), default(Vector3));
		this.ReplaceTransform(ref this.lThigh, base.transform.rotation, default(Vector3));
		this.ReplaceTransform(ref this.rThigh, base.transform.rotation, default(Vector3));
		this.ReplaceTransform(ref this.lCalf, base.transform.rotation, default(Vector3));
		this.ReplaceTransform(ref this.rCalf, base.transform.rotation, default(Vector3));
		this.ReplaceTransform(ref this.lFoot, base.transform.rotation, default(Vector3));
		this.ReplaceTransform(ref this.rFoot, base.transform.rotation, default(Vector3));
		this.ReplaceTransform(ref this.lForearm, base.transform.rotation, default(Vector3));
		this.ReplaceTransform(ref this.rForearm, base.transform.rotation, default(Vector3));
		this.ReplaceTransform(ref this.lUpperArm, base.transform.rotation, default(Vector3));
		this.ReplaceTransform(ref this.rUpperArm, base.transform.rotation, default(Vector3));
		this.ReplaceTransform(ref this.spine, base.transform.rotation, default(Vector3));
		if (this.mouthUpper == null && this.Mouth != null)
		{
			Transform transform = this.Mouth;
			this.mouthUpper = Instantiate<Transform>(this.Mouth, this.Mouth.parent);
			this.mouthUpper.position = transform.position;
			this.mouthLower = Instantiate<Transform>(this.Mouth, this.jaw);
			this.mouthLower.position = transform.position;
		}
	}

	// Token: 0x060002E8 RID: 744 RVA: 0x0001D494 File Offset: 0x0001B694
	public void ReplaceTransform(ref Transform tf, Quaternion rotation, Vector3 offset = default(Vector3))
	{
		if (tf == null)
		{
			return;
		}
		Transform transform = new GameObject().transform;
		transform.name = tf.name + "_ParentIK";
		transform.parent = tf.parent;
		transform.position = tf.position + base.transform.right * offset.x + base.transform.up * offset.y + base.transform.forward * offset.z;
		transform.rotation = rotation;
		Transform transform2 = new GameObject().transform;
		transform2.name = tf.name + "_IK";
		transform2.parent = transform;
		transform2.position = tf.position;
		transform2.localEulerAngles = Vector3.zero;
		tf.parent = transform2;
		tf = transform2;
	}

	// Token: 0x060002E9 RID: 745 RVA: 0x0001D58C File Offset: 0x0001B78C
	public Avatar GetAvatar()
	{
		List<ValueTuple<string, Transform>> list = new List<ValueTuple<string, Transform>>
		{
			new ValueTuple<string, Transform>("Hips", this.hips),
			new ValueTuple<string, Transform>("Spine", this.spine),
			new ValueTuple<string, Transform>("Head", this.head),
			new ValueTuple<string, Transform>("LeftEye", this.lEye),
			new ValueTuple<string, Transform>("RightEye", this.rEye),
			new ValueTuple<string, Transform>("LeftUpperLeg", this.lThigh),
			new ValueTuple<string, Transform>("LeftLowerLeg", this.lCalf),
			new ValueTuple<string, Transform>("LeftFoot", this.lFoot),
			new ValueTuple<string, Transform>("LeftToes", this.lToes),
			new ValueTuple<string, Transform>("LeftShoulder", this.lShoulder),
			new ValueTuple<string, Transform>("LeftUpperArm", this.lUpperArm),
			new ValueTuple<string, Transform>("LeftLowerArm", this.lForearm),
			new ValueTuple<string, Transform>("LeftHand", this.lHand),
			new ValueTuple<string, Transform>("Left Thumb Proximal", this.lThumbKnuckles),
			new ValueTuple<string, Transform>("Left Thumb Intermediate", this.lThumbMiddle),
			new ValueTuple<string, Transform>("Left Thumb Distal", this.lThumbTip),
			new ValueTuple<string, Transform>("Left Index Proximal", this.lIndexKnuckles),
			new ValueTuple<string, Transform>("Left Index Intermediate", this.lIndexMiddle),
			new ValueTuple<string, Transform>("Left Index Distal", this.lIndexTip),
			new ValueTuple<string, Transform>("Left Middle Proximal", this.lMiddleKnuckles),
			new ValueTuple<string, Transform>("Left Middle Intermediate", this.lMiddleMiddle),
			new ValueTuple<string, Transform>("Left Middle Distal", this.lMiddleTip),
			new ValueTuple<string, Transform>("Left Ring Proximal", this.lRingKnuckles),
			new ValueTuple<string, Transform>("Left Ring Intermediate", this.lRingMiddle),
			new ValueTuple<string, Transform>("Left Ring Distal", this.lRingTip),
			new ValueTuple<string, Transform>("Left Little Proximal", this.lPinkyKnuckles),
			new ValueTuple<string, Transform>("Left Little Intermediate", this.lPinkyMiddle),
			new ValueTuple<string, Transform>("Left Little Distal", this.lPinkyTip),
			new ValueTuple<string, Transform>("RightUpperLeg", this.rThigh),
			new ValueTuple<string, Transform>("RightLowerLeg", this.rCalf),
			new ValueTuple<string, Transform>("RightFoot", this.rFoot),
			new ValueTuple<string, Transform>("RightToes", this.rToes),
			new ValueTuple<string, Transform>("RightShoulder", this.rShoulder),
			new ValueTuple<string, Transform>("RightUpperArm", this.rUpperArm),
			new ValueTuple<string, Transform>("RightLowerArm", this.rForearm),
			new ValueTuple<string, Transform>("RightHand", this.rHand),
			new ValueTuple<string, Transform>("Right Thumb Proximal", this.rThumbKnuckles),
			new ValueTuple<string, Transform>("Right Thumb Intermediate", this.rThumbMiddle),
			new ValueTuple<string, Transform>("Right Thumb Distal", this.rThumbTip),
			new ValueTuple<string, Transform>("Right Index Proximal", this.rIndexKnuckles),
			new ValueTuple<string, Transform>("Right Index Intermediate", this.rIndexMiddle),
			new ValueTuple<string, Transform>("Right Index Distal", this.rIndexTip),
			new ValueTuple<string, Transform>("Right Middle Proximal", this.rMiddleKnuckles),
			new ValueTuple<string, Transform>("Right Middle Intermediate", this.rMiddleMiddle),
			new ValueTuple<string, Transform>("Right Middle Distal", this.rMiddleTip),
			new ValueTuple<string, Transform>("Right Ring Proximal", this.rRingKnuckles),
			new ValueTuple<string, Transform>("Right Ring Intermediate", this.rRingMiddle),
			new ValueTuple<string, Transform>("Right Ring Distal", this.rRingTip),
			new ValueTuple<string, Transform>("Right Little Proximal", this.rPinkyKnuckles),
			new ValueTuple<string, Transform>("Right Little Intermediate", this.rPinkyMiddle),
			new ValueTuple<string, Transform>("Right Little Distal", this.rPinkyTip)
		};
		for (int i = list.Count - 1; i >= 0; i--)
		{
			if (list[i].Item2 == null)
			{
				list.RemoveAt(i);
			}
		}
		HumanBone[] array = new HumanBone[list.Count];
		List<Transform> list2 = new List<Transform>();
		for (int j = 0; j < list.Count; j++)
		{
			ValueTuple<string, Transform> valueTuple = list[j];
			string item = valueTuple.Item1;
			Transform item2 = valueTuple.Item2;
			HumanBone humanBone = default(HumanBone);
			humanBone.humanName = item;
			humanBone.boneName = item2.name;
			humanBone.limit.useDefaultValues = true;
			array[j] = humanBone;
			this.CollectSkeleton(item2, list2);
		}
		SkeletonBone[] array2 = new SkeletonBone[list2.Count];
		for (int k = 0; k < list2.Count; k++)
		{
			Transform transform = list2[k];
			array2[k] = new SkeletonBone
			{
				name = transform.name,
				position = transform.localPosition,
				scale = transform.localScale,
				rotation = transform.localRotation
			};
		}
		HumanDescription humanDescription = new HumanDescription
		{
			human = array,
			skeleton = array2
		};
		return AvatarBuilder.BuildHumanAvatar(base.gameObject, humanDescription);
	}

	// Token: 0x060002EA RID: 746 RVA: 0x0001DB50 File Offset: 0x0001BD50
	public BipedReferences GetBipedReferences()
	{
		BipedReferences bipedReferences = new BipedReferences();
		bipedReferences.root = base.transform;
		bipedReferences.pelvis = this.hips;
		bipedReferences.spine = new Transform[]
		{
			this.spine
		};
		bipedReferences.head = this.head;
		BipedReferences bipedReferences2 = bipedReferences;
		Transform[] eyes;
		if (!this.lEye)
		{
			eyes = new Transform[0];
		}
		else
		{
			Transform[] array = new Transform[2];
			array[0] = this.lEye;
			eyes = array;
			array[1] = this.rEye;
		}
		bipedReferences2.eyes = eyes;
		bipedReferences.leftThigh = this.lThigh;
		bipedReferences.leftCalf = this.lCalf;
		bipedReferences.leftFoot = this.lFoot;
		bipedReferences.leftUpperArm = this.lUpperArm;
		bipedReferences.leftForearm = this.lForearm;
		bipedReferences.leftHand = this.lHand;
		bipedReferences.rightThigh = this.rThigh;
		bipedReferences.rightCalf = this.rCalf;
		bipedReferences.rightFoot = this.rFoot;
		bipedReferences.rightUpperArm = this.rUpperArm;
		bipedReferences.rightForearm = this.rForearm;
		bipedReferences.rightHand = this.rHand;
		return bipedReferences;
	}

	// Token: 0x060002EB RID: 747 RVA: 0x0001DC60 File Offset: 0x0001BE60
	public void CollectSkeleton(Transform t, List<Transform> skeleton)
	{
		if (skeleton.Contains(t))
		{
			return;
		}
		skeleton.Add(t);
		if (t.parent != null)
		{
			this.CollectSkeleton(t.parent, skeleton);
		}
	}

	// Token: 0x060002EC RID: 748 RVA: 0x0001DC90 File Offset: 0x0001BE90
	public BipedRagdollReferences SetUpRagdollReferences(Rig target)
	{
		Rig.g__move(this.hips, target.hips);
		Rig.g__move(this.spine, target.spine);
		Rig.g__move(this.head, target.head);
		Rig.g__move(this.lUpperArm, target.lUpperArm);
		Rig.g__move(this.lForearm, target.lForearm);
		Rig.g__move(this.lHand, target.lHand);
		Rig.g__move(this.rUpperArm, target.rUpperArm);
		Rig.g__move(this.rForearm, target.rForearm);
		Rig.g__move(this.rHand, target.rHand);
		Rig.g__move(this.lThigh, target.lThigh);
		Rig.g__move(this.lCalf, target.lCalf);
		Rig.g__move(this.lFoot, target.lFoot);
		Rig.g__move(this.rThigh, target.rThigh);
		Rig.g__move(this.rCalf, target.rCalf);
		Rig.g__move(this.rFoot, target.rFoot);
		return new BipedRagdollReferences
		{
			root = base.transform,
			hips = this.hips,
			spine = this.spine,
			head = this.head,
			leftUpperArm = this.lUpperArm,
			leftLowerArm = this.lForearm,
			leftHand = this.lHand,
			rightUpperArm = this.rUpperArm,
			rightLowerArm = this.rForearm,
			rightHand = this.rHand,
			leftUpperLeg = this.lThigh,
			leftLowerLeg = this.lCalf,
			leftFoot = this.lFoot,
			rightUpperLeg = this.rThigh,
			rightLowerLeg = this.rCalf,
			rightFoot = this.rFoot
		};
	}

	// Token: 0x060002ED RID: 749 RVA: 0x0001DE78 File Offset: 0x0001C078
	public void SetUpPuppet(PuppetMaster puppet, Rig target)
	{
		if (target.overrideHeadSize)
		{
			this.head.GetComponent<CapsuleCollider>().radius = target.headSize;
		}
		if (target.overrideHead)
		{
			this.head.GetComponent<CapsuleCollider>().center = target.headCenter;
		}
		if (target.overrideHips)
		{
			this.hips.GetComponent<BoxCollider>().size = target.hipsSize;
		}
		List<ValueTuple<Transform, Transform, Muscle.Group>> list = new List<ValueTuple<Transform, Transform, Muscle.Group>>
		{
			new ValueTuple<Transform, Transform, Muscle.Group>(this.hips, target.hips, Muscle.Group.Hips),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.spine, target.spine, Muscle.Group.Spine),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.head, target.head, Muscle.Group.Head),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.lUpperArm, target.lUpperArm, Muscle.Group.Arm),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.lForearm, target.lForearm, Muscle.Group.Arm),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.lHand, target.lHand, Muscle.Group.Hand),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.rUpperArm, target.rUpperArm, Muscle.Group.Arm),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.rForearm, target.rForearm, Muscle.Group.Arm),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.rHand, target.rHand, Muscle.Group.Hand),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.lThigh, target.lThigh, Muscle.Group.Leg),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.lCalf, target.lCalf, Muscle.Group.Leg),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.lFoot, target.lFoot, Muscle.Group.Foot),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.rThigh, target.rThigh, Muscle.Group.Leg),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.rCalf, target.rCalf, Muscle.Group.Leg),
			new ValueTuple<Transform, Transform, Muscle.Group>(this.rFoot, target.rFoot, Muscle.Group.Foot)
		};
		puppet.muscles = new Muscle[list.Count];
		Muscle[] muscles = puppet.muscles;
		for (int i = 0; i < list.Count; i++)
		{
			ValueTuple<Transform, Transform, Muscle.Group> valueTuple = list[i];
			Transform item = valueTuple.Item1;
			Transform item2 = valueTuple.Item2;
			Muscle.Group item3 = valueTuple.Item3;
			Component[] components = item.GetComponents<Component>();
			muscles[i] = new Muscle
			{
				joint = item.GetComponent<ConfigurableJoint>(),
				name = item.name,
				target = item2,
				props = new Muscle.Props
				{
					pinWeight = 1f,
					muscleWeight = 1f,
					mappingWeight = 1f,
					muscleDamper = 1f,
					mapPosition = Rig.g__isMapPosition(item3),
					group = item3
				}
			};
		}
		foreach (Transform transform in target.m_attachPoints)
		{
			if (transform != null)
			{
				Transform parent = transform.parent;
				bool flag = false;
				for (int j = 0; j < 4; j++)
				{
					foreach (Muscle muscle in target.m_girl.m_puppet.muscles)
					{
						if (parent == muscle.target)
						{
							Game.Instance.m_attachDict.Add(transform, muscle);
							flag = true;
							break;
						}
					}
					if (flag)
					{
						break;
					}
					parent = parent.parent;
				}
			}
		}
	}

	// Token: 0x060002EF RID: 751 RVA: 0x0001E1EF File Offset: 0x0001C3EF
	[CompilerGenerated]
	internal static void g__move(Transform bone, Transform targetBone)
	{
		bone.position = targetBone.position;
		bone.rotation = targetBone.rotation;
	}

	// Token: 0x060002F0 RID: 752 RVA: 0x0001E209 File Offset: 0x0001C409
	[CompilerGenerated]
	internal static bool g__isMapPosition(Muscle.Group group)
	{
		return group == Muscle.Group.Hips;
	}

	// Token: 0x04000305 RID: 773
	[Header("Holes")]
	public List<Transform> mouth;

	// Token: 0x04000306 RID: 774
	public Transform mouthUpper;

	// Token: 0x04000307 RID: 775
	public Transform mouthLower;

	// Token: 0x04000308 RID: 776
	public Transform lips;

	// Token: 0x04000309 RID: 777
	[Header("Avatar")]
	public Transform hips;

	// Token: 0x0400030A RID: 778
	public Transform spine;

	// Token: 0x0400030B RID: 779
	public Transform chest;

	// Token: 0x0400030C RID: 780
	public Transform head;

	// Token: 0x0400030D RID: 781
	public Transform lEye;

	// Token: 0x0400030E RID: 782
	public Transform rEye;

	// Token: 0x0400030F RID: 783
	public Transform jaw;

	// Token: 0x04000310 RID: 784
	public Transform lThigh;

	// Token: 0x04000311 RID: 785
	public Transform lCalf;

	// Token: 0x04000312 RID: 786
	public Transform lFoot;

	// Token: 0x04000313 RID: 787
	public Transform lToes;

	// Token: 0x04000314 RID: 788
	public Transform lShoulder;

	// Token: 0x04000315 RID: 789
	public Transform lUpperArm;

	// Token: 0x04000316 RID: 790
	public Transform lForearm;

	// Token: 0x04000317 RID: 791
	public Transform lHand;

	// Token: 0x04000318 RID: 792
	public Transform lThumbKnuckles;

	// Token: 0x04000319 RID: 793
	public Transform lThumbMiddle;

	// Token: 0x0400031A RID: 794
	public Transform lThumbTip;

	// Token: 0x0400031B RID: 795
	public Transform lIndexKnuckles;

	// Token: 0x0400031C RID: 796
	public Transform lIndexMiddle;

	// Token: 0x0400031D RID: 797
	public Transform lIndexTip;

	// Token: 0x0400031E RID: 798
	public Transform lMiddleKnuckles;

	// Token: 0x0400031F RID: 799
	public Transform lMiddleMiddle;

	// Token: 0x04000320 RID: 800
	public Transform lMiddleTip;

	// Token: 0x04000321 RID: 801
	public Transform lRingKnuckles;

	// Token: 0x04000322 RID: 802
	public Transform lRingMiddle;

	// Token: 0x04000323 RID: 803
	public Transform lRingTip;

	// Token: 0x04000324 RID: 804
	public Transform lPinkyKnuckles;

	// Token: 0x04000325 RID: 805
	public Transform lPinkyMiddle;

	// Token: 0x04000326 RID: 806
	public Transform lPinkyTip;

	// Token: 0x04000327 RID: 807
	public Transform rThigh;

	// Token: 0x04000328 RID: 808
	public Transform rCalf;

	// Token: 0x04000329 RID: 809
	public Transform rFoot;

	// Token: 0x0400032A RID: 810
	public Transform rToes;

	// Token: 0x0400032B RID: 811
	public Transform rShoulder;

	// Token: 0x0400032C RID: 812
	public Transform rUpperArm;

	// Token: 0x0400032D RID: 813
	public Transform rForearm;

	// Token: 0x0400032E RID: 814
	public Transform rHand;

	// Token: 0x0400032F RID: 815
	public Transform rThumbKnuckles;

	// Token: 0x04000330 RID: 816
	public Transform rThumbMiddle;

	// Token: 0x04000331 RID: 817
	public Transform rThumbTip;

	// Token: 0x04000332 RID: 818
	public Transform rIndexKnuckles;

	// Token: 0x04000333 RID: 819
	public Transform rIndexMiddle;

	// Token: 0x04000334 RID: 820
	public Transform rIndexTip;

	// Token: 0x04000335 RID: 821
	public Transform rMiddleKnuckles;

	// Token: 0x04000336 RID: 822
	public Transform rMiddleMiddle;

	// Token: 0x04000337 RID: 823
	public Transform rMiddleTip;

	// Token: 0x04000338 RID: 824
	public Transform rRingKnuckles;

	// Token: 0x04000339 RID: 825
	public Transform rRingMiddle;

	// Token: 0x0400033A RID: 826
	public Transform rRingTip;

	// Token: 0x0400033B RID: 827
	public Transform rPinkyKnuckles;

	// Token: 0x0400033C RID: 828
	public Transform rPinkyMiddle;

	// Token: 0x0400033D RID: 829
	public Transform rPinkyTip;

	// Token: 0x0400033E RID: 830
	public List<Transform> penis;

	// Token: 0x0400033F RID: 831
	public Transform penisBarrel;

	// Token: 0x04000340 RID: 832
	public Transform penisTip;

	// Token: 0x04000341 RID: 833
	public Transform lPelvisHandPos;

	// Token: 0x04000342 RID: 834
	public Transform rPelvisHandPos;

	// Token: 0x04000343 RID: 835
	public Transform lThighHandRest;

	// Token: 0x04000344 RID: 836
	public Transform rThighHandRest;

	// Token: 0x04000345 RID: 837
	public Transform lHeadGrab;

	// Token: 0x04000346 RID: 838
	public Transform rHeadGrab;

	// Token: 0x04000347 RID: 839
	public Transform lThighGrab;

	// Token: 0x04000348 RID: 840
	public Transform rThighGrab;

	// Token: 0x04000349 RID: 841
	public List<Transform> m_attachPoints;

	// Token: 0x0400034A RID: 842
	public List<Transform> breasts;

	// Token: 0x0400034B RID: 843
	[Header("Config")]
	public Vector3 hipsOffset;

	// Token: 0x0400034C RID: 844
	[Header("Ragdoll")]
	public bool overrideHeadSize;

	// Token: 0x0400034D RID: 845
	public float headSize = 0.1f;

	// Token: 0x0400034E RID: 846
	public bool overrideHead;

	// Token: 0x0400034F RID: 847
	public Vector3 headCenter;

	// Token: 0x04000350 RID: 848
	public bool overrideHips;

	// Token: 0x04000351 RID: 849
	public Vector3 hipsSize;

	// Token: 0x04000352 RID: 850
	private Girl m_girl;
}

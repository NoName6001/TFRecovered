Shader "HairShader_T_DVA" {
	Properties {
		_TextureSample0 ("Texture Sample 0", 2D) = "black" {}
		_TextureSample1 ("Texture Sample 1", 2D) = "white" {}
		_TextureSample2 ("Texture Sample 2", 2D) = "white" {}
		_Float0 ("Float 0", Float) = 0
		_TextureSample3 ("Texture Sample 3", 2D) = "white" {}
		[HideInInspector] _texcoord ("", 2D) = "white" {}
		[HideInInspector] __dirty ("", Float) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 42315
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[9];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD1.y = u_xlat3.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.w = u_xlat0.y;
					    vs_TEXCOORD3.w = u_xlat0.z;
					    vs_TEXCOORD2.y = u_xlat3.y;
					    vs_TEXCOORD3.y = u_xlat3.z;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[9];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD1.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2 = u_xlat0.xxxx * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD1.y = u_xlat3.x;
					    vs_TEXCOORD1.z = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.w = u_xlat0.y;
					    vs_TEXCOORD3.w = u_xlat0.z;
					    vs_TEXCOORD2.y = u_xlat3.y;
					    vs_TEXCOORD3.y = u_xlat3.z;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.z = u_xlat2.w;
					    u_xlat0.x = u_xlat2.y * u_xlat2.y;
					    u_xlat0.x = u_xlat2.x * u_xlat2.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat2.ywzx * u_xlat2;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[9];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2 = vec4(u_xlat16) * u_xlat2.xyzz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.wxy;
					    u_xlat3.xyz = u_xlat2.ywx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat15) * u_xlat3.xyz;
					    vs_TEXCOORD1.y = u_xlat3.x;
					    vs_TEXCOORD1.w = u_xlat0.x;
					    vs_TEXCOORD1.z = u_xlat2.x;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat3.y;
					    vs_TEXCOORD3.y = u_xlat3.z;
					    vs_TEXCOORD2.w = u_xlat0.y;
					    vs_TEXCOORD2.z = u_xlat2.y;
					    vs_TEXCOORD3.w = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat2.w;
					    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat2.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat3 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = u_xlat1 * u_xlat2.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat2.wwzw + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat15 = u_xlat2.y * u_xlat2.y;
					    u_xlat15 = u_xlat2.x * u_xlat2.x + (-u_xlat15);
					    u_xlat2 = u_xlat2.ywzx * u_xlat2;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat3.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat2.xyz;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Float0;
						vec4 _TextureSample2_ST;
						vec4 _TextureSample3_ST;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _TextureSample3;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec3 u_xlat3;
					float u_xlat16_3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec4 u_xlat10_9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					float u_xlat14;
					float u_xlat15;
					float u_xlat16;
					vec3 u_xlat18;
					vec3 u_xlat19;
					float u_xlat27;
					float u_xlat16_27;
					float u_xlat28;
					float u_xlat39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					float u_xlat42;
					float u_xlat16_42;
					float u_xlat43;
					bool u_xlatb43;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat2.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat10_3 = texture(_TextureSample1, u_xlat3.xy);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_5 = texture(_TextureSample2, u_xlat5.xy);
					    u_xlat18.xy = vs_TEXCOORD0.xy * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
					    u_xlat10_6 = texture(_TextureSample3, u_xlat18.xy);
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat18.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat18.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat18.xyz;
					        u_xlat18.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat18.xyz;
					        u_xlat18.xyz = u_xlat18.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat18.xyz = (bool(u_xlatb40)) ? u_xlat18.xyz : u_xlat0.xyz;
					        u_xlat18.xyz = u_xlat18.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat18.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat7.y * 0.25 + 0.75;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat7.x = max(u_xlat40, u_xlat41);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					    } else {
					        u_xlat7.x = float(1.0);
					        u_xlat7.y = float(1.0);
					        u_xlat7.z = float(1.0);
					        u_xlat7.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat40 = dot(u_xlat7, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat41 = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat41 = inversesqrt(u_xlat41);
					    u_xlat3.xyz = vec3(u_xlat41) * u_xlat7.xyz;
					    u_xlat16_41 = (-u_xlat10_5.x) + 1.0;
					    u_xlat42 = dot((-u_xlat2.xyz), u_xlat3.xyz);
					    u_xlat42 = u_xlat42 + u_xlat42;
					    u_xlat18.xyz = u_xlat3.xyz * (-vec3(u_xlat42)) + (-u_xlat2.xyz);
					    u_xlat19.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat18.xyz, u_xlat18.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat18.xyz;
					        u_xlat8.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat18.xyz;
					    //ENDIF
					    }
					    u_xlat16_40 = (-u_xlat16_41) * 0.699999988 + 1.70000005;
					    u_xlat16_40 = u_xlat16_40 * u_xlat16_41;
					    u_xlat40 = u_xlat16_40 * 6.0;
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, u_xlat40);
					    u_xlat16_42 = u_xlat10_7.w + -1.0;
					    u_xlat42 = unity_SpecCube0_HDR.w * u_xlat16_42 + 1.0;
					    u_xlat42 = u_xlat42 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat42);
					    u_xlatb43 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb43){
					        u_xlatb43 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb43){
					            u_xlat43 = dot(u_xlat18.xyz, u_xlat18.xyz);
					            u_xlat43 = inversesqrt(u_xlat43);
					            u_xlat9.xyz = vec3(u_xlat43) * u_xlat18.xyz;
					            u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat43 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat43 = min(u_xlat10.z, u_xlat43);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat18.xyz = u_xlat9.xyz * vec3(u_xlat43) + u_xlat0.xyz;
					        //ENDIF
					        }
					        u_xlat10_9 = textureLod(unity_SpecCube1, u_xlat18.xyz, u_xlat40);
					        u_xlat16_0.x = u_xlat10_9.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0.x + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat10_9.xyz * u_xlat0.xxx;
					        u_xlat18.xyz = vec3(u_xlat42) * u_xlat10_7.xyz + (-u_xlat0.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat18.xyz + u_xlat0.xyz;
					    //ENDIF
					    }
					    u_xlat16_0.xyz = u_xlat10_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat0.xyz = vec3(_Float0) * u_xlat16_0.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat40 = (-_Float0) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat40) * u_xlat10_4.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat1.xyz;
					    u_xlat39 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = dot(vec2(u_xlat14), vec2(u_xlat16_41));
					    u_xlat14 = u_xlat14 + -0.5;
					    u_xlat27 = (-u_xlat2.x) + 1.0;
					    u_xlat28 = u_xlat27 * u_xlat27;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat27 = u_xlat27 * u_xlat28;
					    u_xlat27 = u_xlat14 * u_xlat27 + 1.0;
					    u_xlat28 = -abs(u_xlat39) + 1.0;
					    u_xlat3.x = u_xlat28 * u_xlat28;
					    u_xlat3.x = u_xlat3.x * u_xlat3.x;
					    u_xlat28 = u_xlat28 * u_xlat3.x;
					    u_xlat14 = u_xlat14 * u_xlat28 + 1.0;
					    u_xlat14 = u_xlat14 * u_xlat27;
					    u_xlat14 = u_xlat2.x * u_xlat14;
					    u_xlat16_27 = u_xlat16_41 * u_xlat16_41;
					    u_xlat16_27 = max(u_xlat16_27, 0.00200000009);
					    u_xlat16_3 = (-u_xlat16_27) + 1.0;
					    u_xlat16 = abs(u_xlat39) * u_xlat16_3 + u_xlat16_27;
					    u_xlat3.x = u_xlat2.x * u_xlat16_3 + u_xlat16_27;
					    u_xlat39 = abs(u_xlat39) * u_xlat3.x;
					    u_xlat39 = u_xlat2.x * u_xlat16 + u_xlat39;
					    u_xlat39 = u_xlat39 + 9.99999975e-06;
					    u_xlat39 = 0.5 / u_xlat39;
					    u_xlat16_3 = u_xlat16_27 * u_xlat16_27;
					    u_xlat16 = u_xlat15 * u_xlat16_3 + (-u_xlat15);
					    u_xlat15 = u_xlat16 * u_xlat15 + 1.0;
					    u_xlat16_3 = u_xlat16_3 * 0.318309873;
					    u_xlat15 = u_xlat15 * u_xlat15 + 1.00000001e-07;
					    u_xlat15 = u_xlat16_3 / u_xlat15;
					    u_xlat39 = u_xlat39 * u_xlat15;
					    u_xlat39 = u_xlat39 * 3.14159274;
					    u_xlat39 = max(u_xlat39, 9.99999975e-05);
					    u_xlat39 = sqrt(u_xlat39);
					    u_xlat39 = u_xlat2.x * u_xlat39;
					    u_xlat16_27 = u_xlat16_27 * 0.280000001;
					    u_xlat16_27 = (-u_xlat16_27) * u_xlat16_41 + 1.0;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlatb2 = u_xlat2.x!=0.0;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat39 = u_xlat39 * u_xlat2.x;
					    u_xlat40 = (-u_xlat40) + u_xlat10_5.x;
					    u_xlat40 = u_xlat40 + 1.0;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat2.xyw = vec3(u_xlat14) * u_xlat19.xyz;
					    u_xlat3.xyz = u_xlat19.xyz * vec3(u_xlat39);
					    u_xlat39 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat39 * u_xlat39;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat39 = u_xlat39 * u_xlat1.x;
					    u_xlat5.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xyz;
					    u_xlat2.xyw = u_xlat4.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat8.xyz * vec3(u_xlat16_27);
					    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat40);
					    u_xlat0.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat0.xyz + u_xlat2.xyw;
					    SV_Target0.w = u_xlat10_6.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Float0;
						vec4 _TextureSample2_ST;
						vec4 _TextureSample3_ST;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _TextureSample3;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec4 u_xlat10_8;
					vec3 u_xlat9;
					vec4 u_xlat10_9;
					vec3 u_xlat10;
					vec4 u_xlat10_10;
					vec3 u_xlat11;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					bvec3 u_xlatb13;
					float u_xlat15;
					float u_xlat16;
					vec3 u_xlat19;
					vec3 u_xlat20;
					float u_xlat21;
					float u_xlat29;
					float u_xlat16_29;
					float u_xlat30;
					float u_xlat42;
					float u_xlat43;
					float u_xlat16_43;
					bool u_xlatb43;
					float u_xlat44;
					float u_xlat16_44;
					bool u_xlatb44;
					float u_xlat45;
					bool u_xlatb45;
					float u_xlat16_46;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD1.w;
					    u_xlat0.y = vs_TEXCOORD2.w;
					    u_xlat0.z = vs_TEXCOORD3.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat2.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat10_3 = texture(_TextureSample1, u_xlat3.xy);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_5 = texture(_TextureSample2, u_xlat5.xy);
					    u_xlat19.xy = vs_TEXCOORD0.xy * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
					    u_xlat10_6 = texture(_TextureSample3, u_xlat19.xy);
					    u_xlatb43 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb43){
					        u_xlatb44 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat19.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat19.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat19.xyz;
					        u_xlat19.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat19.xyz;
					        u_xlat19.xyz = u_xlat19.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat19.xyz = (bool(u_xlatb44)) ? u_xlat19.xyz : u_xlat0.xyz;
					        u_xlat19.xyz = u_xlat19.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat19.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat44 = u_xlat7.y * 0.25 + 0.75;
					        u_xlat45 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat7.x = max(u_xlat44, u_xlat45);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					    } else {
					        u_xlat7.x = float(1.0);
					        u_xlat7.y = float(1.0);
					        u_xlat7.z = float(1.0);
					        u_xlat7.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat44 = dot(u_xlat7, unity_OcclusionMaskSelector);
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat3.x = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat7.xyz;
					    u_xlat16_46 = (-u_xlat10_5.x) + 1.0;
					    u_xlat19.x = dot((-u_xlat2.xyz), u_xlat3.xyz);
					    u_xlat19.x = u_xlat19.x + u_xlat19.x;
					    u_xlat19.xyz = u_xlat3.xyz * (-u_xlat19.xxx) + (-u_xlat2.xyz);
					    u_xlat20.xyz = vec3(u_xlat44) * _LightColor0.xyz;
					    if(u_xlatb43){
					        u_xlatb43 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb43)) ? u_xlat7.xyz : u_xlat0.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat43 = u_xlat7.y * 0.25;
					        u_xlat44 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat21 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat43 = max(u_xlat43, u_xlat44);
					        u_xlat7.x = min(u_xlat21, u_xlat43);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					        u_xlat9.xyz = u_xlat7.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_9 = texture(unity_ProbeVolumeSH, u_xlat9.xyz);
					        u_xlat7.xyz = u_xlat7.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat3.w = 1.0;
					        u_xlat8.x = dot(u_xlat10_8, u_xlat3);
					        u_xlat8.y = dot(u_xlat10_9, u_xlat3);
					        u_xlat8.z = dot(u_xlat10_7, u_xlat3);
					    } else {
					        u_xlat3.w = 1.0;
					        u_xlat8.x = dot(unity_SHAr, u_xlat3);
					        u_xlat8.y = dot(unity_SHAg, u_xlat3);
					        u_xlat8.z = dot(unity_SHAb, u_xlat3);
					    //ENDIF
					    }
					    u_xlat7.xyz = u_xlat8.xyz + vs_TEXCOORD4.xyz;
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat7.xyz = log2(u_xlat7.xyz);
					    u_xlat7.xyz = u_xlat7.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat7.xyz = exp2(u_xlat7.xyz);
					    u_xlat7.xyz = u_xlat7.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb43 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb43){
					        u_xlat43 = dot(u_xlat19.xyz, u_xlat19.xyz);
					        u_xlat43 = inversesqrt(u_xlat43);
					        u_xlat8.xyz = vec3(u_xlat43) * u_xlat19.xyz;
					        u_xlat9.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					        u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					        u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat9;
					            hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					            hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					            hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					            u_xlat9 = hlslcc_movcTemp;
					        }
					        u_xlat43 = min(u_xlat9.y, u_xlat9.x);
					        u_xlat43 = min(u_xlat9.z, u_xlat43);
					        u_xlat9.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat43) + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat19.xyz;
					    //ENDIF
					    }
					    u_xlat16_43 = (-u_xlat16_46) * 0.699999988 + 1.70000005;
					    u_xlat16_43 = u_xlat16_43 * u_xlat16_46;
					    u_xlat43 = u_xlat16_43 * 6.0;
					    u_xlat10_8 = textureLod(unity_SpecCube0, u_xlat8.xyz, u_xlat43);
					    u_xlat16_44 = u_xlat10_8.w + -1.0;
					    u_xlat44 = unity_SpecCube0_HDR.w * u_xlat16_44 + 1.0;
					    u_xlat44 = u_xlat44 * unity_SpecCube0_HDR.x;
					    u_xlat9.xyz = u_xlat10_8.xyz * vec3(u_xlat44);
					    u_xlatb45 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb45){
					        u_xlatb45 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb45){
					            u_xlat45 = dot(u_xlat19.xyz, u_xlat19.xyz);
					            u_xlat45 = inversesqrt(u_xlat45);
					            u_xlat10.xyz = vec3(u_xlat45) * u_xlat19.xyz;
					            u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat10.xyz;
					            u_xlat12.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat12.xyz = u_xlat12.xyz / u_xlat10.xyz;
					            u_xlatb13.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat10.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat11;
					                hlslcc_movcTemp.x = (u_xlatb13.x) ? u_xlat11.x : u_xlat12.x;
					                hlslcc_movcTemp.y = (u_xlatb13.y) ? u_xlat11.y : u_xlat12.y;
					                hlslcc_movcTemp.z = (u_xlatb13.z) ? u_xlat11.z : u_xlat12.z;
					                u_xlat11 = hlslcc_movcTemp;
					            }
					            u_xlat45 = min(u_xlat11.y, u_xlat11.x);
					            u_xlat45 = min(u_xlat11.z, u_xlat45);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat19.xyz = u_xlat10.xyz * vec3(u_xlat45) + u_xlat0.xyz;
					        //ENDIF
					        }
					        u_xlat10_10 = textureLod(unity_SpecCube1, u_xlat19.xyz, u_xlat43);
					        u_xlat16_0.x = u_xlat10_10.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0.x + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat10_10.xyz * u_xlat0.xxx;
					        u_xlat19.xyz = vec3(u_xlat44) * u_xlat10_8.xyz + (-u_xlat0.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat19.xyz + u_xlat0.xyz;
					    //ENDIF
					    }
					    u_xlat16_0.xyz = u_xlat10_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat0.xyz = vec3(_Float0) * u_xlat16_0.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat43 = (-_Float0) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat43) * u_xlat10_4.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat42) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat1.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat42 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat15 = u_xlat1.x * u_xlat1.x;
					    u_xlat15 = dot(vec2(u_xlat15), vec2(u_xlat16_46));
					    u_xlat15 = u_xlat15 + -0.5;
					    u_xlat29 = (-u_xlat2.x) + 1.0;
					    u_xlat30 = u_xlat29 * u_xlat29;
					    u_xlat30 = u_xlat30 * u_xlat30;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat29 = u_xlat15 * u_xlat29 + 1.0;
					    u_xlat30 = -abs(u_xlat42) + 1.0;
					    u_xlat44 = u_xlat30 * u_xlat30;
					    u_xlat44 = u_xlat44 * u_xlat44;
					    u_xlat30 = u_xlat30 * u_xlat44;
					    u_xlat15 = u_xlat15 * u_xlat30 + 1.0;
					    u_xlat15 = u_xlat15 * u_xlat29;
					    u_xlat15 = u_xlat2.x * u_xlat15;
					    u_xlat16_29 = u_xlat16_46 * u_xlat16_46;
					    u_xlat16_29 = max(u_xlat16_29, 0.00200000009);
					    u_xlat16_44 = (-u_xlat16_29) + 1.0;
					    u_xlat3.x = abs(u_xlat42) * u_xlat16_44 + u_xlat16_29;
					    u_xlat44 = u_xlat2.x * u_xlat16_44 + u_xlat16_29;
					    u_xlat42 = abs(u_xlat42) * u_xlat44;
					    u_xlat42 = u_xlat2.x * u_xlat3.x + u_xlat42;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat16_44 = u_xlat16_29 * u_xlat16_29;
					    u_xlat3.x = u_xlat16 * u_xlat16_44 + (-u_xlat16);
					    u_xlat16 = u_xlat3.x * u_xlat16 + 1.0;
					    u_xlat16_44 = u_xlat16_44 * 0.318309873;
					    u_xlat16 = u_xlat16 * u_xlat16 + 1.00000001e-07;
					    u_xlat16 = u_xlat16_44 / u_xlat16;
					    u_xlat42 = u_xlat42 * u_xlat16;
					    u_xlat42 = u_xlat42 * 3.14159274;
					    u_xlat42 = max(u_xlat42, 9.99999975e-05);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat42 = u_xlat2.x * u_xlat42;
					    u_xlat16_29 = u_xlat16_29 * 0.280000001;
					    u_xlat16_29 = (-u_xlat16_29) * u_xlat16_46 + 1.0;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlatb2 = u_xlat2.x!=0.0;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat42 = u_xlat42 * u_xlat2.x;
					    u_xlat43 = (-u_xlat43) + u_xlat10_5.x;
					    u_xlat43 = u_xlat43 + 1.0;
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat2.xyw = u_xlat20.xyz * vec3(u_xlat15) + u_xlat7.xyz;
					    u_xlat3.xyz = u_xlat20.xyz * vec3(u_xlat42);
					    u_xlat42 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat42 * u_xlat42;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat42 = u_xlat42 * u_xlat1.x;
					    u_xlat5.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xyz;
					    u_xlat2.xyw = u_xlat4.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(u_xlat16_29);
					    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat43);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat3.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat0.xyz + u_xlat2.xyw;
					    SV_Target0.w = u_xlat10_6.x;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 94972
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD1.y = u_xlat3.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.y = u_xlat3.y;
					    vs_TEXCOORD3.y = u_xlat3.z;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD5.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[9];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD1.y = u_xlat2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.y = u_xlat2.y;
					    vs_TEXCOORD3.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD1.y = u_xlat3.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.y = u_xlat3.y;
					    vs_TEXCOORD3.y = u_xlat3.z;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD5 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD1.y = u_xlat3.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.y = u_xlat3.y;
					    vs_TEXCOORD3.y = u_xlat3.z;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD5.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD5.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD1.y = u_xlat2.x;
					    vs_TEXCOORD1.x = u_xlat1.z;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    vs_TEXCOORD2.x = u_xlat1.x;
					    vs_TEXCOORD3.x = u_xlat1.y;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.y = u_xlat2.y;
					    vs_TEXCOORD3.y = u_xlat2.z;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Float0;
						vec4 _TextureSample2_ST;
						vec4 _TextureSample3_ST;
						vec4 unused_0_9;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _TextureSample3;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat16_1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec2 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat10;
					vec3 u_xlat13;
					vec3 u_xlat14;
					vec3 u_xlat16_14;
					float u_xlat16;
					float u_xlat16_16;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					float u_xlat16_25;
					bool u_xlatb25;
					float u_xlat26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat10_3 = texture(_TextureSample1, u_xlat3.xy);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_5 = texture(_TextureSample2, u_xlat5.xy);
					    u_xlat13.xy = vs_TEXCOORD0.xy * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
					    u_xlat10_6 = texture(_TextureSample3, u_xlat13.xy);
					    u_xlat13.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat13.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat13.xyz;
					    u_xlat13.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat13.xyz;
					    u_xlat13.xyz = u_xlat13.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb25 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb25){
					        u_xlatb25 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat14.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat14.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat14.xyz;
					        u_xlat14.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat14.xyz;
					        u_xlat14.xyz = u_xlat14.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat14.xyz = (bool(u_xlatb25)) ? u_xlat14.xyz : vs_TEXCOORD4.xyz;
					        u_xlat14.xyz = u_xlat14.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat14.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat25 = u_xlat7.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat7.x = max(u_xlat25, u_xlat26);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					    } else {
					        u_xlat7.x = float(1.0);
					        u_xlat7.y = float(1.0);
					        u_xlat7.z = float(1.0);
					        u_xlat7.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat25 = dot(u_xlat7, unity_OcclusionMaskSelector);
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat26 = dot(u_xlat13.xyz, u_xlat13.xyz);
					    u_xlat10_7 = texture(_LightTexture0, vec2(u_xlat26));
					    u_xlat25 = u_xlat25 * u_xlat10_7.x;
					    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat26 = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat26 = inversesqrt(u_xlat26);
					    u_xlat3.xyz = vec3(u_xlat26) * u_xlat7.xyz;
					    u_xlat13.xyz = vec3(u_xlat25) * _LightColor0.xyz;
					    u_xlat16_14.xyz = u_xlat10_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat14.xyz = vec3(_Float0) * u_xlat16_14.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat25 = (-_Float0) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat25) * u_xlat10_4.xyz;
					    u_xlat16_25 = (-u_xlat10_5.x) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat10 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x * u_xlat0.x;
					    u_xlat8.x = dot(u_xlat8.xx, vec2(u_xlat16_25));
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat1.x;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat1.x = -abs(u_xlat24) + 1.0;
					    u_xlat9 = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat9 * u_xlat9;
					    u_xlat1.x = u_xlat1.x * u_xlat9;
					    u_xlat8.x = u_xlat8.x * u_xlat1.x + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16_16 = u_xlat16_25 * u_xlat16_25;
					    u_xlat16_16 = max(u_xlat16_16, 0.00200000009);
					    u_xlat16_1 = (-u_xlat16_16) + 1.0;
					    u_xlat9 = abs(u_xlat24) * u_xlat16_1 + u_xlat16_16;
					    u_xlat1.x = u_xlat2.x * u_xlat16_1 + u_xlat16_16;
					    u_xlat24 = abs(u_xlat24) * u_xlat1.x;
					    u_xlat24 = u_xlat2.x * u_xlat9 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16_16 = u_xlat16_16 * u_xlat16_16;
					    u_xlat1.x = u_xlat10 * u_xlat16_16 + (-u_xlat10);
					    u_xlat1.x = u_xlat1.x * u_xlat10 + 1.0;
					    u_xlat16_16 = u_xlat16_16 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat16 = u_xlat16_16 / u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat2.xx * u_xlat8.xy;
					    u_xlat24 = dot(u_xlat14.xyz, u_xlat14.xyz);
					    u_xlatb24 = u_xlat24!=0.0;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16 = u_xlat24 * u_xlat8.y;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat13.xyz;
					    u_xlat8.xyz = u_xlat13.xyz * vec3(u_xlat16);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat2.xyz = (-u_xlat14.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat14.xyz;
					    u_xlat0.xyz = u_xlat8.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_6.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Float0;
						vec4 _TextureSample2_ST;
						vec4 _TextureSample3_ST;
						vec4 unused_0_8;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _TextureSample3;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec2 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					vec3 u_xlat11;
					vec3 u_xlat12;
					vec3 u_xlat16_12;
					float u_xlat14;
					float u_xlat16_14;
					float u_xlat15;
					float u_xlat16_15;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat16_22;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat10_2 = texture(_TextureSample1, u_xlat2.xy);
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_3 = texture(_TextureSample0, u_xlat3.xy);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_4 = texture(_TextureSample2, u_xlat4.xy);
					    u_xlat11.xy = vs_TEXCOORD0.xy * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
					    u_xlat10_5 = texture(_TextureSample3, u_xlat11.xy);
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat11.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat11.xyz;
					        u_xlat11.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat11.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat11.xyz = (bool(u_xlatb22)) ? u_xlat11.xyz : vs_TEXCOORD4.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat11.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat22, u_xlat23);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat22 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz;
					    u_xlat11.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat16_12.xyz = u_xlat10_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat12.xyz = vec3(_Float0) * u_xlat16_12.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Float0) * 0.779083729 + 0.779083729;
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat10_3.xyz;
					    u_xlat16_22 = (-u_xlat10_4.x) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat8 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat16_22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat15 = u_xlat14 * u_xlat14;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat14 = u_xlat14 * u_xlat15;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat15 = -abs(u_xlat21) + 1.0;
					    u_xlat2.x = u_xlat15 * u_xlat15;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat15 = u_xlat15 * u_xlat2.x;
					    u_xlat7.x = u_xlat7.x * u_xlat15 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat16_14 = u_xlat16_22 * u_xlat16_22;
					    u_xlat16_14 = max(u_xlat16_14, 0.00200000009);
					    u_xlat16_15 = (-u_xlat16_14) + 1.0;
					    u_xlat22 = abs(u_xlat21) * u_xlat16_15 + u_xlat16_14;
					    u_xlat15 = u_xlat1.x * u_xlat16_15 + u_xlat16_14;
					    u_xlat21 = abs(u_xlat21) * u_xlat15;
					    u_xlat21 = u_xlat1.x * u_xlat22 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat16_14 = u_xlat16_14 * u_xlat16_14;
					    u_xlat15 = u_xlat8 * u_xlat16_14 + (-u_xlat8);
					    u_xlat8 = u_xlat15 * u_xlat8 + 1.0;
					    u_xlat16_14 = u_xlat16_14 * 0.318309873;
					    u_xlat8 = u_xlat8 * u_xlat8 + 1.00000001e-07;
					    u_xlat14 = u_xlat16_14 / u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat12.xyz, u_xlat12.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat11.xyz;
					    u_xlat7.xyz = u_xlat11.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat12.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_5.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Float0;
						vec4 _TextureSample2_ST;
						vec4 _TextureSample3_ST;
						vec4 unused_0_9;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _TextureSample3;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat16_1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec2 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec4 u_xlat10_7;
					vec4 u_xlat8;
					vec4 u_xlat10_8;
					vec3 u_xlat9;
					float u_xlat10;
					float u_xlat11;
					vec3 u_xlat14;
					vec3 u_xlat15;
					vec3 u_xlat16_15;
					float u_xlat18;
					float u_xlat16_18;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat16_28;
					bool u_xlatb28;
					float u_xlat29;
					bool u_xlatb29;
					float u_xlat30;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat10_3 = texture(_TextureSample1, u_xlat3.xy);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_5 = texture(_TextureSample2, u_xlat5.xy);
					    u_xlat14.xy = vs_TEXCOORD0.xy * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
					    u_xlat10_6 = texture(_TextureSample3, u_xlat14.xy);
					    u_xlat7 = vs_TEXCOORD4.yyyy * unity_WorldToLight[1];
					    u_xlat7 = unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat7;
					    u_xlat7 = unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat7;
					    u_xlat7 = u_xlat7 + unity_WorldToLight[3];
					    u_xlatb28 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb28){
					        u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat14.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat14.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat14.xyz;
					        u_xlat14.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat14.xyz;
					        u_xlat14.xyz = u_xlat14.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat14.xyz = (bool(u_xlatb28)) ? u_xlat14.xyz : vs_TEXCOORD4.xyz;
					        u_xlat14.xyz = u_xlat14.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat8.yzw = u_xlat14.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat28 = u_xlat8.y * 0.25 + 0.75;
					        u_xlat29 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat8.x = max(u_xlat28, u_xlat29);
					        u_xlat8 = texture(unity_ProbeVolumeSH, u_xlat8.xzw);
					    } else {
					        u_xlat8.x = float(1.0);
					        u_xlat8.y = float(1.0);
					        u_xlat8.z = float(1.0);
					        u_xlat8.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat28 = dot(u_xlat8, unity_OcclusionMaskSelector);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlatb29 = 0.0<u_xlat7.z;
					    u_xlat29 = u_xlatb29 ? 1.0 : float(0.0);
					    u_xlat14.xy = u_xlat7.xy / u_xlat7.ww;
					    u_xlat14.xy = u_xlat14.xy + vec2(0.5, 0.5);
					    u_xlat10_8 = texture(_LightTexture0, u_xlat14.xy);
					    u_xlat29 = u_xlat29 * u_xlat10_8.w;
					    u_xlat30 = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat10_7 = texture(_LightTextureB0, vec2(u_xlat30));
					    u_xlat29 = u_xlat29 * u_xlat10_7.x;
					    u_xlat28 = u_xlat28 * u_xlat29;
					    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat29 = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat3.xyz = vec3(u_xlat29) * u_xlat7.xyz;
					    u_xlat14.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    u_xlat16_15.xyz = u_xlat10_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat15.xyz = vec3(_Float0) * u_xlat16_15.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat28 = (-_Float0) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat28) * u_xlat10_4.xyz;
					    u_xlat16_28 = (-u_xlat10_5.x) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat2.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = dot(u_xlat9.xx, vec2(u_xlat16_28));
					    u_xlat9.x = u_xlat9.x + -0.5;
					    u_xlat18 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat18 = u_xlat9.x * u_xlat18 + 1.0;
					    u_xlat1.x = -abs(u_xlat27) + 1.0;
					    u_xlat10 = u_xlat1.x * u_xlat1.x;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat1.x = u_xlat1.x * u_xlat10;
					    u_xlat9.x = u_xlat9.x * u_xlat1.x + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat16_18 = u_xlat16_28 * u_xlat16_28;
					    u_xlat16_18 = max(u_xlat16_18, 0.00200000009);
					    u_xlat16_1 = (-u_xlat16_18) + 1.0;
					    u_xlat10 = abs(u_xlat27) * u_xlat16_1 + u_xlat16_18;
					    u_xlat1.x = u_xlat2.x * u_xlat16_1 + u_xlat16_18;
					    u_xlat27 = abs(u_xlat27) * u_xlat1.x;
					    u_xlat27 = u_xlat2.x * u_xlat10 + u_xlat27;
					    u_xlat27 = u_xlat27 + 9.99999975e-06;
					    u_xlat27 = 0.5 / u_xlat27;
					    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
					    u_xlat1.x = u_xlat11 * u_xlat16_18 + (-u_xlat11);
					    u_xlat1.x = u_xlat1.x * u_xlat11 + 1.0;
					    u_xlat16_18 = u_xlat16_18 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat18 = u_xlat16_18 / u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat27;
					    u_xlat18 = u_xlat18 * 3.14159274;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = u_xlat2.xx * u_xlat9.xy;
					    u_xlat27 = dot(u_xlat15.xyz, u_xlat15.xyz);
					    u_xlatb27 = u_xlat27!=0.0;
					    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat27 * u_xlat9.y;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat14.xyz;
					    u_xlat9.xyz = u_xlat14.xyz * vec3(u_xlat18);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat2.xyz = (-u_xlat15.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat15.xyz;
					    u_xlat0.xyz = u_xlat9.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_6.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Float0;
						vec4 _TextureSample2_ST;
						vec4 _TextureSample3_ST;
						vec4 unused_0_9;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _TextureSample3;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					float u_xlat16_1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec2 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec4 u_xlat10_7;
					vec4 u_xlat10_8;
					vec3 u_xlat9;
					float u_xlat10;
					float u_xlat11;
					vec3 u_xlat14;
					vec3 u_xlat15;
					vec3 u_xlat16_15;
					float u_xlat18;
					float u_xlat16_18;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat28;
					float u_xlat16_28;
					bool u_xlatb28;
					float u_xlat29;
					float u_xlat16_29;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat1.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat28 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat2.xyz = vec3(u_xlat28) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat10_3 = texture(_TextureSample1, u_xlat3.xy);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_5 = texture(_TextureSample2, u_xlat5.xy);
					    u_xlat14.xy = vs_TEXCOORD0.xy * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
					    u_xlat10_6 = texture(_TextureSample3, u_xlat14.xy);
					    u_xlat14.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat14.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat14.xyz;
					    u_xlat14.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat14.xyz;
					    u_xlat14.xyz = u_xlat14.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb28 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb28){
					        u_xlatb28 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat15.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat15.xyz;
					        u_xlat15.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat15.xyz;
					        u_xlat15.xyz = u_xlat15.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat15.xyz = (bool(u_xlatb28)) ? u_xlat15.xyz : vs_TEXCOORD4.xyz;
					        u_xlat15.xyz = u_xlat15.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat15.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat28 = u_xlat7.y * 0.25 + 0.75;
					        u_xlat29 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat7.x = max(u_xlat28, u_xlat29);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					    } else {
					        u_xlat7.x = float(1.0);
					        u_xlat7.y = float(1.0);
					        u_xlat7.z = float(1.0);
					        u_xlat7.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat28 = dot(u_xlat7, unity_OcclusionMaskSelector);
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat29 = dot(u_xlat14.xyz, u_xlat14.xyz);
					    u_xlat10_7 = texture(_LightTextureB0, vec2(u_xlat29));
					    u_xlat10_8 = texture(_LightTexture0, u_xlat14.xyz);
					    u_xlat16_29 = u_xlat10_7.x * u_xlat10_8.w;
					    u_xlat28 = u_xlat28 * u_xlat16_29;
					    u_xlat7.x = dot(vs_TEXCOORD1.xyz, u_xlat10_3.xyz);
					    u_xlat7.y = dot(vs_TEXCOORD2.xyz, u_xlat10_3.xyz);
					    u_xlat7.z = dot(vs_TEXCOORD3.xyz, u_xlat10_3.xyz);
					    u_xlat29 = dot(u_xlat7.xyz, u_xlat7.xyz);
					    u_xlat29 = inversesqrt(u_xlat29);
					    u_xlat3.xyz = vec3(u_xlat29) * u_xlat7.xyz;
					    u_xlat14.xyz = vec3(u_xlat28) * _LightColor0.xyz;
					    u_xlat16_15.xyz = u_xlat10_4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat15.xyz = vec3(_Float0) * u_xlat16_15.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat28 = (-_Float0) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat28) * u_xlat10_4.xyz;
					    u_xlat16_28 = (-u_xlat10_5.x) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat27) + u_xlat2.xyz;
					    u_xlat27 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat27 = max(u_xlat27, 0.00100000005);
					    u_xlat27 = inversesqrt(u_xlat27);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz;
					    u_xlat27 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat11 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat11 = clamp(u_xlat11, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat9.x = u_xlat0.x * u_xlat0.x;
					    u_xlat9.x = dot(u_xlat9.xx, vec2(u_xlat16_28));
					    u_xlat9.x = u_xlat9.x + -0.5;
					    u_xlat18 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat1.x;
					    u_xlat18 = u_xlat9.x * u_xlat18 + 1.0;
					    u_xlat1.x = -abs(u_xlat27) + 1.0;
					    u_xlat10 = u_xlat1.x * u_xlat1.x;
					    u_xlat10 = u_xlat10 * u_xlat10;
					    u_xlat1.x = u_xlat1.x * u_xlat10;
					    u_xlat9.x = u_xlat9.x * u_xlat1.x + 1.0;
					    u_xlat9.x = u_xlat9.x * u_xlat18;
					    u_xlat16_18 = u_xlat16_28 * u_xlat16_28;
					    u_xlat16_18 = max(u_xlat16_18, 0.00200000009);
					    u_xlat16_1 = (-u_xlat16_18) + 1.0;
					    u_xlat10 = abs(u_xlat27) * u_xlat16_1 + u_xlat16_18;
					    u_xlat1.x = u_xlat2.x * u_xlat16_1 + u_xlat16_18;
					    u_xlat27 = abs(u_xlat27) * u_xlat1.x;
					    u_xlat27 = u_xlat2.x * u_xlat10 + u_xlat27;
					    u_xlat27 = u_xlat27 + 9.99999975e-06;
					    u_xlat27 = 0.5 / u_xlat27;
					    u_xlat16_18 = u_xlat16_18 * u_xlat16_18;
					    u_xlat1.x = u_xlat11 * u_xlat16_18 + (-u_xlat11);
					    u_xlat1.x = u_xlat1.x * u_xlat11 + 1.0;
					    u_xlat16_18 = u_xlat16_18 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat18 = u_xlat16_18 / u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat27;
					    u_xlat18 = u_xlat18 * 3.14159274;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = u_xlat2.xx * u_xlat9.xy;
					    u_xlat27 = dot(u_xlat15.xyz, u_xlat15.xyz);
					    u_xlatb27 = u_xlat27!=0.0;
					    u_xlat27 = u_xlatb27 ? 1.0 : float(0.0);
					    u_xlat18 = u_xlat27 * u_xlat9.y;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat14.xyz;
					    u_xlat9.xyz = u_xlat14.xyz * vec3(u_xlat18);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat2.xyz = (-u_xlat15.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat15.xyz;
					    u_xlat0.xyz = u_xlat9.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_6.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 _LightColor0;
						vec4 unused_0_3;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Float0;
						vec4 _TextureSample2_ST;
						vec4 _TextureSample3_ST;
						vec4 unused_0_9;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _TextureSample3;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec2 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					float u_xlat8;
					vec3 u_xlat11;
					vec3 u_xlat12;
					vec3 u_xlat16_12;
					float u_xlat14;
					float u_xlat16_14;
					float u_xlat15;
					float u_xlat16_15;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat16_22;
					bool u_xlatb22;
					float u_xlat23;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat10_2 = texture(_TextureSample1, u_xlat2.xy);
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_3 = texture(_TextureSample0, u_xlat3.xy);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_4 = texture(_TextureSample2, u_xlat4.xy);
					    u_xlat11.xy = vs_TEXCOORD0.xy * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
					    u_xlat10_5 = texture(_TextureSample3, u_xlat11.xy);
					    u_xlat11.xy = vs_TEXCOORD4.yy * unity_WorldToLight[1].xy;
					    u_xlat11.xy = unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat11.xy;
					    u_xlat11.xy = unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat11.xy;
					    u_xlat11.xy = u_xlat11.xy + unity_WorldToLight[3].xy;
					    u_xlatb22 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb22){
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat12.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat12.xyz;
					        u_xlat12.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat12.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat12.xyz = (bool(u_xlatb22)) ? u_xlat12.xyz : vs_TEXCOORD4.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat12.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat22 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat23 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat22, u_xlat23);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat22 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat10_6 = texture(_LightTexture0, u_xlat11.xy);
					    u_xlat22 = u_xlat22 * u_xlat10_6.w;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat10_2.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat10_2.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat10_2.xyz);
					    u_xlat2.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat6.xyz;
					    u_xlat11.xyz = vec3(u_xlat22) * _LightColor0.xyz;
					    u_xlat16_12.xyz = u_xlat10_3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat12.xyz = vec3(_Float0) * u_xlat16_12.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat22 = (-_Float0) * 0.779083729 + 0.779083729;
					    u_xlat3.xyz = vec3(u_xlat22) * u_xlat10_3.xyz;
					    u_xlat16_22 = (-u_xlat10_4.x) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat8 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat16_22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat1.x) + 1.0;
					    u_xlat15 = u_xlat14 * u_xlat14;
					    u_xlat15 = u_xlat15 * u_xlat15;
					    u_xlat14 = u_xlat14 * u_xlat15;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat15 = -abs(u_xlat21) + 1.0;
					    u_xlat2.x = u_xlat15 * u_xlat15;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat15 = u_xlat15 * u_xlat2.x;
					    u_xlat7.x = u_xlat7.x * u_xlat15 + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat16_14 = u_xlat16_22 * u_xlat16_22;
					    u_xlat16_14 = max(u_xlat16_14, 0.00200000009);
					    u_xlat16_15 = (-u_xlat16_14) + 1.0;
					    u_xlat22 = abs(u_xlat21) * u_xlat16_15 + u_xlat16_14;
					    u_xlat15 = u_xlat1.x * u_xlat16_15 + u_xlat16_14;
					    u_xlat21 = abs(u_xlat21) * u_xlat15;
					    u_xlat21 = u_xlat1.x * u_xlat22 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat16_14 = u_xlat16_14 * u_xlat16_14;
					    u_xlat15 = u_xlat8 * u_xlat16_14 + (-u_xlat8);
					    u_xlat8 = u_xlat15 * u_xlat8 + 1.0;
					    u_xlat16_14 = u_xlat16_14 * 0.318309873;
					    u_xlat8 = u_xlat8 * u_xlat8 + 1.00000001e-07;
					    u_xlat14 = u_xlat16_14 / u_xlat8;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat1.xx * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat12.xyz, u_xlat12.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat11.xyz;
					    u_xlat7.xyz = u_xlat11.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat12.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat12.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat10_5.x;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "ShadowCaster"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			ColorMask RGB -1
			Cull Off
			GpuProgramID 203887
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat8;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_LightShadowBias.z;
					    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlatb13 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb13)) ? u_xlat1.xyz : u_xlat0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat8 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat8);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat8) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat8;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					bool u_xlatb13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = (-u_xlat0.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = (-u_xlat1.x) * u_xlat1.x + 1.0;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * unity_LightShadowBias.z;
					    u_xlat1.xyz = (-u_xlat2.xyz) * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlatb13 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb13)) ? u_xlat1.xyz : u_xlat0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "UNITY_PASS_SHADOWCASTER" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[8];
						vec4 _TextureSample3_ST;
					};
					uniform  sampler2D _TextureSample3;
					uniform  sampler3D _DitherMaskLOD;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					bool u_xlatb0;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD1.xy * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
					    u_xlat10_0 = texture(_TextureSample3, u_xlat0.xy);
					    u_xlat0.z = u_xlat10_0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat10_0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat10_0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" "UNITY_PASS_SHADOWCASTER" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[8];
						vec4 _TextureSample3_ST;
					};
					uniform  sampler2D _TextureSample3;
					uniform  sampler3D _DitherMaskLOD;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					bool u_xlatb0;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xy = vs_TEXCOORD1.xy * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
					    u_xlat10_0 = texture(_TextureSample3, u_xlat0.xy);
					    u_xlat0.z = u_xlat10_0.x * 0.9375;
					    u_xlat0.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat10_0 = texture(_DitherMaskLOD, u_xlat0.xyz);
					    u_xlat0.x = u_xlat10_0.w + -0.00999999978;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
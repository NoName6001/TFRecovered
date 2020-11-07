Shader "HairShader_2Sided_Liz" {
	Properties {
		_Cutoff ("Mask Clip Value", Float) = 0.75
		_TextureSample0 ("Texture Sample 0", 2D) = "white" {}
		_TextureSample1 ("Texture Sample 1", 2D) = "bump" {}
		_Specular ("Specular", 2D) = "black" {}
		_Spec_Contrast ("Spec_Contrast", Float) = 0
		_Metallic ("Metallic", Float) = 0
		_WetnessRT ("WetnessRT", 2D) = "black" {}
		_Spec_Brightness ("Spec_Brightness", Float) = 0
		_FluidShininess ("FluidShininess", Float) = 0.77
		_Diffuse_Brightness ("Diffuse_Brightness", Float) = 0
		_MaxOriginalSpecular ("MaxOriginalSpecular", Float) = 1
		_NormalValue ("NormalValue", Float) = 1
		_TextureSample2 ("Texture Sample 2", 2D) = "white" {}
		[HideInInspector] _texcoord ("", 2D) = "white" {}
		[HideInInspector] _texcoord2 ("", 2D) = "white" {}
		[HideInInspector] __dirty ("", Float) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest+0" "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest+0" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Cull Off
			GpuProgramID 29752
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
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
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
					    vs_TEXCOORD1.w = u_xlat0.x;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat2.y;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD2.w = u_xlat0.y;
					    vs_TEXCOORD3.w = u_xlat0.z;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
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
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
					    vs_TEXCOORD1.w = u_xlat0.x;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.z = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.w = u_xlat0.y;
					    vs_TEXCOORD3.w = u_xlat0.z;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    vs_TEXCOORD2.z = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat3.w;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat2 = u_xlat3.ywzx * u_xlat3;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD4.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
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
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
					    vs_TEXCOORD1.w = u_xlat0.x;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat2.y;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD2.w = u_xlat0.y;
					    vs_TEXCOORD3.w = u_xlat0.z;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					float u_xlat20;
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
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat20 = inversesqrt(u_xlat20);
					    u_xlat3 = vec4(u_xlat20) * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat4.xyz = vec3(u_xlat18) * u_xlat4.xyz;
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.w = u_xlat0.x;
					    vs_TEXCOORD1.z = u_xlat3.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    vs_TEXCOORD2.w = u_xlat0.y;
					    vs_TEXCOORD2.z = u_xlat3.y;
					    vs_TEXCOORD3.w = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat3.w;
					    u_xlat2 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat3.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat2 * u_xlat2 + u_xlat4;
					    u_xlat2 = u_xlat2 * u_xlat3.xxxx + u_xlat5;
					    u_xlat2 = u_xlat0 * u_xlat3.wwzw + u_xlat2;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat4;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat18 = u_xlat3.y * u_xlat3.y;
					    u_xlat18 = u_xlat3.x * u_xlat3.x + (-u_xlat18);
					    u_xlat3 = u_xlat3.ywzx * u_xlat3;
					    u_xlat4.x = dot(unity_SHBr, u_xlat3);
					    u_xlat4.y = dot(unity_SHBg, u_xlat3);
					    u_xlat4.z = dot(unity_SHBb, u_xlat3);
					    u_xlat3.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    vs_TEXCOORD4.xyz = u_xlat0.xyz * u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
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
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_16[2];
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
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					float u_xlat14;
					float u_xlat15;
					float u_xlat16;
					float u_xlat27;
					float u_xlat28;
					float u_xlat39;
					float u_xlat40;
					float u_xlat16_40;
					float u_xlat41;
					bool u_xlatb41;
					float u_xlat42;
					float u_xlat43;
					float u_xlat16_43;
					float u_xlat44;
					bool u_xlatb44;
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
					    u_xlat3 = texture(_TextureSample1, u_xlat3.xy);
					    u_xlat3.x = u_xlat3.w * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat40 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat3.z = sqrt(u_xlat40);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4.xyz = u_xlat10_4.xyz + vec3(_Diffuse_Brightness);
					    u_xlat5.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_5 = texture(_WetnessRT, u_xlat5.xy);
					    u_xlat16_40 = max(u_xlat10_5.w, 0.0);
					    u_xlat40 = min(u_xlat16_40, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_5 = texture(_Specular, u_xlat5.xy);
					    u_xlat41 = u_xlat10_5.x + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat41 = dot(u_xlat5.xy, vec2(u_xlat41));
					    u_xlat41 = max(u_xlat41, 0.0);
					    u_xlat41 = min(u_xlat41, _MaxOriginalSpecular);
					    u_xlat40 = u_xlat40 + u_xlat41;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_5 = texture(_TextureSample2, u_xlat5.xy);
					    u_xlat41 = u_xlat10_5.x + (-_Cutoff);
					    u_xlatb41 = u_xlat41<0.0;
					    if(((int(u_xlatb41) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb41 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb41){
					        u_xlatb41 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb41)) ? u_xlat5.xyz : u_xlat0.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat41 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat42 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat41, u_xlat42);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat41 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat42 = (-u_xlat40) + 1.0;
					    u_xlat43 = dot((-u_xlat2.xyz), u_xlat3.xyz);
					    u_xlat43 = u_xlat43 + u_xlat43;
					    u_xlat5.xyz = u_xlat3.xyz * (-vec3(u_xlat43)) + (-u_xlat2.xyz);
					    u_xlat6.xyz = vec3(u_xlat41) * _LightColor0.xyz;
					    u_xlatb41 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb41){
					        u_xlat41 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat41 = inversesqrt(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat41) * u_xlat5.xyz;
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
					        u_xlat41 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat41 = min(u_xlat8.z, u_xlat41);
					        u_xlat8.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat41) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat5.xyz;
					    //ENDIF
					    }
					    u_xlat41 = (-u_xlat42) * 0.699999988 + 1.70000005;
					    u_xlat41 = u_xlat41 * u_xlat42;
					    u_xlat41 = u_xlat41 * 6.0;
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, u_xlat41);
					    u_xlat16_43 = u_xlat10_7.w + -1.0;
					    u_xlat43 = unity_SpecCube0_HDR.w * u_xlat16_43 + 1.0;
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat43);
					    u_xlatb44 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb44){
					        u_xlatb44 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb44){
					            u_xlat44 = dot(u_xlat5.xyz, u_xlat5.xyz);
					            u_xlat44 = inversesqrt(u_xlat44);
					            u_xlat9.xyz = vec3(u_xlat44) * u_xlat5.xyz;
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
					            u_xlat44 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat44 = min(u_xlat10.z, u_xlat44);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat5.xyz = u_xlat9.xyz * vec3(u_xlat44) + u_xlat0.xyz;
					        //ENDIF
					        }
					        u_xlat10_5 = textureLod(unity_SpecCube1, u_xlat5.xyz, u_xlat41);
					        u_xlat16_0 = u_xlat10_5.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0 + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat10_5.xyz * u_xlat0.xxx;
					        u_xlat5.xyz = vec3(u_xlat43) * u_xlat10_7.xyz + (-u_xlat0.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat0.xyz;
					    //ENDIF
					    }
					    u_xlat0.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat0.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat0.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat41 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
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
					    u_xlat14 = dot(vec2(u_xlat14), vec2(u_xlat42));
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
					    u_xlat27 = u_xlat42 * u_xlat42;
					    u_xlat27 = max(u_xlat27, 0.00200000009);
					    u_xlat3.x = (-u_xlat27) + 1.0;
					    u_xlat16 = abs(u_xlat39) * u_xlat3.x + u_xlat27;
					    u_xlat3.x = u_xlat2.x * u_xlat3.x + u_xlat27;
					    u_xlat39 = abs(u_xlat39) * u_xlat3.x;
					    u_xlat39 = u_xlat2.x * u_xlat16 + u_xlat39;
					    u_xlat39 = u_xlat39 + 9.99999975e-06;
					    u_xlat39 = 0.5 / u_xlat39;
					    u_xlat3.x = u_xlat27 * u_xlat27;
					    u_xlat16 = u_xlat15 * u_xlat3.x + (-u_xlat15);
					    u_xlat15 = u_xlat16 * u_xlat15 + 1.0;
					    u_xlat3.x = u_xlat3.x * 0.318309873;
					    u_xlat15 = u_xlat15 * u_xlat15 + 1.00000001e-07;
					    u_xlat15 = u_xlat3.x / u_xlat15;
					    u_xlat39 = u_xlat39 * u_xlat15;
					    u_xlat39 = u_xlat39 * 3.14159274;
					    u_xlat39 = max(u_xlat39, 9.99999975e-05);
					    u_xlat39 = sqrt(u_xlat39);
					    u_xlat39 = u_xlat2.x * u_xlat39;
					    u_xlat27 = u_xlat27 * 0.280000001;
					    u_xlat27 = (-u_xlat27) * u_xlat42 + 1.0;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlatb2 = u_xlat2.x!=0.0;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat39 = u_xlat39 * u_xlat2.x;
					    u_xlat40 = u_xlat40 + (-u_xlat41);
					    u_xlat40 = u_xlat40 + 1.0;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat2.xyw = vec3(u_xlat14) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(u_xlat39);
					    u_xlat39 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat39 * u_xlat39;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat39 = u_xlat39 * u_xlat1.x;
					    u_xlat5.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xyz;
					    u_xlat2.xyw = u_xlat4.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat8.xyz * vec3(u_xlat27);
					    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat40);
					    u_xlat0.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat0.xyz + u_xlat2.xyw;
					    SV_Target0.w = 1.0;
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
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_16[2];
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
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec4 u_xlat10_8;
					vec3 u_xlat9;
					vec4 u_xlat10_9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					bvec3 u_xlatb13;
					float u_xlat15;
					float u_xlat16;
					vec3 u_xlat17;
					float u_xlat29;
					float u_xlat30;
					float u_xlat42;
					float u_xlat43;
					float u_xlat16_43;
					float u_xlat44;
					bool u_xlatb44;
					float u_xlat45;
					bool u_xlatb45;
					float u_xlat46;
					float u_xlat16_46;
					float u_xlat47;
					bool u_xlatb47;
					float u_xlat48;
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
					    u_xlat3 = texture(_TextureSample1, u_xlat3.xy);
					    u_xlat3.x = u_xlat3.w * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat43 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat3.z = sqrt(u_xlat43);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4.xyz = u_xlat10_4.xyz + vec3(_Diffuse_Brightness);
					    u_xlat5.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_5 = texture(_WetnessRT, u_xlat5.xy);
					    u_xlat16_43 = max(u_xlat10_5.w, 0.0);
					    u_xlat43 = min(u_xlat16_43, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_5 = texture(_Specular, u_xlat5.xy);
					    u_xlat44 = u_xlat10_5.x + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat44 = dot(u_xlat5.xy, vec2(u_xlat44));
					    u_xlat44 = max(u_xlat44, 0.0);
					    u_xlat44 = min(u_xlat44, _MaxOriginalSpecular);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_5 = texture(_TextureSample2, u_xlat5.xy);
					    u_xlat44 = u_xlat10_5.x + (-_Cutoff);
					    u_xlatb44 = u_xlat44<0.0;
					    if(((int(u_xlatb44) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb44 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb44){
					        u_xlatb45 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb45)) ? u_xlat5.xyz : u_xlat0.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat45 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat46 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat45, u_xlat46);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat45 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat3.x = (-u_xlat43) + 1.0;
					    u_xlat17.x = dot((-u_xlat2.xyz), u_xlat5.xyz);
					    u_xlat17.x = u_xlat17.x + u_xlat17.x;
					    u_xlat6.xyz = u_xlat5.xyz * (-u_xlat17.xxx) + (-u_xlat2.xyz);
					    u_xlat17.xyz = vec3(u_xlat45) * _LightColor0.xyz;
					    if(u_xlatb44){
					        u_xlatb44 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb44)) ? u_xlat7.xyz : u_xlat0.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat44 = u_xlat7.y * 0.25;
					        u_xlat46 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat48 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat44 = max(u_xlat44, u_xlat46);
					        u_xlat7.x = min(u_xlat48, u_xlat44);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					        u_xlat9.xyz = u_xlat7.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_9 = texture(unity_ProbeVolumeSH, u_xlat9.xyz);
					        u_xlat7.xyz = u_xlat7.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.w = 1.0;
					        u_xlat8.x = dot(u_xlat10_8, u_xlat5);
					        u_xlat8.y = dot(u_xlat10_9, u_xlat5);
					        u_xlat8.z = dot(u_xlat10_7, u_xlat5);
					    } else {
					        u_xlat5.w = 1.0;
					        u_xlat8.x = dot(unity_SHAr, u_xlat5);
					        u_xlat8.y = dot(unity_SHAg, u_xlat5);
					        u_xlat8.z = dot(unity_SHAb, u_xlat5);
					    //ENDIF
					    }
					    u_xlat7.xyz = u_xlat8.xyz + vs_TEXCOORD4.xyz;
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat7.xyz = log2(u_xlat7.xyz);
					    u_xlat7.xyz = u_xlat7.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat7.xyz = exp2(u_xlat7.xyz);
					    u_xlat7.xyz = u_xlat7.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb44 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb44){
					        u_xlat44 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat44 = inversesqrt(u_xlat44);
					        u_xlat8.xyz = vec3(u_xlat44) * u_xlat6.xyz;
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
					        u_xlat44 = min(u_xlat9.y, u_xlat9.x);
					        u_xlat44 = min(u_xlat9.z, u_xlat44);
					        u_xlat9.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat44) + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat6.xyz;
					    //ENDIF
					    }
					    u_xlat44 = (-u_xlat3.x) * 0.699999988 + 1.70000005;
					    u_xlat44 = u_xlat44 * u_xlat3.x;
					    u_xlat44 = u_xlat44 * 6.0;
					    u_xlat10_8 = textureLod(unity_SpecCube0, u_xlat8.xyz, u_xlat44);
					    u_xlat16_46 = u_xlat10_8.w + -1.0;
					    u_xlat46 = unity_SpecCube0_HDR.w * u_xlat16_46 + 1.0;
					    u_xlat46 = u_xlat46 * unity_SpecCube0_HDR.x;
					    u_xlat9.xyz = u_xlat10_8.xyz * vec3(u_xlat46);
					    u_xlatb47 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb47){
					        u_xlatb47 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb47){
					            u_xlat47 = dot(u_xlat6.xyz, u_xlat6.xyz);
					            u_xlat47 = inversesqrt(u_xlat47);
					            u_xlat10.xyz = vec3(u_xlat47) * u_xlat6.xyz;
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
					            u_xlat47 = min(u_xlat11.y, u_xlat11.x);
					            u_xlat47 = min(u_xlat11.z, u_xlat47);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat6.xyz = u_xlat10.xyz * vec3(u_xlat47) + u_xlat0.xyz;
					        //ENDIF
					        }
					        u_xlat10_6 = textureLod(unity_SpecCube1, u_xlat6.xyz, u_xlat44);
					        u_xlat16_0 = u_xlat10_6.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0 + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat10_6.xyz * u_xlat0.xxx;
					        u_xlat6.xyz = vec3(u_xlat46) * u_xlat10_8.xyz + (-u_xlat0.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat0.xyz;
					    //ENDIF
					    }
					    u_xlat0.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat0.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat0.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat44 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat44) * u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat42) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat1.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat42 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat15 = u_xlat1.x * u_xlat1.x;
					    u_xlat15 = dot(vec2(u_xlat15), u_xlat3.xx);
					    u_xlat15 = u_xlat15 + -0.5;
					    u_xlat29 = (-u_xlat2.x) + 1.0;
					    u_xlat30 = u_xlat29 * u_xlat29;
					    u_xlat30 = u_xlat30 * u_xlat30;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat29 = u_xlat15 * u_xlat29 + 1.0;
					    u_xlat30 = -abs(u_xlat42) + 1.0;
					    u_xlat46 = u_xlat30 * u_xlat30;
					    u_xlat46 = u_xlat46 * u_xlat46;
					    u_xlat30 = u_xlat30 * u_xlat46;
					    u_xlat15 = u_xlat15 * u_xlat30 + 1.0;
					    u_xlat15 = u_xlat15 * u_xlat29;
					    u_xlat15 = u_xlat2.x * u_xlat15;
					    u_xlat29 = u_xlat3.x * u_xlat3.x;
					    u_xlat29 = max(u_xlat29, 0.00200000009);
					    u_xlat46 = (-u_xlat29) + 1.0;
					    u_xlat5.x = abs(u_xlat42) * u_xlat46 + u_xlat29;
					    u_xlat46 = u_xlat2.x * u_xlat46 + u_xlat29;
					    u_xlat42 = abs(u_xlat42) * u_xlat46;
					    u_xlat42 = u_xlat2.x * u_xlat5.x + u_xlat42;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat46 = u_xlat29 * u_xlat29;
					    u_xlat5.x = u_xlat16 * u_xlat46 + (-u_xlat16);
					    u_xlat16 = u_xlat5.x * u_xlat16 + 1.0;
					    u_xlat46 = u_xlat46 * 0.318309873;
					    u_xlat16 = u_xlat16 * u_xlat16 + 1.00000001e-07;
					    u_xlat16 = u_xlat46 / u_xlat16;
					    u_xlat42 = u_xlat42 * u_xlat16;
					    u_xlat42 = u_xlat42 * 3.14159274;
					    u_xlat42 = max(u_xlat42, 9.99999975e-05);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat42 = u_xlat2.x * u_xlat42;
					    u_xlat29 = u_xlat29 * 0.280000001;
					    u_xlat29 = (-u_xlat29) * u_xlat3.x + 1.0;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlatb2 = u_xlat2.x!=0.0;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat42 = u_xlat42 * u_xlat2.x;
					    u_xlat2.x = (-u_xlat44) + 1.0;
					    u_xlat43 = u_xlat43 + u_xlat2.x;
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat2.xyw = u_xlat17.xyz * vec3(u_xlat15) + u_xlat7.xyz;
					    u_xlat3.xyz = u_xlat17.xyz * vec3(u_xlat42);
					    u_xlat42 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat42 * u_xlat42;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat42 = u_xlat42 * u_xlat1.x;
					    u_xlat5.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xyz;
					    u_xlat2.xyw = u_xlat4.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(u_xlat29);
					    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat43);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat3.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat0.xyz + u_xlat2.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_16[2];
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					float u_xlat14;
					float u_xlat15;
					float u_xlat16;
					float u_xlat27;
					float u_xlat28;
					float u_xlat39;
					float u_xlat40;
					float u_xlat16_40;
					float u_xlat41;
					bool u_xlatb41;
					float u_xlat42;
					bool u_xlatb42;
					float u_xlat43;
					float u_xlat16_43;
					float u_xlat44;
					bool u_xlatb44;
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
					    u_xlat3 = texture(_TextureSample1, u_xlat3.xy);
					    u_xlat3.x = u_xlat3.w * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat40 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat3.z = sqrt(u_xlat40);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4.xyz = u_xlat10_4.xyz + vec3(_Diffuse_Brightness);
					    u_xlat5.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_5 = texture(_WetnessRT, u_xlat5.xy);
					    u_xlat16_40 = max(u_xlat10_5.w, 0.0);
					    u_xlat40 = min(u_xlat16_40, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_5 = texture(_Specular, u_xlat5.xy);
					    u_xlat41 = u_xlat10_5.x + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat41 = dot(u_xlat5.xy, vec2(u_xlat41));
					    u_xlat41 = max(u_xlat41, 0.0);
					    u_xlat41 = min(u_xlat41, _MaxOriginalSpecular);
					    u_xlat40 = u_xlat40 + u_xlat41;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_5 = texture(_TextureSample2, u_xlat5.xy);
					    u_xlat41 = u_xlat10_5.x + (-_Cutoff);
					    u_xlatb41 = u_xlat41<0.0;
					    if(((int(u_xlatb41) * int(0xffffffffu)))!=0){discard;}
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat41 = dot(u_xlat1.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat42 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat42 = (-u_xlat41) + u_xlat42;
					    u_xlat41 = unity_ShadowFadeCenterAndType.w * u_xlat42 + u_xlat41;
					    u_xlat41 = u_xlat41 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlatb42 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb42){
					        u_xlatb42 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb42)) ? u_xlat5.xyz : u_xlat0.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat42 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat43 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat42, u_xlat43);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat42 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat42 = clamp(u_xlat42, 0.0, 1.0);
					    u_xlat5.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat10_5 = texture(_ShadowMapTexture, u_xlat5.xy);
					    u_xlat42 = u_xlat42 + (-u_xlat10_5.x);
					    u_xlat41 = u_xlat41 * u_xlat42 + u_xlat10_5.x;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat42 = (-u_xlat40) + 1.0;
					    u_xlat43 = dot((-u_xlat2.xyz), u_xlat3.xyz);
					    u_xlat43 = u_xlat43 + u_xlat43;
					    u_xlat5.xyz = u_xlat3.xyz * (-vec3(u_xlat43)) + (-u_xlat2.xyz);
					    u_xlat6.xyz = vec3(u_xlat41) * _LightColor0.xyz;
					    u_xlatb41 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb41){
					        u_xlat41 = dot(u_xlat5.xyz, u_xlat5.xyz);
					        u_xlat41 = inversesqrt(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat41) * u_xlat5.xyz;
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
					        u_xlat41 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat41 = min(u_xlat8.z, u_xlat41);
					        u_xlat8.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat41) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat5.xyz;
					    //ENDIF
					    }
					    u_xlat41 = (-u_xlat42) * 0.699999988 + 1.70000005;
					    u_xlat41 = u_xlat41 * u_xlat42;
					    u_xlat41 = u_xlat41 * 6.0;
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, u_xlat41);
					    u_xlat16_43 = u_xlat10_7.w + -1.0;
					    u_xlat43 = unity_SpecCube0_HDR.w * u_xlat16_43 + 1.0;
					    u_xlat43 = u_xlat43 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat43);
					    u_xlatb44 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb44){
					        u_xlatb44 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb44){
					            u_xlat44 = dot(u_xlat5.xyz, u_xlat5.xyz);
					            u_xlat44 = inversesqrt(u_xlat44);
					            u_xlat9.xyz = vec3(u_xlat44) * u_xlat5.xyz;
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
					            u_xlat44 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat44 = min(u_xlat10.z, u_xlat44);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat5.xyz = u_xlat9.xyz * vec3(u_xlat44) + u_xlat0.xyz;
					        //ENDIF
					        }
					        u_xlat10_5 = textureLod(unity_SpecCube1, u_xlat5.xyz, u_xlat41);
					        u_xlat16_0 = u_xlat10_5.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0 + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat10_5.xyz * u_xlat0.xxx;
					        u_xlat5.xyz = vec3(u_xlat43) * u_xlat10_7.xyz + (-u_xlat0.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat0.xyz;
					    //ENDIF
					    }
					    u_xlat0.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat0.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat0.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat41 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat41) * u_xlat4.xyz;
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
					    u_xlat14 = dot(vec2(u_xlat14), vec2(u_xlat42));
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
					    u_xlat27 = u_xlat42 * u_xlat42;
					    u_xlat27 = max(u_xlat27, 0.00200000009);
					    u_xlat3.x = (-u_xlat27) + 1.0;
					    u_xlat16 = abs(u_xlat39) * u_xlat3.x + u_xlat27;
					    u_xlat3.x = u_xlat2.x * u_xlat3.x + u_xlat27;
					    u_xlat39 = abs(u_xlat39) * u_xlat3.x;
					    u_xlat39 = u_xlat2.x * u_xlat16 + u_xlat39;
					    u_xlat39 = u_xlat39 + 9.99999975e-06;
					    u_xlat39 = 0.5 / u_xlat39;
					    u_xlat3.x = u_xlat27 * u_xlat27;
					    u_xlat16 = u_xlat15 * u_xlat3.x + (-u_xlat15);
					    u_xlat15 = u_xlat16 * u_xlat15 + 1.0;
					    u_xlat3.x = u_xlat3.x * 0.318309873;
					    u_xlat15 = u_xlat15 * u_xlat15 + 1.00000001e-07;
					    u_xlat15 = u_xlat3.x / u_xlat15;
					    u_xlat39 = u_xlat39 * u_xlat15;
					    u_xlat39 = u_xlat39 * 3.14159274;
					    u_xlat39 = max(u_xlat39, 9.99999975e-05);
					    u_xlat39 = sqrt(u_xlat39);
					    u_xlat39 = u_xlat2.x * u_xlat39;
					    u_xlat27 = u_xlat27 * 0.280000001;
					    u_xlat27 = (-u_xlat27) * u_xlat42 + 1.0;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlatb2 = u_xlat2.x!=0.0;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat39 = u_xlat39 * u_xlat2.x;
					    u_xlat40 = u_xlat40 + (-u_xlat41);
					    u_xlat40 = u_xlat40 + 1.0;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat2.xyw = vec3(u_xlat14) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(u_xlat39);
					    u_xlat39 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat39 * u_xlat39;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat39 = u_xlat39 * u_xlat1.x;
					    u_xlat5.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xyz;
					    u_xlat2.xyw = u_xlat4.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat8.xyz * vec3(u_xlat27);
					    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat40);
					    u_xlat0.xyz = vec3(u_xlat28) * u_xlat3.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat0.xyz + u_xlat2.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_16[2];
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
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
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat8;
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
					vec3 u_xlat17;
					float u_xlat19;
					float u_xlat29;
					float u_xlat30;
					float u_xlat31;
					float u_xlat42;
					float u_xlat43;
					float u_xlat16_43;
					float u_xlat44;
					bool u_xlatb44;
					float u_xlat45;
					bool u_xlatb45;
					float u_xlat46;
					float u_xlat16_46;
					bool u_xlatb46;
					float u_xlat47;
					bool u_xlatb47;
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
					    u_xlat3 = texture(_TextureSample1, u_xlat3.xy);
					    u_xlat3.x = u_xlat3.w * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat43 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat3.z = sqrt(u_xlat43);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4.xyz = u_xlat10_4.xyz + vec3(_Diffuse_Brightness);
					    u_xlat5.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_5 = texture(_WetnessRT, u_xlat5.xy);
					    u_xlat16_43 = max(u_xlat10_5.w, 0.0);
					    u_xlat43 = min(u_xlat16_43, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_5 = texture(_Specular, u_xlat5.xy);
					    u_xlat44 = u_xlat10_5.x + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat44 = dot(u_xlat5.xy, vec2(u_xlat44));
					    u_xlat44 = max(u_xlat44, 0.0);
					    u_xlat44 = min(u_xlat44, _MaxOriginalSpecular);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_5 = texture(_TextureSample2, u_xlat5.xy);
					    u_xlat44 = u_xlat10_5.x + (-_Cutoff);
					    u_xlatb44 = u_xlat44<0.0;
					    if(((int(u_xlatb44) * int(0xffffffffu)))!=0){discard;}
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat44 = dot(u_xlat1.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat0.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat45 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat45 = sqrt(u_xlat45);
					    u_xlat45 = (-u_xlat44) + u_xlat45;
					    u_xlat44 = unity_ShadowFadeCenterAndType.w * u_xlat45 + u_xlat44;
					    u_xlat44 = u_xlat44 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlatb45 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb45){
					        u_xlatb46 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb46)) ? u_xlat5.xyz : u_xlat0.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat46 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat46, u_xlat19);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat46 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat46 = clamp(u_xlat46, 0.0, 1.0);
					    u_xlat5.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat10_5 = texture(_ShadowMapTexture, u_xlat5.xy);
					    u_xlat46 = u_xlat46 + (-u_xlat10_5.x);
					    u_xlat44 = u_xlat44 * u_xlat46 + u_xlat10_5.x;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat3.x = (-u_xlat43) + 1.0;
					    u_xlat17.x = dot((-u_xlat2.xyz), u_xlat5.xyz);
					    u_xlat17.x = u_xlat17.x + u_xlat17.x;
					    u_xlat6.xyz = u_xlat5.xyz * (-u_xlat17.xxx) + (-u_xlat2.xyz);
					    u_xlat7.xyz = vec3(u_xlat44) * _LightColor0.xyz;
					    if(u_xlatb45){
					        u_xlatb44 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat17.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat17.xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat17.xyz;
					        u_xlat17.xyz = u_xlat17.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat17.xyz = (bool(u_xlatb44)) ? u_xlat17.xyz : u_xlat0.xyz;
					        u_xlat17.xyz = u_xlat17.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat8.yzw = u_xlat17.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat44 = u_xlat8.y * 0.25;
					        u_xlat17.x = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat31 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat44 = max(u_xlat44, u_xlat17.x);
					        u_xlat8.x = min(u_xlat31, u_xlat44);
					        u_xlat10_9 = texture(unity_ProbeVolumeSH, u_xlat8.xzw);
					        u_xlat17.xyz = u_xlat8.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_10 = texture(unity_ProbeVolumeSH, u_xlat17.xyz);
					        u_xlat17.xyz = u_xlat8.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat17.xyz);
					        u_xlat5.w = 1.0;
					        u_xlat9.x = dot(u_xlat10_9, u_xlat5);
					        u_xlat9.y = dot(u_xlat10_10, u_xlat5);
					        u_xlat9.z = dot(u_xlat10_8, u_xlat5);
					    } else {
					        u_xlat5.w = 1.0;
					        u_xlat9.x = dot(unity_SHAr, u_xlat5);
					        u_xlat9.y = dot(unity_SHAg, u_xlat5);
					        u_xlat9.z = dot(unity_SHAb, u_xlat5);
					    //ENDIF
					    }
					    u_xlat17.xyz = u_xlat9.xyz + vs_TEXCOORD4.xyz;
					    u_xlat17.xyz = max(u_xlat17.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat17.xyz = log2(u_xlat17.xyz);
					    u_xlat17.xyz = u_xlat17.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat17.xyz = exp2(u_xlat17.xyz);
					    u_xlat17.xyz = u_xlat17.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat17.xyz = max(u_xlat17.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb44 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb44){
					        u_xlat44 = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat44 = inversesqrt(u_xlat44);
					        u_xlat8.xyz = vec3(u_xlat44) * u_xlat6.xyz;
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
					        u_xlat44 = min(u_xlat9.y, u_xlat9.x);
					        u_xlat44 = min(u_xlat9.z, u_xlat44);
					        u_xlat9.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat44) + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat6.xyz;
					    //ENDIF
					    }
					    u_xlat44 = (-u_xlat3.x) * 0.699999988 + 1.70000005;
					    u_xlat44 = u_xlat44 * u_xlat3.x;
					    u_xlat44 = u_xlat44 * 6.0;
					    u_xlat10_8 = textureLod(unity_SpecCube0, u_xlat8.xyz, u_xlat44);
					    u_xlat16_46 = u_xlat10_8.w + -1.0;
					    u_xlat46 = unity_SpecCube0_HDR.w * u_xlat16_46 + 1.0;
					    u_xlat46 = u_xlat46 * unity_SpecCube0_HDR.x;
					    u_xlat9.xyz = u_xlat10_8.xyz * vec3(u_xlat46);
					    u_xlatb47 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb47){
					        u_xlatb47 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb47){
					            u_xlat47 = dot(u_xlat6.xyz, u_xlat6.xyz);
					            u_xlat47 = inversesqrt(u_xlat47);
					            u_xlat10.xyz = vec3(u_xlat47) * u_xlat6.xyz;
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
					            u_xlat47 = min(u_xlat11.y, u_xlat11.x);
					            u_xlat47 = min(u_xlat11.z, u_xlat47);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat6.xyz = u_xlat10.xyz * vec3(u_xlat47) + u_xlat0.xyz;
					        //ENDIF
					        }
					        u_xlat10_6 = textureLod(unity_SpecCube1, u_xlat6.xyz, u_xlat44);
					        u_xlat16_0 = u_xlat10_6.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0 + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat10_6.xyz * u_xlat0.xxx;
					        u_xlat6.xyz = vec3(u_xlat46) * u_xlat10_8.xyz + (-u_xlat0.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat0.xyz;
					    //ENDIF
					    }
					    u_xlat0.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat0.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat0.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat44 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat44) * u_xlat4.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat42) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat1.xyz = vec3(u_xlat42) * u_xlat1.xyz;
					    u_xlat42 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat15 = u_xlat1.x * u_xlat1.x;
					    u_xlat15 = dot(vec2(u_xlat15), u_xlat3.xx);
					    u_xlat15 = u_xlat15 + -0.5;
					    u_xlat29 = (-u_xlat2.x) + 1.0;
					    u_xlat30 = u_xlat29 * u_xlat29;
					    u_xlat30 = u_xlat30 * u_xlat30;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat29 = u_xlat15 * u_xlat29 + 1.0;
					    u_xlat30 = -abs(u_xlat42) + 1.0;
					    u_xlat46 = u_xlat30 * u_xlat30;
					    u_xlat46 = u_xlat46 * u_xlat46;
					    u_xlat30 = u_xlat30 * u_xlat46;
					    u_xlat15 = u_xlat15 * u_xlat30 + 1.0;
					    u_xlat15 = u_xlat15 * u_xlat29;
					    u_xlat15 = u_xlat2.x * u_xlat15;
					    u_xlat29 = u_xlat3.x * u_xlat3.x;
					    u_xlat29 = max(u_xlat29, 0.00200000009);
					    u_xlat46 = (-u_xlat29) + 1.0;
					    u_xlat5.x = abs(u_xlat42) * u_xlat46 + u_xlat29;
					    u_xlat46 = u_xlat2.x * u_xlat46 + u_xlat29;
					    u_xlat42 = abs(u_xlat42) * u_xlat46;
					    u_xlat42 = u_xlat2.x * u_xlat5.x + u_xlat42;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat46 = u_xlat29 * u_xlat29;
					    u_xlat5.x = u_xlat16 * u_xlat46 + (-u_xlat16);
					    u_xlat16 = u_xlat5.x * u_xlat16 + 1.0;
					    u_xlat46 = u_xlat46 * 0.318309873;
					    u_xlat16 = u_xlat16 * u_xlat16 + 1.00000001e-07;
					    u_xlat16 = u_xlat46 / u_xlat16;
					    u_xlat42 = u_xlat42 * u_xlat16;
					    u_xlat42 = u_xlat42 * 3.14159274;
					    u_xlat42 = max(u_xlat42, 9.99999975e-05);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat42 = u_xlat2.x * u_xlat42;
					    u_xlat29 = u_xlat29 * 0.280000001;
					    u_xlat29 = (-u_xlat29) * u_xlat3.x + 1.0;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlatb2 = u_xlat2.x!=0.0;
					    u_xlat2.x = u_xlatb2 ? 1.0 : float(0.0);
					    u_xlat42 = u_xlat42 * u_xlat2.x;
					    u_xlat43 = u_xlat43 + (-u_xlat44);
					    u_xlat43 = u_xlat43 + 1.0;
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat2.xyw = u_xlat7.xyz * vec3(u_xlat15) + u_xlat17.xyz;
					    u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat42);
					    u_xlat42 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat42 * u_xlat42;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat42 = u_xlat42 * u_xlat1.x;
					    u_xlat5.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.xyz;
					    u_xlat2.xyw = u_xlat4.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(u_xlat29);
					    u_xlat3.xyz = (-u_xlat0.xyz) + vec3(u_xlat43);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat3.xyz + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat0.xyz + u_xlat2.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "AlphaTest+0" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Blend One One, One One
			ZWrite Off
			Cull Off
			GpuProgramID 124267
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[10];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[10];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[10];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[10];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec2 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD5.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SPOT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[10];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SHADOWS_SOFT" "SPOT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[9];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[10];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
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
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat0.zw;
					    vs_TEXCOORD6.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[10];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec2 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat2.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat17 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat17) * u_xlat4.xyz;
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat2.y;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD5.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[10];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[10];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[10];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[10];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_17[2];
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
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat16_22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.xy);
					    u_xlat3.x = u_xlat3.w * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat22 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat22 = min(u_xlat22, 1.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4.xyz = u_xlat10_4.xyz + vec3(_Diffuse_Brightness);
					    u_xlat5.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_5 = texture(_WetnessRT, u_xlat5.xy);
					    u_xlat16_22 = max(u_xlat10_5.w, 0.0);
					    u_xlat22 = min(u_xlat16_22, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_5 = texture(_Specular, u_xlat5.xy);
					    u_xlat23 = u_xlat10_5.x + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat23 = dot(u_xlat5.xy, vec2(u_xlat23));
					    u_xlat23 = max(u_xlat23, 0.0);
					    u_xlat23 = min(u_xlat23, _MaxOriginalSpecular);
					    u_xlat22 = u_xlat22 + u_xlat23;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_5 = texture(_TextureSample2, u_xlat5.xy);
					    u_xlat23 = u_xlat10_5.x + (-_Cutoff);
					    u_xlatb23 = u_xlat23<0.0;
					    if(((int(u_xlatb23) * int(0xffffffffu)))!=0){discard;}
					    u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb23 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb23){
					        u_xlatb23 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb23)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat23 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat24 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat23, u_xlat24);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat23 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_5 = texture(_LightTexture0, vec2(u_xlat24));
					    u_xlat23 = u_xlat23 * u_xlat10_5.x;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat23) * _LightColor0.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat23 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat23) * u_xlat4.xyz;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat5.xyz;
					    u_xlat7.xyz = u_xlat5.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
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
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_16[2];
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
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat16_19;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.xy);
					    u_xlat2.x = u_xlat2.w * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_NormalValue);
					    u_xlat19 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat19 = min(u_xlat19, 1.0);
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat2.z = sqrt(u_xlat19);
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_3 = texture(_TextureSample0, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat10_3.xyz + vec3(_Diffuse_Brightness);
					    u_xlat4.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_4 = texture(_WetnessRT, u_xlat4.xy);
					    u_xlat16_19 = max(u_xlat10_4.w, 0.0);
					    u_xlat19 = min(u_xlat16_19, _FluidShininess);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_4 = texture(_Specular, u_xlat4.xy);
					    u_xlat20 = u_xlat10_4.x + _Spec_Brightness;
					    u_xlat4.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat20 = dot(u_xlat4.xy, vec2(u_xlat20));
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat20 = min(u_xlat20, _MaxOriginalSpecular);
					    u_xlat19 = u_xlat19 + u_xlat20;
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_4 = texture(_TextureSample2, u_xlat4.xy);
					    u_xlat20 = u_xlat10_4.x + (-_Cutoff);
					    u_xlatb20 = u_xlat20<0.0;
					    if(((int(u_xlatb20) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb20 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb20){
					        u_xlatb20 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb20)) ? u_xlat4.xyz : vs_TEXCOORD4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat20 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat21 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat20, u_xlat21);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat20 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat4.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat20) * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat20 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat2.x = u_xlat13 * u_xlat13;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat4.xyz;
					    u_xlat6.xyz = u_xlat4.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat2.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_17[2];
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
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat16_22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.xy);
					    u_xlat3.x = u_xlat3.w * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat22 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat22 = min(u_xlat22, 1.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4.xyz = u_xlat10_4.xyz + vec3(_Diffuse_Brightness);
					    u_xlat5.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_5 = texture(_WetnessRT, u_xlat5.xy);
					    u_xlat16_22 = max(u_xlat10_5.w, 0.0);
					    u_xlat22 = min(u_xlat16_22, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_5 = texture(_Specular, u_xlat5.xy);
					    u_xlat23 = u_xlat10_5.x + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat23 = dot(u_xlat5.xy, vec2(u_xlat23));
					    u_xlat23 = max(u_xlat23, 0.0);
					    u_xlat23 = min(u_xlat23, _MaxOriginalSpecular);
					    u_xlat22 = u_xlat22 + u_xlat23;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_5 = texture(_TextureSample2, u_xlat5.xy);
					    u_xlat23 = u_xlat10_5.x + (-_Cutoff);
					    u_xlatb23 = u_xlat23<0.0;
					    if(((int(u_xlatb23) * int(0xffffffffu)))!=0){discard;}
					    u_xlat5 = vs_TEXCOORD4.yyyy * unity_WorldToLight[1];
					    u_xlat5 = unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat5;
					    u_xlat5 = unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat5;
					    u_xlat5 = u_xlat5 + unity_WorldToLight[3];
					    u_xlatb23 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb23){
					        u_xlatb23 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb23)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat23 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat24 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat23, u_xlat24);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat23 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlatb24 = 0.0<u_xlat5.z;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat6.xy = u_xlat5.xy / u_xlat5.ww;
					    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
					    u_xlat10_6 = texture(_LightTexture0, u_xlat6.xy);
					    u_xlat24 = u_xlat24 * u_xlat10_6.w;
					    u_xlat25 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_5 = texture(_LightTextureB0, vec2(u_xlat25));
					    u_xlat24 = u_xlat24 * u_xlat10_5.x;
					    u_xlat23 = u_xlat23 * u_xlat24;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat23) * _LightColor0.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat23 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat23) * u_xlat4.xyz;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat5.xyz;
					    u_xlat7.xyz = u_xlat5.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_17[2];
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
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat16_22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					float u_xlat16_24;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat3 = texture(_TextureSample1, u_xlat3.xy);
					    u_xlat3.x = u_xlat3.w * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat22 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat22 = min(u_xlat22, 1.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4.xyz = u_xlat10_4.xyz + vec3(_Diffuse_Brightness);
					    u_xlat5.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_5 = texture(_WetnessRT, u_xlat5.xy);
					    u_xlat16_22 = max(u_xlat10_5.w, 0.0);
					    u_xlat22 = min(u_xlat16_22, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_5 = texture(_Specular, u_xlat5.xy);
					    u_xlat23 = u_xlat10_5.x + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat23 = dot(u_xlat5.xy, vec2(u_xlat23));
					    u_xlat23 = max(u_xlat23, 0.0);
					    u_xlat23 = min(u_xlat23, _MaxOriginalSpecular);
					    u_xlat22 = u_xlat22 + u_xlat23;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_5 = texture(_TextureSample2, u_xlat5.xy);
					    u_xlat23 = u_xlat10_5.x + (-_Cutoff);
					    u_xlatb23 = u_xlat23<0.0;
					    if(((int(u_xlatb23) * int(0xffffffffu)))!=0){discard;}
					    u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb23 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb23){
					        u_xlatb23 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb23)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat23 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat24 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat23, u_xlat24);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat23 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat23 = clamp(u_xlat23, 0.0, 1.0);
					    u_xlat24 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_6 = texture(_LightTextureB0, vec2(u_xlat24));
					    u_xlat10_5 = texture(_LightTexture0, u_xlat5.xyz);
					    u_xlat16_24 = u_xlat10_5.w * u_xlat10_6.x;
					    u_xlat23 = u_xlat23 * u_xlat16_24;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat23) * _LightColor0.xyz;
					    u_xlat6.xyz = u_xlat4.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat23 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat4.xyz = vec3(u_xlat23) * u_xlat4.xyz;
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat22));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat22 * u_xlat22;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat21 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat5.xyz;
					    u_xlat7.xyz = u_xlat5.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat22 = u_xlat0.x * u_xlat0.x;
					    u_xlat22 = u_xlat22 * u_xlat22;
					    u_xlat0.x = u_xlat0.x * u_xlat22;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat7.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_17[2];
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
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat16_19;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.xy);
					    u_xlat2.x = u_xlat2.w * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_NormalValue);
					    u_xlat19 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat19 = min(u_xlat19, 1.0);
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat2.z = sqrt(u_xlat19);
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_3 = texture(_TextureSample0, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat10_3.xyz + vec3(_Diffuse_Brightness);
					    u_xlat4.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_4 = texture(_WetnessRT, u_xlat4.xy);
					    u_xlat16_19 = max(u_xlat10_4.w, 0.0);
					    u_xlat19 = min(u_xlat16_19, _FluidShininess);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_4 = texture(_Specular, u_xlat4.xy);
					    u_xlat20 = u_xlat10_4.x + _Spec_Brightness;
					    u_xlat4.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat20 = dot(u_xlat4.xy, vec2(u_xlat20));
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat20 = min(u_xlat20, _MaxOriginalSpecular);
					    u_xlat19 = u_xlat19 + u_xlat20;
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_4 = texture(_TextureSample2, u_xlat4.xy);
					    u_xlat20 = u_xlat10_4.x + (-_Cutoff);
					    u_xlatb20 = u_xlat20<0.0;
					    if(((int(u_xlatb20) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD4.yy * unity_WorldToLight[1].xy;
					    u_xlat4.xy = unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat4.xy;
					    u_xlat4.xy = unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat4.xy;
					    u_xlat4.xy = u_xlat4.xy + unity_WorldToLight[3].xy;
					    u_xlatb20 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb20){
					        u_xlatb20 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb20)) ? u_xlat5.xyz : vs_TEXCOORD4.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat20 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat21 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat20, u_xlat21);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat20 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlat10_4 = texture(_LightTexture0, u_xlat4.xy);
					    u_xlat20 = u_xlat20 * u_xlat10_4.w;
					    u_xlat4.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat20) * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat20 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat2.x = u_xlat13 * u_xlat13;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat4.xyz;
					    u_xlat6.xyz = u_xlat4.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat2.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SPOT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_17[2];
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[8];
						mat4x4 unity_WorldToShadow[4];
						vec4 unused_3_2[12];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2D _ShadowMapTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					float u_xlat9;
					vec3 u_xlat10;
					bool u_xlatb10;
					float u_xlat16;
					vec2 u_xlat18;
					float u_xlat10_18;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					float u_xlat16_25;
					float u_xlat26;
					bool u_xlatb26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat4 = texture(_TextureSample1, u_xlat4.xy);
					    u_xlat4.x = u_xlat4.w * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat25 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat25 = min(u_xlat25, 1.0);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat4.z = sqrt(u_xlat25);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5.xyz = u_xlat10_5.xyz + vec3(_Diffuse_Brightness);
					    u_xlat6.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_6 = texture(_WetnessRT, u_xlat6.xy);
					    u_xlat16_25 = max(u_xlat10_6.w, 0.0);
					    u_xlat25 = min(u_xlat16_25, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_6 = texture(_Specular, u_xlat6.xy);
					    u_xlat26 = u_xlat10_6.x + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat26 = dot(u_xlat6.xy, vec2(u_xlat26));
					    u_xlat26 = max(u_xlat26, 0.0);
					    u_xlat26 = min(u_xlat26, _MaxOriginalSpecular);
					    u_xlat25 = u_xlat25 + u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_6 = texture(_TextureSample2, u_xlat6.xy);
					    u_xlat26 = u_xlat10_6.x + (-_Cutoff);
					    u_xlatb26 = u_xlat26<0.0;
					    if(((int(u_xlatb26) * int(0xffffffffu)))!=0){discard;}
					    u_xlat6 = vs_TEXCOORD4.yyyy * unity_WorldToLight[1];
					    u_xlat6 = unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat6;
					    u_xlat6 = unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat6;
					    u_xlat6 = u_xlat6 + unity_WorldToLight[3];
					    u_xlat7.x = unity_MatrixV[0].z;
					    u_xlat7.y = unity_MatrixV[1].z;
					    u_xlat7.z = unity_MatrixV[2].z;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
					    u_xlat10.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = (-u_xlat2.x) + u_xlat10.x;
					    u_xlat2.x = unity_ShadowFadeCenterAndType.w * u_xlat10.x + u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb10 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb10){
					        u_xlatb10 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb10)) ? u_xlat7.xyz : vs_TEXCOORD4.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat7.y * 0.25 + 0.75;
					        u_xlat18.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat7.x = max(u_xlat18.x, u_xlat10.x);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					    } else {
					        u_xlat7.x = float(1.0);
					        u_xlat7.y = float(1.0);
					        u_xlat7.z = float(1.0);
					        u_xlat7.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat10.x = dot(u_xlat7, unity_OcclusionMaskSelector);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat7 = vs_TEXCOORD4.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					    u_xlat7 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD4.xxxx + u_xlat7;
					    u_xlat7 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD4.zzzz + u_xlat7;
					    u_xlat7 = u_xlat7 + unity_WorldToShadow[3 / 4][3 % 4];
					    u_xlat7.xyz = u_xlat7.xyz / u_xlat7.www;
					    vec3 txVec0 = vec3(u_xlat7.xy,u_xlat7.z);
					    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat26 = (-_LightShadowData.x) + 1.0;
					    u_xlat18.x = u_xlat10_18 * u_xlat26 + _LightShadowData.x;
					    u_xlat10.x = (-u_xlat18.x) + u_xlat10.x;
					    u_xlat2.x = u_xlat2.x * u_xlat10.x + u_xlat18.x;
					    u_xlatb10 = 0.0<u_xlat6.z;
					    u_xlat10.x = u_xlatb10 ? 1.0 : float(0.0);
					    u_xlat18.xy = u_xlat6.xy / u_xlat6.ww;
					    u_xlat18.xy = u_xlat18.xy + vec2(0.5, 0.5);
					    u_xlat10_7 = texture(_LightTexture0, u_xlat18.xy);
					    u_xlat10.x = u_xlat10.x * u_xlat10_7.w;
					    u_xlat18.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_6 = texture(_LightTextureB0, u_xlat18.xx);
					    u_xlat10.x = u_xlat10.x * u_xlat10_6.x;
					    u_xlat2.x = u_xlat2.x * u_xlat10.x;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat10.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat6.xyz = u_xlat5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.x = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat3.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat10.xyz, u_xlat3.xyz);
					    u_xlat2.x = dot(u_xlat10.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat0.xyz);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x * u_xlat0.x;
					    u_xlat8.x = dot(u_xlat8.xx, vec2(u_xlat25));
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
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat1.x = (-u_xlat16) + 1.0;
					    u_xlat9 = abs(u_xlat24) * u_xlat1.x + u_xlat16;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat1.x;
					    u_xlat24 = u_xlat2.x * u_xlat9 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat10.x * u_xlat16 + (-u_xlat10.x);
					    u_xlat1.x = u_xlat1.x * u_xlat10.x + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat2.xx * u_xlat8.xy;
					    u_xlat24 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb24 = u_xlat24!=0.0;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16 = u_xlat24 * u_xlat8.y;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat4.xyz;
					    u_xlat8.xyz = u_xlat4.xyz * vec3(u_xlat16);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat8.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SHADOWS_SOFT" "SPOT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2[5];
						vec4 _ShadowMapTexture_TexelSize;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_18[2];
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[8];
						mat4x4 unity_WorldToShadow[4];
						vec4 unused_3_2[12];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2D _ShadowMapTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec4 u_xlat10_7;
					vec4 u_xlat8;
					vec4 u_xlat9;
					vec4 u_xlat10;
					vec4 u_xlat11;
					vec3 u_xlat12;
					float u_xlat13;
					vec3 u_xlat14;
					bool u_xlatb14;
					float u_xlat24;
					vec2 u_xlat26;
					float u_xlat10_26;
					bool u_xlatb26;
					vec2 u_xlat34;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat37;
					float u_xlat16_37;
					float u_xlat38;
					float u_xlat10_38;
					bool u_xlatb38;
					float u_xlat39;
					float u_xlat10_39;
					float u_xlat40;
					float u_xlat10_40;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat37 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat3.xyz = vec3(u_xlat37) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat4 = texture(_TextureSample1, u_xlat4.xy);
					    u_xlat4.x = u_xlat4.w * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat37 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat37 = min(u_xlat37, 1.0);
					    u_xlat37 = (-u_xlat37) + 1.0;
					    u_xlat4.z = sqrt(u_xlat37);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5.xyz = u_xlat10_5.xyz + vec3(_Diffuse_Brightness);
					    u_xlat6.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_6 = texture(_WetnessRT, u_xlat6.xy);
					    u_xlat16_37 = max(u_xlat10_6.w, 0.0);
					    u_xlat37 = min(u_xlat16_37, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_6 = texture(_Specular, u_xlat6.xy);
					    u_xlat38 = u_xlat10_6.x + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat38 = dot(u_xlat6.xy, vec2(u_xlat38));
					    u_xlat38 = max(u_xlat38, 0.0);
					    u_xlat38 = min(u_xlat38, _MaxOriginalSpecular);
					    u_xlat37 = u_xlat37 + u_xlat38;
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_6 = texture(_TextureSample2, u_xlat6.xy);
					    u_xlat38 = u_xlat10_6.x + (-_Cutoff);
					    u_xlatb38 = u_xlat38<0.0;
					    if(((int(u_xlatb38) * int(0xffffffffu)))!=0){discard;}
					    u_xlat6 = vs_TEXCOORD4.yyyy * unity_WorldToLight[1];
					    u_xlat6 = unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat6;
					    u_xlat6 = unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat6;
					    u_xlat6 = u_xlat6 + unity_WorldToLight[3];
					    u_xlat7.x = unity_MatrixV[0].z;
					    u_xlat7.y = unity_MatrixV[1].z;
					    u_xlat7.z = unity_MatrixV[2].z;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
					    u_xlat14.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat14.x = dot(u_xlat14.xyz, u_xlat14.xyz);
					    u_xlat14.x = sqrt(u_xlat14.x);
					    u_xlat14.x = (-u_xlat2.x) + u_xlat14.x;
					    u_xlat2.x = unity_ShadowFadeCenterAndType.w * u_xlat14.x + u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb14 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb14){
					        u_xlatb14 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat14.xyz = (bool(u_xlatb14)) ? u_xlat7.xyz : vs_TEXCOORD4.xyz;
					        u_xlat14.xyz = u_xlat14.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat14.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat14.x = u_xlat7.y * 0.25 + 0.75;
					        u_xlat26.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat7.x = max(u_xlat26.x, u_xlat14.x);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					    } else {
					        u_xlat7.x = float(1.0);
					        u_xlat7.y = float(1.0);
					        u_xlat7.z = float(1.0);
					        u_xlat7.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat14.x = dot(u_xlat7, unity_OcclusionMaskSelector);
					    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
					    u_xlatb26 = u_xlat2.x<0.99000001;
					    if(u_xlatb26){
					        u_xlat7 = vs_TEXCOORD4.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					        u_xlat7 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD4.xxxx + u_xlat7;
					        u_xlat7 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD4.zzzz + u_xlat7;
					        u_xlat7 = u_xlat7 + unity_WorldToShadow[3 / 4][3 % 4];
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat7.www;
					        u_xlat26.xy = u_xlat7.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					        u_xlat26.xy = floor(u_xlat26.xy);
					        u_xlat7.xy = u_xlat7.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat26.xy);
					        u_xlat8 = u_xlat7.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
					        u_xlat9.xw = u_xlat8.xz * u_xlat8.xz;
					        u_xlat8.xz = u_xlat9.xw * vec2(0.5, 0.5) + (-u_xlat7.xy);
					        u_xlat10.xy = (-u_xlat7.xy) + vec2(1.0, 1.0);
					        u_xlat34.xy = min(u_xlat7.xy, vec2(0.0, 0.0));
					        u_xlat10.xy = (-u_xlat34.xy) * u_xlat34.xy + u_xlat10.xy;
					        u_xlat7.xy = max(u_xlat7.xy, vec2(0.0, 0.0));
					        u_xlat7.xy = (-u_xlat7.xy) * u_xlat7.xy + u_xlat8.yw;
					        u_xlat11.x = u_xlat8.x;
					        u_xlat11.y = u_xlat10.x;
					        u_xlat11.z = u_xlat7.x;
					        u_xlat11.w = u_xlat9.x;
					        u_xlat11 = u_xlat11 * vec4(0.444440007, 0.444440007, 0.444440007, 0.222220004);
					        u_xlat9.x = u_xlat8.z;
					        u_xlat9.y = u_xlat10.y;
					        u_xlat9.z = u_xlat7.y;
					        u_xlat8 = u_xlat9 * vec4(0.444440007, 0.444440007, 0.444440007, 0.222220004);
					        u_xlat9 = u_xlat11.ywyw + u_xlat11.xzxz;
					        u_xlat10 = u_xlat8.yyww + u_xlat8.xxzz;
					        u_xlat7.xy = u_xlat11.yw / u_xlat9.zw;
					        u_xlat7.xy = u_xlat7.xy + vec2(-1.5, 0.5);
					        u_xlat8.xy = u_xlat8.yw / u_xlat10.yw;
					        u_xlat8.xy = u_xlat8.xy + vec2(-1.5, 0.5);
					        u_xlat11.xy = u_xlat7.xy * _ShadowMapTexture_TexelSize.xx;
					        u_xlat11.zw = u_xlat8.xy * _ShadowMapTexture_TexelSize.yy;
					        u_xlat8 = u_xlat9 * u_xlat10;
					        u_xlat9 = u_xlat26.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat11.xzyz;
					        vec3 txVec0 = vec3(u_xlat9.xy,u_xlat7.z);
					        u_xlat10_39 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        vec3 txVec1 = vec3(u_xlat9.zw,u_xlat7.z);
					        u_xlat10_40 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat40 = u_xlat10_40 * u_xlat8.y;
					        u_xlat39 = u_xlat8.x * u_xlat10_39 + u_xlat40;
					        u_xlat9 = u_xlat26.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat11.xwyw;
					        vec3 txVec2 = vec3(u_xlat9.xy,u_xlat7.z);
					        u_xlat10_26 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat26.x = u_xlat8.z * u_xlat10_26 + u_xlat39;
					        vec3 txVec3 = vec3(u_xlat9.zw,u_xlat7.z);
					        u_xlat10_38 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat26.x = u_xlat8.w * u_xlat10_38 + u_xlat26.x;
					        u_xlat38 = (-_LightShadowData.x) + 1.0;
					        u_xlat26.x = u_xlat26.x * u_xlat38 + _LightShadowData.x;
					    } else {
					        u_xlat26.x = 1.0;
					    //ENDIF
					    }
					    u_xlat14.x = (-u_xlat26.x) + u_xlat14.x;
					    u_xlat2.x = u_xlat2.x * u_xlat14.x + u_xlat26.x;
					    u_xlatb14 = 0.0<u_xlat6.z;
					    u_xlat14.x = u_xlatb14 ? 1.0 : float(0.0);
					    u_xlat26.xy = u_xlat6.xy / u_xlat6.ww;
					    u_xlat26.xy = u_xlat26.xy + vec2(0.5, 0.5);
					    u_xlat10_7 = texture(_LightTexture0, u_xlat26.xy);
					    u_xlat14.x = u_xlat14.x * u_xlat10_7.w;
					    u_xlat26.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_6 = texture(_LightTextureB0, u_xlat26.xx);
					    u_xlat14.x = u_xlat14.x * u_xlat10_6.x;
					    u_xlat2.x = u_xlat2.x * u_xlat14.x;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat14.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat14.xyz = u_xlat14.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat6.xyz = u_xlat5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.x = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
					    u_xlat37 = (-u_xlat37) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + u_xlat3.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat14.xyz, u_xlat3.xyz);
					    u_xlat2.x = dot(u_xlat14.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat14.x = dot(u_xlat14.xyz, u_xlat0.xyz);
					    u_xlat14.x = clamp(u_xlat14.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = dot(u_xlat12.xx, vec2(u_xlat37));
					    u_xlat12.x = u_xlat12.x + -0.5;
					    u_xlat24 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat24 * u_xlat24;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat24 = u_xlat24 * u_xlat1.x;
					    u_xlat24 = u_xlat12.x * u_xlat24 + 1.0;
					    u_xlat1.x = -abs(u_xlat36) + 1.0;
					    u_xlat13 = u_xlat1.x * u_xlat1.x;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat1.x = u_xlat1.x * u_xlat13;
					    u_xlat12.x = u_xlat12.x * u_xlat1.x + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24;
					    u_xlat24 = u_xlat37 * u_xlat37;
					    u_xlat24 = max(u_xlat24, 0.00200000009);
					    u_xlat1.x = (-u_xlat24) + 1.0;
					    u_xlat13 = abs(u_xlat36) * u_xlat1.x + u_xlat24;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat24;
					    u_xlat36 = abs(u_xlat36) * u_xlat1.x;
					    u_xlat36 = u_xlat2.x * u_xlat13 + u_xlat36;
					    u_xlat36 = u_xlat36 + 9.99999975e-06;
					    u_xlat36 = 0.5 / u_xlat36;
					    u_xlat24 = u_xlat24 * u_xlat24;
					    u_xlat1.x = u_xlat14.x * u_xlat24 + (-u_xlat14.x);
					    u_xlat1.x = u_xlat1.x * u_xlat14.x + 1.0;
					    u_xlat24 = u_xlat24 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat24 = u_xlat24 / u_xlat1.x;
					    u_xlat24 = u_xlat24 * u_xlat36;
					    u_xlat24 = u_xlat24 * 3.14159274;
					    u_xlat24 = max(u_xlat24, 9.99999975e-05);
					    u_xlat12.y = sqrt(u_xlat24);
					    u_xlat12.xy = u_xlat2.xx * u_xlat12.xy;
					    u_xlat36 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb36 = u_xlat36!=0.0;
					    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
					    u_xlat24 = u_xlat36 * u_xlat12.y;
					    u_xlat1.xyz = u_xlat12.xxx * u_xlat4.xyz;
					    u_xlat12.xyz = u_xlat4.xyz * vec3(u_xlat24);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat37 = u_xlat0.x * u_xlat0.x;
					    u_xlat37 = u_xlat37 * u_xlat37;
					    u_xlat0.x = u_xlat0.x * u_xlat37;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat12.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_16[2];
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat10;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat16_19;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.xy);
					    u_xlat2.x = u_xlat2.w * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_NormalValue);
					    u_xlat19 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat19 = min(u_xlat19, 1.0);
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat2.z = sqrt(u_xlat19);
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_3 = texture(_TextureSample0, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat10_3.xyz + vec3(_Diffuse_Brightness);
					    u_xlat4.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_4 = texture(_WetnessRT, u_xlat4.xy);
					    u_xlat16_19 = max(u_xlat10_4.w, 0.0);
					    u_xlat19 = min(u_xlat16_19, _FluidShininess);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_4 = texture(_Specular, u_xlat4.xy);
					    u_xlat20 = u_xlat10_4.x + _Spec_Brightness;
					    u_xlat4.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat20 = dot(u_xlat4.xy, vec2(u_xlat20));
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat20 = min(u_xlat20, _MaxOriginalSpecular);
					    u_xlat19 = u_xlat19 + u_xlat20;
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_4 = texture(_TextureSample2, u_xlat4.xy);
					    u_xlat20 = u_xlat10_4.x + (-_Cutoff);
					    u_xlatb20 = u_xlat20<0.0;
					    if(((int(u_xlatb20) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat20 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat21 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat21 = sqrt(u_xlat21);
					    u_xlat21 = (-u_xlat20) + u_xlat21;
					    u_xlat20 = unity_ShadowFadeCenterAndType.w * u_xlat21 + u_xlat20;
					    u_xlat20 = u_xlat20 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlatb21 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb21){
					        u_xlatb21 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb21)) ? u_xlat4.xyz : vs_TEXCOORD4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat21 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat10 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat21, u_xlat10);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat21 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat21 = u_xlat21 + (-u_xlat10_4.x);
					    u_xlat20 = u_xlat20 * u_xlat21 + u_xlat10_4.x;
					    u_xlat4.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat20) * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat20 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat2.x = u_xlat13 * u_xlat13;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat4.xyz;
					    u_xlat6.xyz = u_xlat4.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat2.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_17[2];
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
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat12;
					float u_xlat13;
					vec2 u_xlat16;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat16_19;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					bool u_xlatb21;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat2 = texture(_TextureSample1, u_xlat2.xy);
					    u_xlat2.x = u_xlat2.w * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_NormalValue);
					    u_xlat19 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat19 = min(u_xlat19, 1.0);
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat2.z = sqrt(u_xlat19);
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_3 = texture(_TextureSample0, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat10_3.xyz + vec3(_Diffuse_Brightness);
					    u_xlat4.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_4 = texture(_WetnessRT, u_xlat4.xy);
					    u_xlat16_19 = max(u_xlat10_4.w, 0.0);
					    u_xlat19 = min(u_xlat16_19, _FluidShininess);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_4 = texture(_Specular, u_xlat4.xy);
					    u_xlat20 = u_xlat10_4.x + _Spec_Brightness;
					    u_xlat4.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat20 = dot(u_xlat4.xy, vec2(u_xlat20));
					    u_xlat20 = max(u_xlat20, 0.0);
					    u_xlat20 = min(u_xlat20, _MaxOriginalSpecular);
					    u_xlat19 = u_xlat19 + u_xlat20;
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_4 = texture(_TextureSample2, u_xlat4.xy);
					    u_xlat20 = u_xlat10_4.x + (-_Cutoff);
					    u_xlatb20 = u_xlat20<0.0;
					    if(((int(u_xlatb20) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD4.yy * unity_WorldToLight[1].xy;
					    u_xlat4.xy = unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat4.xy;
					    u_xlat4.xy = unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat4.xy;
					    u_xlat4.xy = u_xlat4.xy + unity_WorldToLight[3].xy;
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat20 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat21 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat21 = sqrt(u_xlat21);
					    u_xlat21 = (-u_xlat20) + u_xlat21;
					    u_xlat20 = unity_ShadowFadeCenterAndType.w * u_xlat21 + u_xlat20;
					    u_xlat20 = u_xlat20 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat20 = clamp(u_xlat20, 0.0, 1.0);
					    u_xlatb21 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb21){
					        u_xlatb21 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb21)) ? u_xlat5.xyz : vs_TEXCOORD4.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat21 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat16.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat21, u_xlat16.x);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat21 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat21 = clamp(u_xlat21, 0.0, 1.0);
					    u_xlat16.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat10_5 = texture(_ShadowMapTexture, u_xlat16.xy);
					    u_xlat21 = u_xlat21 + (-u_xlat10_5.x);
					    u_xlat2.w = u_xlat20 * u_xlat21 + u_xlat10_5.x;
					    u_xlat4 = texture(_LightTexture0, u_xlat4.xy);
					    u_xlat4.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2 = u_xlat2.xxxw * u_xlat4;
					    u_xlat4.xyz = u_xlat2.www * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat3.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat5.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat5.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat20 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat19));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat2.x = u_xlat13 * u_xlat13;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat19 * u_xlat19;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat19 = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat19 + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat4.xyz;
					    u_xlat6.xyz = u_xlat4.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat19 = u_xlat0.x * u_xlat0.x;
					    u_xlat19 = u_xlat19 * u_xlat19;
					    u_xlat0.x = u_xlat0.x * u_xlat19;
					    u_xlat2.xyz = (-u_xlat5.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat6.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_17[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					vec3 u_xlat10;
					bool u_xlatb10;
					float u_xlat16;
					float u_xlat18;
					float u_xlat10_18;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					float u_xlat16_25;
					float u_xlat26;
					bool u_xlatb26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat4 = texture(_TextureSample1, u_xlat4.xy);
					    u_xlat4.x = u_xlat4.w * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat25 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat25 = min(u_xlat25, 1.0);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat4.z = sqrt(u_xlat25);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5.xyz = u_xlat10_5.xyz + vec3(_Diffuse_Brightness);
					    u_xlat6.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_6 = texture(_WetnessRT, u_xlat6.xy);
					    u_xlat16_25 = max(u_xlat10_6.w, 0.0);
					    u_xlat25 = min(u_xlat16_25, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_6 = texture(_Specular, u_xlat6.xy);
					    u_xlat26 = u_xlat10_6.x + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat26 = dot(u_xlat6.xy, vec2(u_xlat26));
					    u_xlat26 = max(u_xlat26, 0.0);
					    u_xlat26 = min(u_xlat26, _MaxOriginalSpecular);
					    u_xlat25 = u_xlat25 + u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_6 = texture(_TextureSample2, u_xlat6.xy);
					    u_xlat26 = u_xlat10_6.x + (-_Cutoff);
					    u_xlatb26 = u_xlat26<0.0;
					    if(((int(u_xlatb26) * int(0xffffffffu)))!=0){discard;}
					    u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat6.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + unity_WorldToLight[3].xyz;
					    u_xlat7.x = unity_MatrixV[0].z;
					    u_xlat7.y = unity_MatrixV[1].z;
					    u_xlat7.z = unity_MatrixV[2].z;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
					    u_xlat10.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = (-u_xlat2.x) + u_xlat10.x;
					    u_xlat2.x = unity_ShadowFadeCenterAndType.w * u_xlat10.x + u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb10 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb10){
					        u_xlatb10 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb10)) ? u_xlat7.xyz : vs_TEXCOORD4.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat7.y * 0.25 + 0.75;
					        u_xlat18 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat7.x = max(u_xlat18, u_xlat10.x);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					    } else {
					        u_xlat7.x = float(1.0);
					        u_xlat7.y = float(1.0);
					        u_xlat7.z = float(1.0);
					        u_xlat7.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat10.x = dot(u_xlat7, unity_OcclusionMaskSelector);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat7.xyz = vs_TEXCOORD4.xyz + (-_LightPositionRange.xyz);
					    u_xlat18 = max(abs(u_xlat7.y), abs(u_xlat7.x));
					    u_xlat18 = max(abs(u_xlat7.z), u_xlat18);
					    u_xlat18 = u_xlat18 + (-_LightProjectionParams.z);
					    u_xlat18 = max(u_xlat18, 9.99999975e-06);
					    u_xlat18 = u_xlat18 * _LightProjectionParams.w;
					    u_xlat18 = _LightProjectionParams.y / u_xlat18;
					    u_xlat18 = u_xlat18 + (-_LightProjectionParams.x);
					    u_xlat18 = (-u_xlat18) + 1.0;
					    vec4 txVec0 = vec4(u_xlat7.xyz,u_xlat18);
					    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat26 = (-_LightShadowData.x) + 1.0;
					    u_xlat18 = u_xlat10_18 * u_xlat26 + _LightShadowData.x;
					    u_xlat10.x = (-u_xlat18) + u_xlat10.x;
					    u_xlat2.x = u_xlat2.x * u_xlat10.x + u_xlat18;
					    u_xlat10.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_6 = texture(_LightTexture0, u_xlat10.xx);
					    u_xlat2.x = u_xlat2.x * u_xlat10_6.x;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat10.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat6.xyz = u_xlat5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.x = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat3.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat10.xyz, u_xlat3.xyz);
					    u_xlat2.x = dot(u_xlat10.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat0.xyz);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x * u_xlat0.x;
					    u_xlat8.x = dot(u_xlat8.xx, vec2(u_xlat25));
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
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat1.x = (-u_xlat16) + 1.0;
					    u_xlat9 = abs(u_xlat24) * u_xlat1.x + u_xlat16;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat1.x;
					    u_xlat24 = u_xlat2.x * u_xlat9 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat10.x * u_xlat16 + (-u_xlat10.x);
					    u_xlat1.x = u_xlat1.x * u_xlat10.x + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat2.xx * u_xlat8.xy;
					    u_xlat24 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb24 = u_xlat24!=0.0;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16 = u_xlat24 * u_xlat8.y;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat4.xyz;
					    u_xlat8.xyz = u_xlat4.xyz * vec3(u_xlat16);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat8.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_17[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					bool u_xlatb12;
					float u_xlat20;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					float u_xlat16_31;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat4 = texture(_TextureSample1, u_xlat4.xy);
					    u_xlat4.x = u_xlat4.w * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat31 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat31 = min(u_xlat31, 1.0);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat4.z = sqrt(u_xlat31);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5.xyz = u_xlat10_5.xyz + vec3(_Diffuse_Brightness);
					    u_xlat6.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_6 = texture(_WetnessRT, u_xlat6.xy);
					    u_xlat16_31 = max(u_xlat10_6.w, 0.0);
					    u_xlat31 = min(u_xlat16_31, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_6 = texture(_Specular, u_xlat6.xy);
					    u_xlat32 = u_xlat10_6.x + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat32 = dot(u_xlat6.xy, vec2(u_xlat32));
					    u_xlat32 = max(u_xlat32, 0.0);
					    u_xlat32 = min(u_xlat32, _MaxOriginalSpecular);
					    u_xlat31 = u_xlat31 + u_xlat32;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_6 = texture(_TextureSample2, u_xlat6.xy);
					    u_xlat32 = u_xlat10_6.x + (-_Cutoff);
					    u_xlatb32 = u_xlat32<0.0;
					    if(((int(u_xlatb32) * int(0xffffffffu)))!=0){discard;}
					    u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat6.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + unity_WorldToLight[3].xyz;
					    u_xlat7.x = unity_MatrixV[0].z;
					    u_xlat7.y = unity_MatrixV[1].z;
					    u_xlat7.z = unity_MatrixV[2].z;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
					    u_xlat12.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat12.x = dot(u_xlat12.xyz, u_xlat12.xyz);
					    u_xlat12.x = sqrt(u_xlat12.x);
					    u_xlat12.x = (-u_xlat2.x) + u_xlat12.x;
					    u_xlat2.x = unity_ShadowFadeCenterAndType.w * u_xlat12.x + u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat12.xyz = (bool(u_xlatb12)) ? u_xlat7.xyz : vs_TEXCOORD4.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat12.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat7.y * 0.25 + 0.75;
					        u_xlat22 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat7.x = max(u_xlat22, u_xlat12.x);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					    } else {
					        u_xlat7.x = float(1.0);
					        u_xlat7.y = float(1.0);
					        u_xlat7.z = float(1.0);
					        u_xlat7.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat12.x = dot(u_xlat7, unity_OcclusionMaskSelector);
					    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
					    u_xlatb22 = u_xlat2.x<0.99000001;
					    if(u_xlatb22){
					        u_xlat7.xyz = vs_TEXCOORD4.xyz + (-_LightPositionRange.xyz);
					        u_xlat22 = max(abs(u_xlat7.y), abs(u_xlat7.x));
					        u_xlat22 = max(abs(u_xlat7.z), u_xlat22);
					        u_xlat22 = u_xlat22 + (-_LightProjectionParams.z);
					        u_xlat22 = max(u_xlat22, 9.99999975e-06);
					        u_xlat22 = u_xlat22 * _LightProjectionParams.w;
					        u_xlat22 = _LightProjectionParams.y / u_xlat22;
					        u_xlat22 = u_xlat22 + (-_LightProjectionParams.x);
					        u_xlat22 = (-u_xlat22) + 1.0;
					        u_xlat8.xyz = u_xlat7.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
					        vec4 txVec0 = vec4(u_xlat8.xyz,u_xlat22);
					        u_xlat8.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        u_xlat9.xyz = u_xlat7.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
					        vec4 txVec1 = vec4(u_xlat9.xyz,u_xlat22);
					        u_xlat8.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat9.xyz = u_xlat7.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
					        vec4 txVec2 = vec4(u_xlat9.xyz,u_xlat22);
					        u_xlat8.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat7.xyz = u_xlat7.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
					        vec4 txVec3 = vec4(u_xlat7.xyz,u_xlat22);
					        u_xlat8.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat22 = dot(u_xlat8, vec4(0.25, 0.25, 0.25, 0.25));
					        u_xlat32 = (-_LightShadowData.x) + 1.0;
					        u_xlat22 = u_xlat22 * u_xlat32 + _LightShadowData.x;
					    } else {
					        u_xlat22 = 1.0;
					    //ENDIF
					    }
					    u_xlat12.x = (-u_xlat22) + u_xlat12.x;
					    u_xlat2.x = u_xlat2.x * u_xlat12.x + u_xlat22;
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_6 = texture(_LightTexture0, u_xlat12.xx);
					    u_xlat2.x = u_xlat2.x * u_xlat10_6.x;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat12.x = inversesqrt(u_xlat12.x);
					    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat6.xyz = u_xlat5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.x = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat3.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat3.xyz);
					    u_xlat2.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.x = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = dot(u_xlat10.xx, vec2(u_xlat31));
					    u_xlat10.x = u_xlat10.x + -0.5;
					    u_xlat20 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat20 * u_xlat20;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat20 = u_xlat20 * u_xlat1.x;
					    u_xlat20 = u_xlat10.x * u_xlat20 + 1.0;
					    u_xlat1.x = -abs(u_xlat30) + 1.0;
					    u_xlat11 = u_xlat1.x * u_xlat1.x;
					    u_xlat11 = u_xlat11 * u_xlat11;
					    u_xlat1.x = u_xlat1.x * u_xlat11;
					    u_xlat10.x = u_xlat10.x * u_xlat1.x + 1.0;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat20 = u_xlat31 * u_xlat31;
					    u_xlat20 = max(u_xlat20, 0.00200000009);
					    u_xlat1.x = (-u_xlat20) + 1.0;
					    u_xlat11 = abs(u_xlat30) * u_xlat1.x + u_xlat20;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat20;
					    u_xlat30 = abs(u_xlat30) * u_xlat1.x;
					    u_xlat30 = u_xlat2.x * u_xlat11 + u_xlat30;
					    u_xlat30 = u_xlat30 + 9.99999975e-06;
					    u_xlat30 = 0.5 / u_xlat30;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat1.x = u_xlat12.x * u_xlat20 + (-u_xlat12.x);
					    u_xlat1.x = u_xlat1.x * u_xlat12.x + 1.0;
					    u_xlat20 = u_xlat20 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat20 = u_xlat20 / u_xlat1.x;
					    u_xlat20 = u_xlat20 * u_xlat30;
					    u_xlat20 = u_xlat20 * 3.14159274;
					    u_xlat20 = max(u_xlat20, 9.99999975e-05);
					    u_xlat10.y = sqrt(u_xlat20);
					    u_xlat10.xy = u_xlat2.xx * u_xlat10.xy;
					    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb30 = u_xlat30!=0.0;
					    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
					    u_xlat20 = u_xlat30 * u_xlat10.y;
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat4.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * vec3(u_xlat20);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat31 = u_xlat0.x * u_xlat0.x;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat0.x = u_xlat0.x * u_xlat31;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat10.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_17[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					float u_xlat9;
					vec3 u_xlat10;
					float u_xlat16_10;
					bool u_xlatb10;
					float u_xlat16;
					float u_xlat18;
					float u_xlat10_18;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					float u_xlat16_25;
					float u_xlat26;
					bool u_xlatb26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat4 = texture(_TextureSample1, u_xlat4.xy);
					    u_xlat4.x = u_xlat4.w * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat25 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat25 = min(u_xlat25, 1.0);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat4.z = sqrt(u_xlat25);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5.xyz = u_xlat10_5.xyz + vec3(_Diffuse_Brightness);
					    u_xlat6.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_6 = texture(_WetnessRT, u_xlat6.xy);
					    u_xlat16_25 = max(u_xlat10_6.w, 0.0);
					    u_xlat25 = min(u_xlat16_25, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_6 = texture(_Specular, u_xlat6.xy);
					    u_xlat26 = u_xlat10_6.x + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat26 = dot(u_xlat6.xy, vec2(u_xlat26));
					    u_xlat26 = max(u_xlat26, 0.0);
					    u_xlat26 = min(u_xlat26, _MaxOriginalSpecular);
					    u_xlat25 = u_xlat25 + u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_6 = texture(_TextureSample2, u_xlat6.xy);
					    u_xlat26 = u_xlat10_6.x + (-_Cutoff);
					    u_xlatb26 = u_xlat26<0.0;
					    if(((int(u_xlatb26) * int(0xffffffffu)))!=0){discard;}
					    u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat6.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + unity_WorldToLight[3].xyz;
					    u_xlat7.x = unity_MatrixV[0].z;
					    u_xlat7.y = unity_MatrixV[1].z;
					    u_xlat7.z = unity_MatrixV[2].z;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
					    u_xlat10.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat10.xyz);
					    u_xlat10.x = sqrt(u_xlat10.x);
					    u_xlat10.x = (-u_xlat2.x) + u_xlat10.x;
					    u_xlat2.x = unity_ShadowFadeCenterAndType.w * u_xlat10.x + u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb10 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb10){
					        u_xlatb10 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat10.xyz = (bool(u_xlatb10)) ? u_xlat7.xyz : vs_TEXCOORD4.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat10.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat7.y * 0.25 + 0.75;
					        u_xlat18 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat7.x = max(u_xlat18, u_xlat10.x);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					    } else {
					        u_xlat7.x = float(1.0);
					        u_xlat7.y = float(1.0);
					        u_xlat7.z = float(1.0);
					        u_xlat7.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat10.x = dot(u_xlat7, unity_OcclusionMaskSelector);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat7.xyz = vs_TEXCOORD4.xyz + (-_LightPositionRange.xyz);
					    u_xlat18 = max(abs(u_xlat7.y), abs(u_xlat7.x));
					    u_xlat18 = max(abs(u_xlat7.z), u_xlat18);
					    u_xlat18 = u_xlat18 + (-_LightProjectionParams.z);
					    u_xlat18 = max(u_xlat18, 9.99999975e-06);
					    u_xlat18 = u_xlat18 * _LightProjectionParams.w;
					    u_xlat18 = _LightProjectionParams.y / u_xlat18;
					    u_xlat18 = u_xlat18 + (-_LightProjectionParams.x);
					    u_xlat18 = (-u_xlat18) + 1.0;
					    vec4 txVec0 = vec4(u_xlat7.xyz,u_xlat18);
					    u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat26 = (-_LightShadowData.x) + 1.0;
					    u_xlat18 = u_xlat10_18 * u_xlat26 + _LightShadowData.x;
					    u_xlat10.x = (-u_xlat18) + u_xlat10.x;
					    u_xlat2.x = u_xlat2.x * u_xlat10.x + u_xlat18;
					    u_xlat10.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_7 = texture(_LightTextureB0, u_xlat10.xx);
					    u_xlat10_6 = texture(_LightTexture0, u_xlat6.xyz);
					    u_xlat16_10 = u_xlat10_6.w * u_xlat10_7.x;
					    u_xlat2.x = u_xlat2.x * u_xlat16_10;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat10.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xyz = u_xlat10.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat6.xyz = u_xlat5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.x = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat3.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat10.xyz, u_xlat3.xyz);
					    u_xlat2.x = dot(u_xlat10.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat10.x = dot(u_xlat10.xyz, u_xlat0.xyz);
					    u_xlat10.x = clamp(u_xlat10.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x * u_xlat0.x;
					    u_xlat8.x = dot(u_xlat8.xx, vec2(u_xlat25));
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
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat1.x = (-u_xlat16) + 1.0;
					    u_xlat9 = abs(u_xlat24) * u_xlat1.x + u_xlat16;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat1.x;
					    u_xlat24 = u_xlat2.x * u_xlat9 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat10.x * u_xlat16 + (-u_xlat10.x);
					    u_xlat1.x = u_xlat1.x * u_xlat10.x + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat2.xx * u_xlat8.xy;
					    u_xlat24 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb24 = u_xlat24!=0.0;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16 = u_xlat24 * u_xlat8.y;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat4.xyz;
					    u_xlat8.xyz = u_xlat4.xyz * vec3(u_xlat16);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat8.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_17[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec4 u_xlat10_7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					float u_xlat16_12;
					bool u_xlatb12;
					float u_xlat20;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					float u_xlat16_31;
					float u_xlat32;
					bool u_xlatb32;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat31 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat31 = inversesqrt(u_xlat31);
					    u_xlat3.xyz = vec3(u_xlat31) * u_xlat2.xyz;
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat4 = texture(_TextureSample1, u_xlat4.xy);
					    u_xlat4.x = u_xlat4.w * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat31 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat31 = min(u_xlat31, 1.0);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat4.z = sqrt(u_xlat31);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5.xyz = u_xlat10_5.xyz + vec3(_Diffuse_Brightness);
					    u_xlat6.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_6 = texture(_WetnessRT, u_xlat6.xy);
					    u_xlat16_31 = max(u_xlat10_6.w, 0.0);
					    u_xlat31 = min(u_xlat16_31, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_6 = texture(_Specular, u_xlat6.xy);
					    u_xlat32 = u_xlat10_6.x + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat32 = dot(u_xlat6.xy, vec2(u_xlat32));
					    u_xlat32 = max(u_xlat32, 0.0);
					    u_xlat32 = min(u_xlat32, _MaxOriginalSpecular);
					    u_xlat31 = u_xlat31 + u_xlat32;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_6 = texture(_TextureSample2, u_xlat6.xy);
					    u_xlat32 = u_xlat10_6.x + (-_Cutoff);
					    u_xlatb32 = u_xlat32<0.0;
					    if(((int(u_xlatb32) * int(0xffffffffu)))!=0){discard;}
					    u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat6.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + unity_WorldToLight[3].xyz;
					    u_xlat7.x = unity_MatrixV[0].z;
					    u_xlat7.y = unity_MatrixV[1].z;
					    u_xlat7.z = unity_MatrixV[2].z;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat7.xyz);
					    u_xlat12.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat12.x = dot(u_xlat12.xyz, u_xlat12.xyz);
					    u_xlat12.x = sqrt(u_xlat12.x);
					    u_xlat12.x = (-u_xlat2.x) + u_xlat12.x;
					    u_xlat2.x = unity_ShadowFadeCenterAndType.w * u_xlat12.x + u_xlat2.x;
					    u_xlat2.x = u_xlat2.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat12.xyz = (bool(u_xlatb12)) ? u_xlat7.xyz : vs_TEXCOORD4.xyz;
					        u_xlat12.xyz = u_xlat12.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat12.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12.x = u_xlat7.y * 0.25 + 0.75;
					        u_xlat22 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat7.x = max(u_xlat22, u_xlat12.x);
					        u_xlat7 = texture(unity_ProbeVolumeSH, u_xlat7.xzw);
					    } else {
					        u_xlat7.x = float(1.0);
					        u_xlat7.y = float(1.0);
					        u_xlat7.z = float(1.0);
					        u_xlat7.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat12.x = dot(u_xlat7, unity_OcclusionMaskSelector);
					    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
					    u_xlatb22 = u_xlat2.x<0.99000001;
					    if(u_xlatb22){
					        u_xlat7.xyz = vs_TEXCOORD4.xyz + (-_LightPositionRange.xyz);
					        u_xlat22 = max(abs(u_xlat7.y), abs(u_xlat7.x));
					        u_xlat22 = max(abs(u_xlat7.z), u_xlat22);
					        u_xlat22 = u_xlat22 + (-_LightProjectionParams.z);
					        u_xlat22 = max(u_xlat22, 9.99999975e-06);
					        u_xlat22 = u_xlat22 * _LightProjectionParams.w;
					        u_xlat22 = _LightProjectionParams.y / u_xlat22;
					        u_xlat22 = u_xlat22 + (-_LightProjectionParams.x);
					        u_xlat22 = (-u_xlat22) + 1.0;
					        u_xlat8.xyz = u_xlat7.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
					        vec4 txVec0 = vec4(u_xlat8.xyz,u_xlat22);
					        u_xlat8.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        u_xlat9.xyz = u_xlat7.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
					        vec4 txVec1 = vec4(u_xlat9.xyz,u_xlat22);
					        u_xlat8.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat9.xyz = u_xlat7.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
					        vec4 txVec2 = vec4(u_xlat9.xyz,u_xlat22);
					        u_xlat8.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat7.xyz = u_xlat7.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
					        vec4 txVec3 = vec4(u_xlat7.xyz,u_xlat22);
					        u_xlat8.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat22 = dot(u_xlat8, vec4(0.25, 0.25, 0.25, 0.25));
					        u_xlat32 = (-_LightShadowData.x) + 1.0;
					        u_xlat22 = u_xlat22 * u_xlat32 + _LightShadowData.x;
					    } else {
					        u_xlat22 = 1.0;
					    //ENDIF
					    }
					    u_xlat12.x = (-u_xlat22) + u_xlat12.x;
					    u_xlat2.x = u_xlat2.x * u_xlat12.x + u_xlat22;
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_7 = texture(_LightTextureB0, u_xlat12.xx);
					    u_xlat10_6 = texture(_LightTexture0, u_xlat6.xyz);
					    u_xlat16_12 = u_xlat10_6.w * u_xlat10_7.x;
					    u_xlat2.x = u_xlat2.x * u_xlat16_12;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat12.x = inversesqrt(u_xlat12.x);
					    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat6.xyz = u_xlat5.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat6.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat6.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.x = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat5.xyz = u_xlat2.xxx * u_xlat5.xyz;
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat30) + u_xlat3.xyz;
					    u_xlat30 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat0.xyz = vec3(u_xlat30) * u_xlat0.xyz;
					    u_xlat30 = dot(u_xlat12.xyz, u_xlat3.xyz);
					    u_xlat2.x = dot(u_xlat12.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat12.x = dot(u_xlat12.xyz, u_xlat0.xyz);
					    u_xlat12.x = clamp(u_xlat12.x, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10.x = u_xlat0.x * u_xlat0.x;
					    u_xlat10.x = dot(u_xlat10.xx, vec2(u_xlat31));
					    u_xlat10.x = u_xlat10.x + -0.5;
					    u_xlat20 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat20 * u_xlat20;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat20 = u_xlat20 * u_xlat1.x;
					    u_xlat20 = u_xlat10.x * u_xlat20 + 1.0;
					    u_xlat1.x = -abs(u_xlat30) + 1.0;
					    u_xlat11 = u_xlat1.x * u_xlat1.x;
					    u_xlat11 = u_xlat11 * u_xlat11;
					    u_xlat1.x = u_xlat1.x * u_xlat11;
					    u_xlat10.x = u_xlat10.x * u_xlat1.x + 1.0;
					    u_xlat10.x = u_xlat10.x * u_xlat20;
					    u_xlat20 = u_xlat31 * u_xlat31;
					    u_xlat20 = max(u_xlat20, 0.00200000009);
					    u_xlat1.x = (-u_xlat20) + 1.0;
					    u_xlat11 = abs(u_xlat30) * u_xlat1.x + u_xlat20;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat20;
					    u_xlat30 = abs(u_xlat30) * u_xlat1.x;
					    u_xlat30 = u_xlat2.x * u_xlat11 + u_xlat30;
					    u_xlat30 = u_xlat30 + 9.99999975e-06;
					    u_xlat30 = 0.5 / u_xlat30;
					    u_xlat20 = u_xlat20 * u_xlat20;
					    u_xlat1.x = u_xlat12.x * u_xlat20 + (-u_xlat12.x);
					    u_xlat1.x = u_xlat1.x * u_xlat12.x + 1.0;
					    u_xlat20 = u_xlat20 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat20 = u_xlat20 / u_xlat1.x;
					    u_xlat20 = u_xlat20 * u_xlat30;
					    u_xlat20 = u_xlat20 * 3.14159274;
					    u_xlat20 = max(u_xlat20, 9.99999975e-05);
					    u_xlat10.y = sqrt(u_xlat20);
					    u_xlat10.xy = u_xlat2.xx * u_xlat10.xy;
					    u_xlat30 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlatb30 = u_xlat30!=0.0;
					    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
					    u_xlat20 = u_xlat30 * u_xlat10.y;
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat4.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * vec3(u_xlat20);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat31 = u_xlat0.x * u_xlat0.x;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat0.x = u_xlat0.x * u_xlat31;
					    u_xlat2.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx + u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat10.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "DEFERRED"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DEFERRED" "QUEUE" = "AlphaTest+0" "RenderType" = "Opaque" }
			Cull Off
			GpuProgramID 145465
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
						vec4 unused_0_3;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
						vec4 unused_0_3;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = u_xlat2.y * u_xlat2.y;
					    u_xlat0.x = u_xlat2.x * u_xlat2.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat2.ywzx * u_xlat2;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
						vec4 unused_0_3;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
						vec4 unused_0_3;
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
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
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
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
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
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.x = u_xlat2.y * u_xlat2.y;
					    u_xlat0.x = u_xlat2.x * u_xlat2.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat2.ywzx * u_xlat2;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD6.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_14[3];
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec4 u_xlat0;
					vec4 u_xlat10_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec2 u_xlat2;
					float u_xlat16_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_0 = texture(_TextureSample2, u_xlat0.xy);
					    u_xlat0.x = u_xlat10_0.x + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_0 = texture(_TextureSample0, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat10_0.xyz + vec3(_Diffuse_Brightness);
					    u_xlat6 = (-_Metallic) * 0.779083729 + 0.779083729;
					    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat0.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    SV_Target0.w = 1.0;
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_0 = texture(_Specular, u_xlat0.xy);
					    u_xlat0.x = u_xlat10_0.x + _Spec_Brightness;
					    u_xlat2.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat0.x = dot(u_xlat2.xy, u_xlat0.xx);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = min(u_xlat0.x, _MaxOriginalSpecular);
					    u_xlat2.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_1 = texture(_WetnessRT, u_xlat2.xy);
					    u_xlat16_2 = max(u_xlat10_1.w, 0.0);
					    u_xlat2.x = min(u_xlat16_2, _FluidShininess);
					    SV_Target1.w = u_xlat0.x + u_xlat2.x;
					    SV_Target1.w = clamp(SV_Target1.w, 0.0, 1.0);
					    u_xlat0.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat0 = texture(_TextureSample1, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * u_xlat0.x;
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_NormalValue);
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat6 = min(u_xlat6, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat0.z = sqrt(u_xlat6);
					    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    SV_Target2.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_14[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_1_4[6];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					float u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					float u_xlat16_15;
					bool u_xlatb15;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat0 = texture(_TextureSample1, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * u_xlat0.x;
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_NormalValue);
					    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat15 = min(u_xlat15, 1.0);
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat0.z = sqrt(u_xlat15);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_1 = texture(_TextureSample0, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat10_1.xyz + vec3(_Diffuse_Brightness);
					    u_xlat2.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_2 = texture(_WetnessRT, u_xlat2.xy);
					    u_xlat16_15 = max(u_xlat10_2.w, 0.0);
					    u_xlat15 = min(u_xlat16_15, _FluidShininess);
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_2 = texture(_Specular, u_xlat2.xy);
					    u_xlat16 = u_xlat10_2.x + _Spec_Brightness;
					    u_xlat2.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat16 = dot(u_xlat2.xy, vec2(u_xlat16));
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = min(u_xlat16, _MaxOriginalSpecular);
					    SV_Target1.w = u_xlat15 + u_xlat16;
					    SV_Target1.w = clamp(SV_Target1.w, 0.0, 1.0);
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_2 = texture(_TextureSample2, u_xlat2.xy);
					    u_xlat15 = u_xlat10_2.x + (-_Cutoff);
					    u_xlatb15 = u_xlat15<0.0;
					    if(((int(u_xlatb15) * int(0xffffffffu)))!=0){discard;}
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat8.x = vs_TEXCOORD1.w;
					        u_xlat8.y = vs_TEXCOORD2.w;
					        u_xlat8.z = vs_TEXCOORD3.w;
					        u_xlat2.xyz = (bool(u_xlatb16)) ? u_xlat2.xyz : u_xlat8.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat2.y * 0.25;
					        u_xlat7 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat3.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat16 = max(u_xlat16, u_xlat7);
					        u_xlat2.x = min(u_xlat3.x, u_xlat16);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat0.w = 1.0;
					        u_xlat3.x = dot(u_xlat10_3, u_xlat0);
					        u_xlat3.y = dot(u_xlat10_4, u_xlat0);
					        u_xlat3.z = dot(u_xlat10_2, u_xlat0);
					    } else {
					        u_xlat0.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat0);
					        u_xlat3.y = dot(unity_SHAg, u_xlat0);
					        u_xlat3.z = dot(unity_SHAb, u_xlat0);
					    //ENDIF
					    }
					    u_xlat2.xyz = u_xlat3.xyz + vs_TEXCOORD6.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xyz = u_xlat1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat15 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat1.xyz;
					    SV_Target2.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target3.xyz = exp2((-u_xlat2.xyz));
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_14[3];
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec4 u_xlat0;
					vec4 u_xlat10_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec2 u_xlat2;
					float u_xlat16_2;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_0 = texture(_TextureSample2, u_xlat0.xy);
					    u_xlat0.x = u_xlat10_0.x + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_0 = texture(_TextureSample0, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat10_0.xyz + vec3(_Diffuse_Brightness);
					    u_xlat6 = (-_Metallic) * 0.779083729 + 0.779083729;
					    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat0.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    SV_Target0.w = 1.0;
					    u_xlat0.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_0 = texture(_Specular, u_xlat0.xy);
					    u_xlat0.x = u_xlat10_0.x + _Spec_Brightness;
					    u_xlat2.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat0.x = dot(u_xlat2.xy, u_xlat0.xx);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = min(u_xlat0.x, _MaxOriginalSpecular);
					    u_xlat2.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_1 = texture(_WetnessRT, u_xlat2.xy);
					    u_xlat16_2 = max(u_xlat10_1.w, 0.0);
					    u_xlat2.x = min(u_xlat16_2, _FluidShininess);
					    SV_Target1.w = u_xlat0.x + u_xlat2.x;
					    SV_Target1.w = clamp(SV_Target1.w, 0.0, 1.0);
					    u_xlat0.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat0 = texture(_TextureSample1, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * u_xlat0.x;
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_NormalValue);
					    u_xlat6 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat6 = min(u_xlat6, 1.0);
					    u_xlat6 = (-u_xlat6) + 1.0;
					    u_xlat0.z = sqrt(u_xlat6);
					    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    SV_Target2.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						float _NormalValue;
						vec4 _TextureSample1_ST;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _Metallic;
						vec4 _WetnessRT_ST;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_14[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_1_4[6];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _TextureSample1;
					uniform  sampler2D _TextureSample0;
					uniform  sampler2D _WetnessRT;
					uniform  sampler2D _Specular;
					uniform  sampler2D _TextureSample2;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					float u_xlat7;
					vec3 u_xlat8;
					float u_xlat15;
					float u_xlat16_15;
					bool u_xlatb15;
					float u_xlat16;
					bool u_xlatb16;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat0 = texture(_TextureSample1, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.w * u_xlat0.x;
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(_NormalValue);
					    u_xlat15 = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat15 = min(u_xlat15, 1.0);
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat0.z = sqrt(u_xlat15);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_1 = texture(_TextureSample0, u_xlat1.xy);
					    u_xlat1.xyz = u_xlat10_1.xyz + vec3(_Diffuse_Brightness);
					    u_xlat2.xy = vs_TEXCOORD0.zw * _WetnessRT_ST.xy + _WetnessRT_ST.zw;
					    u_xlat10_2 = texture(_WetnessRT, u_xlat2.xy);
					    u_xlat16_15 = max(u_xlat10_2.w, 0.0);
					    u_xlat15 = min(u_xlat16_15, _FluidShininess);
					    u_xlat2.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_2 = texture(_Specular, u_xlat2.xy);
					    u_xlat16 = u_xlat10_2.x + _Spec_Brightness;
					    u_xlat2.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat16 = dot(u_xlat2.xy, vec2(u_xlat16));
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = min(u_xlat16, _MaxOriginalSpecular);
					    SV_Target1.w = u_xlat15 + u_xlat16;
					    SV_Target1.w = clamp(SV_Target1.w, 0.0, 1.0);
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_2 = texture(_TextureSample2, u_xlat2.xy);
					    u_xlat15 = u_xlat10_2.x + (-_Cutoff);
					    u_xlatb15 = u_xlat15<0.0;
					    if(((int(u_xlatb15) * int(0xffffffffu)))!=0){discard;}
					    u_xlat2.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD2.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD3.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat8.x = vs_TEXCOORD1.w;
					        u_xlat8.y = vs_TEXCOORD2.w;
					        u_xlat8.z = vs_TEXCOORD3.w;
					        u_xlat2.xyz = (bool(u_xlatb16)) ? u_xlat2.xyz : u_xlat8.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat2.y * 0.25;
					        u_xlat7 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat3.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat16 = max(u_xlat16, u_xlat7);
					        u_xlat2.x = min(u_xlat3.x, u_xlat16);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat0.w = 1.0;
					        u_xlat3.x = dot(u_xlat10_3, u_xlat0);
					        u_xlat3.y = dot(u_xlat10_4, u_xlat0);
					        u_xlat3.z = dot(u_xlat10_2, u_xlat0);
					    } else {
					        u_xlat0.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat0);
					        u_xlat3.y = dot(unity_SHAg, u_xlat0);
					        u_xlat3.z = dot(unity_SHAb, u_xlat0);
					    //ENDIF
					    }
					    u_xlat2.xyz = u_xlat3.xyz + vs_TEXCOORD6.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3.xyz = u_xlat1.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = vec3(vec3(_Metallic, _Metallic, _Metallic)) * u_xlat3.xyz + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat15 = (-_Metallic) * 0.779083729 + 0.779083729;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    SV_Target3.xyz = u_xlat2.xyz * u_xlat1.xyz;
					    SV_Target2.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.xyz = u_xlat1.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "ShadowCaster"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "AlphaTest+0" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Cull Off
			GpuProgramID 207384
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_2_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_2_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat6 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat6);
					    gl_Position.xyw = u_xlat0.xyw;
					    u_xlat0.x = (-u_xlat6) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat0.x + u_xlat6;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[14];
						vec4 _texcoord_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_2_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_2_2[20];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat1;
					    u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					    u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					    u_xlat9 = sqrt(u_xlat9);
					    u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlatb9 = unity_LightShadowBias.z!=0.0;
					    u_xlat0.xyz = (bool(u_xlatb9)) ? u_xlat0.xyz : u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[12];
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_3;
					};
					uniform  sampler2D _TextureSample2;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat10_0;
					bool u_xlatb0;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_0 = texture(_TextureSample2, u_xlat0.xy);
					    u_xlat0.x = u_xlat10_0.x + (-_Cutoff);
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[12];
						vec4 _TextureSample2_ST;
						float _Cutoff;
						vec4 unused_0_3;
					};
					uniform  sampler2D _TextureSample2;
					in  vec2 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat10_0;
					bool u_xlatb0;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
					    u_xlat10_0 = texture(_TextureSample2, u_xlat0.xy);
					    u_xlat0.x = u_xlat10_0.x + (-_Cutoff);
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
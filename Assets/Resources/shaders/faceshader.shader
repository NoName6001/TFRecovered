Shader "Face Shader" {
	Properties {
		_TextureSample0 ("Texture Sample 0", 2D) = "white" {}
		_TextureSample1 ("Texture Sample 1", 2D) = "bump" {}
		_Specular ("Specular", 2D) = "black" {}
		_Spec_Contrast ("Spec_Contrast", Float) = 0
		_DifContrast ("DifContrast", Float) = 1
		_WetnessRT ("WetnessRT", 2D) = "black" {}
		_Spec_Brightness ("Spec_Brightness", Float) = 0
		_FluidShininess ("FluidShininess", Float) = 0.77
		_MaxOriginalSpecular ("MaxOriginalSpecular", Float) = 1
		_Diffuse_Brightness ("Diffuse_Brightness", Float) = 0
		_ColorRT ("ColorRT", 2D) = "black" {}
		_ColorRTAlpha ("ColorRTAlpha", Float) = 1
		_NormalValue ("NormalValue", Float) = 1
		[Toggle(_USEUV2_ON)] _UseUV2 ("Use UV 2", Float) = 0
		[HideInInspector] _texcoord2 ("", 2D) = "white" {}
		[HideInInspector] _texcoord ("", 2D) = "white" {}
		[HideInInspector] __dirty ("", Float) = 1
	}
	SubShader {
		Tags { "QUEUE" = "Geometry+0" "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry+0" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 36025
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
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
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 unused_1_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_5[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
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
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
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
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(binding = 3, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
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
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(binding = 3, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
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
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
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
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityLighting {
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
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
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
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityLighting {
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
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
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
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
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
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityLighting {
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
					layout(binding = 3, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
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
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityLighting {
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
					layout(binding = 3, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_3_4;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
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
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
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
					Keywords { "DIRECTIONAL" "INSTANCING_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						vec4 unused_1_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_1_2;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(binding = 3, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 4, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
					layout(location = 6) flat out uint vs_SV_InstanceID0;
					float u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat13;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    u_xlat4.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].yzx;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0 = inversesqrt(u_xlat0);
					    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
					    vs_TEXCOORD1.y = u_xlat3.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD1.w = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.w = u_xlat4.y;
					    vs_TEXCOORD3.w = u_xlat4.z;
					    vs_TEXCOORD2.y = u_xlat3.y;
					    vs_TEXCOORD3.y = u_xlat3.z;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "LIGHTPROBE_SH" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						vec4 unused_1_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_1_2;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(binding = 3, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 4, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(binding = 5, std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_5_1[14];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
					layout(location = 7) flat out uint vs_SV_InstanceID0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					int u_xlati4;
					float u_xlat8;
					float u_xlat13;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati4 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati4] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)];
					    u_xlat1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 1)].yzx;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati4].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 2)].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati4].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 1)].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 2)].xyz);
					    u_xlat4.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat3 = u_xlat4.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat13);
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat3.x;
					    vs_TEXCOORD1.w = u_xlat1.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.w = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat1.z;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    vs_TEXCOORD2.z = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat3.w;
					    u_xlat4.x = u_xlat3.y * u_xlat3.y;
					    u_xlat4.x = u_xlat3.x * u_xlat3.x + (-u_xlat4.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat1);
					    u_xlat2.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat1);
					    u_xlat2.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "LIGHTPROBE_SH" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						vec4 unused_1_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_1_2;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(binding = 3, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 4, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(binding = 5, std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_5_1[14];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
					layout(location = 7) flat out uint vs_SV_InstanceID0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					int u_xlati4;
					float u_xlat8;
					float u_xlat13;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati4 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati4] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)];
					    u_xlat1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 1)].yzx;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati4].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati4 + 2)].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat8 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat2.xyz = vec3(u_xlat8) * u_xlat2.xyz;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati4].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 1)].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati4 + 2)].xyz);
					    u_xlat4.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat3 = u_xlat4.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat4.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(u_xlat13);
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat3.x;
					    vs_TEXCOORD1.w = u_xlat1.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.w = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat1.z;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    vs_TEXCOORD2.z = u_xlat3.y;
					    vs_TEXCOORD3.z = u_xlat3.w;
					    u_xlat4.x = u_xlat3.y * u_xlat3.y;
					    u_xlat4.x = u_xlat3.x * u_xlat3.x + (-u_xlat4.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat1);
					    u_xlat2.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat1);
					    u_xlat2.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat4.xxx + u_xlat2.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "SHADOWS_SCREEN" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						vec4 unused_2_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_2_2;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(binding = 4, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 5, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_5_1[16];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
					layout(location = 6) flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					float u_xlat17;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    u_xlat5.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].yzx;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
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
					    vs_TEXCOORD1.w = u_xlat5.x;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD2.w = u_xlat5.y;
					    vs_TEXCOORD3.w = u_xlat5.z;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						vec4 unused_2_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_2_2;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(binding = 4, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 5, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_5_1[16];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
					layout(location = 6) flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					float u_xlat17;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    u_xlat5.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].yzx;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
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
					    vs_TEXCOORD1.w = u_xlat5.x;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD2.w = u_xlat5.y;
					    vs_TEXCOORD3.w = u_xlat5.z;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						vec4 unused_2_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_2_2;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(binding = 4, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 5, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_5_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(binding = 6, std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_6_1[14];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
					layout(location = 7) flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					int u_xlati5;
					float u_xlat10;
					float u_xlat16;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati5 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati5] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)];
					    u_xlat1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 1)].yzx;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati5].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 2)].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat10 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat3.xyz = vec3(u_xlat10) * u_xlat3.xyz;
					    u_xlat4.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati5].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 1)].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 2)].xyz);
					    u_xlat5.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat4 = u_xlat5.xxxx * u_xlat4.xyzz;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat4.wxy;
					    u_xlat5.xyz = u_xlat4.ywx * u_xlat3.yzx + (-u_xlat5.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    vs_TEXCOORD1.y = u_xlat5.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat4.x;
					    vs_TEXCOORD1.w = u_xlat1.x;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.w = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat1.z;
					    vs_TEXCOORD2.y = u_xlat5.y;
					    vs_TEXCOORD3.y = u_xlat5.z;
					    vs_TEXCOORD2.z = u_xlat4.y;
					    vs_TEXCOORD3.z = u_xlat4.w;
					    u_xlat5.x = u_xlat4.y * u_xlat4.y;
					    u_xlat5.x = u_xlat4.x * u_xlat4.x + (-u_xlat5.x);
					    u_xlat1 = u_xlat4.ywzx * u_xlat4;
					    u_xlat3.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat1);
					    u_xlat3.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat1);
					    u_xlat3.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat5.xxx + u_xlat3.xyz;
					    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat2.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						vec4 unused_2_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_2_2;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(binding = 4, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 5, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_5_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(binding = 6, std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_6_1[14];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
					layout(location = 7) flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					int u_xlati5;
					float u_xlat10;
					float u_xlat16;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati5 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati5] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)];
					    u_xlat1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 1)].yzx;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati5].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati5 + 2)].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat10 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat3.xyz = vec3(u_xlat10) * u_xlat3.xyz;
					    u_xlat4.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati5].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 1)].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati5 + 2)].xyz);
					    u_xlat5.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat4 = u_xlat5.xxxx * u_xlat4.xyzz;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat4.wxy;
					    u_xlat5.xyz = u_xlat4.ywx * u_xlat3.yzx + (-u_xlat5.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    vs_TEXCOORD1.y = u_xlat5.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat4.x;
					    vs_TEXCOORD1.w = u_xlat1.x;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.w = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat1.z;
					    vs_TEXCOORD2.y = u_xlat5.y;
					    vs_TEXCOORD3.y = u_xlat5.z;
					    vs_TEXCOORD2.z = u_xlat4.y;
					    vs_TEXCOORD3.z = u_xlat4.w;
					    u_xlat5.x = u_xlat4.y * u_xlat4.y;
					    u_xlat5.x = u_xlat4.x * u_xlat4.x + (-u_xlat5.x);
					    u_xlat1 = u_xlat4.ywzx * u_xlat4;
					    u_xlat3.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat1);
					    u_xlat3.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat1);
					    u_xlat3.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat1);
					    vs_TEXCOORD4.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat5.xxx + u_xlat3.xyz;
					    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat2.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "VERTEXLIGHT_ON" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						vec4 unused_1_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_1_2;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(binding = 3, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 4, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
					layout(location = 6) flat out uint vs_SV_InstanceID0;
					float u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat13;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    u_xlat4.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].yzx;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0 = inversesqrt(u_xlat0);
					    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
					    vs_TEXCOORD1.y = u_xlat3.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD1.w = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.w = u_xlat4.y;
					    vs_TEXCOORD3.w = u_xlat4.z;
					    vs_TEXCOORD2.y = u_xlat3.y;
					    vs_TEXCOORD3.y = u_xlat3.z;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						vec4 unused_1_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_1_2;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(binding = 3, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 4, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
					layout(location = 6) flat out uint vs_SV_InstanceID0;
					float u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat13;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    u_xlat4.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].yzx;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0 = inversesqrt(u_xlat0);
					    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
					    vs_TEXCOORD1.y = u_xlat3.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD1.w = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.w = u_xlat4.y;
					    vs_TEXCOORD3.w = u_xlat4.z;
					    vs_TEXCOORD2.y = u_xlat3.y;
					    vs_TEXCOORD3.y = u_xlat3.z;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[40];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						vec4 unused_2_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_2_2;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(binding = 4, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 5, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_5_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(binding = 6, std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_6_1[14];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
					layout(location = 7) flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					int u_xlati6;
					float u_xlat12;
					float u_xlat19;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati6 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati6 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati6] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati6 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati6 + 3)];
					    u_xlat1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati6 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati6 + 1)].yzx;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati6].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati6 + 2)].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati6].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati6 + 1)].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati6 + 2)].xyz);
					    u_xlat6.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat6.x = inversesqrt(u_xlat6.x);
					    u_xlat3 = u_xlat6.xxxx * u_xlat3.xyzz;
					    u_xlat6.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat6.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat6.xyz);
					    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat19);
					    vs_TEXCOORD1.y = u_xlat6.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat3.x;
					    vs_TEXCOORD1.w = u_xlat1.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.w = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat6.y;
					    vs_TEXCOORD3.y = u_xlat6.z;
					    vs_TEXCOORD2.z = u_xlat3.y;
					    vs_TEXCOORD3.w = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat3.w;
					    u_xlat6.x = u_xlat3.y * u_xlat3.y;
					    u_xlat6.x = u_xlat3.x * u_xlat3.x + (-u_xlat6.x);
					    u_xlat2 = u_xlat3.ywzx * u_xlat3;
					    u_xlat4.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat2);
					    u_xlat4.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat2);
					    u_xlat4.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat2);
					    u_xlat0.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat6.xxx + u_xlat4.xyz;
					    u_xlat2 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat3.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat5 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat3.xxxx + u_xlat4;
					    u_xlat3 = u_xlat1 * u_xlat3.wwzw + u_xlat4;
					    u_xlat2 = u_xlat5 * u_xlat5 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[40];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						vec4 unused_2_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_2_2;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(binding = 4, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 5, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_5_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(binding = 6, std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_6_1[14];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
					layout(location = 7) flat out uint vs_SV_InstanceID0;
					vec3 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					int u_xlati6;
					float u_xlat12;
					float u_xlat19;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati6 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati6 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati6] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati6 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati6 + 3)];
					    u_xlat1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati6 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati6 + 1)].yzx;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati6].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati6 + 2)].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati6].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati6 + 1)].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati6 + 2)].xyz);
					    u_xlat6.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat6.x = inversesqrt(u_xlat6.x);
					    u_xlat3 = u_xlat6.xxxx * u_xlat3.xyzz;
					    u_xlat6.xyz = u_xlat2.xyz * u_xlat3.wxy;
					    u_xlat6.xyz = u_xlat3.ywx * u_xlat2.yzx + (-u_xlat6.xyz);
					    u_xlat19 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat19);
					    vs_TEXCOORD1.y = u_xlat6.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat3.x;
					    vs_TEXCOORD1.w = u_xlat1.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.w = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat6.y;
					    vs_TEXCOORD3.y = u_xlat6.z;
					    vs_TEXCOORD2.z = u_xlat3.y;
					    vs_TEXCOORD3.w = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat3.w;
					    u_xlat6.x = u_xlat3.y * u_xlat3.y;
					    u_xlat6.x = u_xlat3.x * u_xlat3.x + (-u_xlat6.x);
					    u_xlat2 = u_xlat3.ywzx * u_xlat3;
					    u_xlat4.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat2);
					    u_xlat4.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat2);
					    u_xlat4.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat2);
					    u_xlat0.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat6.xxx + u_xlat4.xyz;
					    u_xlat2 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat3.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat5 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat3.xxxx + u_xlat4;
					    u_xlat3 = u_xlat1 * u_xlat3.wwzw + u_xlat4;
					    u_xlat2 = u_xlat5 * u_xlat5 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat2.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat2.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat2.xyz + u_xlat0.xyz;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						vec4 unused_2_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_2_2;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(binding = 4, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 5, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_5_1[16];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
					layout(location = 6) flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					float u_xlat17;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    u_xlat5.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].yzx;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
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
					    vs_TEXCOORD1.w = u_xlat5.x;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD2.w = u_xlat5.y;
					    vs_TEXCOORD3.w = u_xlat5.z;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						vec4 unused_2_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_2_2;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(binding = 4, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 5, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_5_1[16];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
					layout(location = 6) flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					float u_xlat17;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    u_xlat5.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].yzx;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
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
					    vs_TEXCOORD1.w = u_xlat5.x;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD2.w = u_xlat5.y;
					    vs_TEXCOORD3.w = u_xlat5.z;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[40];
					};
					layout(binding = 3, std140) uniform UnityPerDraw {
						vec4 unused_3_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_3_2;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(binding = 5, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 6, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_6_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(binding = 7, std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_7_1[14];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
					layout(location = 7) flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					int u_xlati7;
					float u_xlat14;
					float u_xlat22;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati7 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati7 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati7] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati7 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati7 + 3)];
					    u_xlat1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati7 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati7 + 1)].yzx;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati7].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati7 + 2)].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat14 = inversesqrt(u_xlat14);
					    u_xlat3.xyz = vec3(u_xlat14) * u_xlat3.xyz;
					    u_xlat4.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati7].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati7 + 1)].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati7 + 2)].xyz);
					    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat7.x = inversesqrt(u_xlat7.x);
					    u_xlat4 = u_xlat7.xxxx * u_xlat4.xyzz;
					    u_xlat7.xyz = u_xlat3.xyz * u_xlat4.wxy;
					    u_xlat7.xyz = u_xlat4.ywx * u_xlat3.yzx + (-u_xlat7.xyz);
					    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat22);
					    vs_TEXCOORD1.y = u_xlat7.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat4.x;
					    vs_TEXCOORD1.w = u_xlat1.x;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.w = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat7.y;
					    vs_TEXCOORD3.y = u_xlat7.z;
					    vs_TEXCOORD2.z = u_xlat4.y;
					    vs_TEXCOORD3.w = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat4.w;
					    u_xlat7.x = u_xlat4.y * u_xlat4.y;
					    u_xlat7.x = u_xlat4.x * u_xlat4.x + (-u_xlat7.x);
					    u_xlat3 = u_xlat4.ywzx * u_xlat4;
					    u_xlat5.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat3);
					    u_xlat5.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat3);
					    u_xlat5.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat3);
					    u_xlat0.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat7.xxx + u_xlat5.xyz;
					    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat5 = u_xlat4.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat6 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat6 * u_xlat4.xxxx + u_xlat5;
					    u_xlat4 = u_xlat1 * u_xlat4.wwzw + u_xlat5;
					    u_xlat3 = u_xlat6 * u_xlat6 + u_xlat3;
					    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat3.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat3.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat3.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat2.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[40];
					};
					layout(binding = 3, std140) uniform UnityPerDraw {
						vec4 unused_3_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_3_2;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(binding = 5, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 6, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_6_1[16];
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(binding = 7, std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_7_1[14];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
					layout(location = 6) out vec4 vs_TEXCOORD7;
					layout(location = 7) flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					int u_xlati7;
					float u_xlat14;
					float u_xlat22;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati7 = u_xlati0 << 3;
					    u_xlati0 = u_xlati0 * 7;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati7 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati7] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati7 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati7 + 3)];
					    u_xlat1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati7 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati7 + 1)].yzx;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati7].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati7 + 2)].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat14 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat14 = inversesqrt(u_xlat14);
					    u_xlat3.xyz = vec3(u_xlat14) * u_xlat3.xyz;
					    u_xlat4.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati7].xyz);
					    u_xlat4.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati7 + 1)].xyz);
					    u_xlat4.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati7 + 2)].xyz);
					    u_xlat7.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat7.x = inversesqrt(u_xlat7.x);
					    u_xlat4 = u_xlat7.xxxx * u_xlat4.xyzz;
					    u_xlat7.xyz = u_xlat3.xyz * u_xlat4.wxy;
					    u_xlat7.xyz = u_xlat4.ywx * u_xlat3.yzx + (-u_xlat7.xyz);
					    u_xlat22 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat22);
					    vs_TEXCOORD1.y = u_xlat7.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat4.x;
					    vs_TEXCOORD1.w = u_xlat1.x;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.w = u_xlat1.y;
					    vs_TEXCOORD2.y = u_xlat7.y;
					    vs_TEXCOORD3.y = u_xlat7.z;
					    vs_TEXCOORD2.z = u_xlat4.y;
					    vs_TEXCOORD3.w = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat4.w;
					    u_xlat7.x = u_xlat4.y * u_xlat4.y;
					    u_xlat7.x = u_xlat4.x * u_xlat4.x + (-u_xlat7.x);
					    u_xlat3 = u_xlat4.ywzx * u_xlat4;
					    u_xlat5.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBrArray, u_xlat3);
					    u_xlat5.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBgArray, u_xlat3);
					    u_xlat5.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHBbArray, u_xlat3);
					    u_xlat0.xyz = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.xyz * u_xlat7.xxx + u_xlat5.xyz;
					    u_xlat3 = (-u_xlat1.yyyy) + unity_4LightPosY0;
					    u_xlat5 = u_xlat4.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat6 = (-u_xlat1.xxxx) + unity_4LightPosX0;
					    u_xlat1 = (-u_xlat1.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat6 * u_xlat4.xxxx + u_xlat5;
					    u_xlat4 = u_xlat1 * u_xlat4.wwzw + u_xlat5;
					    u_xlat3 = u_xlat6 * u_xlat6 + u_xlat3;
					    u_xlat1 = u_xlat1 * u_xlat1 + u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat1);
					    u_xlat1 = u_xlat1 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat1 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat1;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat3.xyz = u_xlat1.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat1.xyz = unity_LightColor[2].xyz * u_xlat1.zzz + u_xlat3.xyz;
					    u_xlat1.xyz = unity_LightColor[3].xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    vs_TEXCOORD4.xyz = u_xlat1.xyz * u_xlat3.xyz + u_xlat0.xyz;
					    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat2.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						vec4 unused_1_0[9];
						vec4 unity_WorldTransformParams;
						vec4 unused_1_2;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(binding = 3, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 4, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec4 vs_TEXCOORD1;
					layout(location = 2) out vec4 vs_TEXCOORD2;
					layout(location = 3) out vec4 vs_TEXCOORD3;
					layout(location = 4) out vec4 vs_TEXCOORD6;
					layout(location = 5) out vec4 vs_TEXCOORD7;
					layout(location = 6) flat out uint vs_SV_InstanceID0;
					float u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat13;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)];
					    u_xlat4.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD1.xy * _texcoord2_ST.xy + _texcoord2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].yzx;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0 = inversesqrt(u_xlat0);
					    u_xlat2.xyz = vec3(u_xlat0) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat0) * u_xlat3.xyz;
					    vs_TEXCOORD1.y = u_xlat3.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD1.w = u_xlat4.x;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.w = u_xlat4.y;
					    vs_TEXCOORD3.w = u_xlat4.z;
					    vs_TEXCOORD2.y = u_xlat3.y;
					    vs_TEXCOORD3.y = u_xlat3.z;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_TEXCOORD7 = vec4(0.0, 0.0, 0.0, 0.0);
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 4, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 5) uniform  sampler2D _TextureSample1;
					layout(location = 6) uniform  sampler2D _ColorRT;
					layout(location = 7) uniform  sampler2D _TextureSample0;
					layout(location = 8) uniform  sampler2D _WetnessRT;
					layout(location = 9) uniform  sampler2D _Specular;
					layout(location = 10) uniform  samplerCube unity_SpecCube0;
					layout(location = 11) uniform  samplerCube unity_SpecCube1;
					layout(location = 12) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat16_4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					float u_xlat27;
					float u_xlat28;
					float u_xlat39;
					float u_xlat40;
					float u_xlat16_40;
					float u_xlat10_40;
					float u_xlat41;
					float u_xlat10_41;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat40 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat3.z = sqrt(u_xlat40);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat16_4.xyz = u_xlat10_4.xyz + u_xlat10_4.xyz;
					    u_xlat4.xyz = u_xlat7.xyz * u_xlat16_4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat40 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_40 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_40 = max(u_xlat10_40, 0.0);
					    u_xlat40 = min(u_xlat16_40, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_41 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat41 = u_xlat10_41 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat41 = dot(u_xlat5.xy, vec2(u_xlat41));
					    u_xlat41 = max(u_xlat41, 0.0);
					    u_xlat41 = min(u_xlat41, _MaxOriginalSpecular);
					    u_xlat40 = u_xlat40 + u_xlat41;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
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
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat41 = u_xlat28 * u_xlat28;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat28 = u_xlat28 * u_xlat41;
					    u_xlat14 = u_xlat14 * u_xlat28 + 1.0;
					    u_xlat14 = u_xlat14 * u_xlat27;
					    u_xlat14 = u_xlat2.x * u_xlat14;
					    u_xlat27 = u_xlat42 * u_xlat42;
					    u_xlat27 = max(u_xlat27, 0.00200000009);
					    u_xlat41 = (-u_xlat27) + 1.0;
					    u_xlat3.x = abs(u_xlat39) * u_xlat41 + u_xlat27;
					    u_xlat41 = u_xlat2.x * u_xlat41 + u_xlat27;
					    u_xlat39 = abs(u_xlat39) * u_xlat41;
					    u_xlat39 = u_xlat2.x * u_xlat3.x + u_xlat39;
					    u_xlat39 = u_xlat39 + 9.99999975e-06;
					    u_xlat39 = 0.5 / u_xlat39;
					    u_xlat41 = u_xlat27 * u_xlat27;
					    u_xlat3.x = u_xlat15 * u_xlat41 + (-u_xlat15);
					    u_xlat15 = u_xlat3.x * u_xlat15 + 1.0;
					    u_xlat41 = u_xlat41 * 0.318309873;
					    u_xlat15 = u_xlat15 * u_xlat15 + 1.00000001e-07;
					    u_xlat15 = u_xlat41 / u_xlat15;
					    u_xlat39 = u_xlat39 * u_xlat15;
					    u_xlat39 = u_xlat39 * 3.14159274;
					    u_xlat39 = max(u_xlat39, 9.99999975e-05);
					    u_xlat39 = sqrt(u_xlat39);
					    u_xlat39 = u_xlat2.x * u_xlat39;
					    u_xlat27 = u_xlat27 * 0.280000001;
					    u_xlat27 = (-u_xlat27) * u_xlat42 + 1.0;
					    u_xlat40 = u_xlat40 + 0.220916271;
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat2.xyw = vec3(u_xlat14) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(u_xlat39);
					    u_xlat39 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat39 * u_xlat39;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat39 = u_xlat39 * u_xlat1.x;
					    u_xlat39 = u_xlat39 * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat8.xyz * vec3(u_xlat27);
					    u_xlat39 = u_xlat40 + -0.220916301;
					    u_xlat39 = u_xlat28 * u_xlat39 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(binding = 3, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 4, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 5) uniform  sampler2D _TextureSample1;
					layout(location = 6) uniform  sampler2D _ColorRT;
					layout(location = 7) uniform  sampler2D _TextureSample0;
					layout(location = 8) uniform  sampler2D _WetnessRT;
					layout(location = 9) uniform  sampler2D _Specular;
					layout(location = 10) uniform  samplerCube unity_SpecCube0;
					layout(location = 11) uniform  samplerCube unity_SpecCube1;
					layout(location = 12) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					float u_xlat10_43;
					float u_xlat44;
					float u_xlat10_44;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat43 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat3.z = sqrt(u_xlat43);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat43 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat43) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_43 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_43 = max(u_xlat10_43, 0.0);
					    u_xlat43 = min(u_xlat16_43, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_44 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat44 = u_xlat10_44 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat44 = dot(u_xlat5.xy, vec2(u_xlat44));
					    u_xlat44 = max(u_xlat44, 0.0);
					    u_xlat44 = min(u_xlat44, _MaxOriginalSpecular);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
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
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat15 = u_xlat1.x + u_xlat1.x;
					    u_xlat15 = u_xlat1.x * u_xlat15;
					    u_xlat15 = u_xlat15 * u_xlat3.x + -0.5;
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
					    u_xlat29 = u_xlat3.x * u_xlat3.x;
					    u_xlat29 = max(u_xlat29, 0.00200000009);
					    u_xlat44 = (-u_xlat29) + 1.0;
					    u_xlat4.x = abs(u_xlat42) * u_xlat44 + u_xlat29;
					    u_xlat44 = u_xlat2.x * u_xlat44 + u_xlat29;
					    u_xlat42 = abs(u_xlat42) * u_xlat44;
					    u_xlat42 = u_xlat2.x * u_xlat4.x + u_xlat42;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat44 = u_xlat29 * u_xlat29;
					    u_xlat4.x = u_xlat16 * u_xlat44 + (-u_xlat16);
					    u_xlat16 = u_xlat4.x * u_xlat16 + 1.0;
					    u_xlat44 = u_xlat44 * 0.318309873;
					    u_xlat16 = u_xlat16 * u_xlat16 + 1.00000001e-07;
					    u_xlat16 = u_xlat44 / u_xlat16;
					    u_xlat42 = u_xlat42 * u_xlat16;
					    u_xlat42 = u_xlat42 * 3.14159274;
					    u_xlat42 = max(u_xlat42, 9.99999975e-05);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat42 = u_xlat2.x * u_xlat42;
					    u_xlat29 = u_xlat29 * 0.280000001;
					    u_xlat29 = (-u_xlat29) * u_xlat3.x + 1.0;
					    u_xlat43 = u_xlat43 + 0.220916271;
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat2.xyw = u_xlat17.xyz * vec3(u_xlat15) + u_xlat7.xyz;
					    u_xlat3.xyz = u_xlat17.xyz * vec3(u_xlat42);
					    u_xlat42 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat42 * u_xlat42;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat42 = u_xlat42 * u_xlat1.x;
					    u_xlat42 = u_xlat42 * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = vec3(u_xlat42) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(u_xlat29);
					    u_xlat42 = u_xlat43 + -0.220916301;
					    u_xlat42 = u_xlat30 * u_xlat42 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(binding = 3, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 4, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 5) uniform  sampler2D _TextureSample1;
					layout(location = 6) uniform  sampler2D _ColorRT;
					layout(location = 7) uniform  sampler2D _TextureSample0;
					layout(location = 8) uniform  sampler2D _WetnessRT;
					layout(location = 9) uniform  sampler2D _Specular;
					layout(location = 10) uniform  samplerCube unity_SpecCube0;
					layout(location = 11) uniform  samplerCube unity_SpecCube1;
					layout(location = 12) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					float u_xlat10_43;
					float u_xlat44;
					float u_xlat10_44;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat43 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat3.z = sqrt(u_xlat43);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat43 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat43) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_43 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_43 = max(u_xlat10_43, 0.0);
					    u_xlat43 = min(u_xlat16_43, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_44 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat44 = u_xlat10_44 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat44 = dot(u_xlat5.xy, vec2(u_xlat44));
					    u_xlat44 = max(u_xlat44, 0.0);
					    u_xlat44 = min(u_xlat44, _MaxOriginalSpecular);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
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
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat15 = u_xlat1.x + u_xlat1.x;
					    u_xlat15 = u_xlat1.x * u_xlat15;
					    u_xlat15 = u_xlat15 * u_xlat3.x + -0.5;
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
					    u_xlat29 = u_xlat3.x * u_xlat3.x;
					    u_xlat29 = max(u_xlat29, 0.00200000009);
					    u_xlat44 = (-u_xlat29) + 1.0;
					    u_xlat4.x = abs(u_xlat42) * u_xlat44 + u_xlat29;
					    u_xlat44 = u_xlat2.x * u_xlat44 + u_xlat29;
					    u_xlat42 = abs(u_xlat42) * u_xlat44;
					    u_xlat42 = u_xlat2.x * u_xlat4.x + u_xlat42;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat44 = u_xlat29 * u_xlat29;
					    u_xlat4.x = u_xlat16 * u_xlat44 + (-u_xlat16);
					    u_xlat16 = u_xlat4.x * u_xlat16 + 1.0;
					    u_xlat44 = u_xlat44 * 0.318309873;
					    u_xlat16 = u_xlat16 * u_xlat16 + 1.00000001e-07;
					    u_xlat16 = u_xlat44 / u_xlat16;
					    u_xlat42 = u_xlat42 * u_xlat16;
					    u_xlat42 = u_xlat42 * 3.14159274;
					    u_xlat42 = max(u_xlat42, 9.99999975e-05);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat42 = u_xlat2.x * u_xlat42;
					    u_xlat29 = u_xlat29 * 0.280000001;
					    u_xlat29 = (-u_xlat29) * u_xlat3.x + 1.0;
					    u_xlat43 = u_xlat43 + 0.220916271;
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat2.xyw = u_xlat17.xyz * vec3(u_xlat15) + u_xlat7.xyz;
					    u_xlat3.xyz = u_xlat17.xyz * vec3(u_xlat42);
					    u_xlat42 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat42 * u_xlat42;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat42 = u_xlat42 * u_xlat1.x;
					    u_xlat42 = u_xlat42 * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = vec3(u_xlat42) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(u_xlat29);
					    u_xlat42 = u_xlat43 + -0.220916301;
					    u_xlat42 = u_xlat30 * u_xlat42 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 6, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 7) uniform  sampler2D _TextureSample1;
					layout(location = 8) uniform  sampler2D _ColorRT;
					layout(location = 9) uniform  sampler2D _TextureSample0;
					layout(location = 10) uniform  sampler2D _WetnessRT;
					layout(location = 11) uniform  sampler2D _Specular;
					layout(location = 12) uniform  sampler2D _ShadowMapTexture;
					layout(location = 13) uniform  samplerCube unity_SpecCube0;
					layout(location = 14) uniform  samplerCube unity_SpecCube1;
					layout(location = 15) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 4) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat16_4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					float u_xlat27;
					float u_xlat28;
					float u_xlat39;
					float u_xlat40;
					float u_xlat16_40;
					float u_xlat10_40;
					float u_xlat41;
					float u_xlat10_41;
					bool u_xlatb41;
					float u_xlat42;
					bool u_xlatb42;
					float u_xlat43;
					float u_xlat16_43;
					float u_xlat10_43;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat40 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat3.z = sqrt(u_xlat40);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat16_4.xyz = u_xlat10_4.xyz + u_xlat10_4.xyz;
					    u_xlat4.xyz = u_xlat7.xyz * u_xlat16_4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat40 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_40 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_40 = max(u_xlat10_40, 0.0);
					    u_xlat40 = min(u_xlat16_40, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_41 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat41 = u_xlat10_41 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat41 = dot(u_xlat5.xy, vec2(u_xlat41));
					    u_xlat41 = max(u_xlat41, 0.0);
					    u_xlat41 = min(u_xlat41, _MaxOriginalSpecular);
					    u_xlat40 = u_xlat40 + u_xlat41;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
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
					    u_xlat10_43 = texture(_ShadowMapTexture, u_xlat5.xy).x;
					    u_xlat42 = u_xlat42 + (-u_xlat10_43);
					    u_xlat41 = u_xlat41 * u_xlat42 + u_xlat10_43;
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
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat41 = u_xlat28 * u_xlat28;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat28 = u_xlat28 * u_xlat41;
					    u_xlat14 = u_xlat14 * u_xlat28 + 1.0;
					    u_xlat14 = u_xlat14 * u_xlat27;
					    u_xlat14 = u_xlat2.x * u_xlat14;
					    u_xlat27 = u_xlat42 * u_xlat42;
					    u_xlat27 = max(u_xlat27, 0.00200000009);
					    u_xlat41 = (-u_xlat27) + 1.0;
					    u_xlat3.x = abs(u_xlat39) * u_xlat41 + u_xlat27;
					    u_xlat41 = u_xlat2.x * u_xlat41 + u_xlat27;
					    u_xlat39 = abs(u_xlat39) * u_xlat41;
					    u_xlat39 = u_xlat2.x * u_xlat3.x + u_xlat39;
					    u_xlat39 = u_xlat39 + 9.99999975e-06;
					    u_xlat39 = 0.5 / u_xlat39;
					    u_xlat41 = u_xlat27 * u_xlat27;
					    u_xlat3.x = u_xlat15 * u_xlat41 + (-u_xlat15);
					    u_xlat15 = u_xlat3.x * u_xlat15 + 1.0;
					    u_xlat41 = u_xlat41 * 0.318309873;
					    u_xlat15 = u_xlat15 * u_xlat15 + 1.00000001e-07;
					    u_xlat15 = u_xlat41 / u_xlat15;
					    u_xlat39 = u_xlat39 * u_xlat15;
					    u_xlat39 = u_xlat39 * 3.14159274;
					    u_xlat39 = max(u_xlat39, 9.99999975e-05);
					    u_xlat39 = sqrt(u_xlat39);
					    u_xlat39 = u_xlat2.x * u_xlat39;
					    u_xlat27 = u_xlat27 * 0.280000001;
					    u_xlat27 = (-u_xlat27) * u_xlat42 + 1.0;
					    u_xlat40 = u_xlat40 + 0.220916271;
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat2.xyw = vec3(u_xlat14) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(u_xlat39);
					    u_xlat39 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat39 * u_xlat39;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat39 = u_xlat39 * u_xlat1.x;
					    u_xlat39 = u_xlat39 * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat8.xyz * vec3(u_xlat27);
					    u_xlat39 = u_xlat40 + -0.220916301;
					    u_xlat39 = u_xlat28 * u_xlat39 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 6, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 7) uniform  sampler2D _TextureSample1;
					layout(location = 8) uniform  sampler2D _ColorRT;
					layout(location = 9) uniform  sampler2D _TextureSample0;
					layout(location = 10) uniform  sampler2D _WetnessRT;
					layout(location = 11) uniform  sampler2D _Specular;
					layout(location = 12) uniform  sampler2D _ShadowMapTexture;
					layout(location = 13) uniform  samplerCube unity_SpecCube0;
					layout(location = 14) uniform  samplerCube unity_SpecCube1;
					layout(location = 15) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 4) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat16_4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					float u_xlat27;
					float u_xlat28;
					float u_xlat39;
					float u_xlat40;
					float u_xlat16_40;
					float u_xlat10_40;
					float u_xlat41;
					float u_xlat10_41;
					bool u_xlatb41;
					float u_xlat42;
					bool u_xlatb42;
					float u_xlat43;
					float u_xlat16_43;
					float u_xlat10_43;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat40 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat3.z = sqrt(u_xlat40);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat16_4.xyz = u_xlat10_4.xyz + u_xlat10_4.xyz;
					    u_xlat4.xyz = u_xlat7.xyz * u_xlat16_4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat40 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_40 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_40 = max(u_xlat10_40, 0.0);
					    u_xlat40 = min(u_xlat16_40, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_41 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat41 = u_xlat10_41 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat41 = dot(u_xlat5.xy, vec2(u_xlat41));
					    u_xlat41 = max(u_xlat41, 0.0);
					    u_xlat41 = min(u_xlat41, _MaxOriginalSpecular);
					    u_xlat40 = u_xlat40 + u_xlat41;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
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
					    u_xlat10_43 = texture(_ShadowMapTexture, u_xlat5.xy).x;
					    u_xlat42 = u_xlat42 + (-u_xlat10_43);
					    u_xlat41 = u_xlat41 * u_xlat42 + u_xlat10_43;
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
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat41 = u_xlat28 * u_xlat28;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat28 = u_xlat28 * u_xlat41;
					    u_xlat14 = u_xlat14 * u_xlat28 + 1.0;
					    u_xlat14 = u_xlat14 * u_xlat27;
					    u_xlat14 = u_xlat2.x * u_xlat14;
					    u_xlat27 = u_xlat42 * u_xlat42;
					    u_xlat27 = max(u_xlat27, 0.00200000009);
					    u_xlat41 = (-u_xlat27) + 1.0;
					    u_xlat3.x = abs(u_xlat39) * u_xlat41 + u_xlat27;
					    u_xlat41 = u_xlat2.x * u_xlat41 + u_xlat27;
					    u_xlat39 = abs(u_xlat39) * u_xlat41;
					    u_xlat39 = u_xlat2.x * u_xlat3.x + u_xlat39;
					    u_xlat39 = u_xlat39 + 9.99999975e-06;
					    u_xlat39 = 0.5 / u_xlat39;
					    u_xlat41 = u_xlat27 * u_xlat27;
					    u_xlat3.x = u_xlat15 * u_xlat41 + (-u_xlat15);
					    u_xlat15 = u_xlat3.x * u_xlat15 + 1.0;
					    u_xlat41 = u_xlat41 * 0.318309873;
					    u_xlat15 = u_xlat15 * u_xlat15 + 1.00000001e-07;
					    u_xlat15 = u_xlat41 / u_xlat15;
					    u_xlat39 = u_xlat39 * u_xlat15;
					    u_xlat39 = u_xlat39 * 3.14159274;
					    u_xlat39 = max(u_xlat39, 9.99999975e-05);
					    u_xlat39 = sqrt(u_xlat39);
					    u_xlat39 = u_xlat2.x * u_xlat39;
					    u_xlat27 = u_xlat27 * 0.280000001;
					    u_xlat27 = (-u_xlat27) * u_xlat42 + 1.0;
					    u_xlat40 = u_xlat40 + 0.220916271;
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat2.xyw = vec3(u_xlat14) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(u_xlat39);
					    u_xlat39 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat39 * u_xlat39;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat39 = u_xlat39 * u_xlat1.x;
					    u_xlat39 = u_xlat39 * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat8.xyz * vec3(u_xlat27);
					    u_xlat39 = u_xlat40 + -0.220916301;
					    u_xlat39 = u_xlat28 * u_xlat39 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 6, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 7) uniform  sampler2D _TextureSample1;
					layout(location = 8) uniform  sampler2D _ColorRT;
					layout(location = 9) uniform  sampler2D _TextureSample0;
					layout(location = 10) uniform  sampler2D _WetnessRT;
					layout(location = 11) uniform  sampler2D _Specular;
					layout(location = 12) uniform  sampler2D _ShadowMapTexture;
					layout(location = 13) uniform  samplerCube unity_SpecCube0;
					layout(location = 14) uniform  samplerCube unity_SpecCube1;
					layout(location = 15) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 5) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					float u_xlat10_43;
					float u_xlat44;
					float u_xlat10_44;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat43 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat3.z = sqrt(u_xlat43);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat43 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat43) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_43 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_43 = max(u_xlat10_43, 0.0);
					    u_xlat43 = min(u_xlat16_43, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_44 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat44 = u_xlat10_44 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat44 = dot(u_xlat5.xy, vec2(u_xlat44));
					    u_xlat44 = max(u_xlat44, 0.0);
					    u_xlat44 = min(u_xlat44, _MaxOriginalSpecular);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
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
					    u_xlat10_5.x = texture(_ShadowMapTexture, u_xlat5.xy).x;
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
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat15 = u_xlat1.x + u_xlat1.x;
					    u_xlat15 = u_xlat1.x * u_xlat15;
					    u_xlat15 = u_xlat15 * u_xlat3.x + -0.5;
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
					    u_xlat29 = u_xlat3.x * u_xlat3.x;
					    u_xlat29 = max(u_xlat29, 0.00200000009);
					    u_xlat44 = (-u_xlat29) + 1.0;
					    u_xlat4.x = abs(u_xlat42) * u_xlat44 + u_xlat29;
					    u_xlat44 = u_xlat2.x * u_xlat44 + u_xlat29;
					    u_xlat42 = abs(u_xlat42) * u_xlat44;
					    u_xlat42 = u_xlat2.x * u_xlat4.x + u_xlat42;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat44 = u_xlat29 * u_xlat29;
					    u_xlat4.x = u_xlat16 * u_xlat44 + (-u_xlat16);
					    u_xlat16 = u_xlat4.x * u_xlat16 + 1.0;
					    u_xlat44 = u_xlat44 * 0.318309873;
					    u_xlat16 = u_xlat16 * u_xlat16 + 1.00000001e-07;
					    u_xlat16 = u_xlat44 / u_xlat16;
					    u_xlat42 = u_xlat42 * u_xlat16;
					    u_xlat42 = u_xlat42 * 3.14159274;
					    u_xlat42 = max(u_xlat42, 9.99999975e-05);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat42 = u_xlat2.x * u_xlat42;
					    u_xlat29 = u_xlat29 * 0.280000001;
					    u_xlat29 = (-u_xlat29) * u_xlat3.x + 1.0;
					    u_xlat43 = u_xlat43 + 0.220916271;
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat2.xyw = u_xlat7.xyz * vec3(u_xlat15) + u_xlat17.xyz;
					    u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat42);
					    u_xlat42 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat42 * u_xlat42;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat42 = u_xlat42 * u_xlat1.x;
					    u_xlat42 = u_xlat42 * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = vec3(u_xlat42) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(u_xlat29);
					    u_xlat42 = u_xlat43 + -0.220916301;
					    u_xlat42 = u_xlat30 * u_xlat42 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 6, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 7) uniform  sampler2D _TextureSample1;
					layout(location = 8) uniform  sampler2D _ColorRT;
					layout(location = 9) uniform  sampler2D _TextureSample0;
					layout(location = 10) uniform  sampler2D _WetnessRT;
					layout(location = 11) uniform  sampler2D _Specular;
					layout(location = 12) uniform  sampler2D _ShadowMapTexture;
					layout(location = 13) uniform  samplerCube unity_SpecCube0;
					layout(location = 14) uniform  samplerCube unity_SpecCube1;
					layout(location = 15) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 5) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					float u_xlat10_43;
					float u_xlat44;
					float u_xlat10_44;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat43 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat43 = (-u_xlat43) + 1.0;
					    u_xlat3.z = sqrt(u_xlat43);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat43 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat43) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_43 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_43 = max(u_xlat10_43, 0.0);
					    u_xlat43 = min(u_xlat16_43, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_44 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat44 = u_xlat10_44 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat44 = dot(u_xlat5.xy, vec2(u_xlat44));
					    u_xlat44 = max(u_xlat44, 0.0);
					    u_xlat44 = min(u_xlat44, _MaxOriginalSpecular);
					    u_xlat43 = u_xlat43 + u_xlat44;
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
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
					    u_xlat10_5.x = texture(_ShadowMapTexture, u_xlat5.xy).x;
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
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat15 = u_xlat1.x + u_xlat1.x;
					    u_xlat15 = u_xlat1.x * u_xlat15;
					    u_xlat15 = u_xlat15 * u_xlat3.x + -0.5;
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
					    u_xlat29 = u_xlat3.x * u_xlat3.x;
					    u_xlat29 = max(u_xlat29, 0.00200000009);
					    u_xlat44 = (-u_xlat29) + 1.0;
					    u_xlat4.x = abs(u_xlat42) * u_xlat44 + u_xlat29;
					    u_xlat44 = u_xlat2.x * u_xlat44 + u_xlat29;
					    u_xlat42 = abs(u_xlat42) * u_xlat44;
					    u_xlat42 = u_xlat2.x * u_xlat4.x + u_xlat42;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat44 = u_xlat29 * u_xlat29;
					    u_xlat4.x = u_xlat16 * u_xlat44 + (-u_xlat16);
					    u_xlat16 = u_xlat4.x * u_xlat16 + 1.0;
					    u_xlat44 = u_xlat44 * 0.318309873;
					    u_xlat16 = u_xlat16 * u_xlat16 + 1.00000001e-07;
					    u_xlat16 = u_xlat44 / u_xlat16;
					    u_xlat42 = u_xlat42 * u_xlat16;
					    u_xlat42 = u_xlat42 * 3.14159274;
					    u_xlat42 = max(u_xlat42, 9.99999975e-05);
					    u_xlat42 = sqrt(u_xlat42);
					    u_xlat42 = u_xlat2.x * u_xlat42;
					    u_xlat29 = u_xlat29 * 0.280000001;
					    u_xlat29 = (-u_xlat29) * u_xlat3.x + 1.0;
					    u_xlat43 = u_xlat43 + 0.220916271;
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat2.xyw = u_xlat7.xyz * vec3(u_xlat15) + u_xlat17.xyz;
					    u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat42);
					    u_xlat42 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat42 * u_xlat42;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat42 = u_xlat42 * u_xlat1.x;
					    u_xlat42 = u_xlat42 * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = vec3(u_xlat42) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat9.xyz * vec3(u_xlat29);
					    u_xlat42 = u_xlat43 + -0.220916301;
					    u_xlat42 = u_xlat30 * u_xlat42 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat42) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 4, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 5) uniform  sampler2D _TextureSample1;
					layout(location = 6) uniform  sampler2D _ColorRT;
					layout(location = 7) uniform  sampler2D _TextureSample0;
					layout(location = 8) uniform  sampler2D _WetnessRT;
					layout(location = 9) uniform  sampler2D _Specular;
					layout(location = 10) uniform  samplerCube unity_SpecCube0;
					layout(location = 11) uniform  samplerCube unity_SpecCube1;
					layout(location = 12) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat16_4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					float u_xlat27;
					float u_xlat28;
					float u_xlat39;
					float u_xlat40;
					float u_xlat16_40;
					float u_xlat10_40;
					float u_xlat41;
					float u_xlat10_41;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat40 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat3.z = sqrt(u_xlat40);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat16_4.xyz = u_xlat10_4.xyz + u_xlat10_4.xyz;
					    u_xlat4.xyz = u_xlat7.xyz * u_xlat16_4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat40 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_40 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_40 = max(u_xlat10_40, 0.0);
					    u_xlat40 = min(u_xlat16_40, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_41 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat41 = u_xlat10_41 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat41 = dot(u_xlat5.xy, vec2(u_xlat41));
					    u_xlat41 = max(u_xlat41, 0.0);
					    u_xlat41 = min(u_xlat41, _MaxOriginalSpecular);
					    u_xlat40 = u_xlat40 + u_xlat41;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
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
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat41 = u_xlat28 * u_xlat28;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat28 = u_xlat28 * u_xlat41;
					    u_xlat14 = u_xlat14 * u_xlat28 + 1.0;
					    u_xlat14 = u_xlat14 * u_xlat27;
					    u_xlat14 = u_xlat2.x * u_xlat14;
					    u_xlat27 = u_xlat42 * u_xlat42;
					    u_xlat27 = max(u_xlat27, 0.00200000009);
					    u_xlat41 = (-u_xlat27) + 1.0;
					    u_xlat3.x = abs(u_xlat39) * u_xlat41 + u_xlat27;
					    u_xlat41 = u_xlat2.x * u_xlat41 + u_xlat27;
					    u_xlat39 = abs(u_xlat39) * u_xlat41;
					    u_xlat39 = u_xlat2.x * u_xlat3.x + u_xlat39;
					    u_xlat39 = u_xlat39 + 9.99999975e-06;
					    u_xlat39 = 0.5 / u_xlat39;
					    u_xlat41 = u_xlat27 * u_xlat27;
					    u_xlat3.x = u_xlat15 * u_xlat41 + (-u_xlat15);
					    u_xlat15 = u_xlat3.x * u_xlat15 + 1.0;
					    u_xlat41 = u_xlat41 * 0.318309873;
					    u_xlat15 = u_xlat15 * u_xlat15 + 1.00000001e-07;
					    u_xlat15 = u_xlat41 / u_xlat15;
					    u_xlat39 = u_xlat39 * u_xlat15;
					    u_xlat39 = u_xlat39 * 3.14159274;
					    u_xlat39 = max(u_xlat39, 9.99999975e-05);
					    u_xlat39 = sqrt(u_xlat39);
					    u_xlat39 = u_xlat2.x * u_xlat39;
					    u_xlat27 = u_xlat27 * 0.280000001;
					    u_xlat27 = (-u_xlat27) * u_xlat42 + 1.0;
					    u_xlat40 = u_xlat40 + 0.220916271;
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat2.xyw = vec3(u_xlat14) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(u_xlat39);
					    u_xlat39 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat39 * u_xlat39;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat39 = u_xlat39 * u_xlat1.x;
					    u_xlat39 = u_xlat39 * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat8.xyz * vec3(u_xlat27);
					    u_xlat39 = u_xlat40 + -0.220916301;
					    u_xlat39 = u_xlat28 * u_xlat39 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 4, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 5) uniform  sampler2D _TextureSample1;
					layout(location = 6) uniform  sampler2D _ColorRT;
					layout(location = 7) uniform  sampler2D _TextureSample0;
					layout(location = 8) uniform  sampler2D _WetnessRT;
					layout(location = 9) uniform  sampler2D _Specular;
					layout(location = 10) uniform  samplerCube unity_SpecCube0;
					layout(location = 11) uniform  samplerCube unity_SpecCube1;
					layout(location = 12) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					float u_xlat27;
					float u_xlat28;
					float u_xlat39;
					float u_xlat40;
					float u_xlat16_40;
					float u_xlat10_40;
					float u_xlat41;
					float u_xlat10_41;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat40 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat3.z = sqrt(u_xlat40);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat40 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_40 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_40 = max(u_xlat10_40, 0.0);
					    u_xlat40 = min(u_xlat16_40, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_41 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat41 = u_xlat10_41 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat41 = dot(u_xlat5.xy, vec2(u_xlat41));
					    u_xlat41 = max(u_xlat41, 0.0);
					    u_xlat41 = min(u_xlat41, _MaxOriginalSpecular);
					    u_xlat40 = u_xlat40 + u_xlat41;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
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
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat14 = u_xlat1.x + u_xlat1.x;
					    u_xlat14 = u_xlat1.x * u_xlat14;
					    u_xlat14 = u_xlat14 * u_xlat42 + -0.5;
					    u_xlat27 = (-u_xlat2.x) + 1.0;
					    u_xlat28 = u_xlat27 * u_xlat27;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat27 = u_xlat27 * u_xlat28;
					    u_xlat27 = u_xlat14 * u_xlat27 + 1.0;
					    u_xlat28 = -abs(u_xlat39) + 1.0;
					    u_xlat41 = u_xlat28 * u_xlat28;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat28 = u_xlat28 * u_xlat41;
					    u_xlat14 = u_xlat14 * u_xlat28 + 1.0;
					    u_xlat14 = u_xlat14 * u_xlat27;
					    u_xlat14 = u_xlat2.x * u_xlat14;
					    u_xlat27 = u_xlat42 * u_xlat42;
					    u_xlat27 = max(u_xlat27, 0.00200000009);
					    u_xlat41 = (-u_xlat27) + 1.0;
					    u_xlat3.x = abs(u_xlat39) * u_xlat41 + u_xlat27;
					    u_xlat41 = u_xlat2.x * u_xlat41 + u_xlat27;
					    u_xlat39 = abs(u_xlat39) * u_xlat41;
					    u_xlat39 = u_xlat2.x * u_xlat3.x + u_xlat39;
					    u_xlat39 = u_xlat39 + 9.99999975e-06;
					    u_xlat39 = 0.5 / u_xlat39;
					    u_xlat41 = u_xlat27 * u_xlat27;
					    u_xlat3.x = u_xlat15 * u_xlat41 + (-u_xlat15);
					    u_xlat15 = u_xlat3.x * u_xlat15 + 1.0;
					    u_xlat41 = u_xlat41 * 0.318309873;
					    u_xlat15 = u_xlat15 * u_xlat15 + 1.00000001e-07;
					    u_xlat15 = u_xlat41 / u_xlat15;
					    u_xlat39 = u_xlat39 * u_xlat15;
					    u_xlat39 = u_xlat39 * 3.14159274;
					    u_xlat39 = max(u_xlat39, 9.99999975e-05);
					    u_xlat39 = sqrt(u_xlat39);
					    u_xlat39 = u_xlat2.x * u_xlat39;
					    u_xlat27 = u_xlat27 * 0.280000001;
					    u_xlat27 = (-u_xlat27) * u_xlat42 + 1.0;
					    u_xlat40 = u_xlat40 + 0.220916271;
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat2.xyw = vec3(u_xlat14) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(u_xlat39);
					    u_xlat39 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat39 * u_xlat39;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat39 = u_xlat39 * u_xlat1.x;
					    u_xlat39 = u_xlat39 * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat8.xyz * vec3(u_xlat27);
					    u_xlat39 = u_xlat40 + -0.220916301;
					    u_xlat39 = u_xlat28 * u_xlat39 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "LIGHTPROBE_SH" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 4, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(binding = 5, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(binding = 6, std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_6_1[14];
					};
					layout(location = 7) uniform  sampler2D _TextureSample1;
					layout(location = 8) uniform  sampler2D _ColorRT;
					layout(location = 9) uniform  sampler2D _TextureSample0;
					layout(location = 10) uniform  sampler2D _WetnessRT;
					layout(location = 11) uniform  sampler2D _Specular;
					layout(location = 12) uniform  samplerCube unity_SpecCube0;
					layout(location = 13) uniform  samplerCube unity_SpecCube1;
					layout(location = 14) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 5) flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					int u_xlati0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					vec3 u_xlat14;
					float u_xlat16;
					vec3 u_xlat17;
					bool u_xlatb17;
					float u_xlat19;
					vec2 u_xlat28;
					float u_xlat30;
					float u_xlat31;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					float u_xlat16_44;
					float u_xlat10_44;
					float u_xlat45;
					float u_xlat10_45;
					bool u_xlatb45;
					float u_xlat46;
					float u_xlat16_46;
					bool u_xlatb46;
					float u_xlat47;
					bool u_xlatb47;
					void main()
					{
					    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					    u_xlat1.x = vs_TEXCOORD1.w;
					    u_xlat1.y = vs_TEXCOORD2.w;
					    u_xlat1.z = vs_TEXCOORD3.w;
					    u_xlat14.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat43 = dot(u_xlat14.xyz, u_xlat14.xyz);
					    u_xlat43 = inversesqrt(u_xlat43);
					    u_xlat2.xyz = u_xlat14.xyz * vec3(u_xlat43);
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat44 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat44 = min(u_xlat44, 1.0);
					    u_xlat44 = (-u_xlat44) + 1.0;
					    u_xlat3.z = sqrt(u_xlat44);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat44 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat44) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_44 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_44 = max(u_xlat10_44, 0.0);
					    u_xlat44 = min(u_xlat16_44, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_45 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat45 = u_xlat10_45 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat45 = dot(u_xlat5.xy, vec2(u_xlat45));
					    u_xlat45 = max(u_xlat45, 0.0);
					    u_xlat45 = min(u_xlat45, _MaxOriginalSpecular);
					    u_xlat44 = u_xlat44 + u_xlat45;
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlati0 = u_xlati0 * 7;
					    u_xlatb45 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb45){
					        u_xlatb46 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb46)) ? u_xlat5.xyz : u_xlat1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat46 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat46, u_xlat19);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5 = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.wwww;
					    //ENDIF
					    }
					    u_xlat46 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat46 = clamp(u_xlat46, 0.0, 1.0);
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat3.x = (-u_xlat44) + 1.0;
					    u_xlat17.x = dot((-u_xlat2.xyz), u_xlat5.xyz);
					    u_xlat17.x = u_xlat17.x + u_xlat17.x;
					    u_xlat6.xyz = u_xlat5.xyz * (-u_xlat17.xxx) + (-u_xlat2.xyz);
					    u_xlat7.xyz = vec3(u_xlat46) * _LightColor0.xyz;
					    if(u_xlatb45){
					        u_xlatb17 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat8.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat8.xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat17.xyz = (bool(u_xlatb17)) ? u_xlat8.xyz : u_xlat1.xyz;
					        u_xlat17.xyz = u_xlat17.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat8.yzw = u_xlat17.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat17.x = u_xlat8.y * 0.25;
					        u_xlat31 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat45 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat17.x = max(u_xlat31, u_xlat17.x);
					        u_xlat8.x = min(u_xlat45, u_xlat17.x);
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
					        u_xlat9.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHArArray, u_xlat5);
					        u_xlat9.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHAgArray, u_xlat5);
					        u_xlat9.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHAbArray, u_xlat5);
					    //ENDIF
					    }
					    u_xlat17.xyz = u_xlat9.xyz + vs_TEXCOORD4.xyz;
					    u_xlat17.xyz = max(u_xlat17.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat17.xyz = log2(u_xlat17.xyz);
					    u_xlat17.xyz = u_xlat17.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat17.xyz = exp2(u_xlat17.xyz);
					    u_xlat17.xyz = u_xlat17.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat17.xyz = max(u_xlat17.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb0 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb0){
					        u_xlat0.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat8.xyz = u_xlat0.xxx * u_xlat6.xyz;
					        u_xlat9.xyz = (-u_xlat1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					        u_xlat10.xyz = (-u_xlat1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					        u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat9;
					            hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					            hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					            hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					            u_xlat9 = hlslcc_movcTemp;
					        }
					        u_xlat0.x = min(u_xlat9.y, u_xlat9.x);
					        u_xlat0.x = min(u_xlat9.z, u_xlat0.x);
					        u_xlat9.xyz = u_xlat1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat6.xyz;
					    //ENDIF
					    }
					    u_xlat0.x = (-u_xlat3.x) * 0.699999988 + 1.70000005;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * 6.0;
					    u_xlat10_8 = textureLod(unity_SpecCube0, u_xlat8.xyz, u_xlat0.x);
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
					            u_xlat11.xyz = (-u_xlat1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat10.xyz;
					            u_xlat12.xyz = (-u_xlat1.xyz) + unity_SpecCube1_BoxMin.xyz;
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
					            u_xlat1.xyz = u_xlat1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat6.xyz = u_xlat10.xyz * vec3(u_xlat47) + u_xlat1.xyz;
					        //ENDIF
					        }
					        u_xlat10_6 = textureLod(unity_SpecCube1, u_xlat6.xyz, u_xlat0.x);
					        u_xlat16_0 = u_xlat10_6.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0 + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat10_6.xyz * u_xlat0.xxx;
					        u_xlat6.xyz = vec3(u_xlat46) * u_xlat10_8.xyz + (-u_xlat1.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat1.xyz;
					    //ENDIF
					    }
					    u_xlat1.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat14.xyz * vec3(u_xlat43) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat0.xyz = vec3(u_xlat42) * u_xlat0.xyz;
					    u_xlat42 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat43 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat14.x = u_xlat0.x + u_xlat0.x;
					    u_xlat14.x = u_xlat0.x * u_xlat14.x;
					    u_xlat14.x = u_xlat14.x * u_xlat3.x + -0.5;
					    u_xlat28.x = (-u_xlat43) + 1.0;
					    u_xlat16 = u_xlat28.x * u_xlat28.x;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat28.x = u_xlat28.x * u_xlat16;
					    u_xlat28.x = u_xlat14.x * u_xlat28.x + 1.0;
					    u_xlat16 = -abs(u_xlat42) + 1.0;
					    u_xlat30 = u_xlat16 * u_xlat16;
					    u_xlat30 = u_xlat30 * u_xlat30;
					    u_xlat16 = u_xlat16 * u_xlat30;
					    u_xlat14.x = u_xlat14.x * u_xlat16 + 1.0;
					    u_xlat14.x = u_xlat14.x * u_xlat28.x;
					    u_xlat28.x = u_xlat3.x * u_xlat3.x;
					    u_xlat28.x = max(u_xlat28.x, 0.00200000009);
					    u_xlat30 = (-u_xlat28.x) + 1.0;
					    u_xlat4.x = abs(u_xlat42) * u_xlat30 + u_xlat28.x;
					    u_xlat30 = u_xlat43 * u_xlat30 + u_xlat28.x;
					    u_xlat42 = abs(u_xlat42) * u_xlat30;
					    u_xlat42 = u_xlat43 * u_xlat4.x + u_xlat42;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat30 = u_xlat28.x * u_xlat28.x;
					    u_xlat4.x = u_xlat2.x * u_xlat30 + (-u_xlat2.x);
					    u_xlat2.x = u_xlat4.x * u_xlat2.x + 1.0;
					    u_xlat30 = u_xlat30 * 0.318309873;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x + 1.00000001e-07;
					    u_xlat2.x = u_xlat30 / u_xlat2.x;
					    u_xlat28.y = u_xlat42 * u_xlat2.x;
					    u_xlat28.xy = u_xlat28.xy * vec2(0.280000001, 3.14159274);
					    u_xlat42 = max(u_xlat28.y, 9.99999975e-05);
					    u_xlat14.z = sqrt(u_xlat42);
					    u_xlat14.xz = vec2(u_xlat43) * u_xlat14.xz;
					    u_xlat28.x = (-u_xlat28.x) * u_xlat3.x + 1.0;
					    u_xlat43 = u_xlat44 + 0.220916271;
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat2.xzw = u_xlat7.xyz * u_xlat14.xxx + u_xlat17.xyz;
					    u_xlat3.xyz = u_xlat7.xyz * u_xlat14.zzz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat14.x = u_xlat0.x * u_xlat0.x;
					    u_xlat14.x = u_xlat14.x * u_xlat14.x;
					    u_xlat0.x = u_xlat0.x * u_xlat14.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyw = u_xlat1.xyz * u_xlat2.xzw + u_xlat0.xyw;
					    u_xlat1.xyz = u_xlat9.xyz * u_xlat28.xxx;
					    u_xlat28.x = u_xlat43 + -0.220916301;
					    u_xlat28.x = u_xlat16 * u_xlat28.x + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat28.xxx + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "LIGHTPROBE_SH" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 4, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(binding = 5, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(binding = 6, std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_6_1[14];
					};
					layout(location = 7) uniform  sampler2D _TextureSample1;
					layout(location = 8) uniform  sampler2D _ColorRT;
					layout(location = 9) uniform  sampler2D _TextureSample0;
					layout(location = 10) uniform  sampler2D _WetnessRT;
					layout(location = 11) uniform  sampler2D _Specular;
					layout(location = 12) uniform  samplerCube unity_SpecCube0;
					layout(location = 13) uniform  samplerCube unity_SpecCube1;
					layout(location = 14) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 5) flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					int u_xlati0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					vec3 u_xlat14;
					float u_xlat16;
					vec3 u_xlat17;
					bool u_xlatb17;
					float u_xlat19;
					vec2 u_xlat28;
					float u_xlat30;
					float u_xlat31;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					float u_xlat16_44;
					float u_xlat10_44;
					float u_xlat45;
					float u_xlat10_45;
					bool u_xlatb45;
					float u_xlat46;
					float u_xlat16_46;
					bool u_xlatb46;
					float u_xlat47;
					bool u_xlatb47;
					void main()
					{
					    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					    u_xlat1.x = vs_TEXCOORD1.w;
					    u_xlat1.y = vs_TEXCOORD2.w;
					    u_xlat1.z = vs_TEXCOORD3.w;
					    u_xlat14.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat43 = dot(u_xlat14.xyz, u_xlat14.xyz);
					    u_xlat43 = inversesqrt(u_xlat43);
					    u_xlat2.xyz = u_xlat14.xyz * vec3(u_xlat43);
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat44 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat44 = min(u_xlat44, 1.0);
					    u_xlat44 = (-u_xlat44) + 1.0;
					    u_xlat3.z = sqrt(u_xlat44);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat44 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat44) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_44 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_44 = max(u_xlat10_44, 0.0);
					    u_xlat44 = min(u_xlat16_44, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_45 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat45 = u_xlat10_45 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat45 = dot(u_xlat5.xy, vec2(u_xlat45));
					    u_xlat45 = max(u_xlat45, 0.0);
					    u_xlat45 = min(u_xlat45, _MaxOriginalSpecular);
					    u_xlat44 = u_xlat44 + u_xlat45;
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlati0 = u_xlati0 * 7;
					    u_xlatb45 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb45){
					        u_xlatb46 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb46)) ? u_xlat5.xyz : u_xlat1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat46 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat46, u_xlat19);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5 = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.wwww;
					    //ENDIF
					    }
					    u_xlat46 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat46 = clamp(u_xlat46, 0.0, 1.0);
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat3.x = (-u_xlat44) + 1.0;
					    u_xlat17.x = dot((-u_xlat2.xyz), u_xlat5.xyz);
					    u_xlat17.x = u_xlat17.x + u_xlat17.x;
					    u_xlat6.xyz = u_xlat5.xyz * (-u_xlat17.xxx) + (-u_xlat2.xyz);
					    u_xlat7.xyz = vec3(u_xlat46) * _LightColor0.xyz;
					    if(u_xlatb45){
					        u_xlatb17 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat8.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat8.xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat17.xyz = (bool(u_xlatb17)) ? u_xlat8.xyz : u_xlat1.xyz;
					        u_xlat17.xyz = u_xlat17.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat8.yzw = u_xlat17.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat17.x = u_xlat8.y * 0.25;
					        u_xlat31 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat45 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat17.x = max(u_xlat31, u_xlat17.x);
					        u_xlat8.x = min(u_xlat45, u_xlat17.x);
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
					        u_xlat9.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHArArray, u_xlat5);
					        u_xlat9.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHAgArray, u_xlat5);
					        u_xlat9.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHAbArray, u_xlat5);
					    //ENDIF
					    }
					    u_xlat17.xyz = u_xlat9.xyz + vs_TEXCOORD4.xyz;
					    u_xlat17.xyz = max(u_xlat17.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat17.xyz = log2(u_xlat17.xyz);
					    u_xlat17.xyz = u_xlat17.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat17.xyz = exp2(u_xlat17.xyz);
					    u_xlat17.xyz = u_xlat17.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat17.xyz = max(u_xlat17.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb0 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb0){
					        u_xlat0.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat8.xyz = u_xlat0.xxx * u_xlat6.xyz;
					        u_xlat9.xyz = (-u_xlat1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					        u_xlat10.xyz = (-u_xlat1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					        u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat9;
					            hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					            hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					            hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					            u_xlat9 = hlslcc_movcTemp;
					        }
					        u_xlat0.x = min(u_xlat9.y, u_xlat9.x);
					        u_xlat0.x = min(u_xlat9.z, u_xlat0.x);
					        u_xlat9.xyz = u_xlat1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat6.xyz;
					    //ENDIF
					    }
					    u_xlat0.x = (-u_xlat3.x) * 0.699999988 + 1.70000005;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * 6.0;
					    u_xlat10_8 = textureLod(unity_SpecCube0, u_xlat8.xyz, u_xlat0.x);
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
					            u_xlat11.xyz = (-u_xlat1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat10.xyz;
					            u_xlat12.xyz = (-u_xlat1.xyz) + unity_SpecCube1_BoxMin.xyz;
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
					            u_xlat1.xyz = u_xlat1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat6.xyz = u_xlat10.xyz * vec3(u_xlat47) + u_xlat1.xyz;
					        //ENDIF
					        }
					        u_xlat10_6 = textureLod(unity_SpecCube1, u_xlat6.xyz, u_xlat0.x);
					        u_xlat16_0 = u_xlat10_6.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0 + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat10_6.xyz * u_xlat0.xxx;
					        u_xlat6.xyz = vec3(u_xlat46) * u_xlat10_8.xyz + (-u_xlat1.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat1.xyz;
					    //ENDIF
					    }
					    u_xlat1.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat14.xyz * vec3(u_xlat43) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat0.xyz = vec3(u_xlat42) * u_xlat0.xyz;
					    u_xlat42 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat43 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat14.x = u_xlat0.x + u_xlat0.x;
					    u_xlat14.x = u_xlat0.x * u_xlat14.x;
					    u_xlat14.x = u_xlat14.x * u_xlat3.x + -0.5;
					    u_xlat28.x = (-u_xlat43) + 1.0;
					    u_xlat16 = u_xlat28.x * u_xlat28.x;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat28.x = u_xlat28.x * u_xlat16;
					    u_xlat28.x = u_xlat14.x * u_xlat28.x + 1.0;
					    u_xlat16 = -abs(u_xlat42) + 1.0;
					    u_xlat30 = u_xlat16 * u_xlat16;
					    u_xlat30 = u_xlat30 * u_xlat30;
					    u_xlat16 = u_xlat16 * u_xlat30;
					    u_xlat14.x = u_xlat14.x * u_xlat16 + 1.0;
					    u_xlat14.x = u_xlat14.x * u_xlat28.x;
					    u_xlat28.x = u_xlat3.x * u_xlat3.x;
					    u_xlat28.x = max(u_xlat28.x, 0.00200000009);
					    u_xlat30 = (-u_xlat28.x) + 1.0;
					    u_xlat4.x = abs(u_xlat42) * u_xlat30 + u_xlat28.x;
					    u_xlat30 = u_xlat43 * u_xlat30 + u_xlat28.x;
					    u_xlat42 = abs(u_xlat42) * u_xlat30;
					    u_xlat42 = u_xlat43 * u_xlat4.x + u_xlat42;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat30 = u_xlat28.x * u_xlat28.x;
					    u_xlat4.x = u_xlat2.x * u_xlat30 + (-u_xlat2.x);
					    u_xlat2.x = u_xlat4.x * u_xlat2.x + 1.0;
					    u_xlat30 = u_xlat30 * 0.318309873;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x + 1.00000001e-07;
					    u_xlat2.x = u_xlat30 / u_xlat2.x;
					    u_xlat28.y = u_xlat42 * u_xlat2.x;
					    u_xlat28.xy = u_xlat28.xy * vec2(0.280000001, 3.14159274);
					    u_xlat42 = max(u_xlat28.y, 9.99999975e-05);
					    u_xlat14.z = sqrt(u_xlat42);
					    u_xlat14.xz = vec2(u_xlat43) * u_xlat14.xz;
					    u_xlat28.x = (-u_xlat28.x) * u_xlat3.x + 1.0;
					    u_xlat43 = u_xlat44 + 0.220916271;
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat2.xzw = u_xlat7.xyz * u_xlat14.xxx + u_xlat17.xyz;
					    u_xlat3.xyz = u_xlat7.xyz * u_xlat14.zzz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat14.x = u_xlat0.x * u_xlat0.x;
					    u_xlat14.x = u_xlat14.x * u_xlat14.x;
					    u_xlat0.x = u_xlat0.x * u_xlat14.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyw = u_xlat1.xyz * u_xlat2.xzw + u_xlat0.xyw;
					    u_xlat1.xyz = u_xlat9.xyz * u_xlat28.xxx;
					    u_xlat28.x = u_xlat43 + -0.220916301;
					    u_xlat28.x = u_xlat16 * u_xlat28.x + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat28.xxx + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "SHADOWS_SCREEN" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 6, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 7) uniform  sampler2D _TextureSample1;
					layout(location = 8) uniform  sampler2D _ColorRT;
					layout(location = 9) uniform  sampler2D _TextureSample0;
					layout(location = 10) uniform  sampler2D _WetnessRT;
					layout(location = 11) uniform  sampler2D _Specular;
					layout(location = 12) uniform  sampler2D _ShadowMapTexture;
					layout(location = 13) uniform  samplerCube unity_SpecCube0;
					layout(location = 14) uniform  samplerCube unity_SpecCube1;
					layout(location = 15) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 4) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					float u_xlat27;
					float u_xlat28;
					float u_xlat39;
					float u_xlat40;
					float u_xlat16_40;
					float u_xlat10_40;
					float u_xlat41;
					float u_xlat10_41;
					bool u_xlatb41;
					float u_xlat42;
					bool u_xlatb42;
					float u_xlat43;
					float u_xlat16_43;
					float u_xlat10_43;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat40 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat3.z = sqrt(u_xlat40);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat40 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_40 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_40 = max(u_xlat10_40, 0.0);
					    u_xlat40 = min(u_xlat16_40, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_41 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat41 = u_xlat10_41 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat41 = dot(u_xlat5.xy, vec2(u_xlat41));
					    u_xlat41 = max(u_xlat41, 0.0);
					    u_xlat41 = min(u_xlat41, _MaxOriginalSpecular);
					    u_xlat40 = u_xlat40 + u_xlat41;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
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
					    u_xlat10_43 = texture(_ShadowMapTexture, u_xlat5.xy).x;
					    u_xlat42 = u_xlat42 + (-u_xlat10_43);
					    u_xlat41 = u_xlat41 * u_xlat42 + u_xlat10_43;
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
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat14 = u_xlat1.x + u_xlat1.x;
					    u_xlat14 = u_xlat1.x * u_xlat14;
					    u_xlat14 = u_xlat14 * u_xlat42 + -0.5;
					    u_xlat27 = (-u_xlat2.x) + 1.0;
					    u_xlat28 = u_xlat27 * u_xlat27;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat27 = u_xlat27 * u_xlat28;
					    u_xlat27 = u_xlat14 * u_xlat27 + 1.0;
					    u_xlat28 = -abs(u_xlat39) + 1.0;
					    u_xlat41 = u_xlat28 * u_xlat28;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat28 = u_xlat28 * u_xlat41;
					    u_xlat14 = u_xlat14 * u_xlat28 + 1.0;
					    u_xlat14 = u_xlat14 * u_xlat27;
					    u_xlat14 = u_xlat2.x * u_xlat14;
					    u_xlat27 = u_xlat42 * u_xlat42;
					    u_xlat27 = max(u_xlat27, 0.00200000009);
					    u_xlat41 = (-u_xlat27) + 1.0;
					    u_xlat3.x = abs(u_xlat39) * u_xlat41 + u_xlat27;
					    u_xlat41 = u_xlat2.x * u_xlat41 + u_xlat27;
					    u_xlat39 = abs(u_xlat39) * u_xlat41;
					    u_xlat39 = u_xlat2.x * u_xlat3.x + u_xlat39;
					    u_xlat39 = u_xlat39 + 9.99999975e-06;
					    u_xlat39 = 0.5 / u_xlat39;
					    u_xlat41 = u_xlat27 * u_xlat27;
					    u_xlat3.x = u_xlat15 * u_xlat41 + (-u_xlat15);
					    u_xlat15 = u_xlat3.x * u_xlat15 + 1.0;
					    u_xlat41 = u_xlat41 * 0.318309873;
					    u_xlat15 = u_xlat15 * u_xlat15 + 1.00000001e-07;
					    u_xlat15 = u_xlat41 / u_xlat15;
					    u_xlat39 = u_xlat39 * u_xlat15;
					    u_xlat39 = u_xlat39 * 3.14159274;
					    u_xlat39 = max(u_xlat39, 9.99999975e-05);
					    u_xlat39 = sqrt(u_xlat39);
					    u_xlat39 = u_xlat2.x * u_xlat39;
					    u_xlat27 = u_xlat27 * 0.280000001;
					    u_xlat27 = (-u_xlat27) * u_xlat42 + 1.0;
					    u_xlat40 = u_xlat40 + 0.220916271;
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat2.xyw = vec3(u_xlat14) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(u_xlat39);
					    u_xlat39 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat39 * u_xlat39;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat39 = u_xlat39 * u_xlat1.x;
					    u_xlat39 = u_xlat39 * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat8.xyz * vec3(u_xlat27);
					    u_xlat39 = u_xlat40 + -0.220916301;
					    u_xlat39 = u_xlat28 * u_xlat39 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "SHADOWS_SCREEN" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 6, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 7) uniform  sampler2D _TextureSample1;
					layout(location = 8) uniform  sampler2D _ColorRT;
					layout(location = 9) uniform  sampler2D _TextureSample0;
					layout(location = 10) uniform  sampler2D _WetnessRT;
					layout(location = 11) uniform  sampler2D _Specular;
					layout(location = 12) uniform  sampler2D _ShadowMapTexture;
					layout(location = 13) uniform  samplerCube unity_SpecCube0;
					layout(location = 14) uniform  samplerCube unity_SpecCube1;
					layout(location = 15) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 4) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					float u_xlat27;
					float u_xlat28;
					float u_xlat39;
					float u_xlat40;
					float u_xlat16_40;
					float u_xlat10_40;
					float u_xlat41;
					float u_xlat10_41;
					bool u_xlatb41;
					float u_xlat42;
					bool u_xlatb42;
					float u_xlat43;
					float u_xlat16_43;
					float u_xlat10_43;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat40 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat3.z = sqrt(u_xlat40);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat40 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_40 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_40 = max(u_xlat10_40, 0.0);
					    u_xlat40 = min(u_xlat16_40, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_41 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat41 = u_xlat10_41 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat41 = dot(u_xlat5.xy, vec2(u_xlat41));
					    u_xlat41 = max(u_xlat41, 0.0);
					    u_xlat41 = min(u_xlat41, _MaxOriginalSpecular);
					    u_xlat40 = u_xlat40 + u_xlat41;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
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
					    u_xlat10_43 = texture(_ShadowMapTexture, u_xlat5.xy).x;
					    u_xlat42 = u_xlat42 + (-u_xlat10_43);
					    u_xlat41 = u_xlat41 * u_xlat42 + u_xlat10_43;
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
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat14 = u_xlat1.x + u_xlat1.x;
					    u_xlat14 = u_xlat1.x * u_xlat14;
					    u_xlat14 = u_xlat14 * u_xlat42 + -0.5;
					    u_xlat27 = (-u_xlat2.x) + 1.0;
					    u_xlat28 = u_xlat27 * u_xlat27;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat27 = u_xlat27 * u_xlat28;
					    u_xlat27 = u_xlat14 * u_xlat27 + 1.0;
					    u_xlat28 = -abs(u_xlat39) + 1.0;
					    u_xlat41 = u_xlat28 * u_xlat28;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat28 = u_xlat28 * u_xlat41;
					    u_xlat14 = u_xlat14 * u_xlat28 + 1.0;
					    u_xlat14 = u_xlat14 * u_xlat27;
					    u_xlat14 = u_xlat2.x * u_xlat14;
					    u_xlat27 = u_xlat42 * u_xlat42;
					    u_xlat27 = max(u_xlat27, 0.00200000009);
					    u_xlat41 = (-u_xlat27) + 1.0;
					    u_xlat3.x = abs(u_xlat39) * u_xlat41 + u_xlat27;
					    u_xlat41 = u_xlat2.x * u_xlat41 + u_xlat27;
					    u_xlat39 = abs(u_xlat39) * u_xlat41;
					    u_xlat39 = u_xlat2.x * u_xlat3.x + u_xlat39;
					    u_xlat39 = u_xlat39 + 9.99999975e-06;
					    u_xlat39 = 0.5 / u_xlat39;
					    u_xlat41 = u_xlat27 * u_xlat27;
					    u_xlat3.x = u_xlat15 * u_xlat41 + (-u_xlat15);
					    u_xlat15 = u_xlat3.x * u_xlat15 + 1.0;
					    u_xlat41 = u_xlat41 * 0.318309873;
					    u_xlat15 = u_xlat15 * u_xlat15 + 1.00000001e-07;
					    u_xlat15 = u_xlat41 / u_xlat15;
					    u_xlat39 = u_xlat39 * u_xlat15;
					    u_xlat39 = u_xlat39 * 3.14159274;
					    u_xlat39 = max(u_xlat39, 9.99999975e-05);
					    u_xlat39 = sqrt(u_xlat39);
					    u_xlat39 = u_xlat2.x * u_xlat39;
					    u_xlat27 = u_xlat27 * 0.280000001;
					    u_xlat27 = (-u_xlat27) * u_xlat42 + 1.0;
					    u_xlat40 = u_xlat40 + 0.220916271;
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat2.xyw = vec3(u_xlat14) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(u_xlat39);
					    u_xlat39 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat39 * u_xlat39;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat39 = u_xlat39 * u_xlat1.x;
					    u_xlat39 = u_xlat39 * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat8.xyz * vec3(u_xlat27);
					    u_xlat39 = u_xlat40 + -0.220916301;
					    u_xlat39 = u_xlat28 * u_xlat39 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 6, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(binding = 7, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(binding = 8, std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_8_1[14];
					};
					layout(location = 9) uniform  sampler2D _TextureSample1;
					layout(location = 10) uniform  sampler2D _ColorRT;
					layout(location = 11) uniform  sampler2D _TextureSample0;
					layout(location = 12) uniform  sampler2D _WetnessRT;
					layout(location = 13) uniform  sampler2D _Specular;
					layout(location = 14) uniform  sampler2D _ShadowMapTexture;
					layout(location = 15) uniform  samplerCube unity_SpecCube0;
					layout(location = 16) uniform  samplerCube unity_SpecCube1;
					layout(location = 17) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 5) in  vec4 vs_TEXCOORD6;
					layout(location = 6) flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					int u_xlati0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					vec3 u_xlat14;
					float u_xlat16;
					vec3 u_xlat17;
					vec3 u_xlat19;
					float u_xlat10_19;
					float u_xlat21;
					vec2 u_xlat28;
					float u_xlat30;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					float u_xlat16_44;
					float u_xlat10_44;
					float u_xlat45;
					float u_xlat10_45;
					float u_xlat46;
					float u_xlat16_46;
					bool u_xlatb46;
					float u_xlat47;
					bool u_xlatb47;
					float u_xlat48;
					void main()
					{
					    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					    u_xlat1.x = vs_TEXCOORD1.w;
					    u_xlat1.y = vs_TEXCOORD2.w;
					    u_xlat1.z = vs_TEXCOORD3.w;
					    u_xlat14.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat43 = dot(u_xlat14.xyz, u_xlat14.xyz);
					    u_xlat43 = inversesqrt(u_xlat43);
					    u_xlat2.xyz = u_xlat14.xyz * vec3(u_xlat43);
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat44 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat44 = min(u_xlat44, 1.0);
					    u_xlat44 = (-u_xlat44) + 1.0;
					    u_xlat3.z = sqrt(u_xlat44);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat44 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat44) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_44 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_44 = max(u_xlat10_44, 0.0);
					    u_xlat44 = min(u_xlat16_44, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_45 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat45 = u_xlat10_45 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat45 = dot(u_xlat5.xy, vec2(u_xlat45));
					    u_xlat45 = max(u_xlat45, 0.0);
					    u_xlat45 = min(u_xlat45, _MaxOriginalSpecular);
					    u_xlat44 = u_xlat44 + u_xlat45;
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat45 = dot(u_xlat14.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat46 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat46 = sqrt(u_xlat46);
					    u_xlat46 = (-u_xlat45) + u_xlat46;
					    u_xlat45 = unity_ShadowFadeCenterAndType.w * u_xlat46 + u_xlat45;
					    u_xlat45 = u_xlat45 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
					    u_xlati0 = u_xlati0 * 7;
					    u_xlatb46 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb46){
					        u_xlatb5.x = unity_ProbeVolumeParams.y==1.0;
					        u_xlat19.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat19.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat19.xyz;
					        u_xlat19.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat19.xyz;
					        u_xlat19.xyz = u_xlat19.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (u_xlatb5.x) ? u_xlat19.xyz : u_xlat1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19.x = u_xlat5.y * 0.25 + 0.75;
					        u_xlat6.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat19.x, u_xlat6.x);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5 = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.wwww;
					    //ENDIF
					    }
					    u_xlat5.x = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat19.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat10_19 = texture(_ShadowMapTexture, u_xlat19.xy).x;
					    u_xlat5.x = (-u_xlat10_19) + u_xlat5.x;
					    u_xlat45 = u_xlat45 * u_xlat5.x + u_xlat10_19;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat3.x = (-u_xlat44) + 1.0;
					    u_xlat17.x = dot((-u_xlat2.xyz), u_xlat5.xyz);
					    u_xlat17.x = u_xlat17.x + u_xlat17.x;
					    u_xlat6.xyz = u_xlat5.xyz * (-u_xlat17.xxx) + (-u_xlat2.xyz);
					    u_xlat17.xyz = vec3(u_xlat45) * _LightColor0.xyz;
					    if(u_xlatb46){
					        u_xlatb46 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb46)) ? u_xlat7.xyz : u_xlat1.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat46 = u_xlat7.y * 0.25;
					        u_xlat48 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat21 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat46 = max(u_xlat46, u_xlat48);
					        u_xlat7.x = min(u_xlat21, u_xlat46);
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
					        u_xlat8.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHArArray, u_xlat5);
					        u_xlat8.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHAgArray, u_xlat5);
					        u_xlat8.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHAbArray, u_xlat5);
					    //ENDIF
					    }
					    u_xlat7.xyz = u_xlat8.xyz + vs_TEXCOORD4.xyz;
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat7.xyz = log2(u_xlat7.xyz);
					    u_xlat7.xyz = u_xlat7.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat7.xyz = exp2(u_xlat7.xyz);
					    u_xlat7.xyz = u_xlat7.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb0 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb0){
					        u_xlat0.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat8.xyz = u_xlat0.xxx * u_xlat6.xyz;
					        u_xlat9.xyz = (-u_xlat1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					        u_xlat10.xyz = (-u_xlat1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					        u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat9;
					            hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					            hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					            hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					            u_xlat9 = hlslcc_movcTemp;
					        }
					        u_xlat0.x = min(u_xlat9.y, u_xlat9.x);
					        u_xlat0.x = min(u_xlat9.z, u_xlat0.x);
					        u_xlat9.xyz = u_xlat1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat6.xyz;
					    //ENDIF
					    }
					    u_xlat0.x = (-u_xlat3.x) * 0.699999988 + 1.70000005;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * 6.0;
					    u_xlat10_8 = textureLod(unity_SpecCube0, u_xlat8.xyz, u_xlat0.x);
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
					            u_xlat11.xyz = (-u_xlat1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat10.xyz;
					            u_xlat12.xyz = (-u_xlat1.xyz) + unity_SpecCube1_BoxMin.xyz;
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
					            u_xlat1.xyz = u_xlat1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat6.xyz = u_xlat10.xyz * vec3(u_xlat47) + u_xlat1.xyz;
					        //ENDIF
					        }
					        u_xlat10_6 = textureLod(unity_SpecCube1, u_xlat6.xyz, u_xlat0.x);
					        u_xlat16_0 = u_xlat10_6.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0 + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat10_6.xyz * u_xlat0.xxx;
					        u_xlat6.xyz = vec3(u_xlat46) * u_xlat10_8.xyz + (-u_xlat1.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat1.xyz;
					    //ENDIF
					    }
					    u_xlat1.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat14.xyz * vec3(u_xlat43) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat0.xyz = vec3(u_xlat42) * u_xlat0.xyz;
					    u_xlat42 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat43 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat14.x = u_xlat0.x + u_xlat0.x;
					    u_xlat14.x = u_xlat0.x * u_xlat14.x;
					    u_xlat14.x = u_xlat14.x * u_xlat3.x + -0.5;
					    u_xlat28.x = (-u_xlat43) + 1.0;
					    u_xlat16 = u_xlat28.x * u_xlat28.x;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat28.x = u_xlat28.x * u_xlat16;
					    u_xlat28.x = u_xlat14.x * u_xlat28.x + 1.0;
					    u_xlat16 = -abs(u_xlat42) + 1.0;
					    u_xlat30 = u_xlat16 * u_xlat16;
					    u_xlat30 = u_xlat30 * u_xlat30;
					    u_xlat16 = u_xlat16 * u_xlat30;
					    u_xlat14.x = u_xlat14.x * u_xlat16 + 1.0;
					    u_xlat14.x = u_xlat14.x * u_xlat28.x;
					    u_xlat28.x = u_xlat3.x * u_xlat3.x;
					    u_xlat28.x = max(u_xlat28.x, 0.00200000009);
					    u_xlat30 = (-u_xlat28.x) + 1.0;
					    u_xlat4.x = abs(u_xlat42) * u_xlat30 + u_xlat28.x;
					    u_xlat30 = u_xlat43 * u_xlat30 + u_xlat28.x;
					    u_xlat42 = abs(u_xlat42) * u_xlat30;
					    u_xlat42 = u_xlat43 * u_xlat4.x + u_xlat42;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat30 = u_xlat28.x * u_xlat28.x;
					    u_xlat4.x = u_xlat2.x * u_xlat30 + (-u_xlat2.x);
					    u_xlat2.x = u_xlat4.x * u_xlat2.x + 1.0;
					    u_xlat30 = u_xlat30 * 0.318309873;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x + 1.00000001e-07;
					    u_xlat2.x = u_xlat30 / u_xlat2.x;
					    u_xlat28.y = u_xlat42 * u_xlat2.x;
					    u_xlat28.xy = u_xlat28.xy * vec2(0.280000001, 3.14159274);
					    u_xlat42 = max(u_xlat28.y, 9.99999975e-05);
					    u_xlat14.z = sqrt(u_xlat42);
					    u_xlat14.xz = vec2(u_xlat43) * u_xlat14.xz;
					    u_xlat28.x = (-u_xlat28.x) * u_xlat3.x + 1.0;
					    u_xlat43 = u_xlat44 + 0.220916271;
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat2.xzw = u_xlat17.xyz * u_xlat14.xxx + u_xlat7.xyz;
					    u_xlat3.xyz = u_xlat17.xyz * u_xlat14.zzz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat14.x = u_xlat0.x * u_xlat0.x;
					    u_xlat14.x = u_xlat14.x * u_xlat14.x;
					    u_xlat0.x = u_xlat0.x * u_xlat14.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyw = u_xlat1.xyz * u_xlat2.xzw + u_xlat0.xyw;
					    u_xlat1.xyz = u_xlat9.xyz * u_xlat28.xxx;
					    u_xlat28.x = u_xlat43 + -0.220916301;
					    u_xlat28.x = u_xlat16 * u_xlat28.x + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat28.xxx + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 6, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(binding = 7, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins2Array_Type {
						vec4 unity_Builtins2Array.unity_SHArArray;
						vec4 unity_Builtins2Array.unity_SHAgArray;
						vec4 unity_Builtins2Array.unity_SHAbArray;
						vec4 unity_Builtins2Array.unity_SHBrArray;
						vec4 unity_Builtins2Array.unity_SHBgArray;
						vec4 unity_Builtins2Array.unity_SHBbArray;
						vec4 unity_Builtins2Array.unity_SHCArray;
					};
					layout(binding = 8, std140) uniform UnityInstancing_PerDraw2 {
						unity_Builtins2Array_Type unity_Builtins2Array;
						vec4 unused_8_1[14];
					};
					layout(location = 9) uniform  sampler2D _TextureSample1;
					layout(location = 10) uniform  sampler2D _ColorRT;
					layout(location = 11) uniform  sampler2D _TextureSample0;
					layout(location = 12) uniform  sampler2D _WetnessRT;
					layout(location = 13) uniform  sampler2D _Specular;
					layout(location = 14) uniform  sampler2D _ShadowMapTexture;
					layout(location = 15) uniform  samplerCube unity_SpecCube0;
					layout(location = 16) uniform  samplerCube unity_SpecCube1;
					layout(location = 17) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 5) in  vec4 vs_TEXCOORD6;
					layout(location = 6) flat in  uint vs_SV_InstanceID0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					int u_xlati0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					vec3 u_xlat14;
					float u_xlat16;
					vec3 u_xlat17;
					vec3 u_xlat19;
					float u_xlat10_19;
					float u_xlat21;
					vec2 u_xlat28;
					float u_xlat30;
					float u_xlat42;
					float u_xlat43;
					float u_xlat44;
					float u_xlat16_44;
					float u_xlat10_44;
					float u_xlat45;
					float u_xlat10_45;
					float u_xlat46;
					float u_xlat16_46;
					bool u_xlatb46;
					float u_xlat47;
					bool u_xlatb47;
					float u_xlat48;
					void main()
					{
					    u_xlati0 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
					    u_xlat1.x = vs_TEXCOORD1.w;
					    u_xlat1.y = vs_TEXCOORD2.w;
					    u_xlat1.z = vs_TEXCOORD3.w;
					    u_xlat14.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat43 = dot(u_xlat14.xyz, u_xlat14.xyz);
					    u_xlat43 = inversesqrt(u_xlat43);
					    u_xlat2.xyz = u_xlat14.xyz * vec3(u_xlat43);
					    u_xlat3.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat44 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat44 = min(u_xlat44, 1.0);
					    u_xlat44 = (-u_xlat44) + 1.0;
					    u_xlat3.z = sqrt(u_xlat44);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat44 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat44) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_44 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_44 = max(u_xlat10_44, 0.0);
					    u_xlat44 = min(u_xlat16_44, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_45 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat45 = u_xlat10_45 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat45 = dot(u_xlat5.xy, vec2(u_xlat45));
					    u_xlat45 = max(u_xlat45, 0.0);
					    u_xlat45 = min(u_xlat45, _MaxOriginalSpecular);
					    u_xlat44 = u_xlat44 + u_xlat45;
					    u_xlat44 = clamp(u_xlat44, 0.0, 1.0);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat45 = dot(u_xlat14.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat1.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat46 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat46 = sqrt(u_xlat46);
					    u_xlat46 = (-u_xlat45) + u_xlat46;
					    u_xlat45 = unity_ShadowFadeCenterAndType.w * u_xlat46 + u_xlat45;
					    u_xlat45 = u_xlat45 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
					    u_xlati0 = u_xlati0 * 7;
					    u_xlatb46 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb46){
					        u_xlatb5.x = unity_ProbeVolumeParams.y==1.0;
					        u_xlat19.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat19.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat19.xyz;
					        u_xlat19.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat19.xyz;
					        u_xlat19.xyz = u_xlat19.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (u_xlatb5.x) ? u_xlat19.xyz : u_xlat1.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat19.x = u_xlat5.y * 0.25 + 0.75;
					        u_xlat6.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat19.x, u_xlat6.x);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5 = unity_Builtins2Array.unity_Builtins2Array.unity_SHCArray.wwww;
					    //ENDIF
					    }
					    u_xlat5.x = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat5.x = clamp(u_xlat5.x, 0.0, 1.0);
					    u_xlat19.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat10_19 = texture(_ShadowMapTexture, u_xlat19.xy).x;
					    u_xlat5.x = (-u_xlat10_19) + u_xlat5.x;
					    u_xlat45 = u_xlat45 * u_xlat5.x + u_xlat10_19;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat5.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat3.x = (-u_xlat44) + 1.0;
					    u_xlat17.x = dot((-u_xlat2.xyz), u_xlat5.xyz);
					    u_xlat17.x = u_xlat17.x + u_xlat17.x;
					    u_xlat6.xyz = u_xlat5.xyz * (-u_xlat17.xxx) + (-u_xlat2.xyz);
					    u_xlat17.xyz = vec3(u_xlat45) * _LightColor0.xyz;
					    if(u_xlatb46){
					        u_xlatb46 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD2.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD1.www + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD3.www + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb46)) ? u_xlat7.xyz : u_xlat1.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat7.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat46 = u_xlat7.y * 0.25;
					        u_xlat48 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat21 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat46 = max(u_xlat46, u_xlat48);
					        u_xlat7.x = min(u_xlat21, u_xlat46);
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
					        u_xlat8.x = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHArArray, u_xlat5);
					        u_xlat8.y = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHAgArray, u_xlat5);
					        u_xlat8.z = dot(unity_Builtins2Array.unity_Builtins2Array.unity_SHAbArray, u_xlat5);
					    //ENDIF
					    }
					    u_xlat7.xyz = u_xlat8.xyz + vs_TEXCOORD4.xyz;
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat7.xyz = log2(u_xlat7.xyz);
					    u_xlat7.xyz = u_xlat7.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat7.xyz = exp2(u_xlat7.xyz);
					    u_xlat7.xyz = u_xlat7.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb0 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb0){
					        u_xlat0.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat8.xyz = u_xlat0.xxx * u_xlat6.xyz;
					        u_xlat9.xyz = (-u_xlat1.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					        u_xlat10.xyz = (-u_xlat1.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					        u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat9;
					            hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					            hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					            hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					            u_xlat9 = hlslcc_movcTemp;
					        }
					        u_xlat0.x = min(u_xlat9.y, u_xlat9.x);
					        u_xlat0.x = min(u_xlat9.z, u_xlat0.x);
					        u_xlat9.xyz = u_xlat1.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat8.xyz = u_xlat8.xyz * u_xlat0.xxx + u_xlat9.xyz;
					    } else {
					        u_xlat8.xyz = u_xlat6.xyz;
					    //ENDIF
					    }
					    u_xlat0.x = (-u_xlat3.x) * 0.699999988 + 1.70000005;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * 6.0;
					    u_xlat10_8 = textureLod(unity_SpecCube0, u_xlat8.xyz, u_xlat0.x);
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
					            u_xlat11.xyz = (-u_xlat1.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat10.xyz;
					            u_xlat12.xyz = (-u_xlat1.xyz) + unity_SpecCube1_BoxMin.xyz;
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
					            u_xlat1.xyz = u_xlat1.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat6.xyz = u_xlat10.xyz * vec3(u_xlat47) + u_xlat1.xyz;
					        //ENDIF
					        }
					        u_xlat10_6 = textureLod(unity_SpecCube1, u_xlat6.xyz, u_xlat0.x);
					        u_xlat16_0 = u_xlat10_6.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0 + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat1.xyz = u_xlat10_6.xyz * u_xlat0.xxx;
					        u_xlat6.xyz = vec3(u_xlat46) * u_xlat10_8.xyz + (-u_xlat1.xyz);
					        u_xlat9.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat1.xyz;
					    //ENDIF
					    }
					    u_xlat1.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat0.xyz = u_xlat14.xyz * vec3(u_xlat43) + _WorldSpaceLightPos0.xyz;
					    u_xlat42 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat42 = max(u_xlat42, 0.00100000005);
					    u_xlat42 = inversesqrt(u_xlat42);
					    u_xlat0.xyz = vec3(u_xlat42) * u_xlat0.xyz;
					    u_xlat42 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat43 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat43 = clamp(u_xlat43, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat14.x = u_xlat0.x + u_xlat0.x;
					    u_xlat14.x = u_xlat0.x * u_xlat14.x;
					    u_xlat14.x = u_xlat14.x * u_xlat3.x + -0.5;
					    u_xlat28.x = (-u_xlat43) + 1.0;
					    u_xlat16 = u_xlat28.x * u_xlat28.x;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat28.x = u_xlat28.x * u_xlat16;
					    u_xlat28.x = u_xlat14.x * u_xlat28.x + 1.0;
					    u_xlat16 = -abs(u_xlat42) + 1.0;
					    u_xlat30 = u_xlat16 * u_xlat16;
					    u_xlat30 = u_xlat30 * u_xlat30;
					    u_xlat16 = u_xlat16 * u_xlat30;
					    u_xlat14.x = u_xlat14.x * u_xlat16 + 1.0;
					    u_xlat14.x = u_xlat14.x * u_xlat28.x;
					    u_xlat28.x = u_xlat3.x * u_xlat3.x;
					    u_xlat28.x = max(u_xlat28.x, 0.00200000009);
					    u_xlat30 = (-u_xlat28.x) + 1.0;
					    u_xlat4.x = abs(u_xlat42) * u_xlat30 + u_xlat28.x;
					    u_xlat30 = u_xlat43 * u_xlat30 + u_xlat28.x;
					    u_xlat42 = abs(u_xlat42) * u_xlat30;
					    u_xlat42 = u_xlat43 * u_xlat4.x + u_xlat42;
					    u_xlat42 = u_xlat42 + 9.99999975e-06;
					    u_xlat42 = 0.5 / u_xlat42;
					    u_xlat30 = u_xlat28.x * u_xlat28.x;
					    u_xlat4.x = u_xlat2.x * u_xlat30 + (-u_xlat2.x);
					    u_xlat2.x = u_xlat4.x * u_xlat2.x + 1.0;
					    u_xlat30 = u_xlat30 * 0.318309873;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x + 1.00000001e-07;
					    u_xlat2.x = u_xlat30 / u_xlat2.x;
					    u_xlat28.y = u_xlat42 * u_xlat2.x;
					    u_xlat28.xy = u_xlat28.xy * vec2(0.280000001, 3.14159274);
					    u_xlat42 = max(u_xlat28.y, 9.99999975e-05);
					    u_xlat14.z = sqrt(u_xlat42);
					    u_xlat14.xz = vec2(u_xlat43) * u_xlat14.xz;
					    u_xlat28.x = (-u_xlat28.x) * u_xlat3.x + 1.0;
					    u_xlat43 = u_xlat44 + 0.220916271;
					    u_xlat43 = min(u_xlat43, 1.0);
					    u_xlat2.xzw = u_xlat17.xyz * u_xlat14.xxx + u_xlat7.xyz;
					    u_xlat3.xyz = u_xlat17.xyz * u_xlat14.zzz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat14.x = u_xlat0.x * u_xlat0.x;
					    u_xlat14.x = u_xlat14.x * u_xlat14.x;
					    u_xlat0.x = u_xlat0.x * u_xlat14.x;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyw = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat0.xyw = u_xlat1.xyz * u_xlat2.xzw + u_xlat0.xyw;
					    u_xlat1.xyz = u_xlat9.xyz * u_xlat28.xxx;
					    u_xlat28.x = u_xlat43 + -0.220916301;
					    u_xlat28.x = u_xlat16 * u_xlat28.x + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat28.xxx + u_xlat0.xyw;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "INSTANCING_ON" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(binding = 4, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 5) uniform  sampler2D _TextureSample1;
					layout(location = 6) uniform  sampler2D _ColorRT;
					layout(location = 7) uniform  sampler2D _TextureSample0;
					layout(location = 8) uniform  sampler2D _WetnessRT;
					layout(location = 9) uniform  sampler2D _Specular;
					layout(location = 10) uniform  samplerCube unity_SpecCube0;
					layout(location = 11) uniform  samplerCube unity_SpecCube1;
					layout(location = 12) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD1;
					layout(location = 2) in  vec4 vs_TEXCOORD2;
					layout(location = 3) in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
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
					float u_xlat27;
					float u_xlat28;
					float u_xlat39;
					float u_xlat40;
					float u_xlat16_40;
					float u_xlat10_40;
					float u_xlat41;
					float u_xlat10_41;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat40 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat40 = (-u_xlat40) + 1.0;
					    u_xlat3.z = sqrt(u_xlat40);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat40 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat40) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_40 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_40 = max(u_xlat10_40, 0.0);
					    u_xlat40 = min(u_xlat16_40, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_41 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat41 = u_xlat10_41 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat41 = dot(u_xlat5.xy, vec2(u_xlat41));
					    u_xlat41 = max(u_xlat41, 0.0);
					    u_xlat41 = min(u_xlat41, _MaxOriginalSpecular);
					    u_xlat40 = u_xlat40 + u_xlat41;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
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
					    u_xlat0.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat14 = u_xlat1.x + u_xlat1.x;
					    u_xlat14 = u_xlat1.x * u_xlat14;
					    u_xlat14 = u_xlat14 * u_xlat42 + -0.5;
					    u_xlat27 = (-u_xlat2.x) + 1.0;
					    u_xlat28 = u_xlat27 * u_xlat27;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat27 = u_xlat27 * u_xlat28;
					    u_xlat27 = u_xlat14 * u_xlat27 + 1.0;
					    u_xlat28 = -abs(u_xlat39) + 1.0;
					    u_xlat41 = u_xlat28 * u_xlat28;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat28 = u_xlat28 * u_xlat41;
					    u_xlat14 = u_xlat14 * u_xlat28 + 1.0;
					    u_xlat14 = u_xlat14 * u_xlat27;
					    u_xlat14 = u_xlat2.x * u_xlat14;
					    u_xlat27 = u_xlat42 * u_xlat42;
					    u_xlat27 = max(u_xlat27, 0.00200000009);
					    u_xlat41 = (-u_xlat27) + 1.0;
					    u_xlat3.x = abs(u_xlat39) * u_xlat41 + u_xlat27;
					    u_xlat41 = u_xlat2.x * u_xlat41 + u_xlat27;
					    u_xlat39 = abs(u_xlat39) * u_xlat41;
					    u_xlat39 = u_xlat2.x * u_xlat3.x + u_xlat39;
					    u_xlat39 = u_xlat39 + 9.99999975e-06;
					    u_xlat39 = 0.5 / u_xlat39;
					    u_xlat41 = u_xlat27 * u_xlat27;
					    u_xlat3.x = u_xlat15 * u_xlat41 + (-u_xlat15);
					    u_xlat15 = u_xlat3.x * u_xlat15 + 1.0;
					    u_xlat41 = u_xlat41 * 0.318309873;
					    u_xlat15 = u_xlat15 * u_xlat15 + 1.00000001e-07;
					    u_xlat15 = u_xlat41 / u_xlat15;
					    u_xlat39 = u_xlat39 * u_xlat15;
					    u_xlat39 = u_xlat39 * 3.14159274;
					    u_xlat39 = max(u_xlat39, 9.99999975e-05);
					    u_xlat39 = sqrt(u_xlat39);
					    u_xlat39 = u_xlat2.x * u_xlat39;
					    u_xlat27 = u_xlat27 * 0.280000001;
					    u_xlat27 = (-u_xlat27) * u_xlat42 + 1.0;
					    u_xlat40 = u_xlat40 + 0.220916271;
					    u_xlat40 = min(u_xlat40, 1.0);
					    u_xlat2.xyw = vec3(u_xlat14) * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat6.xyz * vec3(u_xlat39);
					    u_xlat39 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat39 * u_xlat39;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat39 = u_xlat39 * u_xlat1.x;
					    u_xlat39 = u_xlat39 * 0.779083729 + 0.220916301;
					    u_xlat3.xyz = vec3(u_xlat39) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyw + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat8.xyz * vec3(u_xlat27);
					    u_xlat39 = u_xlat40 + -0.220916301;
					    u_xlat39 = u_xlat28 * u_xlat39 + 0.220916301;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat39) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			Tags { "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Geometry+0" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 100871
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec3 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
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
					Keywords { "DIRECTIONAL" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					Keywords { "SPOT" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec3 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					Keywords { "POINT_COOKIE" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec3 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec2 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					Keywords { "DIRECTIONAL_COOKIE" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD5;
					layout(location = 2) out vec3 vs_TEXCOORD1;
					layout(location = 3) out vec3 vs_TEXCOORD2;
					layout(location = 4) out vec3 vs_TEXCOORD3;
					layout(location = 5) out vec3 vs_TEXCOORD4;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SPOT" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					Keywords { "SHADOWS_DEPTH" "SPOT" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SHADOWS_SOFT" "SPOT" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[9];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[9];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
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
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[11];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec4 vs_TEXCOORD6;
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
					Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec2 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec2 vs_TEXCOORD5;
					layout(location = 2) out vec3 vs_TEXCOORD1;
					layout(location = 3) out vec3 vs_TEXCOORD2;
					layout(location = 4) out vec3 vs_TEXCOORD3;
					layout(location = 5) out vec3 vs_TEXCOORD4;
					layout(location = 6) out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
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
					    u_xlat2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat2.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat2.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat2.zz + u_xlat0.xy;
					    vs_TEXCOORD5.xy = unity_WorldToLight[3].xy * u_xlat2.ww + u_xlat0.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _texcoord_ST.xy + _texcoord_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat0.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat12 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    vs_TEXCOORD1.y = u_xlat3.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat0.y;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.z = u_xlat0.z;
					    vs_TEXCOORD3.z = u_xlat0.x;
					    vs_TEXCOORD2.y = u_xlat3.y;
					    vs_TEXCOORD3.y = u_xlat3.z;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec3 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					Keywords { "POINT" "SHADOWS_CUBE" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec3 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec3 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec3 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec3 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec3 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec3 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 0) out vec2 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec3 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[7];
						vec4 _texcoord_ST;
						vec4 _texcoord2_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec4 in_TANGENT0;
					layout(location = 2) in  vec3 in_NORMAL0;
					layout(location = 3) in  vec4 in_TEXCOORD0;
					layout(location = 4) in  vec4 in_TEXCOORD1;
					layout(location = 0) out vec4 vs_TEXCOORD0;
					layout(location = 1) out vec3 vs_TEXCOORD1;
					layout(location = 2) out vec3 vs_TEXCOORD2;
					layout(location = 3) out vec3 vs_TEXCOORD3;
					layout(location = 4) out vec3 vs_TEXCOORD4;
					layout(location = 5) out vec3 vs_TEXCOORD5;
					layout(location = 6) out vec4 vs_TEXCOORD6;
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
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 4) uniform  sampler2D _TextureSample1;
					layout(location = 5) uniform  sampler2D _ColorRT;
					layout(location = 6) uniform  sampler2D _TextureSample0;
					layout(location = 7) uniform  sampler2D _WetnessRT;
					layout(location = 8) uniform  sampler2D _Specular;
					layout(location = 9) uniform  sampler2D _LightTexture0;
					layout(location = 10) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec4 u_xlat6;
					vec3 u_xlat16_6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					float u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					float u_xlat16_28;
					float u_xlat10_28;
					float u_xlat29;
					float u_xlat10_29;
					bool u_xlatb29;
					float u_xlat30;
					float u_xlat10_30;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat28 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat28 = min(u_xlat28, 1.0);
					    u_xlat28 = (-u_xlat28) + 1.0;
					    u_xlat3.z = sqrt(u_xlat28);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat28 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat28) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_28 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_28 = max(u_xlat10_28, 0.0);
					    u_xlat28 = min(u_xlat16_28, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_29 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat29 = u_xlat10_29 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat29 = dot(u_xlat5.xy, vec2(u_xlat29));
					    u_xlat29 = max(u_xlat29, 0.0);
					    u_xlat29 = min(u_xlat29, _MaxOriginalSpecular);
					    u_xlat28 = u_xlat28 + u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb29 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb29){
					        u_xlatb29 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb29)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat29 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat29, u_xlat30);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat29 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
					    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_30 = texture(_LightTexture0, vec2(u_xlat30)).x;
					    u_xlat29 = u_xlat29 * u_xlat10_30;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat29) * _LightColor0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat28 = (-u_xlat28) + 1.0;
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
					    u_xlat9.x = u_xlat0.x + u_xlat0.x;
					    u_xlat9.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * u_xlat28 + -0.5;
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
					    u_xlat18 = u_xlat28 * u_xlat28;
					    u_xlat18 = max(u_xlat18, 0.00200000009);
					    u_xlat1.x = (-u_xlat18) + 1.0;
					    u_xlat10 = abs(u_xlat27) * u_xlat1.x + u_xlat18;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat18;
					    u_xlat27 = abs(u_xlat27) * u_xlat1.x;
					    u_xlat27 = u_xlat2.x * u_xlat10 + u_xlat27;
					    u_xlat27 = u_xlat27 + 9.99999975e-06;
					    u_xlat27 = 0.5 / u_xlat27;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat11 * u_xlat18 + (-u_xlat11);
					    u_xlat1.x = u_xlat1.x * u_xlat11 + 1.0;
					    u_xlat18 = u_xlat18 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat18 = u_xlat18 / u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat27;
					    u_xlat18 = u_xlat18 * 3.14159274;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = u_xlat2.xx * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat5.xyz;
					    u_xlat9.xyz = u_xlat5.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 4) uniform  sampler2D _TextureSample1;
					layout(location = 5) uniform  sampler2D _ColorRT;
					layout(location = 6) uniform  sampler2D _TextureSample0;
					layout(location = 7) uniform  sampler2D _WetnessRT;
					layout(location = 8) uniform  sampler2D _Specular;
					layout(location = 9) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bvec3 u_xlatb4;
					vec3 u_xlat5;
					vec3 u_xlat16_5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					float u_xlat17;
					float u_xlat24;
					float u_xlat25;
					float u_xlat16_25;
					float u_xlat10_25;
					float u_xlat26;
					float u_xlat10_26;
					bool u_xlatb26;
					float u_xlat27;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat2.xyz = texture(_TextureSample1, u_xlat2.xy).xyw;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_NormalValue);
					    u_xlat25 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat25 = min(u_xlat25, 1.0);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat2.z = sqrt(u_xlat25);
					    u_xlat10_3 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4 = u_xlat10_4 + vec4(_Diffuse_Brightness);
					    u_xlat5.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat6.x = dot(u_xlat5.xy, u_xlat4.xw);
					    u_xlat6.y = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat6.z = dot(u_xlat5.xy, u_xlat4.zw);
					    u_xlatb4.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_3.xyzx).xyz;
					    u_xlat16_5.xyz = u_xlat10_3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = (-u_xlat16_5.xyz) * u_xlat7.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat3;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat5.x : u_xlat3.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat5.y : u_xlat3.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat5.z : u_xlat3.z;
					        u_xlat3 = hlslcc_movcTemp;
					    }
					    u_xlat25 = u_xlat10_3.w * _ColorRTAlpha;
					    u_xlat3.xyz = (-u_xlat6.xyz) + u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat6.xyz;
					    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
					    u_xlat10_25 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_25 = max(u_xlat10_25, 0.0);
					    u_xlat25 = min(u_xlat16_25, _FluidShininess);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_26 = texture(_Specular, u_xlat4.xy).x;
					    u_xlat26 = u_xlat10_26 + _Spec_Brightness;
					    u_xlat4.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat26 = dot(u_xlat4.xy, vec2(u_xlat26));
					    u_xlat26 = max(u_xlat26, 0.0);
					    u_xlat26 = min(u_xlat26, _MaxOriginalSpecular);
					    u_xlat25 = u_xlat25 + u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlatb26 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb26){
					        u_xlatb26 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb26)) ? u_xlat4.xyz : vs_TEXCOORD4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat26 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat27 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat26, u_xlat27);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat26 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
					    u_xlat4.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat26) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x + u_xlat0.x;
					    u_xlat8.x = u_xlat0.x * u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * u_xlat25 + -0.5;
					    u_xlat16 = (-u_xlat1.x) + 1.0;
					    u_xlat17 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat17 = -abs(u_xlat24) + 1.0;
					    u_xlat2.x = u_xlat17 * u_xlat17;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat17 = u_xlat17 * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat17 + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat25 = abs(u_xlat24) * u_xlat17 + u_xlat16;
					    u_xlat17 = u_xlat1.x * u_xlat17 + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat17;
					    u_xlat24 = u_xlat1.x * u_xlat25 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat9 * u_xlat16 + (-u_xlat9);
					    u_xlat9 = u_xlat17 * u_xlat9 + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat9 = u_xlat9 * u_xlat9 + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat9;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat1.xx * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat4.xyz;
					    u_xlat8.xyz = u_xlat4.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 4) uniform  sampler2D _TextureSample1;
					layout(location = 5) uniform  sampler2D _ColorRT;
					layout(location = 6) uniform  sampler2D _TextureSample0;
					layout(location = 7) uniform  sampler2D _WetnessRT;
					layout(location = 8) uniform  sampler2D _Specular;
					layout(location = 9) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bvec3 u_xlatb4;
					vec3 u_xlat5;
					vec3 u_xlat16_5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					float u_xlat17;
					float u_xlat24;
					float u_xlat25;
					float u_xlat16_25;
					float u_xlat10_25;
					float u_xlat26;
					float u_xlat10_26;
					bool u_xlatb26;
					float u_xlat27;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat2.xyz = texture(_TextureSample1, u_xlat2.xy).xyw;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_NormalValue);
					    u_xlat25 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat25 = min(u_xlat25, 1.0);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat2.z = sqrt(u_xlat25);
					    u_xlat10_3 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4 = u_xlat10_4 + vec4(_Diffuse_Brightness);
					    u_xlat5.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat6.x = dot(u_xlat5.xy, u_xlat4.xw);
					    u_xlat6.y = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat6.z = dot(u_xlat5.xy, u_xlat4.zw);
					    u_xlatb4.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_3.xyzx).xyz;
					    u_xlat16_5.xyz = u_xlat10_3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = (-u_xlat16_5.xyz) * u_xlat7.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat3;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat5.x : u_xlat3.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat5.y : u_xlat3.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat5.z : u_xlat3.z;
					        u_xlat3 = hlslcc_movcTemp;
					    }
					    u_xlat25 = u_xlat10_3.w * _ColorRTAlpha;
					    u_xlat3.xyz = (-u_xlat6.xyz) + u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat6.xyz;
					    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
					    u_xlat10_25 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_25 = max(u_xlat10_25, 0.0);
					    u_xlat25 = min(u_xlat16_25, _FluidShininess);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_26 = texture(_Specular, u_xlat4.xy).x;
					    u_xlat26 = u_xlat10_26 + _Spec_Brightness;
					    u_xlat4.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat26 = dot(u_xlat4.xy, vec2(u_xlat26));
					    u_xlat26 = max(u_xlat26, 0.0);
					    u_xlat26 = min(u_xlat26, _MaxOriginalSpecular);
					    u_xlat25 = u_xlat25 + u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlatb26 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb26){
					        u_xlatb26 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb26)) ? u_xlat4.xyz : vs_TEXCOORD4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat26 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat27 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat26, u_xlat27);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat26 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
					    u_xlat4.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat26) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x + u_xlat0.x;
					    u_xlat8.x = u_xlat0.x * u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * u_xlat25 + -0.5;
					    u_xlat16 = (-u_xlat1.x) + 1.0;
					    u_xlat17 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat17 = -abs(u_xlat24) + 1.0;
					    u_xlat2.x = u_xlat17 * u_xlat17;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat17 = u_xlat17 * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat17 + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat25 = abs(u_xlat24) * u_xlat17 + u_xlat16;
					    u_xlat17 = u_xlat1.x * u_xlat17 + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat17;
					    u_xlat24 = u_xlat1.x * u_xlat25 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat9 * u_xlat16 + (-u_xlat9);
					    u_xlat9 = u_xlat17 * u_xlat9 + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat9 = u_xlat9 * u_xlat9 + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat9;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat1.xx * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat4.xyz;
					    u_xlat8.xyz = u_xlat4.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 4) uniform  sampler2D _TextureSample1;
					layout(location = 5) uniform  sampler2D _ColorRT;
					layout(location = 6) uniform  sampler2D _TextureSample0;
					layout(location = 7) uniform  sampler2D _WetnessRT;
					layout(location = 8) uniform  sampler2D _Specular;
					layout(location = 9) uniform  sampler2D _LightTexture0;
					layout(location = 10) uniform  sampler2D _LightTextureB0;
					layout(location = 11) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec4 u_xlat6;
					vec3 u_xlat16_6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					float u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					float u_xlat16_28;
					float u_xlat10_28;
					float u_xlat29;
					float u_xlat10_29;
					bool u_xlatb29;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					float u_xlat10_31;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat28 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat28 = min(u_xlat28, 1.0);
					    u_xlat28 = (-u_xlat28) + 1.0;
					    u_xlat3.z = sqrt(u_xlat28);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat28 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat28) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_28 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_28 = max(u_xlat10_28, 0.0);
					    u_xlat28 = min(u_xlat16_28, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_29 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat29 = u_xlat10_29 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat29 = dot(u_xlat5.xy, vec2(u_xlat29));
					    u_xlat29 = max(u_xlat29, 0.0);
					    u_xlat29 = min(u_xlat29, _MaxOriginalSpecular);
					    u_xlat28 = u_xlat28 + u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat5 = vs_TEXCOORD4.yyyy * unity_WorldToLight[1];
					    u_xlat5 = unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat5;
					    u_xlat5 = unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat5;
					    u_xlat5 = u_xlat5 + unity_WorldToLight[3];
					    u_xlatb29 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb29){
					        u_xlatb29 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb29)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat29 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat29, u_xlat30);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat29 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
					    u_xlatb30 = 0.0<u_xlat5.z;
					    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
					    u_xlat6.xy = u_xlat5.xy / u_xlat5.ww;
					    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
					    u_xlat10_31 = texture(_LightTexture0, u_xlat6.xy).w;
					    u_xlat30 = u_xlat30 * u_xlat10_31;
					    u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_31 = texture(_LightTextureB0, vec2(u_xlat31)).x;
					    u_xlat30 = u_xlat30 * u_xlat10_31;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat29) * _LightColor0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat28 = (-u_xlat28) + 1.0;
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
					    u_xlat9.x = u_xlat0.x + u_xlat0.x;
					    u_xlat9.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * u_xlat28 + -0.5;
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
					    u_xlat18 = u_xlat28 * u_xlat28;
					    u_xlat18 = max(u_xlat18, 0.00200000009);
					    u_xlat1.x = (-u_xlat18) + 1.0;
					    u_xlat10 = abs(u_xlat27) * u_xlat1.x + u_xlat18;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat18;
					    u_xlat27 = abs(u_xlat27) * u_xlat1.x;
					    u_xlat27 = u_xlat2.x * u_xlat10 + u_xlat27;
					    u_xlat27 = u_xlat27 + 9.99999975e-06;
					    u_xlat27 = 0.5 / u_xlat27;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat11 * u_xlat18 + (-u_xlat11);
					    u_xlat1.x = u_xlat1.x * u_xlat11 + 1.0;
					    u_xlat18 = u_xlat18 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat18 = u_xlat18 / u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat27;
					    u_xlat18 = u_xlat18 * 3.14159274;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = u_xlat2.xx * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat5.xyz;
					    u_xlat9.xyz = u_xlat5.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 4) uniform  sampler2D _TextureSample1;
					layout(location = 5) uniform  sampler2D _ColorRT;
					layout(location = 6) uniform  sampler2D _TextureSample0;
					layout(location = 7) uniform  sampler2D _WetnessRT;
					layout(location = 8) uniform  sampler2D _Specular;
					layout(location = 9) uniform  sampler2D _LightTexture0;
					layout(location = 10) uniform  sampler2D _LightTextureB0;
					layout(location = 11) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec4 u_xlat6;
					vec3 u_xlat16_6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					float u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					float u_xlat16_28;
					float u_xlat10_28;
					float u_xlat29;
					float u_xlat10_29;
					bool u_xlatb29;
					float u_xlat30;
					bool u_xlatb30;
					float u_xlat31;
					float u_xlat10_31;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat28 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat28 = min(u_xlat28, 1.0);
					    u_xlat28 = (-u_xlat28) + 1.0;
					    u_xlat3.z = sqrt(u_xlat28);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat28 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat28) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_28 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_28 = max(u_xlat10_28, 0.0);
					    u_xlat28 = min(u_xlat16_28, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_29 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat29 = u_xlat10_29 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat29 = dot(u_xlat5.xy, vec2(u_xlat29));
					    u_xlat29 = max(u_xlat29, 0.0);
					    u_xlat29 = min(u_xlat29, _MaxOriginalSpecular);
					    u_xlat28 = u_xlat28 + u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat5 = vs_TEXCOORD4.yyyy * unity_WorldToLight[1];
					    u_xlat5 = unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat5;
					    u_xlat5 = unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat5;
					    u_xlat5 = u_xlat5 + unity_WorldToLight[3];
					    u_xlatb29 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb29){
					        u_xlatb29 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb29)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat29 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat29, u_xlat30);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat29 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
					    u_xlatb30 = 0.0<u_xlat5.z;
					    u_xlat30 = u_xlatb30 ? 1.0 : float(0.0);
					    u_xlat6.xy = u_xlat5.xy / u_xlat5.ww;
					    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
					    u_xlat10_31 = texture(_LightTexture0, u_xlat6.xy).w;
					    u_xlat30 = u_xlat30 * u_xlat10_31;
					    u_xlat31 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_31 = texture(_LightTextureB0, vec2(u_xlat31)).x;
					    u_xlat30 = u_xlat30 * u_xlat10_31;
					    u_xlat29 = u_xlat29 * u_xlat30;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat29) * _LightColor0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat28 = (-u_xlat28) + 1.0;
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
					    u_xlat9.x = u_xlat0.x + u_xlat0.x;
					    u_xlat9.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * u_xlat28 + -0.5;
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
					    u_xlat18 = u_xlat28 * u_xlat28;
					    u_xlat18 = max(u_xlat18, 0.00200000009);
					    u_xlat1.x = (-u_xlat18) + 1.0;
					    u_xlat10 = abs(u_xlat27) * u_xlat1.x + u_xlat18;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat18;
					    u_xlat27 = abs(u_xlat27) * u_xlat1.x;
					    u_xlat27 = u_xlat2.x * u_xlat10 + u_xlat27;
					    u_xlat27 = u_xlat27 + 9.99999975e-06;
					    u_xlat27 = 0.5 / u_xlat27;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat11 * u_xlat18 + (-u_xlat11);
					    u_xlat1.x = u_xlat1.x * u_xlat11 + 1.0;
					    u_xlat18 = u_xlat18 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat18 = u_xlat18 / u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat27;
					    u_xlat18 = u_xlat18 * 3.14159274;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = u_xlat2.xx * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat5.xyz;
					    u_xlat9.xyz = u_xlat5.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 4) uniform  sampler2D _TextureSample1;
					layout(location = 5) uniform  sampler2D _ColorRT;
					layout(location = 6) uniform  sampler2D _TextureSample0;
					layout(location = 7) uniform  sampler2D _WetnessRT;
					layout(location = 8) uniform  sampler2D _Specular;
					layout(location = 9) uniform  sampler2D _LightTextureB0;
					layout(location = 10) uniform  samplerCube _LightTexture0;
					layout(location = 11) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec4 u_xlat6;
					vec3 u_xlat16_6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					float u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					float u_xlat16_28;
					float u_xlat10_28;
					float u_xlat29;
					float u_xlat10_29;
					bool u_xlatb29;
					float u_xlat30;
					float u_xlat16_30;
					float u_xlat10_30;
					float u_xlat10_31;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat28 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat28 = min(u_xlat28, 1.0);
					    u_xlat28 = (-u_xlat28) + 1.0;
					    u_xlat3.z = sqrt(u_xlat28);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat28 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat28) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_28 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_28 = max(u_xlat10_28, 0.0);
					    u_xlat28 = min(u_xlat16_28, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_29 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat29 = u_xlat10_29 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat29 = dot(u_xlat5.xy, vec2(u_xlat29));
					    u_xlat29 = max(u_xlat29, 0.0);
					    u_xlat29 = min(u_xlat29, _MaxOriginalSpecular);
					    u_xlat28 = u_xlat28 + u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb29 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb29){
					        u_xlatb29 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb29)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat29 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat29, u_xlat30);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat29 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
					    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_30 = texture(_LightTextureB0, vec2(u_xlat30)).x;
					    u_xlat10_31 = texture(_LightTexture0, u_xlat5.xyz).w;
					    u_xlat16_30 = u_xlat10_30 * u_xlat10_31;
					    u_xlat29 = u_xlat29 * u_xlat16_30;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat29) * _LightColor0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat28 = (-u_xlat28) + 1.0;
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
					    u_xlat9.x = u_xlat0.x + u_xlat0.x;
					    u_xlat9.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * u_xlat28 + -0.5;
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
					    u_xlat18 = u_xlat28 * u_xlat28;
					    u_xlat18 = max(u_xlat18, 0.00200000009);
					    u_xlat1.x = (-u_xlat18) + 1.0;
					    u_xlat10 = abs(u_xlat27) * u_xlat1.x + u_xlat18;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat18;
					    u_xlat27 = abs(u_xlat27) * u_xlat1.x;
					    u_xlat27 = u_xlat2.x * u_xlat10 + u_xlat27;
					    u_xlat27 = u_xlat27 + 9.99999975e-06;
					    u_xlat27 = 0.5 / u_xlat27;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat11 * u_xlat18 + (-u_xlat11);
					    u_xlat1.x = u_xlat1.x * u_xlat11 + 1.0;
					    u_xlat18 = u_xlat18 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat18 = u_xlat18 / u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat27;
					    u_xlat18 = u_xlat18 * 3.14159274;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = u_xlat2.xx * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat5.xyz;
					    u_xlat9.xyz = u_xlat5.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 4) uniform  sampler2D _TextureSample1;
					layout(location = 5) uniform  sampler2D _ColorRT;
					layout(location = 6) uniform  sampler2D _TextureSample0;
					layout(location = 7) uniform  sampler2D _WetnessRT;
					layout(location = 8) uniform  sampler2D _Specular;
					layout(location = 9) uniform  sampler2D _LightTextureB0;
					layout(location = 10) uniform  samplerCube _LightTexture0;
					layout(location = 11) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec4 u_xlat6;
					vec3 u_xlat16_6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					float u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					float u_xlat16_28;
					float u_xlat10_28;
					float u_xlat29;
					float u_xlat10_29;
					bool u_xlatb29;
					float u_xlat30;
					float u_xlat16_30;
					float u_xlat10_30;
					float u_xlat10_31;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat28 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat28 = min(u_xlat28, 1.0);
					    u_xlat28 = (-u_xlat28) + 1.0;
					    u_xlat3.z = sqrt(u_xlat28);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat28 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat28) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_28 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_28 = max(u_xlat10_28, 0.0);
					    u_xlat28 = min(u_xlat16_28, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_29 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat29 = u_xlat10_29 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat29 = dot(u_xlat5.xy, vec2(u_xlat29));
					    u_xlat29 = max(u_xlat29, 0.0);
					    u_xlat29 = min(u_xlat29, _MaxOriginalSpecular);
					    u_xlat28 = u_xlat28 + u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb29 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb29){
					        u_xlatb29 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb29)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat29 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat29, u_xlat30);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat29 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
					    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_30 = texture(_LightTextureB0, vec2(u_xlat30)).x;
					    u_xlat10_31 = texture(_LightTexture0, u_xlat5.xyz).w;
					    u_xlat16_30 = u_xlat10_30 * u_xlat10_31;
					    u_xlat29 = u_xlat29 * u_xlat16_30;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat29) * _LightColor0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat28 = (-u_xlat28) + 1.0;
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
					    u_xlat9.x = u_xlat0.x + u_xlat0.x;
					    u_xlat9.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * u_xlat28 + -0.5;
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
					    u_xlat18 = u_xlat28 * u_xlat28;
					    u_xlat18 = max(u_xlat18, 0.00200000009);
					    u_xlat1.x = (-u_xlat18) + 1.0;
					    u_xlat10 = abs(u_xlat27) * u_xlat1.x + u_xlat18;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat18;
					    u_xlat27 = abs(u_xlat27) * u_xlat1.x;
					    u_xlat27 = u_xlat2.x * u_xlat10 + u_xlat27;
					    u_xlat27 = u_xlat27 + 9.99999975e-06;
					    u_xlat27 = 0.5 / u_xlat27;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat11 * u_xlat18 + (-u_xlat11);
					    u_xlat1.x = u_xlat1.x * u_xlat11 + 1.0;
					    u_xlat18 = u_xlat18 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat18 = u_xlat18 / u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat27;
					    u_xlat18 = u_xlat18 * 3.14159274;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = u_xlat2.xx * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat5.xyz;
					    u_xlat9.xyz = u_xlat5.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 4) uniform  sampler2D _TextureSample1;
					layout(location = 5) uniform  sampler2D _ColorRT;
					layout(location = 6) uniform  sampler2D _TextureSample0;
					layout(location = 7) uniform  sampler2D _WetnessRT;
					layout(location = 8) uniform  sampler2D _Specular;
					layout(location = 9) uniform  sampler2D _LightTexture0;
					layout(location = 10) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bvec3 u_xlatb4;
					vec4 u_xlat5;
					vec3 u_xlat16_5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					float u_xlat17;
					float u_xlat24;
					float u_xlat25;
					float u_xlat16_25;
					float u_xlat10_25;
					float u_xlat26;
					float u_xlat10_26;
					bool u_xlatb26;
					float u_xlat27;
					float u_xlat10_27;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat2.xyz = texture(_TextureSample1, u_xlat2.xy).xyw;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_NormalValue);
					    u_xlat25 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat25 = min(u_xlat25, 1.0);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat2.z = sqrt(u_xlat25);
					    u_xlat10_3 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4 = u_xlat10_4 + vec4(_Diffuse_Brightness);
					    u_xlat5.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat6.x = dot(u_xlat5.xy, u_xlat4.xw);
					    u_xlat6.y = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat6.z = dot(u_xlat5.xy, u_xlat4.zw);
					    u_xlatb4.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_3.xyzx).xyz;
					    u_xlat16_5.xyz = u_xlat10_3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = (-u_xlat16_5.xyz) * u_xlat7.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat3;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat5.x : u_xlat3.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat5.y : u_xlat3.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat5.z : u_xlat3.z;
					        u_xlat3 = hlslcc_movcTemp;
					    }
					    u_xlat25 = u_xlat10_3.w * _ColorRTAlpha;
					    u_xlat3.xyz = (-u_xlat6.xyz) + u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat6.xyz;
					    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
					    u_xlat10_25 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_25 = max(u_xlat10_25, 0.0);
					    u_xlat25 = min(u_xlat16_25, _FluidShininess);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_26 = texture(_Specular, u_xlat4.xy).x;
					    u_xlat26 = u_xlat10_26 + _Spec_Brightness;
					    u_xlat4.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat26 = dot(u_xlat4.xy, vec2(u_xlat26));
					    u_xlat26 = max(u_xlat26, 0.0);
					    u_xlat26 = min(u_xlat26, _MaxOriginalSpecular);
					    u_xlat25 = u_xlat25 + u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD4.yy * unity_WorldToLight[1].xy;
					    u_xlat4.xy = unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat4.xy;
					    u_xlat4.xy = unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat4.xy;
					    u_xlat4.xy = u_xlat4.xy + unity_WorldToLight[3].xy;
					    u_xlatb26 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb26){
					        u_xlatb26 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb26)) ? u_xlat5.xyz : vs_TEXCOORD4.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat26 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat27 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat26, u_xlat27);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat26 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
					    u_xlat10_27 = texture(_LightTexture0, u_xlat4.xy).w;
					    u_xlat26 = u_xlat26 * u_xlat10_27;
					    u_xlat4.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat26) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x + u_xlat0.x;
					    u_xlat8.x = u_xlat0.x * u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * u_xlat25 + -0.5;
					    u_xlat16 = (-u_xlat1.x) + 1.0;
					    u_xlat17 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat17 = -abs(u_xlat24) + 1.0;
					    u_xlat2.x = u_xlat17 * u_xlat17;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat17 = u_xlat17 * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat17 + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat25 = abs(u_xlat24) * u_xlat17 + u_xlat16;
					    u_xlat17 = u_xlat1.x * u_xlat17 + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat17;
					    u_xlat24 = u_xlat1.x * u_xlat25 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat9 * u_xlat16 + (-u_xlat9);
					    u_xlat9 = u_xlat17 * u_xlat9 + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat9 = u_xlat9 * u_xlat9 + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat9;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat1.xx * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat4.xyz;
					    u_xlat8.xyz = u_xlat4.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 4) uniform  sampler2D _TextureSample1;
					layout(location = 5) uniform  sampler2D _ColorRT;
					layout(location = 6) uniform  sampler2D _TextureSample0;
					layout(location = 7) uniform  sampler2D _WetnessRT;
					layout(location = 8) uniform  sampler2D _Specular;
					layout(location = 9) uniform  sampler2D _LightTexture0;
					layout(location = 10) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bvec3 u_xlatb4;
					vec4 u_xlat5;
					vec3 u_xlat16_5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					float u_xlat17;
					float u_xlat24;
					float u_xlat25;
					float u_xlat16_25;
					float u_xlat10_25;
					float u_xlat26;
					float u_xlat10_26;
					bool u_xlatb26;
					float u_xlat27;
					float u_xlat10_27;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat2.xyz = texture(_TextureSample1, u_xlat2.xy).xyw;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_NormalValue);
					    u_xlat25 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat25 = min(u_xlat25, 1.0);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat2.z = sqrt(u_xlat25);
					    u_xlat10_3 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4 = u_xlat10_4 + vec4(_Diffuse_Brightness);
					    u_xlat5.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat6.x = dot(u_xlat5.xy, u_xlat4.xw);
					    u_xlat6.y = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat6.z = dot(u_xlat5.xy, u_xlat4.zw);
					    u_xlatb4.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_3.xyzx).xyz;
					    u_xlat16_5.xyz = u_xlat10_3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = (-u_xlat16_5.xyz) * u_xlat7.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat3;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat5.x : u_xlat3.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat5.y : u_xlat3.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat5.z : u_xlat3.z;
					        u_xlat3 = hlslcc_movcTemp;
					    }
					    u_xlat25 = u_xlat10_3.w * _ColorRTAlpha;
					    u_xlat3.xyz = (-u_xlat6.xyz) + u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat6.xyz;
					    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
					    u_xlat10_25 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_25 = max(u_xlat10_25, 0.0);
					    u_xlat25 = min(u_xlat16_25, _FluidShininess);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_26 = texture(_Specular, u_xlat4.xy).x;
					    u_xlat26 = u_xlat10_26 + _Spec_Brightness;
					    u_xlat4.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat26 = dot(u_xlat4.xy, vec2(u_xlat26));
					    u_xlat26 = max(u_xlat26, 0.0);
					    u_xlat26 = min(u_xlat26, _MaxOriginalSpecular);
					    u_xlat25 = u_xlat25 + u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD4.yy * unity_WorldToLight[1].xy;
					    u_xlat4.xy = unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat4.xy;
					    u_xlat4.xy = unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat4.xy;
					    u_xlat4.xy = u_xlat4.xy + unity_WorldToLight[3].xy;
					    u_xlatb26 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb26){
					        u_xlatb26 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb26)) ? u_xlat5.xyz : vs_TEXCOORD4.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat26 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat27 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat26, u_xlat27);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat26 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
					    u_xlat10_27 = texture(_LightTexture0, u_xlat4.xy).w;
					    u_xlat26 = u_xlat26 * u_xlat10_27;
					    u_xlat4.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat26) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x + u_xlat0.x;
					    u_xlat8.x = u_xlat0.x * u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * u_xlat25 + -0.5;
					    u_xlat16 = (-u_xlat1.x) + 1.0;
					    u_xlat17 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat17 = -abs(u_xlat24) + 1.0;
					    u_xlat2.x = u_xlat17 * u_xlat17;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat17 = u_xlat17 * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat17 + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat25 = abs(u_xlat24) * u_xlat17 + u_xlat16;
					    u_xlat17 = u_xlat1.x * u_xlat17 + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat17;
					    u_xlat24 = u_xlat1.x * u_xlat25 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat9 * u_xlat16 + (-u_xlat9);
					    u_xlat9 = u_xlat17 * u_xlat9 + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat9 = u_xlat9 * u_xlat9 + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat9;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat1.xx * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat4.xyz;
					    u_xlat8.xyz = u_xlat4.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SPOT" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[8];
						mat4x4 unity_WorldToShadow[4];
						vec4 unused_3_2[12];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _LightTexture0;
					layout(location = 12) uniform  sampler2D _LightTextureB0;
					layout(location = 13) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 14) uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2D _ShadowMapTexture;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bvec3 u_xlatb6;
					vec4 u_xlat7;
					vec3 u_xlat16_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					bool u_xlatb12;
					float u_xlat20;
					vec2 u_xlat22;
					float u_xlat10_22;
					float u_xlat30;
					float u_xlat31;
					float u_xlat16_31;
					float u_xlat10_31;
					float u_xlat32;
					float u_xlat10_32;
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
					    u_xlat4.xyz = texture(_TextureSample1, u_xlat4.xy).xyw;
					    u_xlat4.x = u_xlat4.z * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat31 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat31 = min(u_xlat31, 1.0);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat4.z = sqrt(u_xlat31);
					    u_xlat10_5 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_6 = texture(_TextureSample0, u_xlat6.xy);
					    u_xlat6 = u_xlat10_6 + vec4(_Diffuse_Brightness);
					    u_xlat7.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat8.x = dot(u_xlat7.xy, u_xlat6.xw);
					    u_xlat8.y = dot(u_xlat7.xy, u_xlat6.yw);
					    u_xlat8.z = dot(u_xlat7.xy, u_xlat6.zw);
					    u_xlatb6.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_5.xyzx).xyz;
					    u_xlat16_7.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat9.xyz = (-u_xlat8.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat16_7.xyz) * u_xlat9.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat5.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat7.x : u_xlat5.x;
					        hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat7.y : u_xlat5.y;
					        hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat7.z : u_xlat5.z;
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat31 = u_xlat10_5.w * _ColorRTAlpha;
					    u_xlat5.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat31) * u_xlat5.xyz + u_xlat8.xyz;
					    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
					    u_xlat10_31 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_31 = max(u_xlat10_31, 0.0);
					    u_xlat31 = min(u_xlat16_31, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_32 = texture(_Specular, u_xlat6.xy).x;
					    u_xlat32 = u_xlat10_32 + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat32 = dot(u_xlat6.xy, vec2(u_xlat32));
					    u_xlat32 = max(u_xlat32, 0.0);
					    u_xlat32 = min(u_xlat32, _MaxOriginalSpecular);
					    u_xlat31 = u_xlat31 + u_xlat32;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat6 = vs_TEXCOORD4.yyyy * unity_WorldToLight[1];
					    u_xlat6 = unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat6;
					    u_xlat6 = unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat6;
					    u_xlat6 = u_xlat6 + unity_WorldToLight[3];
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
					        u_xlat22.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat7.x = max(u_xlat22.x, u_xlat12.x);
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
					    u_xlat7 = vs_TEXCOORD4.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					    u_xlat7 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD4.xxxx + u_xlat7;
					    u_xlat7 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD4.zzzz + u_xlat7;
					    u_xlat7 = u_xlat7 + unity_WorldToShadow[3 / 4][3 % 4];
					    u_xlat7.xyz = u_xlat7.xyz / u_xlat7.www;
					    vec3 txVec0 = vec3(u_xlat7.xy,u_xlat7.z);
					    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat32 = (-_LightShadowData.x) + 1.0;
					    u_xlat22.x = u_xlat10_22 * u_xlat32 + _LightShadowData.x;
					    u_xlat12.x = (-u_xlat22.x) + u_xlat12.x;
					    u_xlat2.x = u_xlat2.x * u_xlat12.x + u_xlat22.x;
					    u_xlatb12 = 0.0<u_xlat6.z;
					    u_xlat12.x = u_xlatb12 ? 1.0 : float(0.0);
					    u_xlat22.xy = u_xlat6.xy / u_xlat6.ww;
					    u_xlat22.xy = u_xlat22.xy + vec2(0.5, 0.5);
					    u_xlat10_22 = texture(_LightTexture0, u_xlat22.xy).w;
					    u_xlat12.x = u_xlat10_22 * u_xlat12.x;
					    u_xlat22.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_22 = texture(_LightTextureB0, u_xlat22.xx).x;
					    u_xlat12.x = u_xlat10_22 * u_xlat12.x;
					    u_xlat2.x = u_xlat2.x * u_xlat12.x;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat12.x = inversesqrt(u_xlat12.x);
					    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat10.x = u_xlat0.x + u_xlat0.x;
					    u_xlat10.x = u_xlat0.x * u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * u_xlat31 + -0.5;
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
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat4.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * u_xlat10.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat31 = u_xlat0.x * u_xlat0.x;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat0.x = u_xlat0.x * u_xlat31;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SPOT" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[8];
						mat4x4 unity_WorldToShadow[4];
						vec4 unused_3_2[12];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _LightTexture0;
					layout(location = 12) uniform  sampler2D _LightTextureB0;
					layout(location = 13) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 14) uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2D _ShadowMapTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bvec3 u_xlatb6;
					vec4 u_xlat7;
					vec3 u_xlat16_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					bool u_xlatb12;
					float u_xlat20;
					vec2 u_xlat22;
					float u_xlat10_22;
					float u_xlat30;
					float u_xlat31;
					float u_xlat16_31;
					float u_xlat10_31;
					float u_xlat32;
					float u_xlat10_32;
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
					    u_xlat4.xyz = texture(_TextureSample1, u_xlat4.xy).xyw;
					    u_xlat4.x = u_xlat4.z * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat31 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat31 = min(u_xlat31, 1.0);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat4.z = sqrt(u_xlat31);
					    u_xlat10_5 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_6 = texture(_TextureSample0, u_xlat6.xy);
					    u_xlat6 = u_xlat10_6 + vec4(_Diffuse_Brightness);
					    u_xlat7.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat8.x = dot(u_xlat7.xy, u_xlat6.xw);
					    u_xlat8.y = dot(u_xlat7.xy, u_xlat6.yw);
					    u_xlat8.z = dot(u_xlat7.xy, u_xlat6.zw);
					    u_xlatb6.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_5.xyzx).xyz;
					    u_xlat16_7.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat9.xyz = (-u_xlat8.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat16_7.xyz) * u_xlat9.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat5.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat7.x : u_xlat5.x;
					        hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat7.y : u_xlat5.y;
					        hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat7.z : u_xlat5.z;
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat31 = u_xlat10_5.w * _ColorRTAlpha;
					    u_xlat5.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat31) * u_xlat5.xyz + u_xlat8.xyz;
					    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
					    u_xlat10_31 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_31 = max(u_xlat10_31, 0.0);
					    u_xlat31 = min(u_xlat16_31, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_32 = texture(_Specular, u_xlat6.xy).x;
					    u_xlat32 = u_xlat10_32 + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat32 = dot(u_xlat6.xy, vec2(u_xlat32));
					    u_xlat32 = max(u_xlat32, 0.0);
					    u_xlat32 = min(u_xlat32, _MaxOriginalSpecular);
					    u_xlat31 = u_xlat31 + u_xlat32;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
					    u_xlat6 = vs_TEXCOORD4.yyyy * unity_WorldToLight[1];
					    u_xlat6 = unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat6;
					    u_xlat6 = unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat6;
					    u_xlat6 = u_xlat6 + unity_WorldToLight[3];
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
					        u_xlat22.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat7.x = max(u_xlat22.x, u_xlat12.x);
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
					    u_xlat7 = vs_TEXCOORD4.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					    u_xlat7 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD4.xxxx + u_xlat7;
					    u_xlat7 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD4.zzzz + u_xlat7;
					    u_xlat7 = u_xlat7 + unity_WorldToShadow[3 / 4][3 % 4];
					    u_xlat7.xyz = u_xlat7.xyz / u_xlat7.www;
					    vec3 txVec0 = vec3(u_xlat7.xy,u_xlat7.z);
					    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat32 = (-_LightShadowData.x) + 1.0;
					    u_xlat22.x = u_xlat10_22 * u_xlat32 + _LightShadowData.x;
					    u_xlat12.x = (-u_xlat22.x) + u_xlat12.x;
					    u_xlat2.x = u_xlat2.x * u_xlat12.x + u_xlat22.x;
					    u_xlatb12 = 0.0<u_xlat6.z;
					    u_xlat12.x = u_xlatb12 ? 1.0 : float(0.0);
					    u_xlat22.xy = u_xlat6.xy / u_xlat6.ww;
					    u_xlat22.xy = u_xlat22.xy + vec2(0.5, 0.5);
					    u_xlat10_22 = texture(_LightTexture0, u_xlat22.xy).w;
					    u_xlat12.x = u_xlat10_22 * u_xlat12.x;
					    u_xlat22.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_22 = texture(_LightTextureB0, u_xlat22.xx).x;
					    u_xlat12.x = u_xlat10_22 * u_xlat12.x;
					    u_xlat2.x = u_xlat2.x * u_xlat12.x;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat12.x = inversesqrt(u_xlat12.x);
					    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat10.x = u_xlat0.x + u_xlat0.x;
					    u_xlat10.x = u_xlat0.x * u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * u_xlat31 + -0.5;
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
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat4.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * u_xlat10.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat31 = u_xlat0.x * u_xlat0.x;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat0.x = u_xlat0.x * u_xlat31;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SHADOWS_SOFT" "SPOT" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2[5];
						vec4 _ShadowMapTexture_TexelSize;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_16[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[8];
						mat4x4 unity_WorldToShadow[4];
						vec4 unused_3_2[12];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _LightTexture0;
					layout(location = 12) uniform  sampler2D _LightTextureB0;
					layout(location = 13) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 14) uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2D _ShadowMapTexture;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bvec3 u_xlatb6;
					vec4 u_xlat7;
					vec3 u_xlat16_7;
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
					float u_xlat37;
					float u_xlat16_37;
					float u_xlat10_37;
					float u_xlat38;
					float u_xlat10_38;
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
					    u_xlat4.xyz = texture(_TextureSample1, u_xlat4.xy).xyw;
					    u_xlat4.x = u_xlat4.z * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat37 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat37 = min(u_xlat37, 1.0);
					    u_xlat37 = (-u_xlat37) + 1.0;
					    u_xlat4.z = sqrt(u_xlat37);
					    u_xlat10_5 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_6 = texture(_TextureSample0, u_xlat6.xy);
					    u_xlat6 = u_xlat10_6 + vec4(_Diffuse_Brightness);
					    u_xlat7.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat8.x = dot(u_xlat7.xy, u_xlat6.xw);
					    u_xlat8.y = dot(u_xlat7.xy, u_xlat6.yw);
					    u_xlat8.z = dot(u_xlat7.xy, u_xlat6.zw);
					    u_xlatb6.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_5.xyzx).xyz;
					    u_xlat16_7.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat9.xyz = (-u_xlat8.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat16_7.xyz) * u_xlat9.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat5.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat7.x : u_xlat5.x;
					        hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat7.y : u_xlat5.y;
					        hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat7.z : u_xlat5.z;
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat37 = u_xlat10_5.w * _ColorRTAlpha;
					    u_xlat5.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat37) * u_xlat5.xyz + u_xlat8.xyz;
					    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
					    u_xlat10_37 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_37 = max(u_xlat10_37, 0.0);
					    u_xlat37 = min(u_xlat16_37, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_38 = texture(_Specular, u_xlat6.xy).x;
					    u_xlat38 = u_xlat10_38 + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat38 = dot(u_xlat6.xy, vec2(u_xlat38));
					    u_xlat38 = max(u_xlat38, 0.0);
					    u_xlat38 = min(u_xlat38, _MaxOriginalSpecular);
					    u_xlat37 = u_xlat37 + u_xlat38;
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
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
					    u_xlat10_26 = texture(_LightTexture0, u_xlat26.xy).w;
					    u_xlat14.x = u_xlat10_26 * u_xlat14.x;
					    u_xlat26.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_26 = texture(_LightTextureB0, u_xlat26.xx).x;
					    u_xlat14.x = u_xlat10_26 * u_xlat14.x;
					    u_xlat2.x = u_xlat2.x * u_xlat14.x;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat14.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat14.xyz = u_xlat14.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat12.x = u_xlat0.x + u_xlat0.x;
					    u_xlat12.x = u_xlat0.x * u_xlat12.x;
					    u_xlat12.x = u_xlat12.x * u_xlat37 + -0.5;
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
					    u_xlat1.xyz = u_xlat12.xxx * u_xlat4.xyz;
					    u_xlat12.xyz = u_xlat4.xyz * u_xlat12.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat37 = u_xlat0.x * u_xlat0.x;
					    u_xlat37 = u_xlat37 * u_xlat37;
					    u_xlat0.x = u_xlat0.x * u_xlat37;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat12.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "SHADOWS_SOFT" "SPOT" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2[5];
						vec4 _ShadowMapTexture_TexelSize;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_16;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[8];
						mat4x4 unity_WorldToShadow[4];
						vec4 unused_3_2[12];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _LightTexture0;
					layout(location = 12) uniform  sampler2D _LightTextureB0;
					layout(location = 13) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 14) uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2D _ShadowMapTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bvec3 u_xlatb6;
					vec4 u_xlat7;
					vec3 u_xlat16_7;
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
					float u_xlat37;
					float u_xlat16_37;
					float u_xlat10_37;
					float u_xlat38;
					float u_xlat10_38;
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
					    u_xlat4.xyz = texture(_TextureSample1, u_xlat4.xy).xyw;
					    u_xlat4.x = u_xlat4.z * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat37 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat37 = min(u_xlat37, 1.0);
					    u_xlat37 = (-u_xlat37) + 1.0;
					    u_xlat4.z = sqrt(u_xlat37);
					    u_xlat10_5 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_6 = texture(_TextureSample0, u_xlat6.xy);
					    u_xlat6 = u_xlat10_6 + vec4(_Diffuse_Brightness);
					    u_xlat7.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat8.x = dot(u_xlat7.xy, u_xlat6.xw);
					    u_xlat8.y = dot(u_xlat7.xy, u_xlat6.yw);
					    u_xlat8.z = dot(u_xlat7.xy, u_xlat6.zw);
					    u_xlatb6.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_5.xyzx).xyz;
					    u_xlat16_7.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat9.xyz = (-u_xlat8.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat16_7.xyz) * u_xlat9.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat5.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat7.x : u_xlat5.x;
					        hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat7.y : u_xlat5.y;
					        hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat7.z : u_xlat5.z;
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat37 = u_xlat10_5.w * _ColorRTAlpha;
					    u_xlat5.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat37) * u_xlat5.xyz + u_xlat8.xyz;
					    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
					    u_xlat10_37 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_37 = max(u_xlat10_37, 0.0);
					    u_xlat37 = min(u_xlat16_37, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_38 = texture(_Specular, u_xlat6.xy).x;
					    u_xlat38 = u_xlat10_38 + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat38 = dot(u_xlat6.xy, vec2(u_xlat38));
					    u_xlat38 = max(u_xlat38, 0.0);
					    u_xlat38 = min(u_xlat38, _MaxOriginalSpecular);
					    u_xlat37 = u_xlat37 + u_xlat38;
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
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
					    u_xlat10_26 = texture(_LightTexture0, u_xlat26.xy).w;
					    u_xlat14.x = u_xlat10_26 * u_xlat14.x;
					    u_xlat26.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_26 = texture(_LightTextureB0, u_xlat26.xx).x;
					    u_xlat14.x = u_xlat10_26 * u_xlat14.x;
					    u_xlat2.x = u_xlat2.x * u_xlat14.x;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat14.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat14.x = inversesqrt(u_xlat14.x);
					    u_xlat14.xyz = u_xlat14.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat12.x = u_xlat0.x + u_xlat0.x;
					    u_xlat12.x = u_xlat0.x * u_xlat12.x;
					    u_xlat12.x = u_xlat12.x * u_xlat37 + -0.5;
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
					    u_xlat1.xyz = u_xlat12.xxx * u_xlat4.xyz;
					    u_xlat12.xyz = u_xlat4.xyz * u_xlat12.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat37 = u_xlat0.x * u_xlat0.x;
					    u_xlat37 = u_xlat37 * u_xlat37;
					    u_xlat0.x = u_xlat0.x * u_xlat37;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat12.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _ShadowMapTexture;
					layout(location = 12) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 5) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bvec3 u_xlatb4;
					vec3 u_xlat5;
					vec3 u_xlat16_5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat12;
					float u_xlat16;
					float u_xlat17;
					float u_xlat24;
					float u_xlat25;
					float u_xlat16_25;
					float u_xlat10_25;
					float u_xlat26;
					float u_xlat10_26;
					float u_xlat27;
					bool u_xlatb27;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat2.xyz = texture(_TextureSample1, u_xlat2.xy).xyw;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_NormalValue);
					    u_xlat25 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat25 = min(u_xlat25, 1.0);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat2.z = sqrt(u_xlat25);
					    u_xlat10_3 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4 = u_xlat10_4 + vec4(_Diffuse_Brightness);
					    u_xlat5.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat6.x = dot(u_xlat5.xy, u_xlat4.xw);
					    u_xlat6.y = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat6.z = dot(u_xlat5.xy, u_xlat4.zw);
					    u_xlatb4.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_3.xyzx).xyz;
					    u_xlat16_5.xyz = u_xlat10_3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = (-u_xlat16_5.xyz) * u_xlat7.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat3;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat5.x : u_xlat3.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat5.y : u_xlat3.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat5.z : u_xlat3.z;
					        u_xlat3 = hlslcc_movcTemp;
					    }
					    u_xlat25 = u_xlat10_3.w * _ColorRTAlpha;
					    u_xlat3.xyz = (-u_xlat6.xyz) + u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat6.xyz;
					    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
					    u_xlat10_25 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_25 = max(u_xlat10_25, 0.0);
					    u_xlat25 = min(u_xlat16_25, _FluidShininess);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_26 = texture(_Specular, u_xlat4.xy).x;
					    u_xlat26 = u_xlat10_26 + _Spec_Brightness;
					    u_xlat4.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat26 = dot(u_xlat4.xy, vec2(u_xlat26));
					    u_xlat26 = max(u_xlat26, 0.0);
					    u_xlat26 = min(u_xlat26, _MaxOriginalSpecular);
					    u_xlat25 = u_xlat25 + u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat26 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat27 = sqrt(u_xlat27);
					    u_xlat27 = (-u_xlat26) + u_xlat27;
					    u_xlat26 = unity_ShadowFadeCenterAndType.w * u_xlat27 + u_xlat26;
					    u_xlat26 = u_xlat26 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
					    u_xlatb27 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb27){
					        u_xlatb27 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb27)) ? u_xlat4.xyz : vs_TEXCOORD4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat27 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat12 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat27, u_xlat12);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat27 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat10_4.x = texture(_ShadowMapTexture, u_xlat4.xy).x;
					    u_xlat27 = u_xlat27 + (-u_xlat10_4.x);
					    u_xlat26 = u_xlat26 * u_xlat27 + u_xlat10_4.x;
					    u_xlat4.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat26) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x + u_xlat0.x;
					    u_xlat8.x = u_xlat0.x * u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * u_xlat25 + -0.5;
					    u_xlat16 = (-u_xlat1.x) + 1.0;
					    u_xlat17 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat17 = -abs(u_xlat24) + 1.0;
					    u_xlat2.x = u_xlat17 * u_xlat17;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat17 = u_xlat17 * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat17 + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat25 = abs(u_xlat24) * u_xlat17 + u_xlat16;
					    u_xlat17 = u_xlat1.x * u_xlat17 + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat17;
					    u_xlat24 = u_xlat1.x * u_xlat25 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat9 * u_xlat16 + (-u_xlat9);
					    u_xlat9 = u_xlat17 * u_xlat9 + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat9 = u_xlat9 * u_xlat9 + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat9;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat1.xx * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat4.xyz;
					    u_xlat8.xyz = u_xlat4.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_14;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _ShadowMapTexture;
					layout(location = 12) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 5) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bvec3 u_xlatb4;
					vec3 u_xlat5;
					vec3 u_xlat16_5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat12;
					float u_xlat16;
					float u_xlat17;
					float u_xlat24;
					float u_xlat25;
					float u_xlat16_25;
					float u_xlat10_25;
					float u_xlat26;
					float u_xlat10_26;
					float u_xlat27;
					bool u_xlatb27;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat2.xyz = texture(_TextureSample1, u_xlat2.xy).xyw;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_NormalValue);
					    u_xlat25 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat25 = min(u_xlat25, 1.0);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat2.z = sqrt(u_xlat25);
					    u_xlat10_3 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4 = u_xlat10_4 + vec4(_Diffuse_Brightness);
					    u_xlat5.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat6.x = dot(u_xlat5.xy, u_xlat4.xw);
					    u_xlat6.y = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat6.z = dot(u_xlat5.xy, u_xlat4.zw);
					    u_xlatb4.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_3.xyzx).xyz;
					    u_xlat16_5.xyz = u_xlat10_3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = (-u_xlat16_5.xyz) * u_xlat7.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat3;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat5.x : u_xlat3.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat5.y : u_xlat3.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat5.z : u_xlat3.z;
					        u_xlat3 = hlslcc_movcTemp;
					    }
					    u_xlat25 = u_xlat10_3.w * _ColorRTAlpha;
					    u_xlat3.xyz = (-u_xlat6.xyz) + u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat6.xyz;
					    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
					    u_xlat10_25 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_25 = max(u_xlat10_25, 0.0);
					    u_xlat25 = min(u_xlat16_25, _FluidShininess);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_26 = texture(_Specular, u_xlat4.xy).x;
					    u_xlat26 = u_xlat10_26 + _Spec_Brightness;
					    u_xlat4.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat26 = dot(u_xlat4.xy, vec2(u_xlat26));
					    u_xlat26 = max(u_xlat26, 0.0);
					    u_xlat26 = min(u_xlat26, _MaxOriginalSpecular);
					    u_xlat25 = u_xlat25 + u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat26 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat27 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat27 = sqrt(u_xlat27);
					    u_xlat27 = (-u_xlat26) + u_xlat27;
					    u_xlat26 = unity_ShadowFadeCenterAndType.w * u_xlat27 + u_xlat26;
					    u_xlat26 = u_xlat26 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
					    u_xlatb27 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb27){
					        u_xlatb27 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb27)) ? u_xlat4.xyz : vs_TEXCOORD4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat27 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat12 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat27, u_xlat12);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat27 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat10_4.x = texture(_ShadowMapTexture, u_xlat4.xy).x;
					    u_xlat27 = u_xlat27 + (-u_xlat10_4.x);
					    u_xlat26 = u_xlat26 * u_xlat27 + u_xlat10_4.x;
					    u_xlat4.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat26) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x + u_xlat0.x;
					    u_xlat8.x = u_xlat0.x * u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * u_xlat25 + -0.5;
					    u_xlat16 = (-u_xlat1.x) + 1.0;
					    u_xlat17 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat17 = -abs(u_xlat24) + 1.0;
					    u_xlat2.x = u_xlat17 * u_xlat17;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat17 = u_xlat17 * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat17 + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat25 = abs(u_xlat24) * u_xlat17 + u_xlat16;
					    u_xlat17 = u_xlat1.x * u_xlat17 + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat17;
					    u_xlat24 = u_xlat1.x * u_xlat25 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat9 * u_xlat16 + (-u_xlat9);
					    u_xlat9 = u_xlat17 * u_xlat9 + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat9 = u_xlat9 * u_xlat9 + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat9;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat1.xx * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat4.xyz;
					    u_xlat8.xyz = u_xlat4.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _ShadowMapTexture;
					layout(location = 12) uniform  sampler2D _LightTexture0;
					layout(location = 13) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 5) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bvec3 u_xlatb4;
					vec4 u_xlat5;
					vec3 u_xlat16_5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					float u_xlat17;
					vec2 u_xlat20;
					float u_xlat10_20;
					float u_xlat24;
					float u_xlat25;
					float u_xlat16_25;
					float u_xlat10_25;
					float u_xlat26;
					float u_xlat10_26;
					float u_xlat27;
					float u_xlat10_27;
					bool u_xlatb27;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat2.xyz = texture(_TextureSample1, u_xlat2.xy).xyw;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_NormalValue);
					    u_xlat25 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat25 = min(u_xlat25, 1.0);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat2.z = sqrt(u_xlat25);
					    u_xlat10_3 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4 = u_xlat10_4 + vec4(_Diffuse_Brightness);
					    u_xlat5.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat6.x = dot(u_xlat5.xy, u_xlat4.xw);
					    u_xlat6.y = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat6.z = dot(u_xlat5.xy, u_xlat4.zw);
					    u_xlatb4.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_3.xyzx).xyz;
					    u_xlat16_5.xyz = u_xlat10_3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = (-u_xlat16_5.xyz) * u_xlat7.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat3;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat5.x : u_xlat3.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat5.y : u_xlat3.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat5.z : u_xlat3.z;
					        u_xlat3 = hlslcc_movcTemp;
					    }
					    u_xlat25 = u_xlat10_3.w * _ColorRTAlpha;
					    u_xlat3.xyz = (-u_xlat6.xyz) + u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat6.xyz;
					    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
					    u_xlat10_25 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_25 = max(u_xlat10_25, 0.0);
					    u_xlat25 = min(u_xlat16_25, _FluidShininess);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_26 = texture(_Specular, u_xlat4.xy).x;
					    u_xlat26 = u_xlat10_26 + _Spec_Brightness;
					    u_xlat4.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat26 = dot(u_xlat4.xy, vec2(u_xlat26));
					    u_xlat26 = max(u_xlat26, 0.0);
					    u_xlat26 = min(u_xlat26, _MaxOriginalSpecular);
					    u_xlat25 = u_xlat25 + u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD4.yy * unity_WorldToLight[1].xy;
					    u_xlat4.xy = unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat4.xy;
					    u_xlat4.xy = unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat4.xy;
					    u_xlat4.xy = u_xlat4.xy + unity_WorldToLight[3].xy;
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat26 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat27 = sqrt(u_xlat27);
					    u_xlat27 = (-u_xlat26) + u_xlat27;
					    u_xlat26 = unity_ShadowFadeCenterAndType.w * u_xlat27 + u_xlat26;
					    u_xlat26 = u_xlat26 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
					    u_xlatb27 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb27){
					        u_xlatb27 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : vs_TEXCOORD4.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat27 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat20.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat27, u_xlat20.x);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat27 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat20.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat10_20 = texture(_ShadowMapTexture, u_xlat20.xy).x;
					    u_xlat27 = u_xlat27 + (-u_xlat10_20);
					    u_xlat26 = u_xlat26 * u_xlat27 + u_xlat10_20;
					    u_xlat10_27 = texture(_LightTexture0, u_xlat4.xy).w;
					    u_xlat26 = u_xlat26 * u_xlat10_27;
					    u_xlat4.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat26) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x + u_xlat0.x;
					    u_xlat8.x = u_xlat0.x * u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * u_xlat25 + -0.5;
					    u_xlat16 = (-u_xlat1.x) + 1.0;
					    u_xlat17 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat17 = -abs(u_xlat24) + 1.0;
					    u_xlat2.x = u_xlat17 * u_xlat17;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat17 = u_xlat17 * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat17 + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat25 = abs(u_xlat24) * u_xlat17 + u_xlat16;
					    u_xlat17 = u_xlat1.x * u_xlat17 + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat17;
					    u_xlat24 = u_xlat1.x * u_xlat25 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat9 * u_xlat16 + (-u_xlat9);
					    u_xlat9 = u_xlat17 * u_xlat9 + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat9 = u_xlat9 * u_xlat9 + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat9;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat1.xx * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat4.xyz;
					    u_xlat8.xyz = u_xlat4.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _ShadowMapTexture;
					layout(location = 12) uniform  sampler2D _LightTexture0;
					layout(location = 13) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 5) in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bvec3 u_xlatb4;
					vec4 u_xlat5;
					vec3 u_xlat16_5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat16;
					float u_xlat17;
					vec2 u_xlat20;
					float u_xlat10_20;
					float u_xlat24;
					float u_xlat25;
					float u_xlat16_25;
					float u_xlat10_25;
					float u_xlat26;
					float u_xlat10_26;
					float u_xlat27;
					float u_xlat10_27;
					bool u_xlatb27;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xy = vs_TEXCOORD0.xy * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
					    u_xlat2.xyz = texture(_TextureSample1, u_xlat2.xy).xyw;
					    u_xlat2.x = u_xlat2.z * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(_NormalValue);
					    u_xlat25 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat25 = min(u_xlat25, 1.0);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat2.z = sqrt(u_xlat25);
					    u_xlat10_3 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_4 = texture(_TextureSample0, u_xlat4.xy);
					    u_xlat4 = u_xlat10_4 + vec4(_Diffuse_Brightness);
					    u_xlat5.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat6.x = dot(u_xlat5.xy, u_xlat4.xw);
					    u_xlat6.y = dot(u_xlat5.xy, u_xlat4.yw);
					    u_xlat6.z = dot(u_xlat5.xy, u_xlat4.zw);
					    u_xlatb4.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_3.xyzx).xyz;
					    u_xlat16_5.xyz = u_xlat10_3.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_5.xyz = (-u_xlat16_5.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat6.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = (-u_xlat16_5.xyz) * u_xlat7.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + u_xlat3.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat3;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? u_xlat5.x : u_xlat3.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? u_xlat5.y : u_xlat3.y;
					        hlslcc_movcTemp.z = (u_xlatb4.z) ? u_xlat5.z : u_xlat3.z;
					        u_xlat3 = hlslcc_movcTemp;
					    }
					    u_xlat25 = u_xlat10_3.w * _ColorRTAlpha;
					    u_xlat3.xyz = (-u_xlat6.xyz) + u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat6.xyz;
					    u_xlat3.xyz = clamp(u_xlat3.xyz, 0.0, 1.0);
					    u_xlat10_25 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_25 = max(u_xlat10_25, 0.0);
					    u_xlat25 = min(u_xlat16_25, _FluidShininess);
					    u_xlat4.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_26 = texture(_Specular, u_xlat4.xy).x;
					    u_xlat26 = u_xlat10_26 + _Spec_Brightness;
					    u_xlat4.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat26 = dot(u_xlat4.xy, vec2(u_xlat26));
					    u_xlat26 = max(u_xlat26, 0.0);
					    u_xlat26 = min(u_xlat26, _MaxOriginalSpecular);
					    u_xlat25 = u_xlat25 + u_xlat26;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD4.yy * unity_WorldToLight[1].xy;
					    u_xlat4.xy = unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat4.xy;
					    u_xlat4.xy = unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat4.xy;
					    u_xlat4.xy = u_xlat4.xy + unity_WorldToLight[3].xy;
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat26 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD4.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat27 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat27 = sqrt(u_xlat27);
					    u_xlat27 = (-u_xlat26) + u_xlat27;
					    u_xlat26 = unity_ShadowFadeCenterAndType.w * u_xlat27 + u_xlat26;
					    u_xlat26 = u_xlat26 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat26 = clamp(u_xlat26, 0.0, 1.0);
					    u_xlatb27 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb27){
					        u_xlatb27 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb27)) ? u_xlat5.xyz : vs_TEXCOORD4.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat27 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat20.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat27, u_xlat20.x);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat27 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat20.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat10_20 = texture(_ShadowMapTexture, u_xlat20.xy).x;
					    u_xlat27 = u_xlat27 + (-u_xlat10_20);
					    u_xlat26 = u_xlat26 * u_xlat27 + u_xlat10_20;
					    u_xlat10_27 = texture(_LightTexture0, u_xlat4.xy).w;
					    u_xlat26 = u_xlat26 * u_xlat10_27;
					    u_xlat4.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat4.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat4.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat26) * _LightColor0.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x + u_xlat0.x;
					    u_xlat8.x = u_xlat0.x * u_xlat8.x;
					    u_xlat8.x = u_xlat8.x * u_xlat25 + -0.5;
					    u_xlat16 = (-u_xlat1.x) + 1.0;
					    u_xlat17 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat16 = u_xlat16 * u_xlat17;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat17 = -abs(u_xlat24) + 1.0;
					    u_xlat2.x = u_xlat17 * u_xlat17;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat17 = u_xlat17 * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat17 + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat25 * u_xlat25;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat17 = (-u_xlat16) + 1.0;
					    u_xlat25 = abs(u_xlat24) * u_xlat17 + u_xlat16;
					    u_xlat17 = u_xlat1.x * u_xlat17 + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat17;
					    u_xlat24 = u_xlat1.x * u_xlat25 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat17 = u_xlat9 * u_xlat16 + (-u_xlat9);
					    u_xlat9 = u_xlat17 * u_xlat9 + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat9 = u_xlat9 * u_xlat9 + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat9;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat1.xx * u_xlat8.xy;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat4.xyz;
					    u_xlat8.xyz = u_xlat4.xyz * u_xlat8.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat25 = u_xlat0.x * u_xlat0.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat0.x = u_xlat0.x * u_xlat25;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _LightTexture0;
					layout(location = 12) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 13) uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bvec3 u_xlatb6;
					vec4 u_xlat7;
					vec3 u_xlat16_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					float u_xlat10_12;
					bool u_xlatb12;
					float u_xlat20;
					float u_xlat22;
					float u_xlat10_22;
					float u_xlat30;
					float u_xlat31;
					float u_xlat16_31;
					float u_xlat10_31;
					float u_xlat32;
					float u_xlat10_32;
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
					    u_xlat4.xyz = texture(_TextureSample1, u_xlat4.xy).xyw;
					    u_xlat4.x = u_xlat4.z * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat31 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat31 = min(u_xlat31, 1.0);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat4.z = sqrt(u_xlat31);
					    u_xlat10_5 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_6 = texture(_TextureSample0, u_xlat6.xy);
					    u_xlat6 = u_xlat10_6 + vec4(_Diffuse_Brightness);
					    u_xlat7.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat8.x = dot(u_xlat7.xy, u_xlat6.xw);
					    u_xlat8.y = dot(u_xlat7.xy, u_xlat6.yw);
					    u_xlat8.z = dot(u_xlat7.xy, u_xlat6.zw);
					    u_xlatb6.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_5.xyzx).xyz;
					    u_xlat16_7.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat9.xyz = (-u_xlat8.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat16_7.xyz) * u_xlat9.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat5.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat7.x : u_xlat5.x;
					        hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat7.y : u_xlat5.y;
					        hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat7.z : u_xlat5.z;
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat31 = u_xlat10_5.w * _ColorRTAlpha;
					    u_xlat5.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat31) * u_xlat5.xyz + u_xlat8.xyz;
					    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
					    u_xlat10_31 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_31 = max(u_xlat10_31, 0.0);
					    u_xlat31 = min(u_xlat16_31, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_32 = texture(_Specular, u_xlat6.xy).x;
					    u_xlat32 = u_xlat10_32 + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat32 = dot(u_xlat6.xy, vec2(u_xlat32));
					    u_xlat32 = max(u_xlat32, 0.0);
					    u_xlat32 = min(u_xlat32, _MaxOriginalSpecular);
					    u_xlat31 = u_xlat31 + u_xlat32;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
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
					    u_xlat7.xyz = vs_TEXCOORD4.xyz + (-_LightPositionRange.xyz);
					    u_xlat22 = max(abs(u_xlat7.y), abs(u_xlat7.x));
					    u_xlat22 = max(abs(u_xlat7.z), u_xlat22);
					    u_xlat22 = u_xlat22 + (-_LightProjectionParams.z);
					    u_xlat22 = max(u_xlat22, 9.99999975e-06);
					    u_xlat22 = u_xlat22 * _LightProjectionParams.w;
					    u_xlat22 = _LightProjectionParams.y / u_xlat22;
					    u_xlat22 = u_xlat22 + (-_LightProjectionParams.x);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    vec4 txVec0 = vec4(u_xlat7.xyz,u_xlat22);
					    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat32 = (-_LightShadowData.x) + 1.0;
					    u_xlat22 = u_xlat10_22 * u_xlat32 + _LightShadowData.x;
					    u_xlat12.x = (-u_xlat22) + u_xlat12.x;
					    u_xlat2.x = u_xlat2.x * u_xlat12.x + u_xlat22;
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_12 = texture(_LightTexture0, u_xlat12.xx).x;
					    u_xlat2.x = u_xlat2.x * u_xlat10_12;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat12.x = inversesqrt(u_xlat12.x);
					    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat10.x = u_xlat0.x + u_xlat0.x;
					    u_xlat10.x = u_xlat0.x * u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * u_xlat31 + -0.5;
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
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat4.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * u_xlat10.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat31 = u_xlat0.x * u_xlat0.x;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat0.x = u_xlat0.x * u_xlat31;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _LightTexture0;
					layout(location = 12) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 13) uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bvec3 u_xlatb6;
					vec4 u_xlat7;
					vec3 u_xlat16_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					float u_xlat10_12;
					bool u_xlatb12;
					float u_xlat20;
					float u_xlat22;
					float u_xlat10_22;
					float u_xlat30;
					float u_xlat31;
					float u_xlat16_31;
					float u_xlat10_31;
					float u_xlat32;
					float u_xlat10_32;
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
					    u_xlat4.xyz = texture(_TextureSample1, u_xlat4.xy).xyw;
					    u_xlat4.x = u_xlat4.z * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat31 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat31 = min(u_xlat31, 1.0);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat4.z = sqrt(u_xlat31);
					    u_xlat10_5 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_6 = texture(_TextureSample0, u_xlat6.xy);
					    u_xlat6 = u_xlat10_6 + vec4(_Diffuse_Brightness);
					    u_xlat7.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat8.x = dot(u_xlat7.xy, u_xlat6.xw);
					    u_xlat8.y = dot(u_xlat7.xy, u_xlat6.yw);
					    u_xlat8.z = dot(u_xlat7.xy, u_xlat6.zw);
					    u_xlatb6.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_5.xyzx).xyz;
					    u_xlat16_7.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat9.xyz = (-u_xlat8.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat16_7.xyz) * u_xlat9.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat5.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat7.x : u_xlat5.x;
					        hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat7.y : u_xlat5.y;
					        hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat7.z : u_xlat5.z;
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat31 = u_xlat10_5.w * _ColorRTAlpha;
					    u_xlat5.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat31) * u_xlat5.xyz + u_xlat8.xyz;
					    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
					    u_xlat10_31 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_31 = max(u_xlat10_31, 0.0);
					    u_xlat31 = min(u_xlat16_31, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_32 = texture(_Specular, u_xlat6.xy).x;
					    u_xlat32 = u_xlat10_32 + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat32 = dot(u_xlat6.xy, vec2(u_xlat32));
					    u_xlat32 = max(u_xlat32, 0.0);
					    u_xlat32 = min(u_xlat32, _MaxOriginalSpecular);
					    u_xlat31 = u_xlat31 + u_xlat32;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
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
					    u_xlat7.xyz = vs_TEXCOORD4.xyz + (-_LightPositionRange.xyz);
					    u_xlat22 = max(abs(u_xlat7.y), abs(u_xlat7.x));
					    u_xlat22 = max(abs(u_xlat7.z), u_xlat22);
					    u_xlat22 = u_xlat22 + (-_LightProjectionParams.z);
					    u_xlat22 = max(u_xlat22, 9.99999975e-06);
					    u_xlat22 = u_xlat22 * _LightProjectionParams.w;
					    u_xlat22 = _LightProjectionParams.y / u_xlat22;
					    u_xlat22 = u_xlat22 + (-_LightProjectionParams.x);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    vec4 txVec0 = vec4(u_xlat7.xyz,u_xlat22);
					    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat32 = (-_LightShadowData.x) + 1.0;
					    u_xlat22 = u_xlat10_22 * u_xlat32 + _LightShadowData.x;
					    u_xlat12.x = (-u_xlat22) + u_xlat12.x;
					    u_xlat2.x = u_xlat2.x * u_xlat12.x + u_xlat22;
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_12 = texture(_LightTexture0, u_xlat12.xx).x;
					    u_xlat2.x = u_xlat2.x * u_xlat10_12;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat12.x = inversesqrt(u_xlat12.x);
					    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat10.x = u_xlat0.x + u_xlat0.x;
					    u_xlat10.x = u_xlat0.x * u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * u_xlat31 + -0.5;
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
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat4.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * u_xlat10.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat31 = u_xlat0.x * u_xlat0.x;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat0.x = u_xlat0.x * u_xlat31;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _LightTexture0;
					layout(location = 12) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 13) uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bvec3 u_xlatb6;
					vec4 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					float u_xlat10_12;
					bool u_xlatb12;
					float u_xlat20;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat30;
					float u_xlat31;
					float u_xlat16_31;
					float u_xlat10_31;
					float u_xlat32;
					float u_xlat10_32;
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
					    u_xlat4.xyz = texture(_TextureSample1, u_xlat4.xy).xyw;
					    u_xlat4.x = u_xlat4.z * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat31 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat31 = min(u_xlat31, 1.0);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat4.z = sqrt(u_xlat31);
					    u_xlat10_5 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_6 = texture(_TextureSample0, u_xlat6.xy);
					    u_xlat6 = u_xlat10_6 + vec4(_Diffuse_Brightness);
					    u_xlat7.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat8.x = dot(u_xlat7.xy, u_xlat6.xw);
					    u_xlat8.y = dot(u_xlat7.xy, u_xlat6.yw);
					    u_xlat8.z = dot(u_xlat7.xy, u_xlat6.zw);
					    u_xlatb6.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_5.xyzx).xyz;
					    u_xlat16_7.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat9.xyz = (-u_xlat8.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat16_7.xyz) * u_xlat9.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat5.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat7.x : u_xlat5.x;
					        hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat7.y : u_xlat5.y;
					        hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat7.z : u_xlat5.z;
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat31 = u_xlat10_5.w * _ColorRTAlpha;
					    u_xlat5.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat31) * u_xlat5.xyz + u_xlat8.xyz;
					    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
					    u_xlat10_31 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_31 = max(u_xlat10_31, 0.0);
					    u_xlat31 = min(u_xlat16_31, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_32 = texture(_Specular, u_xlat6.xy).x;
					    u_xlat32 = u_xlat10_32 + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat32 = dot(u_xlat6.xy, vec2(u_xlat32));
					    u_xlat32 = max(u_xlat32, 0.0);
					    u_xlat32 = min(u_xlat32, _MaxOriginalSpecular);
					    u_xlat31 = u_xlat31 + u_xlat32;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
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
					    u_xlat10_12 = texture(_LightTexture0, u_xlat12.xx).x;
					    u_xlat2.x = u_xlat2.x * u_xlat10_12;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat12.x = inversesqrt(u_xlat12.x);
					    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat10.x = u_xlat0.x + u_xlat0.x;
					    u_xlat10.x = u_xlat0.x * u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * u_xlat31 + -0.5;
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
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat4.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * u_xlat10.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat31 = u_xlat0.x * u_xlat0.x;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat0.x = u_xlat0.x * u_xlat31;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _LightTexture0;
					layout(location = 12) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 13) uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bvec3 u_xlatb6;
					vec4 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					float u_xlat10_12;
					bool u_xlatb12;
					float u_xlat20;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat30;
					float u_xlat31;
					float u_xlat16_31;
					float u_xlat10_31;
					float u_xlat32;
					float u_xlat10_32;
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
					    u_xlat4.xyz = texture(_TextureSample1, u_xlat4.xy).xyw;
					    u_xlat4.x = u_xlat4.z * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat31 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat31 = min(u_xlat31, 1.0);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat4.z = sqrt(u_xlat31);
					    u_xlat10_5 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_6 = texture(_TextureSample0, u_xlat6.xy);
					    u_xlat6 = u_xlat10_6 + vec4(_Diffuse_Brightness);
					    u_xlat7.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat8.x = dot(u_xlat7.xy, u_xlat6.xw);
					    u_xlat8.y = dot(u_xlat7.xy, u_xlat6.yw);
					    u_xlat8.z = dot(u_xlat7.xy, u_xlat6.zw);
					    u_xlatb6.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_5.xyzx).xyz;
					    u_xlat16_7.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat9.xyz = (-u_xlat8.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat16_7.xyz) * u_xlat9.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat5.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat7.x : u_xlat5.x;
					        hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat7.y : u_xlat5.y;
					        hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat7.z : u_xlat5.z;
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat31 = u_xlat10_5.w * _ColorRTAlpha;
					    u_xlat5.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat31) * u_xlat5.xyz + u_xlat8.xyz;
					    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
					    u_xlat10_31 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_31 = max(u_xlat10_31, 0.0);
					    u_xlat31 = min(u_xlat16_31, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_32 = texture(_Specular, u_xlat6.xy).x;
					    u_xlat32 = u_xlat10_32 + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat32 = dot(u_xlat6.xy, vec2(u_xlat32));
					    u_xlat32 = max(u_xlat32, 0.0);
					    u_xlat32 = min(u_xlat32, _MaxOriginalSpecular);
					    u_xlat31 = u_xlat31 + u_xlat32;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
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
					    u_xlat10_12 = texture(_LightTexture0, u_xlat12.xx).x;
					    u_xlat2.x = u_xlat2.x * u_xlat10_12;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat12.x = inversesqrt(u_xlat12.x);
					    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat10.x = u_xlat0.x + u_xlat0.x;
					    u_xlat10.x = u_xlat0.x * u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * u_xlat31 + -0.5;
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
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat4.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * u_xlat10.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat31 = u_xlat0.x * u_xlat0.x;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat0.x = u_xlat0.x * u_xlat31;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _LightTextureB0;
					layout(location = 12) uniform  samplerCube _LightTexture0;
					layout(location = 13) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 14) uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bvec3 u_xlatb6;
					vec4 u_xlat7;
					vec3 u_xlat16_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					float u_xlat16_12;
					float u_xlat10_12;
					bool u_xlatb12;
					float u_xlat20;
					float u_xlat22;
					float u_xlat10_22;
					float u_xlat30;
					float u_xlat31;
					float u_xlat16_31;
					float u_xlat10_31;
					float u_xlat32;
					float u_xlat10_32;
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
					    u_xlat4.xyz = texture(_TextureSample1, u_xlat4.xy).xyw;
					    u_xlat4.x = u_xlat4.z * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat31 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat31 = min(u_xlat31, 1.0);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat4.z = sqrt(u_xlat31);
					    u_xlat10_5 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_6 = texture(_TextureSample0, u_xlat6.xy);
					    u_xlat6 = u_xlat10_6 + vec4(_Diffuse_Brightness);
					    u_xlat7.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat8.x = dot(u_xlat7.xy, u_xlat6.xw);
					    u_xlat8.y = dot(u_xlat7.xy, u_xlat6.yw);
					    u_xlat8.z = dot(u_xlat7.xy, u_xlat6.zw);
					    u_xlatb6.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_5.xyzx).xyz;
					    u_xlat16_7.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat9.xyz = (-u_xlat8.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat16_7.xyz) * u_xlat9.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat5.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat7.x : u_xlat5.x;
					        hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat7.y : u_xlat5.y;
					        hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat7.z : u_xlat5.z;
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat31 = u_xlat10_5.w * _ColorRTAlpha;
					    u_xlat5.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat31) * u_xlat5.xyz + u_xlat8.xyz;
					    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
					    u_xlat10_31 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_31 = max(u_xlat10_31, 0.0);
					    u_xlat31 = min(u_xlat16_31, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_32 = texture(_Specular, u_xlat6.xy).x;
					    u_xlat32 = u_xlat10_32 + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat32 = dot(u_xlat6.xy, vec2(u_xlat32));
					    u_xlat32 = max(u_xlat32, 0.0);
					    u_xlat32 = min(u_xlat32, _MaxOriginalSpecular);
					    u_xlat31 = u_xlat31 + u_xlat32;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
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
					    u_xlat7.xyz = vs_TEXCOORD4.xyz + (-_LightPositionRange.xyz);
					    u_xlat22 = max(abs(u_xlat7.y), abs(u_xlat7.x));
					    u_xlat22 = max(abs(u_xlat7.z), u_xlat22);
					    u_xlat22 = u_xlat22 + (-_LightProjectionParams.z);
					    u_xlat22 = max(u_xlat22, 9.99999975e-06);
					    u_xlat22 = u_xlat22 * _LightProjectionParams.w;
					    u_xlat22 = _LightProjectionParams.y / u_xlat22;
					    u_xlat22 = u_xlat22 + (-_LightProjectionParams.x);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    vec4 txVec0 = vec4(u_xlat7.xyz,u_xlat22);
					    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat32 = (-_LightShadowData.x) + 1.0;
					    u_xlat22 = u_xlat10_22 * u_xlat32 + _LightShadowData.x;
					    u_xlat12.x = (-u_xlat22) + u_xlat12.x;
					    u_xlat2.x = u_xlat2.x * u_xlat12.x + u_xlat22;
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_12 = texture(_LightTextureB0, u_xlat12.xx).x;
					    u_xlat10_22 = texture(_LightTexture0, u_xlat6.xyz).w;
					    u_xlat16_12 = u_xlat10_22 * u_xlat10_12;
					    u_xlat2.x = u_xlat2.x * u_xlat16_12;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat12.x = inversesqrt(u_xlat12.x);
					    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat10.x = u_xlat0.x + u_xlat0.x;
					    u_xlat10.x = u_xlat0.x * u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * u_xlat31 + -0.5;
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
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat4.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * u_xlat10.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat31 = u_xlat0.x * u_xlat0.x;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat0.x = u_xlat0.x * u_xlat31;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _LightTextureB0;
					layout(location = 12) uniform  samplerCube _LightTexture0;
					layout(location = 13) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 14) uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bvec3 u_xlatb6;
					vec4 u_xlat7;
					vec3 u_xlat16_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					float u_xlat16_12;
					float u_xlat10_12;
					bool u_xlatb12;
					float u_xlat20;
					float u_xlat22;
					float u_xlat10_22;
					float u_xlat30;
					float u_xlat31;
					float u_xlat16_31;
					float u_xlat10_31;
					float u_xlat32;
					float u_xlat10_32;
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
					    u_xlat4.xyz = texture(_TextureSample1, u_xlat4.xy).xyw;
					    u_xlat4.x = u_xlat4.z * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat31 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat31 = min(u_xlat31, 1.0);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat4.z = sqrt(u_xlat31);
					    u_xlat10_5 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_6 = texture(_TextureSample0, u_xlat6.xy);
					    u_xlat6 = u_xlat10_6 + vec4(_Diffuse_Brightness);
					    u_xlat7.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat8.x = dot(u_xlat7.xy, u_xlat6.xw);
					    u_xlat8.y = dot(u_xlat7.xy, u_xlat6.yw);
					    u_xlat8.z = dot(u_xlat7.xy, u_xlat6.zw);
					    u_xlatb6.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_5.xyzx).xyz;
					    u_xlat16_7.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat9.xyz = (-u_xlat8.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat16_7.xyz) * u_xlat9.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat5.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat7.x : u_xlat5.x;
					        hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat7.y : u_xlat5.y;
					        hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat7.z : u_xlat5.z;
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat31 = u_xlat10_5.w * _ColorRTAlpha;
					    u_xlat5.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat31) * u_xlat5.xyz + u_xlat8.xyz;
					    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
					    u_xlat10_31 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_31 = max(u_xlat10_31, 0.0);
					    u_xlat31 = min(u_xlat16_31, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_32 = texture(_Specular, u_xlat6.xy).x;
					    u_xlat32 = u_xlat10_32 + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat32 = dot(u_xlat6.xy, vec2(u_xlat32));
					    u_xlat32 = max(u_xlat32, 0.0);
					    u_xlat32 = min(u_xlat32, _MaxOriginalSpecular);
					    u_xlat31 = u_xlat31 + u_xlat32;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
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
					    u_xlat7.xyz = vs_TEXCOORD4.xyz + (-_LightPositionRange.xyz);
					    u_xlat22 = max(abs(u_xlat7.y), abs(u_xlat7.x));
					    u_xlat22 = max(abs(u_xlat7.z), u_xlat22);
					    u_xlat22 = u_xlat22 + (-_LightProjectionParams.z);
					    u_xlat22 = max(u_xlat22, 9.99999975e-06);
					    u_xlat22 = u_xlat22 * _LightProjectionParams.w;
					    u_xlat22 = _LightProjectionParams.y / u_xlat22;
					    u_xlat22 = u_xlat22 + (-_LightProjectionParams.x);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    vec4 txVec0 = vec4(u_xlat7.xyz,u_xlat22);
					    u_xlat10_22 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat32 = (-_LightShadowData.x) + 1.0;
					    u_xlat22 = u_xlat10_22 * u_xlat32 + _LightShadowData.x;
					    u_xlat12.x = (-u_xlat22) + u_xlat12.x;
					    u_xlat2.x = u_xlat2.x * u_xlat12.x + u_xlat22;
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat10_12 = texture(_LightTextureB0, u_xlat12.xx).x;
					    u_xlat10_22 = texture(_LightTexture0, u_xlat6.xyz).w;
					    u_xlat16_12 = u_xlat10_22 * u_xlat10_12;
					    u_xlat2.x = u_xlat2.x * u_xlat16_12;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat12.x = inversesqrt(u_xlat12.x);
					    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat10.x = u_xlat0.x + u_xlat0.x;
					    u_xlat10.x = u_xlat0.x * u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * u_xlat31 + -0.5;
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
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat4.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * u_xlat10.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat31 = u_xlat0.x * u_xlat0.x;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat0.x = u_xlat0.x * u_xlat31;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _LightTextureB0;
					layout(location = 12) uniform  samplerCube _LightTexture0;
					layout(location = 13) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 14) uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bvec3 u_xlatb6;
					vec4 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					float u_xlat16_12;
					float u_xlat10_12;
					bool u_xlatb12;
					float u_xlat20;
					float u_xlat22;
					float u_xlat10_22;
					bool u_xlatb22;
					float u_xlat30;
					float u_xlat31;
					float u_xlat16_31;
					float u_xlat10_31;
					float u_xlat32;
					float u_xlat10_32;
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
					    u_xlat4.xyz = texture(_TextureSample1, u_xlat4.xy).xyw;
					    u_xlat4.x = u_xlat4.z * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat31 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat31 = min(u_xlat31, 1.0);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat4.z = sqrt(u_xlat31);
					    u_xlat10_5 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_6 = texture(_TextureSample0, u_xlat6.xy);
					    u_xlat6 = u_xlat10_6 + vec4(_Diffuse_Brightness);
					    u_xlat7.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat8.x = dot(u_xlat7.xy, u_xlat6.xw);
					    u_xlat8.y = dot(u_xlat7.xy, u_xlat6.yw);
					    u_xlat8.z = dot(u_xlat7.xy, u_xlat6.zw);
					    u_xlatb6.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_5.xyzx).xyz;
					    u_xlat16_7.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat9.xyz = (-u_xlat8.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat16_7.xyz) * u_xlat9.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat5.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat7.x : u_xlat5.x;
					        hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat7.y : u_xlat5.y;
					        hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat7.z : u_xlat5.z;
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat31 = u_xlat10_5.w * _ColorRTAlpha;
					    u_xlat5.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat31) * u_xlat5.xyz + u_xlat8.xyz;
					    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
					    u_xlat10_31 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_31 = max(u_xlat10_31, 0.0);
					    u_xlat31 = min(u_xlat16_31, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_32 = texture(_Specular, u_xlat6.xy).x;
					    u_xlat32 = u_xlat10_32 + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat32 = dot(u_xlat6.xy, vec2(u_xlat32));
					    u_xlat32 = max(u_xlat32, 0.0);
					    u_xlat32 = min(u_xlat32, _MaxOriginalSpecular);
					    u_xlat31 = u_xlat31 + u_xlat32;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
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
					    u_xlat10_12 = texture(_LightTextureB0, u_xlat12.xx).x;
					    u_xlat10_22 = texture(_LightTexture0, u_xlat6.xyz).w;
					    u_xlat16_12 = u_xlat10_22 * u_xlat10_12;
					    u_xlat2.x = u_xlat2.x * u_xlat16_12;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat12.x = inversesqrt(u_xlat12.x);
					    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat10.x = u_xlat0.x + u_xlat0.x;
					    u_xlat10.x = u_xlat0.x * u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * u_xlat31 + -0.5;
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
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat4.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * u_xlat10.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat31 = u_xlat0.x * u_xlat0.x;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat0.x = u_xlat0.x * u_xlat31;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 _LightPositionRange;
						vec4 _LightProjectionParams;
						vec4 unused_2_3[43];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_5;
					};
					layout(binding = 3, std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _TextureSample1;
					layout(location = 7) uniform  sampler2D _ColorRT;
					layout(location = 8) uniform  sampler2D _TextureSample0;
					layout(location = 9) uniform  sampler2D _WetnessRT;
					layout(location = 10) uniform  sampler2D _Specular;
					layout(location = 11) uniform  sampler2D _LightTextureB0;
					layout(location = 12) uniform  samplerCube _LightTexture0;
					layout(location = 13) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 14) uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bvec3 u_xlatb6;
					vec4 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					float u_xlat11;
					vec3 u_xlat12;
					float u_xlat16_12;
					float u_xlat10_12;
					bool u_xlatb12;
					float u_xlat20;
					float u_xlat22;
					float u_xlat10_22;
					bool u_xlatb22;
					float u_xlat30;
					float u_xlat31;
					float u_xlat16_31;
					float u_xlat10_31;
					float u_xlat32;
					float u_xlat10_32;
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
					    u_xlat4.xyz = texture(_TextureSample1, u_xlat4.xy).xyw;
					    u_xlat4.x = u_xlat4.z * u_xlat4.x;
					    u_xlat4.xy = u_xlat4.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat4.xy = u_xlat4.xy * vec2(_NormalValue);
					    u_xlat31 = dot(u_xlat4.xy, u_xlat4.xy);
					    u_xlat31 = min(u_xlat31, 1.0);
					    u_xlat31 = (-u_xlat31) + 1.0;
					    u_xlat4.z = sqrt(u_xlat31);
					    u_xlat10_5 = texture(_ColorRT, vs_TEXCOORD0.xy);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_6 = texture(_TextureSample0, u_xlat6.xy);
					    u_xlat6 = u_xlat10_6 + vec4(_Diffuse_Brightness);
					    u_xlat7.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat8.x = dot(u_xlat7.xy, u_xlat6.xw);
					    u_xlat8.y = dot(u_xlat7.xy, u_xlat6.yw);
					    u_xlat8.z = dot(u_xlat7.xy, u_xlat6.zw);
					    u_xlatb6.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_5.xyzx).xyz;
					    u_xlat16_7.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_7.xyz = (-u_xlat16_7.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat9.xyz = (-u_xlat8.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat7.xyz = (-u_xlat16_7.xyz) * u_xlat9.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat5.xyz = u_xlat10_5.xyz * u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat5.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat5;
					        hlslcc_movcTemp.x = (u_xlatb6.x) ? u_xlat7.x : u_xlat5.x;
					        hlslcc_movcTemp.y = (u_xlatb6.y) ? u_xlat7.y : u_xlat5.y;
					        hlslcc_movcTemp.z = (u_xlatb6.z) ? u_xlat7.z : u_xlat5.z;
					        u_xlat5 = hlslcc_movcTemp;
					    }
					    u_xlat31 = u_xlat10_5.w * _ColorRTAlpha;
					    u_xlat5.xyz = (-u_xlat8.xyz) + u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat31) * u_xlat5.xyz + u_xlat8.xyz;
					    u_xlat5.xyz = clamp(u_xlat5.xyz, 0.0, 1.0);
					    u_xlat10_31 = texture(_WetnessRT, vs_TEXCOORD0.xy).w;
					    u_xlat16_31 = max(u_xlat10_31, 0.0);
					    u_xlat31 = min(u_xlat16_31, _FluidShininess);
					    u_xlat6.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_32 = texture(_Specular, u_xlat6.xy).x;
					    u_xlat32 = u_xlat10_32 + _Spec_Brightness;
					    u_xlat6.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat32 = dot(u_xlat6.xy, vec2(u_xlat32));
					    u_xlat32 = max(u_xlat32, 0.0);
					    u_xlat32 = min(u_xlat32, _MaxOriginalSpecular);
					    u_xlat31 = u_xlat31 + u_xlat32;
					    u_xlat31 = clamp(u_xlat31, 0.0, 1.0);
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
					    u_xlat10_12 = texture(_LightTextureB0, u_xlat12.xx).x;
					    u_xlat10_22 = texture(_LightTexture0, u_xlat6.xyz).w;
					    u_xlat16_12 = u_xlat10_22 * u_xlat10_12;
					    u_xlat2.x = u_xlat2.x * u_xlat16_12;
					    u_xlat6.x = dot(vs_TEXCOORD1.xyz, u_xlat4.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD2.xyz, u_xlat4.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD3.xyz, u_xlat4.xyz);
					    u_xlat12.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat12.x = inversesqrt(u_xlat12.x);
					    u_xlat12.xyz = u_xlat12.xxx * u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat2.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
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
					    u_xlat10.x = u_xlat0.x + u_xlat0.x;
					    u_xlat10.x = u_xlat0.x * u_xlat10.x;
					    u_xlat10.x = u_xlat10.x * u_xlat31 + -0.5;
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
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat4.xyz;
					    u_xlat10.xyz = u_xlat4.xyz * u_xlat10.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat31 = u_xlat0.x * u_xlat0.x;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat0.x = u_xlat0.x * u_xlat31;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat10.xyz;
					    SV_Target0.xyz = u_xlat5.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						float _NormalValue;
						vec4 _TextureSample1_ST;
						float _DifContrast;
						vec4 _TextureSample0_ST;
						float _Diffuse_Brightness;
						float _ColorRTAlpha;
						float _FluidShininess;
						float _Spec_Contrast;
						vec4 _Specular_ST;
						float _Spec_Brightness;
						float _MaxOriginalSpecular;
						vec4 unused_0_15[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(binding = 3, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 4) uniform  sampler2D _TextureSample1;
					layout(location = 5) uniform  sampler2D _ColorRT;
					layout(location = 6) uniform  sampler2D _TextureSample0;
					layout(location = 7) uniform  sampler2D _WetnessRT;
					layout(location = 8) uniform  sampler2D _Specular;
					layout(location = 9) uniform  sampler2D _LightTexture0;
					layout(location = 10) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec4 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec3 u_xlatb5;
					vec4 u_xlat6;
					vec3 u_xlat16_6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					float u_xlat10;
					float u_xlat11;
					float u_xlat18;
					float u_xlat27;
					float u_xlat28;
					float u_xlat16_28;
					float u_xlat10_28;
					float u_xlat29;
					float u_xlat10_29;
					bool u_xlatb29;
					float u_xlat30;
					float u_xlat10_30;
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
					    u_xlat3.xyz = texture(_TextureSample1, u_xlat3.xy).xyw;
					    u_xlat3.x = u_xlat3.z * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat3.xy = u_xlat3.xy * vec2(_NormalValue);
					    u_xlat28 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat28 = min(u_xlat28, 1.0);
					    u_xlat28 = (-u_xlat28) + 1.0;
					    u_xlat3.z = sqrt(u_xlat28);
					    u_xlat10_4 = texture(_ColorRT, vs_TEXCOORD0.zw);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
					    u_xlat10_5 = texture(_TextureSample0, u_xlat5.xy);
					    u_xlat5 = u_xlat10_5 + vec4(_Diffuse_Brightness);
					    u_xlat6.xy = vec2(_DifContrast) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat7.x = dot(u_xlat6.xy, u_xlat5.xw);
					    u_xlat7.y = dot(u_xlat6.xy, u_xlat5.yw);
					    u_xlat7.z = dot(u_xlat6.xy, u_xlat5.zw);
					    u_xlatb5.xyz = lessThan(vec4(0.5, 0.5, 0.5, 0.0), u_xlat10_4.xyzx).xyz;
					    u_xlat16_6.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_6.xyz = (-u_xlat16_6.xyz) * vec3(2.0, 2.0, 2.0) + vec3(1.0, 1.0, 1.0);
					    u_xlat8.xyz = (-u_xlat7.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat6.xyz = (-u_xlat16_6.xyz) * u_xlat8.xyz + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat10_4.xyz * u_xlat7.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat4.xyz;
					    {
					        vec3 hlslcc_movcTemp = u_xlat4;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? u_xlat6.x : u_xlat4.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? u_xlat6.y : u_xlat4.y;
					        hlslcc_movcTemp.z = (u_xlatb5.z) ? u_xlat6.z : u_xlat4.z;
					        u_xlat4 = hlslcc_movcTemp;
					    }
					    u_xlat28 = u_xlat10_4.w * _ColorRTAlpha;
					    u_xlat4.xyz = (-u_xlat7.xyz) + u_xlat4.xyz;
					    u_xlat4.xyz = vec3(u_xlat28) * u_xlat4.xyz + u_xlat7.xyz;
					    u_xlat4.xyz = clamp(u_xlat4.xyz, 0.0, 1.0);
					    u_xlat10_28 = texture(_WetnessRT, vs_TEXCOORD0.zw).w;
					    u_xlat16_28 = max(u_xlat10_28, 0.0);
					    u_xlat28 = min(u_xlat16_28, _FluidShininess);
					    u_xlat5.xy = vs_TEXCOORD0.xy * _Specular_ST.xy + _Specular_ST.zw;
					    u_xlat10_29 = texture(_Specular, u_xlat5.xy).x;
					    u_xlat29 = u_xlat10_29 + _Spec_Brightness;
					    u_xlat5.xy = vec2(vec2(_Spec_Contrast, _Spec_Contrast)) * vec2(1.0, -0.5) + vec2(0.0, 0.5);
					    u_xlat29 = dot(u_xlat5.xy, vec2(u_xlat29));
					    u_xlat29 = max(u_xlat29, 0.0);
					    u_xlat29 = min(u_xlat29, _MaxOriginalSpecular);
					    u_xlat28 = u_xlat28 + u_xlat29;
					    u_xlat28 = clamp(u_xlat28, 0.0, 1.0);
					    u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb29 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb29){
					        u_xlatb29 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb29)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat29 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat30 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat29, u_xlat30);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat29 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat29 = clamp(u_xlat29, 0.0, 1.0);
					    u_xlat30 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_30 = texture(_LightTexture0, vec2(u_xlat30)).x;
					    u_xlat29 = u_xlat29 * u_xlat10_30;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat29) * _LightColor0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.779083729, 0.779083729, 0.779083729);
					    u_xlat28 = (-u_xlat28) + 1.0;
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
					    u_xlat9.x = u_xlat0.x + u_xlat0.x;
					    u_xlat9.x = u_xlat0.x * u_xlat9.x;
					    u_xlat9.x = u_xlat9.x * u_xlat28 + -0.5;
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
					    u_xlat18 = u_xlat28 * u_xlat28;
					    u_xlat18 = max(u_xlat18, 0.00200000009);
					    u_xlat1.x = (-u_xlat18) + 1.0;
					    u_xlat10 = abs(u_xlat27) * u_xlat1.x + u_xlat18;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat18;
					    u_xlat27 = abs(u_xlat27) * u_xlat1.x;
					    u_xlat27 = u_xlat2.x * u_xlat10 + u_xlat27;
					    u_xlat27 = u_xlat27 + 9.99999975e-06;
					    u_xlat27 = 0.5 / u_xlat27;
					    u_xlat18 = u_xlat18 * u_xlat18;
					    u_xlat1.x = u_xlat11 * u_xlat18 + (-u_xlat11);
					    u_xlat1.x = u_xlat1.x * u_xlat11 + 1.0;
					    u_xlat18 = u_xlat18 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat18 = u_xlat18 / u_xlat1.x;
					    u_xlat18 = u_xlat18 * u_xlat27;
					    u_xlat18 = u_xlat18 * 3.14159274;
					    u_xlat18 = max(u_xlat18, 9.99999975e-05);
					    u_xlat9.y = sqrt(u_xlat18);
					    u_xlat9.xy = u_xlat2.xx * u_xlat9.xy;
					    u_xlat1.xyz = u_xlat9.xxx * u_xlat5.xyz;
					    u_xlat9.xyz = u_xlat5.xyz * u_xlat9.yyy;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat28 = u_xlat0.x * u_xlat0.x;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat0.x = u_xlat0.x * u_xlat28;
					    u_xlat0.x = u_xlat0.x * 0.779083729 + 0.220916301;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat9.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "ShadowCaster"
			Tags { "LIGHTMODE" = "SHADOWCASTER" "QUEUE" = "Geometry+0" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 145128
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(binding = 1, std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 0) out vec3 vs_TEXCOORD1;
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
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(binding = 1, std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 0) out vec3 vs_TEXCOORD1;
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
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(binding = 1, std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 0) out vec3 vs_TEXCOORD1;
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
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(binding = 1, std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 0) out vec3 vs_TEXCOORD1;
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
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(binding = 1, std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(binding = 3, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 4, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 0) out vec3 vs_TEXCOORD1;
					layout(location = 1) flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].xyz * in_POSITION0.zzz + u_xlat3.xyz;
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat3.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)] * in_POSITION0.wwww + u_xlat1;
					    u_xlatb3 = unity_LightShadowBias.z!=0.0;
					    if(u_xlatb3){
					        u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					        u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					        u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					        u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					        u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					        u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat9 = inversesqrt(u_xlat9);
					        u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					        u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					        u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					        u_xlat9 = sqrt(u_xlat9);
					        u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					        u_xlat1.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    //ENDIF
					    }
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat6 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat6);
					    u_xlat1.x = (-u_xlat6) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat6;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "INSTANCING_ON" "SHADOWS_CUBE" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(binding = 1, std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(binding = 3, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 4, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 0) out vec3 vs_TEXCOORD1;
					layout(location = 1) flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].xyz * in_POSITION0.zzz + u_xlat3.xyz;
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat3.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)] * in_POSITION0.wwww + u_xlat1;
					    u_xlatb3 = unity_LightShadowBias.z!=0.0;
					    if(u_xlatb3){
					        u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					        u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					        u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					        u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					        u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					        u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat9 = inversesqrt(u_xlat9);
					        u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					        u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					        u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					        u_xlat9 = sqrt(u_xlat9);
					        u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					        u_xlat1.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    //ENDIF
					    }
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "INSTANCING_ON" "SHADOWS_CUBE" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(binding = 1, std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(binding = 3, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 4, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 0) out vec3 vs_TEXCOORD1;
					layout(location = 1) flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].xyz * in_POSITION0.zzz + u_xlat3.xyz;
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat3.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)] * in_POSITION0.wwww + u_xlat1;
					    u_xlatb3 = unity_LightShadowBias.z!=0.0;
					    if(u_xlatb3){
					        u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					        u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					        u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					        u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					        u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					        u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat9 = inversesqrt(u_xlat9);
					        u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					        u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					        u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					        u_xlat9 = sqrt(u_xlat9);
					        u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					        u_xlat1.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    //ENDIF
					    }
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = min(u_xlat0.w, u_xlat0.z);
					    u_xlat1.x = (-u_xlat0.z) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat0.z;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" "_USEUV2_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_0_1[47];
					};
					layout(binding = 1, std140) uniform UnityShadows {
						vec4 unused_1_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_1_2[20];
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(binding = 3, std140) uniform UnityDrawCallInfo {
						int unity_BaseInstanceID;
					};
					struct unity_Builtins0Array_Type {
						mat4x4 unity_Builtins0Array.unity_ObjectToWorldArray;
						mat4x4 unity_Builtins0Array.unity_WorldToObjectArray;
					};
					layout(binding = 4, std140) uniform UnityInstancing_PerDraw0 {
						unity_Builtins0Array_Type unity_Builtins0Array;
						vec4 unused_4_1[16];
					};
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 0) out vec3 vs_TEXCOORD1;
					layout(location = 1) flat out uint vs_SV_InstanceID0;
					vec4 u_xlat0;
					int u_xlati0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
					    u_xlati0 = u_xlati0 << 3;
					    u_xlat3.xyz = in_POSITION0.yyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)].xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0].xyz * in_POSITION0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)].xyz * in_POSITION0.zzz + u_xlat3.xyz;
					    vs_TEXCOORD1.xyz = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)].xyz * in_POSITION0.www + u_xlat3.xyz;
					    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 1)];
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[u_xlati0] * in_POSITION0.xxxx + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 2)] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat1 = unity_Builtins0Array.unity_Builtins0Array.unity_ObjectToWorldArray[(u_xlati0 + 3)] * in_POSITION0.wwww + u_xlat1;
					    u_xlatb3 = unity_LightShadowBias.z!=0.0;
					    if(u_xlatb3){
					        u_xlat2.x = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[u_xlati0].xyz);
					        u_xlat2.y = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 1)].xyz);
					        u_xlat2.z = dot(in_NORMAL0.xyz, unity_Builtins0Array.unity_Builtins0Array.unity_WorldToObjectArray[(u_xlati0 + 2)].xyz);
					        u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat0.x = inversesqrt(u_xlat0.x);
					        u_xlat0.xyz = u_xlat0.xxx * u_xlat2.xyz;
					        u_xlat2.xyz = (-u_xlat1.xyz) * _WorldSpaceLightPos0.www + _WorldSpaceLightPos0.xyz;
					        u_xlat9 = dot(u_xlat2.xyz, u_xlat2.xyz);
					        u_xlat9 = inversesqrt(u_xlat9);
					        u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					        u_xlat9 = dot(u_xlat0.xyz, u_xlat2.xyz);
					        u_xlat9 = (-u_xlat9) * u_xlat9 + 1.0;
					        u_xlat9 = sqrt(u_xlat9);
					        u_xlat9 = u_xlat9 * unity_LightShadowBias.z;
					        u_xlat1.xyz = (-u_xlat0.xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    //ENDIF
					    }
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.x = unity_LightShadowBias.x / u_xlat0.w;
					    u_xlat1.x = min(u_xlat1.x, 0.0);
					    u_xlat1.x = max(u_xlat1.x, -1.0);
					    u_xlat6 = u_xlat0.z + u_xlat1.x;
					    u_xlat1.x = min(u_xlat0.w, u_xlat6);
					    u_xlat1.x = (-u_xlat6) + u_xlat1.x;
					    gl_Position.z = unity_LightShadowBias.y * u_xlat1.x + u_xlat6;
					    gl_Position.xyw = u_xlat0.xyw;
					    vs_SV_InstanceID0 = uint(gl_InstanceID);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "INSTANCING_ON" "SHADOWS_CUBE" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "INSTANCING_ON" "SHADOWS_CUBE" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "INSTANCING_ON" "SHADOWS_DEPTH" "_USEUV2_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
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
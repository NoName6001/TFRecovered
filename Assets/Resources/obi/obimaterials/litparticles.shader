Shader "Particles/Alpha Blended Premultiply Lit" {
	Properties {
		_MainTex ("Particle Texture", 2D) = "white" {}
		_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 24083
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
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
					uniform  sampler2D _ShadowMapTexture;
					in  vec4 in_POSITION0;
					in  vec4 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec3 vs_COLOR1;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
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
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat0 = textureLod(_ShadowMapTexture, u_xlat1.xy, 0.0);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.x = u_xlat1.y * u_xlat1.y;
					    u_xlat4.x = u_xlat1.x * u_xlat1.x + (-u_xlat4.x);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat4.xyz = unity_SHC.xyz * u_xlat4.xxx + u_xlat3.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat1);
					    u_xlat2.y = dot(unity_SHAg, u_xlat1);
					    u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat2.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    vs_COLOR1.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
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
					uniform  sampler2D _ShadowMapTexture;
					in  vec4 in_POSITION0;
					in  vec4 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec3 vs_COLOR1;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
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
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat0 = textureLod(_ShadowMapTexture, u_xlat1.xy, 0.0);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.x = u_xlat1.y * u_xlat1.y;
					    u_xlat4.x = u_xlat1.x * u_xlat1.x + (-u_xlat4.x);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat4.xyz = unity_SHC.xyz * u_xlat4.xxx + u_xlat3.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat1);
					    u_xlat2.y = dot(unity_SHAg, u_xlat1);
					    u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat2.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    vs_COLOR1.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
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
					uniform  sampler2D _ShadowMapTexture;
					in  vec4 in_POSITION0;
					in  vec4 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec3 vs_COLOR1;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
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
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat0 = textureLod(_ShadowMapTexture, u_xlat1.xy, 0.0);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.x = u_xlat1.y * u_xlat1.y;
					    u_xlat4.x = u_xlat1.x * u_xlat1.x + (-u_xlat4.x);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat4.xyz = unity_SHC.xyz * u_xlat4.xxx + u_xlat3.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat1);
					    u_xlat2.y = dot(unity_SHAg, u_xlat1);
					    u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat2.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    vs_COLOR1.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2[2];
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
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
					uniform  sampler2D _ShadowMapTexture;
					in  vec4 in_POSITION0;
					in  vec4 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec3 vs_COLOR1;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
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
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_COLOR0 = in_COLOR0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    u_xlat0.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    vs_TEXCOORD1 = u_xlat0;
					    u_xlat0 = textureLod(_ShadowMapTexture, u_xlat1.xy, 0.0);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat4.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4.x = inversesqrt(u_xlat4.x);
					    u_xlat1.xyz = u_xlat4.xxx * u_xlat1.xyz;
					    u_xlat4.x = u_xlat1.y * u_xlat1.y;
					    u_xlat4.x = u_xlat1.x * u_xlat1.x + (-u_xlat4.x);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat4.xyz = unity_SHC.xyz * u_xlat4.xxx + u_xlat3.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat1);
					    u_xlat2.y = dot(unity_SHAg, u_xlat1);
					    u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    u_xlat1.x = dot(u_xlat1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat2.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    vs_COLOR1.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat4.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
					
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec3 vs_COLOR1;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat10_1;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.xyz * vs_COLOR1.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.w = vs_COLOR0.w;
					    u_xlat0 = u_xlat0 * u_xlat10_1;
					    SV_Target0 = u_xlat0 * vs_COLOR0.wwww;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec3 vs_COLOR1;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat10_1;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.xyz * vs_COLOR1.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.w = vs_COLOR0.w;
					    u_xlat0 = u_xlat0 * u_xlat10_1;
					    SV_Target0 = u_xlat0 * vs_COLOR0.wwww;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec3 vs_COLOR1;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat10_1;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.xyz * vs_COLOR1.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.w = vs_COLOR0.w;
					    u_xlat0 = u_xlat0 * u_xlat10_1;
					    SV_Target0 = u_xlat0 * vs_COLOR0.wwww;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec3 vs_COLOR1;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat10_1;
					void main()
					{
					    u_xlat0.xyz = vs_COLOR0.xyz * vs_COLOR1.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.w = vs_COLOR0.w;
					    u_xlat0 = u_xlat0 * u_xlat10_1;
					    SV_Target0 = u_xlat0 * vs_COLOR0.wwww;
					    return;
					}"
				}
			}
		}
		UsePass "Legacy Shaders/VertexLit/SHADOWCASTER"
	}
}
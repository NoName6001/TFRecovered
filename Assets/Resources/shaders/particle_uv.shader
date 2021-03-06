Shader "Particle_UV" {
	Properties {
		_TintColor ("Tint Color", Vector) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One Zero, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 51584
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SOFTPARTICLES_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[5];
						vec4 _ProjectionParams;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_2_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    u_xlat2 = u_xlat0.y * unity_MatrixV[1].z;
					    u_xlat0.x = unity_MatrixV[0].z * u_xlat0.x + u_xlat2;
					    u_xlat0.x = unity_MatrixV[2].z * u_xlat0.z + u_xlat0.x;
					    u_xlat0.x = unity_MatrixV[3].z * u_xlat0.w + u_xlat0.x;
					    vs_TEXCOORD2.z = (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD2.w = u_xlat1.w;
					    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
						vec4 unused_0_0[2];
						vec4 _TintColor;
						vec4 _MainTex_ST;
						vec4 unused_0_3;
					};
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec4 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec2 u_xlat1;
					vec4 u_xlat10_1;
					void main()
					{
					    u_xlat0 = vs_COLOR0 + vs_COLOR0;
					    u_xlat0 = u_xlat0 * _TintColor;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
					    SV_Target0 = u_xlat0 * u_xlat10_1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SOFTPARTICLES_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TintColor;
						vec4 _MainTex_ST;
						float _InvFade;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[7];
						vec4 _ZBufferParams;
						vec4 unused_1_2;
					};
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _MainTex;
					in  vec4 vs_COLOR0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat10_0;
					vec2 u_xlat1;
					vec4 u_xlat10_1;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_0 = texture(_CameraDepthTexture, u_xlat0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.x = u_xlat0.x + (-vs_TEXCOORD2.z);
					    u_xlat0.x = u_xlat0.x * _InvFade;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.w = u_xlat0.x * vs_COLOR0.w;
					    u_xlat0.xyz = vs_COLOR0.xyz;
					    u_xlat0 = u_xlat0 + u_xlat0;
					    u_xlat0 = u_xlat0 * _TintColor;
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
					    SV_Target0 = u_xlat0 * u_xlat10_1;
					    return;
					}"
				}
			}
		}
	}
	CustomEditor "ASEMaterialInspector"
}
Shader "Obi/DistanceFieldSlice" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader {
		LOD 100
		Tags { "RenderType" = "Opaque" }
		Pass {
			LOD 100
			Tags { "RenderType" = "Opaque" }
			Cull Off
			GpuProgramID 28876
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
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
					
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					vec4 u_xlat10_0;
					float u_xlat1;
					float u_xlat2;
					float u_xlat4;
					float u_xlat6;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0 = u_xlat10_0.x + -0.5;
					    u_xlat2 = dFdx(u_xlat0);
					    u_xlat4 = dFdy(u_xlat0);
					    u_xlat2 = abs(u_xlat4) + abs(u_xlat2);
					    u_xlat4 = u_xlat2 + u_xlat0;
					    u_xlat2 = u_xlat2 + u_xlat2;
					    u_xlat2 = float(1.0) / u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat4;
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat4 = u_xlat2 * -2.0 + 3.0;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat4;
					    u_xlat4 = abs(u_xlat0) * 40.0;
					    u_xlat0 = -abs(u_xlat0) + 1.0;
					    u_xlat4 = sin(u_xlat4);
					    u_xlat6 = dFdx(u_xlat4);
					    u_xlat1 = dFdy(u_xlat4);
					    u_xlat6 = abs(u_xlat6) + abs(u_xlat1);
					    u_xlat4 = u_xlat6 + u_xlat4;
					    u_xlat6 = u_xlat6 + u_xlat6;
					    u_xlat6 = float(1.0) / u_xlat6;
					    u_xlat4 = u_xlat6 * u_xlat4;
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat6 = u_xlat4 * -2.0 + 3.0;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat6;
					    u_xlat4 = u_xlat4 * 0.150000006 + 0.850000024;
					    u_xlat0 = u_xlat4 * u_xlat0;
					    SV_Target0.yz = vec2(u_xlat2) * vec2(u_xlat0);
					    SV_Target0.x = u_xlat0;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}
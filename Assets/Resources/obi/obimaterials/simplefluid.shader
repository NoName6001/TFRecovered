Shader "Obi/Fluid/Simple2DFluid" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_RefractionCoeff ("Refraction", Range(-0.1, 0.1)) = 0.01
		_Color ("Fluid color", Vector) = (0.3,0.6,1,1)
	}
	SubShader {
		Pass {
			Name "SimpleFluid"
			Tags { "LIGHTMODE" = "FORWARDBASE" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			GpuProgramID 46312
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
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[7];
						vec4 _Color;
						float _RefractionCoeff;
						float _ThicknessCutoff;
					};
					uniform  sampler2D _Thickness;
					uniform  sampler2D _Refraction;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat10_0;
					bool u_xlatb0;
					void main()
					{
					    u_xlat10_0 = texture(_Thickness, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat10_0.w * 10.0;
					    u_xlatb0 = u_xlat0.x<_ThicknessCutoff;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.xy = vec2(_RefractionCoeff) * u_xlat10_0.ww + vs_TEXCOORD0.xy;
					    u_xlat10_0 = texture(_Refraction, u_xlat0.xy);
					    SV_Target0 = u_xlat10_0 * _Color;
					    return;
					}"
				}
			}
		}
	}
}
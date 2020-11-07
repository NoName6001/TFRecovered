Shader "Custom/ShadowDrawer" {
	Properties {
		_Color ("Shadow Color", Vector) = (0,0,0,0.6)
		_ShadowBoost ("sShadow Boost", Float) = 1
	}
	SubShader {
		Tags { "QUEUE" = "AlphaTest+49" }
		Pass {
			Tags { "QUEUE" = "AlphaTest+49" }
			ColorMask 0 -1
			GpuProgramID 37209
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
					
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
		}
		Pass {
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest+49" "SHADOWSUPPORT" = "true" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			GpuProgramID 87520
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
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
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD1;
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
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
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
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD1;
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
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD1;
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
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
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
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD1;
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
					    u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD1.zw = u_xlat0.zw;
					    vs_TEXCOORD1.xy = u_xlat1.zz + u_xlat1.xw;
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
						vec4 _Color;
					};
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0.xyz = _Color.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 _Color;
					};
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0.xyz = _Color.xyz;
					    SV_Target0.w = 0.0;
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
						vec4 _Color;
					};
					uniform  sampler2D _ShadowMapTexture;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat10_0;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy);
					    SV_Target0.w = u_xlat10_0.x * (-_Color.w) + _Color.w;
					    SV_Target0.xyz = _Color.xyz;
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
						vec4 _Color;
					};
					uniform  sampler2D _ShadowMapTexture;
					in  vec4 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat10_0;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD1.xy / vs_TEXCOORD1.ww;
					    u_xlat10_0 = texture(_ShadowMapTexture, u_xlat0.xy);
					    SV_Target0.w = u_xlat10_0.x * (-_Color.w) + _Color.w;
					    SV_Target0.xyz = _Color.xyz;
					    return;
					}"
				}
			}
		}
		Pass {
			Tags { "LIGHTMODE" = "FORWARDADD" "QUEUE" = "AlphaTest+49" "SHADOWSUPPORT" = "true" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			GpuProgramID 187516
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
						vec4 unused_0_2[4];
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
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD2 = u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
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
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
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
						vec4 unused_0_2[4];
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
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD2 = u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD0 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
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
						vec4 unused_0_2[4];
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
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD2 = u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_2[4];
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
					out vec4 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD2 = u_xlat0;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD0.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
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
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[8];
						mat4x4 unity_WorldToShadow[4];
						vec4 unused_1_2[14];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD2 = u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD0 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					    u_xlat1 = unity_WorldToShadow[0 / 4][0 % 4] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToShadow[2 / 4][2 % 4] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD1 = unity_WorldToShadow[3 / 4][3 % 4] * u_xlat0.wwww + u_xlat1;
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
						vec4 unused_0_0[7];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_1_0[8];
						mat4x4 unity_WorldToShadow[4];
						vec4 unused_1_2[14];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD2 = u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD0 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					    u_xlat1 = unity_WorldToShadow[0 / 4][0 % 4] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToShadow[2 / 4][2 % 4] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD1 = unity_WorldToShadow[3 / 4][3 % 4] * u_xlat0.wwww + u_xlat1;
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
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0;
						vec4 _LightPositionRange;
						vec4 unused_1_2[46];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD2 = u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
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
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0;
						vec4 _LightPositionRange;
						vec4 unused_1_2[46];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD2 = u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
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
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0;
						vec4 _LightPositionRange;
						vec4 unused_1_2[46];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD2 = u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
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
						vec4 unused_0_0[2];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0;
						vec4 _LightPositionRange;
						vec4 unused_1_2[46];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD2 = u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD0.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz + (-_LightPositionRange.xyz);
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
						vec4 _Color;
						vec4 unused_0_3[2];
						float _ShadowBoost;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat0.xyz = u_xlat0.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat0.yzw = u_xlat0.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat2.x = u_xlat0.y * 0.25 + 0.75;
					        u_xlat1 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat0.x = max(u_xlat2.x, u_xlat1);
					        u_xlat0 = texture(unity_ProbeVolumeSH, u_xlat0.xzw);
					    } else {
					        u_xlat0.x = float(1.0);
					        u_xlat0.y = float(1.0);
					        u_xlat0.z = float(1.0);
					        u_xlat0.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat0.x = dot(u_xlat0, unity_OcclusionMaskSelector);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10_1 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat2.x = u_xlat10_1.x * _ShadowBoost;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _Color.w;
					    SV_Target0.w = u_xlat2.x * u_xlat0.x;
					    SV_Target0.xyz = _Color.xyz;
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
						vec4 _Color;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat0.xyz = u_xlat0.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat0.yzw = u_xlat0.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat2.x = u_xlat0.y * 0.25 + 0.75;
					        u_xlat1 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat0.x = max(u_xlat2.x, u_xlat1);
					        u_xlat0 = texture(unity_ProbeVolumeSH, u_xlat0.xzw);
					    } else {
					        u_xlat0.x = float(1.0);
					        u_xlat0.y = float(1.0);
					        u_xlat0.z = float(1.0);
					        u_xlat0.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat0.x = dot(u_xlat0, unity_OcclusionMaskSelector);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    SV_Target0.w = u_xlat0.x * _Color.w;
					    SV_Target0.xyz = _Color.xyz;
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
						vec4 _Color;
						vec4 unused_0_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					bool u_xlatb3;
					vec2 u_xlat6;
					void main()
					{
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat0.xyz = u_xlat0.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat0.yzw = u_xlat0.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat3.x = u_xlat0.y * 0.25 + 0.75;
					        u_xlat1.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat0.x = max(u_xlat3.x, u_xlat1.x);
					        u_xlat0 = texture(unity_ProbeVolumeSH, u_xlat0.xzw);
					    } else {
					        u_xlat0.x = float(1.0);
					        u_xlat0.y = float(1.0);
					        u_xlat0.z = float(1.0);
					        u_xlat0.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat0.x = dot(u_xlat0, unity_OcclusionMaskSelector);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat1 = vs_TEXCOORD2.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + unity_WorldToLight[3];
					    u_xlatb3 = 0.0<u_xlat1.z;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
					    u_xlat10_2 = texture(_LightTexture0, u_xlat6.xy);
					    u_xlat3.x = u_xlat3.x * u_xlat10_2.w;
					    u_xlat6.x = dot(u_xlat1, u_xlat1);
					    u_xlat10_1 = texture(_LightTextureB0, u_xlat6.xx);
					    u_xlat3.x = u_xlat3.x * u_xlat10_1.x;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _Color.w;
					    SV_Target0.w = u_xlat3.x * u_xlat0.x;
					    SV_Target0.xyz = _Color.xyz;
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
						vec4 unused_0_0[6];
						vec4 _Color;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat0.xyz = u_xlat0.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat0.yzw = u_xlat0.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat2.x = u_xlat0.y * 0.25 + 0.75;
					        u_xlat1 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat0.x = max(u_xlat2.x, u_xlat1);
					        u_xlat0 = texture(unity_ProbeVolumeSH, u_xlat0.xzw);
					    } else {
					        u_xlat0.x = float(1.0);
					        u_xlat0.y = float(1.0);
					        u_xlat0.z = float(1.0);
					        u_xlat0.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat0.x = dot(u_xlat0, unity_OcclusionMaskSelector);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    SV_Target0.w = u_xlat0.x * _Color.w;
					    SV_Target0.xyz = _Color.xyz;
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
						vec4 unused_0_0[6];
						vec4 _Color;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					float u_xlat1;
					vec3 u_xlat2;
					void main()
					{
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat0.xyz = u_xlat0.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat0.yzw = u_xlat0.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat2.x = u_xlat0.y * 0.25 + 0.75;
					        u_xlat1 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat0.x = max(u_xlat2.x, u_xlat1);
					        u_xlat0 = texture(unity_ProbeVolumeSH, u_xlat0.xzw);
					    } else {
					        u_xlat0.x = float(1.0);
					        u_xlat0.y = float(1.0);
					        u_xlat0.z = float(1.0);
					        u_xlat0.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat0.x = dot(u_xlat0, unity_OcclusionMaskSelector);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    SV_Target0.w = u_xlat0.x * _Color.w;
					    SV_Target0.xyz = _Color.xyz;
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
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_3[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_2;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2D _ShadowMapTexture;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					bool u_xlatb3;
					vec2 u_xlat6;
					float u_xlat10_6;
					float u_xlat9;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = unity_MatrixV[0].z;
					    u_xlat1.y = unity_MatrixV[1].z;
					    u_xlat1.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat3.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat3.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlat3.x = (-u_xlat0.x) + u_xlat3.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat3.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb3 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb3){
					        u_xlatb3 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb3)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat3.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat6.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat6.x, u_xlat3.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat3.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
					    u_xlat1 = vs_TEXCOORD2.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					    u_xlat1 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD2.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD2.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + unity_WorldToShadow[3 / 4][3 % 4];
					    u_xlat1.xyz = u_xlat1.xyz / u_xlat1.www;
					    vec3 txVec0 = vec3(u_xlat1.xy,u_xlat1.z);
					    u_xlat10_6 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat9 = (-_LightShadowData.x) + 1.0;
					    u_xlat6.x = u_xlat10_6 * u_xlat9 + _LightShadowData.x;
					    u_xlat3.x = (-u_xlat6.x) + u_xlat3.x;
					    u_xlat0.x = u_xlat0.x * u_xlat3.x + u_xlat6.x;
					    u_xlat1 = vs_TEXCOORD2.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + unity_WorldToLight[3];
					    u_xlatb3 = 0.0<u_xlat1.z;
					    u_xlat3.x = u_xlatb3 ? 1.0 : float(0.0);
					    u_xlat6.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
					    u_xlat10_2 = texture(_LightTexture0, u_xlat6.xy);
					    u_xlat3.x = u_xlat3.x * u_xlat10_2.w;
					    u_xlat6.x = dot(u_xlat1, u_xlat1);
					    u_xlat10_1 = texture(_LightTextureB0, u_xlat6.xx);
					    u_xlat3.x = u_xlat3.x * u_xlat10_1.x;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _Color.w;
					    SV_Target0.w = u_xlat3.x * u_xlat0.x;
					    SV_Target0.xyz = _Color.xyz;
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
						vec4 unused_0_0[6];
						vec4 _ShadowMapTexture_TexelSize;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_4[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_2;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  sampler2DShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  sampler2D _ShadowMapTexture;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat7;
					float u_xlat10_7;
					vec2 u_xlat12;
					float u_xlat10_12;
					bool u_xlatb12;
					vec2 u_xlat16;
					float u_xlat18;
					float u_xlat10_18;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = unity_MatrixV[0].z;
					    u_xlat1.y = unity_MatrixV[1].z;
					    u_xlat1.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat6.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat6.x = sqrt(u_xlat6.x);
					    u_xlat6.x = (-u_xlat0.x) + u_xlat6.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat6.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb6 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb6){
					        u_xlatb6 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb6)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat6.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat12.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat12.x, u_xlat6.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat6.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat6.x = clamp(u_xlat6.x, 0.0, 1.0);
					    u_xlatb12 = u_xlat0.x<0.99000001;
					    if(u_xlatb12){
					        u_xlat1 = vs_TEXCOORD2.yyyy * unity_WorldToShadow[1 / 4][1 % 4];
					        u_xlat1 = unity_WorldToShadow[0 / 4][0 % 4] * vs_TEXCOORD2.xxxx + u_xlat1;
					        u_xlat1 = unity_WorldToShadow[2 / 4][2 % 4] * vs_TEXCOORD2.zzzz + u_xlat1;
					        u_xlat1 = u_xlat1 + unity_WorldToShadow[3 / 4][3 % 4];
					        u_xlat1.xyz = u_xlat1.xyz / u_xlat1.www;
					        u_xlat12.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + vec2(0.5, 0.5);
					        u_xlat12.xy = floor(u_xlat12.xy);
					        u_xlat1.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.zw + (-u_xlat12.xy);
					        u_xlat2 = u_xlat1.xxyy + vec4(0.5, 1.0, 0.5, 1.0);
					        u_xlat3.xw = u_xlat2.xz * u_xlat2.xz;
					        u_xlat2.xz = u_xlat3.xw * vec2(0.5, 0.5) + (-u_xlat1.xy);
					        u_xlat4.xy = (-u_xlat1.xy) + vec2(1.0, 1.0);
					        u_xlat16.xy = min(u_xlat1.xy, vec2(0.0, 0.0));
					        u_xlat4.xy = (-u_xlat16.xy) * u_xlat16.xy + u_xlat4.xy;
					        u_xlat1.xy = max(u_xlat1.xy, vec2(0.0, 0.0));
					        u_xlat1.xy = (-u_xlat1.xy) * u_xlat1.xy + u_xlat2.yw;
					        u_xlat5.x = u_xlat2.x;
					        u_xlat5.y = u_xlat4.x;
					        u_xlat5.z = u_xlat1.x;
					        u_xlat5.w = u_xlat3.x;
					        u_xlat5 = u_xlat5 * vec4(0.444440007, 0.444440007, 0.444440007, 0.222220004);
					        u_xlat3.x = u_xlat2.z;
					        u_xlat3.y = u_xlat4.y;
					        u_xlat3.z = u_xlat1.y;
					        u_xlat2 = u_xlat3 * vec4(0.444440007, 0.444440007, 0.444440007, 0.222220004);
					        u_xlat3 = u_xlat5.ywyw + u_xlat5.xzxz;
					        u_xlat4 = u_xlat2.yyww + u_xlat2.xxzz;
					        u_xlat1.xy = u_xlat5.yw / u_xlat3.zw;
					        u_xlat1.xy = u_xlat1.xy + vec2(-1.5, 0.5);
					        u_xlat2.xy = u_xlat2.yw / u_xlat4.yw;
					        u_xlat2.xy = u_xlat2.xy + vec2(-1.5, 0.5);
					        u_xlat5.xy = u_xlat1.xy * _ShadowMapTexture_TexelSize.xx;
					        u_xlat5.zw = u_xlat2.xy * _ShadowMapTexture_TexelSize.yy;
					        u_xlat2 = u_xlat3 * u_xlat4;
					        u_xlat3 = u_xlat12.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xzyz;
					        vec3 txVec0 = vec3(u_xlat3.xy,u_xlat1.z);
					        u_xlat10_1.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        vec3 txVec1 = vec3(u_xlat3.zw,u_xlat1.z);
					        u_xlat10_7 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat7 = u_xlat10_7 * u_xlat2.y;
					        u_xlat1.x = u_xlat2.x * u_xlat10_1.x + u_xlat7;
					        u_xlat3 = u_xlat12.xyxy * _ShadowMapTexture_TexelSize.xyxy + u_xlat5.xwyw;
					        vec3 txVec2 = vec3(u_xlat3.xy,u_xlat1.z);
					        u_xlat10_12 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat12.x = u_xlat2.z * u_xlat10_12 + u_xlat1.x;
					        vec3 txVec3 = vec3(u_xlat3.zw,u_xlat1.z);
					        u_xlat10_18 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat12.x = u_xlat2.w * u_xlat10_18 + u_xlat12.x;
					        u_xlat18 = (-_LightShadowData.x) + 1.0;
					        u_xlat12.x = u_xlat12.x * u_xlat18 + _LightShadowData.x;
					    } else {
					        u_xlat12.x = 1.0;
					    //ENDIF
					    }
					    u_xlat6.x = (-u_xlat12.x) + u_xlat6.x;
					    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat12.x;
					    u_xlat1 = vs_TEXCOORD2.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat1;
					    u_xlat1 = u_xlat1 + unity_WorldToLight[3];
					    u_xlatb6 = 0.0<u_xlat1.z;
					    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
					    u_xlat12.xy = u_xlat1.xy / u_xlat1.ww;
					    u_xlat12.xy = u_xlat12.xy + vec2(0.5, 0.5);
					    u_xlat10_2 = texture(_LightTexture0, u_xlat12.xy);
					    u_xlat6.x = u_xlat6.x * u_xlat10_2.w;
					    u_xlat12.x = dot(u_xlat1, u_xlat1);
					    u_xlat10_1 = texture(_LightTextureB0, u_xlat12.xx);
					    u_xlat6.x = u_xlat6.x * u_xlat10_1.x;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _Color.w;
					    SV_Target0.w = u_xlat6.x * u_xlat0.x;
					    SV_Target0.xyz = _Color.xyz;
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
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_3[2];
						float _ShadowBoost;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					bool u_xlatb2;
					float u_xlat4;
					float u_xlat10_4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = unity_MatrixV[0].z;
					    u_xlat1.y = unity_MatrixV[1].z;
					    u_xlat1.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat2.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat4 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat4, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat2.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-_LightPositionRange.xyz);
					    u_xlat4 = max(abs(u_xlat1.y), abs(u_xlat1.x));
					    u_xlat4 = max(abs(u_xlat1.z), u_xlat4);
					    u_xlat4 = u_xlat4 + (-_LightProjectionParams.z);
					    u_xlat4 = max(u_xlat4, 9.99999975e-06);
					    u_xlat4 = u_xlat4 * _LightProjectionParams.w;
					    u_xlat4 = _LightProjectionParams.y / u_xlat4;
					    u_xlat4 = u_xlat4 + (-_LightProjectionParams.x);
					    u_xlat4 = (-u_xlat4) + 1.0;
					    vec4 txVec0 = vec4(u_xlat1.xyz,u_xlat4);
					    u_xlat10_4 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat6 = (-_LightShadowData.x) + 1.0;
					    u_xlat4 = u_xlat10_4 * u_xlat6 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat4) + u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x + u_xlat4;
					    u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10_1 = texture(_LightTexture0, u_xlat2.xx);
					    u_xlat2.x = u_xlat10_1.x * _ShadowBoost;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _Color.w;
					    SV_Target0.w = u_xlat2.x * u_xlat0.x;
					    SV_Target0.xyz = _Color.xyz;
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
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_3[2];
						float _ShadowBoost;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0;
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
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					bool u_xlatb4;
					float u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = unity_MatrixV[0].z;
					    u_xlat1.y = unity_MatrixV[1].z;
					    u_xlat1.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = (-u_xlat0.x) + u_xlat4.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat4.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb4 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb4){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb4)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat4.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat8 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat8, u_xlat4.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat4.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlatb8 = u_xlat0.x<0.99000001;
					    if(u_xlatb8){
					        u_xlat1.xyz = vs_TEXCOORD2.xyz + (-_LightPositionRange.xyz);
					        u_xlat8 = max(abs(u_xlat1.y), abs(u_xlat1.x));
					        u_xlat8 = max(abs(u_xlat1.z), u_xlat8);
					        u_xlat8 = u_xlat8 + (-_LightProjectionParams.z);
					        u_xlat8 = max(u_xlat8, 9.99999975e-06);
					        u_xlat8 = u_xlat8 * _LightProjectionParams.w;
					        u_xlat8 = _LightProjectionParams.y / u_xlat8;
					        u_xlat8 = u_xlat8 + (-_LightProjectionParams.x);
					        u_xlat8 = (-u_xlat8) + 1.0;
					        u_xlat2.xyz = u_xlat1.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
					        vec4 txVec0 = vec4(u_xlat2.xyz,u_xlat8);
					        u_xlat2.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        u_xlat3.xyz = u_xlat1.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
					        vec4 txVec1 = vec4(u_xlat3.xyz,u_xlat8);
					        u_xlat2.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat3.xyz = u_xlat1.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
					        vec4 txVec2 = vec4(u_xlat3.xyz,u_xlat8);
					        u_xlat2.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat1.xyz = u_xlat1.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
					        vec4 txVec3 = vec4(u_xlat1.xyz,u_xlat8);
					        u_xlat2.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat8 = dot(u_xlat2, vec4(0.25, 0.25, 0.25, 0.25));
					        u_xlat12 = (-_LightShadowData.x) + 1.0;
					        u_xlat8 = u_xlat8 * u_xlat12 + _LightShadowData.x;
					    } else {
					        u_xlat8 = 1.0;
					    //ENDIF
					    }
					    u_xlat4.x = (-u_xlat8) + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * u_xlat4.x + u_xlat8;
					    u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat10_1 = texture(_LightTexture0, u_xlat4.xx);
					    u_xlat4.x = u_xlat10_1.x * _ShadowBoost;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _Color.w;
					    SV_Target0.w = u_xlat4.x * u_xlat0.x;
					    SV_Target0.xyz = _Color.xyz;
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
						vec4 unused_0_0[6];
						vec4 _Color;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0;
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
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					float u_xlat4;
					float u_xlat10_4;
					float u_xlat6;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = unity_MatrixV[0].z;
					    u_xlat1.y = unity_MatrixV[1].z;
					    u_xlat1.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat2.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat2.x = sqrt(u_xlat2.x);
					    u_xlat2.x = (-u_xlat0.x) + u_xlat2.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat2.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb2 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb2){
					        u_xlatb2 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb2)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat2.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat4 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat4, u_xlat2.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat2.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-_LightPositionRange.xyz);
					    u_xlat4 = max(abs(u_xlat1.y), abs(u_xlat1.x));
					    u_xlat4 = max(abs(u_xlat1.z), u_xlat4);
					    u_xlat4 = u_xlat4 + (-_LightProjectionParams.z);
					    u_xlat4 = max(u_xlat4, 9.99999975e-06);
					    u_xlat4 = u_xlat4 * _LightProjectionParams.w;
					    u_xlat4 = _LightProjectionParams.y / u_xlat4;
					    u_xlat4 = u_xlat4 + (-_LightProjectionParams.x);
					    u_xlat4 = (-u_xlat4) + 1.0;
					    vec4 txVec0 = vec4(u_xlat1.xyz,u_xlat4);
					    u_xlat10_4 = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					    u_xlat6 = (-_LightShadowData.x) + 1.0;
					    u_xlat4 = u_xlat10_4 * u_xlat6 + _LightShadowData.x;
					    u_xlat2.x = (-u_xlat4) + u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x + u_xlat4;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    SV_Target0.w = u_xlat0.x * _Color.w;
					    SV_Target0.xyz = _Color.xyz;
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
						vec4 unused_0_0[6];
						vec4 _Color;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0;
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
					uniform  sampler3D unity_ProbeVolumeSH;
					uniform  samplerCubeShadow hlslcc_zcmp_ShadowMapTexture;
					uniform  samplerCube _ShadowMapTexture;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					bool u_xlatb4;
					float u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat1.x = unity_MatrixV[0].z;
					    u_xlat1.y = unity_MatrixV[1].z;
					    u_xlat1.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat1.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = (-u_xlat0.x) + u_xlat4.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat4.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb4 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb4){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb4)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat4.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat8 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat8, u_xlat4.x);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat4.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlatb8 = u_xlat0.x<0.99000001;
					    if(u_xlatb8){
					        u_xlat1.xyz = vs_TEXCOORD2.xyz + (-_LightPositionRange.xyz);
					        u_xlat8 = max(abs(u_xlat1.y), abs(u_xlat1.x));
					        u_xlat8 = max(abs(u_xlat1.z), u_xlat8);
					        u_xlat8 = u_xlat8 + (-_LightProjectionParams.z);
					        u_xlat8 = max(u_xlat8, 9.99999975e-06);
					        u_xlat8 = u_xlat8 * _LightProjectionParams.w;
					        u_xlat8 = _LightProjectionParams.y / u_xlat8;
					        u_xlat8 = u_xlat8 + (-_LightProjectionParams.x);
					        u_xlat8 = (-u_xlat8) + 1.0;
					        u_xlat2.xyz = u_xlat1.xyz + vec3(0.0078125, 0.0078125, 0.0078125);
					        vec4 txVec0 = vec4(u_xlat2.xyz,u_xlat8);
					        u_xlat2.x = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec0, 0.0);
					        u_xlat3.xyz = u_xlat1.xyz + vec3(-0.0078125, -0.0078125, 0.0078125);
					        vec4 txVec1 = vec4(u_xlat3.xyz,u_xlat8);
					        u_xlat2.y = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec1, 0.0);
					        u_xlat3.xyz = u_xlat1.xyz + vec3(-0.0078125, 0.0078125, -0.0078125);
					        vec4 txVec2 = vec4(u_xlat3.xyz,u_xlat8);
					        u_xlat2.z = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec2, 0.0);
					        u_xlat1.xyz = u_xlat1.xyz + vec3(0.0078125, -0.0078125, -0.0078125);
					        vec4 txVec3 = vec4(u_xlat1.xyz,u_xlat8);
					        u_xlat2.w = textureLod(hlslcc_zcmp_ShadowMapTexture, txVec3, 0.0);
					        u_xlat8 = dot(u_xlat2, vec4(0.25, 0.25, 0.25, 0.25));
					        u_xlat12 = (-_LightShadowData.x) + 1.0;
					        u_xlat8 = u_xlat8 * u_xlat12 + _LightShadowData.x;
					    } else {
					        u_xlat8 = 1.0;
					    //ENDIF
					    }
					    u_xlat4.x = (-u_xlat8) + u_xlat4.x;
					    u_xlat0.x = u_xlat0.x * u_xlat4.x + u_xlat8;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    SV_Target0.w = u_xlat0.x * _Color.w;
					    SV_Target0.xyz = _Color.xyz;
					    return;
					}"
				}
			}
		}
	}
	Fallback "Mobile/VertexLit"
}
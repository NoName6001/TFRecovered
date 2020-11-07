Shader "Obi/Simple Particles" {
	Properties {
		_Color ("Particle color", Vector) = (1,1,1,1)
	}
	SubShader {
		Pass {
			Name "ParticleFwdBase"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			GpuProgramID 823
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _RadiusScale;
						vec4 _Color;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						vec4 unused_3_3[10];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixV[1];
					    u_xlat0 = unity_MatrixV[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixV[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixV[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = in_TEXCOORD0.w * _RadiusScale;
					    u_xlat2.xy = in_NORMAL0.xy;
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat0 = u_xlat2 * u_xlat1.xxxx + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * glstate_matrix_projection[1];
					    u_xlat1 = glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat0.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat0.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat1.xyz;
					    u_xlat2.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat2.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.yyy;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * u_xlat2.zzz + u_xlat0.xyz;
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
						vec4 unused_0_0[6];
						float _RadiusScale;
						vec4 _Color;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						vec4 unused_3_3[10];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixV[1];
					    u_xlat0 = unity_MatrixV[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixV[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixV[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = in_TEXCOORD0.w * _RadiusScale;
					    u_xlat2.xy = in_NORMAL0.xy;
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat0 = u_xlat2 * u_xlat1.xxxx + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * glstate_matrix_projection[1];
					    u_xlat1 = glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat0.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat0.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat1.xyz;
					    u_xlat2.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat2.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.yyy;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * u_xlat2.zzz + u_xlat0.xyz;
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
						vec4 unused_0_0[6];
						float _RadiusScale;
						vec4 _Color;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						vec4 unused_4_3[10];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixV[1];
					    u_xlat0 = unity_MatrixV[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixV[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixV[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = in_TEXCOORD0.w * _RadiusScale;
					    u_xlat2.xy = in_NORMAL0.xy;
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat0 = u_xlat2 * u_xlat1.xxxx + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * glstate_matrix_projection[1];
					    u_xlat1 = glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat1.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat1.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat2.xyz;
					    u_xlat3.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat3.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * u_xlat3.zzz + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
						vec4 unused_0_0[6];
						float _RadiusScale;
						vec4 _Color;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						vec4 unused_4_3[10];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixV[1];
					    u_xlat0 = unity_MatrixV[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixV[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixV[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = in_TEXCOORD0.w * _RadiusScale;
					    u_xlat2.xy = in_NORMAL0.xy;
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat0 = u_xlat2 * u_xlat1.xxxx + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * glstate_matrix_projection[1];
					    u_xlat1 = glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat1.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat1.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat2.xyz;
					    u_xlat3.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat3.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * u_xlat3.zzz + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
						vec4 unused_0_0[6];
						float _RadiusScale;
						vec4 _Color;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						vec4 unused_3_3[10];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixV[1];
					    u_xlat0 = unity_MatrixV[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixV[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixV[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = in_TEXCOORD0.w * _RadiusScale;
					    u_xlat2.xy = in_NORMAL0.xy;
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat0 = u_xlat2 * u_xlat1.xxxx + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * glstate_matrix_projection[1];
					    u_xlat1 = glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat0.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat0.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat1.xyz;
					    u_xlat2.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat2.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.yyy;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * u_xlat2.zzz + u_xlat0.xyz;
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
						vec4 unused_0_0[6];
						float _RadiusScale;
						vec4 _Color;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						vec4 unused_3_3[10];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixV[1];
					    u_xlat0 = unity_MatrixV[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixV[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixV[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = in_TEXCOORD0.w * _RadiusScale;
					    u_xlat2.xy = in_NORMAL0.xy;
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat0 = u_xlat2 * u_xlat1.xxxx + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * glstate_matrix_projection[1];
					    u_xlat1 = glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat0.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat0.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat1.xyz;
					    u_xlat2.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat2.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.yyy;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz * u_xlat2.zzz + u_xlat0.xyz;
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
						vec4 unused_0_0[6];
						float _RadiusScale;
						vec4 _Color;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						vec4 unused_4_3[10];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixV[1];
					    u_xlat0 = unity_MatrixV[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixV[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixV[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = in_TEXCOORD0.w * _RadiusScale;
					    u_xlat2.xy = in_NORMAL0.xy;
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat0 = u_xlat2 * u_xlat1.xxxx + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * glstate_matrix_projection[1];
					    u_xlat1 = glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat1.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat1.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat2.xyz;
					    u_xlat3.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat3.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * u_xlat3.zzz + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
						vec4 unused_0_0[6];
						float _RadiusScale;
						vec4 _Color;
						vec4 unused_0_3;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						vec4 unused_4_3[10];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixV[1];
					    u_xlat0 = unity_MatrixV[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixV[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixV[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = in_TEXCOORD0.w * _RadiusScale;
					    u_xlat2.xy = in_NORMAL0.xy;
					    u_xlat2.z = float(0.0);
					    u_xlat2.w = float(0.0);
					    u_xlat0 = u_xlat2 * u_xlat1.xxxx + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * glstate_matrix_projection[1];
					    u_xlat1 = glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat0 = glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
					    gl_Position = u_xlat0;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
					    u_xlat1.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat1.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat2.xyz;
					    u_xlat3.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat3.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.yyy;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz * u_xlat3.zzz + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD4.zw = u_xlat0.zw;
					    vs_TEXCOORD4.xy = u_xlat1.zz + u_xlat1.xw;
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
						vec4 unused_0_0[8];
						vec4 _LightColor0;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_1_1[22];
					};
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlatb2 = u_xlat0.x<0.0;
					    u_xlat1.z = sqrt(u_xlat0.x);
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat0.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    SV_Target0.w = vs_COLOR0.w;
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
						vec4 unused_0_0[8];
						vec4 _LightColor0;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_1_1[22];
					};
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlatb2 = u_xlat0.x<0.0;
					    u_xlat1.z = sqrt(u_xlat0.x);
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat0.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    SV_Target0.w = vs_COLOR0.w;
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
						vec4 unused_0_0[8];
						vec4 _LightColor0;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_1_1[22];
					};
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlatb2 = u_xlat0.x<0.0;
					    u_xlat1.z = sqrt(u_xlat0.x);
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat0.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    SV_Target0.w = vs_COLOR0.w;
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
						vec4 unused_0_0[8];
						vec4 _LightColor0;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_1_1[22];
					};
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					bool u_xlatb2;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlatb2 = u_xlat0.x<0.0;
					    u_xlat1.z = sqrt(u_xlat0.x);
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat0.xyz = _LightColor0.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    SV_Target0.w = vs_COLOR0.w;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "ShadowCaster"
			Tags { "LIGHTMODE" = "SHADOWCASTER" "SHADOWSUPPORT" = "true" }
			Offset 1, 1
			Fog {
				Mode Off
			}
			GpuProgramID 121486
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_DEPTH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _RadiusScale;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						vec4 unused_1_3[10];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixV[1];
					    u_xlat0 = unity_MatrixV[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixV[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixV[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xy = in_NORMAL0.xy;
					    u_xlat1.z = float(0.0);
					    u_xlat1.w = float(0.0);
					    u_xlat2 = in_TEXCOORD0.w * _RadiusScale;
					    u_xlat0 = u_xlat1 * vec4(u_xlat2) + u_xlat0;
					    vs_TEXCOORD0.z = u_xlat2;
					    u_xlat1 = u_xlat0.yyyy * glstate_matrix_projection[1];
					    u_xlat1 = glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
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
						vec4 unused_0_0[6];
						float _RadiusScale;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						vec4 unused_1_3[10];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec3 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixV[1];
					    u_xlat0 = unity_MatrixV[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixV[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixV[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xy = in_NORMAL0.xy;
					    u_xlat1.z = float(0.0);
					    u_xlat1.w = float(0.0);
					    u_xlat2 = in_TEXCOORD0.w * _RadiusScale;
					    u_xlat0 = u_xlat1 * vec4(u_xlat2) + u_xlat0;
					    vs_TEXCOORD0.z = u_xlat2;
					    u_xlat1 = u_xlat0.yyyy * glstate_matrix_projection[1];
					    u_xlat1 = glstate_matrix_projection[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = glstate_matrix_projection[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = glstate_matrix_projection[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy * vec2(0.5, 0.5) + vec2(0.5, 0.5);
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
					
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
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
					
					in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					bool u_xlatb0;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat0.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
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
}
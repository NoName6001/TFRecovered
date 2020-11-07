Shader "Obi/Particles" {
	Properties {
		_Color ("Particle color", Vector) = (1,1,1,1)
		_RadiusScale ("Radius scale", Float) = 1
	}
	SubShader {
		Pass {
			Name "ParticleFwdBase"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			GpuProgramID 12974
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
						mat4x4 unity_MatrixInvV;
						mat4x4 unity_MatrixVP;
						vec4 unused_3_5[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec2 in_TEXCOORD3;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					vec3 u_xlat13;
					float u_xlat22;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat36;
					void main()
					{
					    u_xlat0.y = unity_MatrixV[2].y;
					    u_xlat0.z = unity_MatrixV[0].y;
					    u_xlat0.x = unity_MatrixV[1].y;
					    u_xlat1.xy = in_POSITION0.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * in_POSITION0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * in_POSITION0.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat12.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat12.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlatb33 = glstate_matrix_projection[0].w==0.0;
					    u_xlatb34 = glstate_matrix_projection[1].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlatb34 = glstate_matrix_projection[2].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlat34 = in_TEXCOORD3.x * _RadiusScale;
					    u_xlat2.x = u_xlat34 * in_TEXCOORD0.w;
					    u_xlat13.x = float(1.0) / u_xlat2.x;
					    u_xlat2.z = u_xlat34 * in_TEXCOORD1.w;
					    u_xlat34 = u_xlat34 * in_TEXCOORD2.w;
					    u_xlat13.z = float(1.0) / u_xlat2.z;
					    u_xlat3.xy = u_xlat13.xz * in_TEXCOORD0.xy;
					    u_xlat36 = float(1.0) / u_xlat34;
					    u_xlat3.z = u_xlat36 * in_TEXCOORD0.z;
					    u_xlat4.x = dot(u_xlat3.xyz, in_TEXCOORD0.xyz);
					    u_xlat4.y = dot(u_xlat3.xyz, in_TEXCOORD1.xyz);
					    u_xlat4.z = dot(u_xlat3.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat5.xy = u_xlat13.xz * in_TEXCOORD1.xy;
					    u_xlat6.xy = u_xlat13.xz * in_TEXCOORD2.xy;
					    u_xlat5.z = u_xlat36 * in_TEXCOORD1.z;
					    u_xlat6.z = u_xlat36 * in_TEXCOORD2.z;
					    u_xlat7.x = dot(u_xlat5.xyz, in_TEXCOORD0.xyz);
					    u_xlat7.y = dot(u_xlat5.xyz, in_TEXCOORD1.xyz);
					    u_xlat7.z = dot(u_xlat5.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.y = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat5.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat5.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat5.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat3.zxy);
					    u_xlat0.xyz = (-u_xlat3.yzx) * u_xlat0.yzx + (-u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yzx * (-u_xlat3.zxy);
					    u_xlat1.xyz = (-u_xlat3.yzx) * u_xlat0.zxy + (-u_xlat1.xyz);
					    u_xlat13.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13.x = inversesqrt(u_xlat13.x);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
					    u_xlat6.xy = u_xlat2.xz * in_TEXCOORD0.xy;
					    u_xlat6.z = u_xlat34 * in_TEXCOORD0.z;
					    u_xlat8.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat8.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat8.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat9.xy = u_xlat2.xz * in_TEXCOORD1.xy;
					    u_xlat10.xy = u_xlat2.xz * in_TEXCOORD2.xy;
					    u_xlat9.z = u_xlat34 * in_TEXCOORD1.z;
					    u_xlat10.z = u_xlat34 * in_TEXCOORD2.z;
					    u_xlat2.x = dot(u_xlat9.xyz, in_TEXCOORD0.xyz);
					    u_xlat2.y = dot(u_xlat9.xyz, in_TEXCOORD1.xyz);
					    u_xlat2.z = dot(u_xlat9.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat9.x = dot(u_xlat10.xyz, in_TEXCOORD0.xyz);
					    u_xlat9.y = dot(u_xlat10.xyz, in_TEXCOORD1.xyz);
					    u_xlat9.z = dot(u_xlat10.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat6.xyz * in_NORMAL0.yyy;
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat0.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat6.xyz * in_NORMAL0.xxx + u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    vs_TEXCOORD0.z = float(1.0) / u_xlat1.x;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat12.xxx;
					    u_xlat1.x = (-u_xlat12.x) + 1.0;
					    u_xlat3.w = sqrt(u_xlat1.x);
					    u_xlat1 = (bool(u_xlatb33)) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat3;
					    u_xlat3.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat3.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat3.xyz + in_POSITION0.xyz;
					    u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD0.w = u_xlat1.w;
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy;
					    u_xlat1.xy = u_xlat0.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat12.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat12.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlat2.xyz = u_xlat0.yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat3.xyz;
					    u_xlat6.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat6.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat6.xyz;
					    u_xlat6.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat6.yyy;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat6.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat3.xyz;
					    vs_TEXCOORD2.xyz = u_xlat3.xyz * u_xlat6.zzz + u_xlat2.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat33 = dot(u_xlat7.xyz, u_xlat2.xyz);
					    u_xlat1.xyz = vec3(u_xlat33) * unity_MatrixV[1].xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat34 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat1.xyz = unity_MatrixV[0].xyz * vec3(u_xlat33) + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_MatrixV[2].xyz * vec3(u_xlat34) + u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat7.xyz, u_xlat0.xyz);
					    u_xlat1.z = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat11.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat22 = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = vec3(u_xlat22) * unity_MatrixV[1].xyz;
					    u_xlat11.xyz = unity_MatrixV[0].xyz * u_xlat11.xxx + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_MatrixV[2].xyz * u_xlat0.xxx + u_xlat11.xyz;
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
						mat4x4 unity_MatrixInvV;
						mat4x4 unity_MatrixVP;
						vec4 unused_3_5[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec2 in_TEXCOORD3;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					vec3 u_xlat13;
					float u_xlat22;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat36;
					void main()
					{
					    u_xlat0.y = unity_MatrixV[2].y;
					    u_xlat0.z = unity_MatrixV[0].y;
					    u_xlat0.x = unity_MatrixV[1].y;
					    u_xlat1.xy = in_POSITION0.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * in_POSITION0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * in_POSITION0.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat12.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat12.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlatb33 = glstate_matrix_projection[0].w==0.0;
					    u_xlatb34 = glstate_matrix_projection[1].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlatb34 = glstate_matrix_projection[2].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlat34 = in_TEXCOORD3.x * _RadiusScale;
					    u_xlat2.x = u_xlat34 * in_TEXCOORD0.w;
					    u_xlat13.x = float(1.0) / u_xlat2.x;
					    u_xlat2.z = u_xlat34 * in_TEXCOORD1.w;
					    u_xlat34 = u_xlat34 * in_TEXCOORD2.w;
					    u_xlat13.z = float(1.0) / u_xlat2.z;
					    u_xlat3.xy = u_xlat13.xz * in_TEXCOORD0.xy;
					    u_xlat36 = float(1.0) / u_xlat34;
					    u_xlat3.z = u_xlat36 * in_TEXCOORD0.z;
					    u_xlat4.x = dot(u_xlat3.xyz, in_TEXCOORD0.xyz);
					    u_xlat4.y = dot(u_xlat3.xyz, in_TEXCOORD1.xyz);
					    u_xlat4.z = dot(u_xlat3.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat5.xy = u_xlat13.xz * in_TEXCOORD1.xy;
					    u_xlat6.xy = u_xlat13.xz * in_TEXCOORD2.xy;
					    u_xlat5.z = u_xlat36 * in_TEXCOORD1.z;
					    u_xlat6.z = u_xlat36 * in_TEXCOORD2.z;
					    u_xlat7.x = dot(u_xlat5.xyz, in_TEXCOORD0.xyz);
					    u_xlat7.y = dot(u_xlat5.xyz, in_TEXCOORD1.xyz);
					    u_xlat7.z = dot(u_xlat5.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.y = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat5.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat5.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat5.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat3.zxy);
					    u_xlat0.xyz = (-u_xlat3.yzx) * u_xlat0.yzx + (-u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yzx * (-u_xlat3.zxy);
					    u_xlat1.xyz = (-u_xlat3.yzx) * u_xlat0.zxy + (-u_xlat1.xyz);
					    u_xlat13.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13.x = inversesqrt(u_xlat13.x);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
					    u_xlat6.xy = u_xlat2.xz * in_TEXCOORD0.xy;
					    u_xlat6.z = u_xlat34 * in_TEXCOORD0.z;
					    u_xlat8.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat8.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat8.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat9.xy = u_xlat2.xz * in_TEXCOORD1.xy;
					    u_xlat10.xy = u_xlat2.xz * in_TEXCOORD2.xy;
					    u_xlat9.z = u_xlat34 * in_TEXCOORD1.z;
					    u_xlat10.z = u_xlat34 * in_TEXCOORD2.z;
					    u_xlat2.x = dot(u_xlat9.xyz, in_TEXCOORD0.xyz);
					    u_xlat2.y = dot(u_xlat9.xyz, in_TEXCOORD1.xyz);
					    u_xlat2.z = dot(u_xlat9.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat9.x = dot(u_xlat10.xyz, in_TEXCOORD0.xyz);
					    u_xlat9.y = dot(u_xlat10.xyz, in_TEXCOORD1.xyz);
					    u_xlat9.z = dot(u_xlat10.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat6.xyz * in_NORMAL0.yyy;
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat0.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat6.xyz * in_NORMAL0.xxx + u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    vs_TEXCOORD0.z = float(1.0) / u_xlat1.x;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat12.xxx;
					    u_xlat1.x = (-u_xlat12.x) + 1.0;
					    u_xlat3.w = sqrt(u_xlat1.x);
					    u_xlat1 = (bool(u_xlatb33)) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat3;
					    u_xlat3.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat3.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat3.xyz + in_POSITION0.xyz;
					    u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD0.w = u_xlat1.w;
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy;
					    u_xlat1.xy = u_xlat0.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat12.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat12.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlat2.xyz = u_xlat0.yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat3.xyz;
					    u_xlat6.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat6.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat6.xyz;
					    u_xlat6.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat6.yyy;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat6.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat3.xyz;
					    vs_TEXCOORD2.xyz = u_xlat3.xyz * u_xlat6.zzz + u_xlat2.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat33 = dot(u_xlat7.xyz, u_xlat2.xyz);
					    u_xlat1.xyz = vec3(u_xlat33) * unity_MatrixV[1].xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat34 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat1.xyz = unity_MatrixV[0].xyz * vec3(u_xlat33) + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_MatrixV[2].xyz * vec3(u_xlat34) + u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat7.xyz, u_xlat0.xyz);
					    u_xlat1.z = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat11.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat22 = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = vec3(u_xlat22) * unity_MatrixV[1].xyz;
					    u_xlat11.xyz = unity_MatrixV[0].xyz * u_xlat11.xxx + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_MatrixV[2].xyz * u_xlat0.xxx + u_xlat11.xyz;
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
						mat4x4 unity_MatrixInvV;
						mat4x4 unity_MatrixVP;
						vec4 unused_4_5[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec2 in_TEXCOORD3;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					vec3 u_xlat13;
					float u_xlat22;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat0.y = unity_MatrixV[2].y;
					    u_xlat0.z = unity_MatrixV[0].y;
					    u_xlat0.x = unity_MatrixV[1].y;
					    u_xlat1.xy = in_POSITION0.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * in_POSITION0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * in_POSITION0.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat12.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat12.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlatb33 = glstate_matrix_projection[0].w==0.0;
					    u_xlatb34 = glstate_matrix_projection[1].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlatb34 = glstate_matrix_projection[2].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlat34 = in_TEXCOORD3.x * _RadiusScale;
					    u_xlat2.x = u_xlat34 * in_TEXCOORD0.w;
					    u_xlat13.x = float(1.0) / u_xlat2.x;
					    u_xlat2.z = u_xlat34 * in_TEXCOORD1.w;
					    u_xlat34 = u_xlat34 * in_TEXCOORD2.w;
					    u_xlat13.z = float(1.0) / u_xlat2.z;
					    u_xlat3.xy = u_xlat13.xz * in_TEXCOORD0.xy;
					    u_xlat36 = float(1.0) / u_xlat34;
					    u_xlat3.z = u_xlat36 * in_TEXCOORD0.z;
					    u_xlat4.x = dot(u_xlat3.xyz, in_TEXCOORD0.xyz);
					    u_xlat4.y = dot(u_xlat3.xyz, in_TEXCOORD1.xyz);
					    u_xlat4.z = dot(u_xlat3.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat5.xy = u_xlat13.xz * in_TEXCOORD1.xy;
					    u_xlat6.xy = u_xlat13.xz * in_TEXCOORD2.xy;
					    u_xlat5.z = u_xlat36 * in_TEXCOORD1.z;
					    u_xlat6.z = u_xlat36 * in_TEXCOORD2.z;
					    u_xlat7.x = dot(u_xlat5.xyz, in_TEXCOORD0.xyz);
					    u_xlat7.y = dot(u_xlat5.xyz, in_TEXCOORD1.xyz);
					    u_xlat7.z = dot(u_xlat5.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.y = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat5.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat5.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat5.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat3.zxy);
					    u_xlat0.xyz = (-u_xlat3.yzx) * u_xlat0.yzx + (-u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yzx * (-u_xlat3.zxy);
					    u_xlat1.xyz = (-u_xlat3.yzx) * u_xlat0.zxy + (-u_xlat1.xyz);
					    u_xlat13.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13.x = inversesqrt(u_xlat13.x);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
					    u_xlat6.xy = u_xlat2.xz * in_TEXCOORD0.xy;
					    u_xlat6.z = u_xlat34 * in_TEXCOORD0.z;
					    u_xlat8.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat8.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat8.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat9.xy = u_xlat2.xz * in_TEXCOORD1.xy;
					    u_xlat10.xy = u_xlat2.xz * in_TEXCOORD2.xy;
					    u_xlat9.z = u_xlat34 * in_TEXCOORD1.z;
					    u_xlat10.z = u_xlat34 * in_TEXCOORD2.z;
					    u_xlat2.x = dot(u_xlat9.xyz, in_TEXCOORD0.xyz);
					    u_xlat2.y = dot(u_xlat9.xyz, in_TEXCOORD1.xyz);
					    u_xlat2.z = dot(u_xlat9.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat9.x = dot(u_xlat10.xyz, in_TEXCOORD0.xyz);
					    u_xlat9.y = dot(u_xlat10.xyz, in_TEXCOORD1.xyz);
					    u_xlat9.z = dot(u_xlat10.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat6.xyz * in_NORMAL0.yyy;
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat0.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat6.xyz * in_NORMAL0.xxx + u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    vs_TEXCOORD0.z = float(1.0) / u_xlat1.x;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat12.xxx;
					    u_xlat1.x = (-u_xlat12.x) + 1.0;
					    u_xlat3.w = sqrt(u_xlat1.x);
					    u_xlat1 = (bool(u_xlatb33)) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat3;
					    u_xlat3.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat3.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat3.xyz + in_POSITION0.xyz;
					    u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD0.w = u_xlat1.w;
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy;
					    u_xlat2.xy = u_xlat0.yy * unity_MatrixV[1].xy;
					    u_xlat2.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_MatrixV[3].xy;
					    u_xlat13.xyz = u_xlat2.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat2.xyz = unity_MatrixInvV[0].xyz * u_xlat2.xxx + u_xlat13.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_MatrixInvV[3].xyz;
					    u_xlat2.xyz = (bool(u_xlatb33)) ? u_xlat2.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
					    u_xlat3.xyz = u_xlat0.yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    vs_TEXCOORD1.xyz = unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat3.xyz;
					    u_xlat6.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat6.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat6.xyz;
					    u_xlat8.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat8.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat8.xyz;
					    u_xlat8.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat8.xyz;
					    u_xlat8.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz * u_xlat8.yyy;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat8.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat6.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat6.xyz;
					    vs_TEXCOORD2.xyz = u_xlat6.xyz * u_xlat8.zzz + u_xlat3.xyz;
					    u_xlat3.x = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat3.y = dot(u_xlat7.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat33 = dot(u_xlat7.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = vec3(u_xlat33) * unity_MatrixV[1].xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat35 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = unity_MatrixV[0].xyz * vec3(u_xlat33) + u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = unity_MatrixV[2].xyz * vec3(u_xlat35) + u_xlat2.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat7.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat11.x = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat7.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vec3(u_xlat22) * unity_MatrixV[1].xyz;
					    u_xlat11.xyz = unity_MatrixV[0].xyz * u_xlat11.xxx + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = unity_MatrixV[2].xyz * u_xlat0.xxx + u_xlat11.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
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
						mat4x4 unity_MatrixInvV;
						mat4x4 unity_MatrixVP;
						vec4 unused_4_5[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec2 in_TEXCOORD3;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					vec3 u_xlat13;
					float u_xlat22;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat0.y = unity_MatrixV[2].y;
					    u_xlat0.z = unity_MatrixV[0].y;
					    u_xlat0.x = unity_MatrixV[1].y;
					    u_xlat1.xy = in_POSITION0.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * in_POSITION0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * in_POSITION0.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat12.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat12.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlatb33 = glstate_matrix_projection[0].w==0.0;
					    u_xlatb34 = glstate_matrix_projection[1].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlatb34 = glstate_matrix_projection[2].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlat34 = in_TEXCOORD3.x * _RadiusScale;
					    u_xlat2.x = u_xlat34 * in_TEXCOORD0.w;
					    u_xlat13.x = float(1.0) / u_xlat2.x;
					    u_xlat2.z = u_xlat34 * in_TEXCOORD1.w;
					    u_xlat34 = u_xlat34 * in_TEXCOORD2.w;
					    u_xlat13.z = float(1.0) / u_xlat2.z;
					    u_xlat3.xy = u_xlat13.xz * in_TEXCOORD0.xy;
					    u_xlat36 = float(1.0) / u_xlat34;
					    u_xlat3.z = u_xlat36 * in_TEXCOORD0.z;
					    u_xlat4.x = dot(u_xlat3.xyz, in_TEXCOORD0.xyz);
					    u_xlat4.y = dot(u_xlat3.xyz, in_TEXCOORD1.xyz);
					    u_xlat4.z = dot(u_xlat3.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat5.xy = u_xlat13.xz * in_TEXCOORD1.xy;
					    u_xlat6.xy = u_xlat13.xz * in_TEXCOORD2.xy;
					    u_xlat5.z = u_xlat36 * in_TEXCOORD1.z;
					    u_xlat6.z = u_xlat36 * in_TEXCOORD2.z;
					    u_xlat7.x = dot(u_xlat5.xyz, in_TEXCOORD0.xyz);
					    u_xlat7.y = dot(u_xlat5.xyz, in_TEXCOORD1.xyz);
					    u_xlat7.z = dot(u_xlat5.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.y = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat5.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat5.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat5.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat3.zxy);
					    u_xlat0.xyz = (-u_xlat3.yzx) * u_xlat0.yzx + (-u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yzx * (-u_xlat3.zxy);
					    u_xlat1.xyz = (-u_xlat3.yzx) * u_xlat0.zxy + (-u_xlat1.xyz);
					    u_xlat13.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13.x = inversesqrt(u_xlat13.x);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
					    u_xlat6.xy = u_xlat2.xz * in_TEXCOORD0.xy;
					    u_xlat6.z = u_xlat34 * in_TEXCOORD0.z;
					    u_xlat8.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat8.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat8.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat9.xy = u_xlat2.xz * in_TEXCOORD1.xy;
					    u_xlat10.xy = u_xlat2.xz * in_TEXCOORD2.xy;
					    u_xlat9.z = u_xlat34 * in_TEXCOORD1.z;
					    u_xlat10.z = u_xlat34 * in_TEXCOORD2.z;
					    u_xlat2.x = dot(u_xlat9.xyz, in_TEXCOORD0.xyz);
					    u_xlat2.y = dot(u_xlat9.xyz, in_TEXCOORD1.xyz);
					    u_xlat2.z = dot(u_xlat9.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat9.x = dot(u_xlat10.xyz, in_TEXCOORD0.xyz);
					    u_xlat9.y = dot(u_xlat10.xyz, in_TEXCOORD1.xyz);
					    u_xlat9.z = dot(u_xlat10.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat6.xyz * in_NORMAL0.yyy;
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat0.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat6.xyz * in_NORMAL0.xxx + u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    vs_TEXCOORD0.z = float(1.0) / u_xlat1.x;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat12.xxx;
					    u_xlat1.x = (-u_xlat12.x) + 1.0;
					    u_xlat3.w = sqrt(u_xlat1.x);
					    u_xlat1 = (bool(u_xlatb33)) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat3;
					    u_xlat3.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat3.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat3.xyz + in_POSITION0.xyz;
					    u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD0.w = u_xlat1.w;
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy;
					    u_xlat2.xy = u_xlat0.yy * unity_MatrixV[1].xy;
					    u_xlat2.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_MatrixV[3].xy;
					    u_xlat13.xyz = u_xlat2.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat2.xyz = unity_MatrixInvV[0].xyz * u_xlat2.xxx + u_xlat13.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_MatrixInvV[3].xyz;
					    u_xlat2.xyz = (bool(u_xlatb33)) ? u_xlat2.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
					    u_xlat3.xyz = u_xlat0.yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    vs_TEXCOORD1.xyz = unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat3.xyz;
					    u_xlat6.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat6.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat6.xyz;
					    u_xlat8.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat8.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat8.xyz;
					    u_xlat8.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat8.xyz;
					    u_xlat8.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz * u_xlat8.yyy;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat8.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat6.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat6.xyz;
					    vs_TEXCOORD2.xyz = u_xlat6.xyz * u_xlat8.zzz + u_xlat3.xyz;
					    u_xlat3.x = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat3.y = dot(u_xlat7.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat33 = dot(u_xlat7.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = vec3(u_xlat33) * unity_MatrixV[1].xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat35 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = unity_MatrixV[0].xyz * vec3(u_xlat33) + u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = unity_MatrixV[2].xyz * vec3(u_xlat35) + u_xlat2.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat7.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat11.x = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat7.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vec3(u_xlat22) * unity_MatrixV[1].xyz;
					    u_xlat11.xyz = unity_MatrixV[0].xyz * u_xlat11.xxx + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = unity_MatrixV[2].xyz * u_xlat0.xxx + u_xlat11.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
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
						mat4x4 unity_MatrixInvV;
						mat4x4 unity_MatrixVP;
						vec4 unused_3_5[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec2 in_TEXCOORD3;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					vec3 u_xlat13;
					float u_xlat22;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat36;
					void main()
					{
					    u_xlat0.y = unity_MatrixV[2].y;
					    u_xlat0.z = unity_MatrixV[0].y;
					    u_xlat0.x = unity_MatrixV[1].y;
					    u_xlat1.xy = in_POSITION0.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * in_POSITION0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * in_POSITION0.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat12.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat12.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlatb33 = glstate_matrix_projection[0].w==0.0;
					    u_xlatb34 = glstate_matrix_projection[1].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlatb34 = glstate_matrix_projection[2].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlat34 = in_TEXCOORD3.x * _RadiusScale;
					    u_xlat2.x = u_xlat34 * in_TEXCOORD0.w;
					    u_xlat13.x = float(1.0) / u_xlat2.x;
					    u_xlat2.z = u_xlat34 * in_TEXCOORD1.w;
					    u_xlat34 = u_xlat34 * in_TEXCOORD2.w;
					    u_xlat13.z = float(1.0) / u_xlat2.z;
					    u_xlat3.xy = u_xlat13.xz * in_TEXCOORD0.xy;
					    u_xlat36 = float(1.0) / u_xlat34;
					    u_xlat3.z = u_xlat36 * in_TEXCOORD0.z;
					    u_xlat4.x = dot(u_xlat3.xyz, in_TEXCOORD0.xyz);
					    u_xlat4.y = dot(u_xlat3.xyz, in_TEXCOORD1.xyz);
					    u_xlat4.z = dot(u_xlat3.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat5.xy = u_xlat13.xz * in_TEXCOORD1.xy;
					    u_xlat6.xy = u_xlat13.xz * in_TEXCOORD2.xy;
					    u_xlat5.z = u_xlat36 * in_TEXCOORD1.z;
					    u_xlat6.z = u_xlat36 * in_TEXCOORD2.z;
					    u_xlat7.x = dot(u_xlat5.xyz, in_TEXCOORD0.xyz);
					    u_xlat7.y = dot(u_xlat5.xyz, in_TEXCOORD1.xyz);
					    u_xlat7.z = dot(u_xlat5.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.y = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat5.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat5.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat5.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat3.zxy);
					    u_xlat0.xyz = (-u_xlat3.yzx) * u_xlat0.yzx + (-u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yzx * (-u_xlat3.zxy);
					    u_xlat1.xyz = (-u_xlat3.yzx) * u_xlat0.zxy + (-u_xlat1.xyz);
					    u_xlat13.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13.x = inversesqrt(u_xlat13.x);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
					    u_xlat6.xy = u_xlat2.xz * in_TEXCOORD0.xy;
					    u_xlat6.z = u_xlat34 * in_TEXCOORD0.z;
					    u_xlat8.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat8.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat8.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat9.xy = u_xlat2.xz * in_TEXCOORD1.xy;
					    u_xlat10.xy = u_xlat2.xz * in_TEXCOORD2.xy;
					    u_xlat9.z = u_xlat34 * in_TEXCOORD1.z;
					    u_xlat10.z = u_xlat34 * in_TEXCOORD2.z;
					    u_xlat2.x = dot(u_xlat9.xyz, in_TEXCOORD0.xyz);
					    u_xlat2.y = dot(u_xlat9.xyz, in_TEXCOORD1.xyz);
					    u_xlat2.z = dot(u_xlat9.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat9.x = dot(u_xlat10.xyz, in_TEXCOORD0.xyz);
					    u_xlat9.y = dot(u_xlat10.xyz, in_TEXCOORD1.xyz);
					    u_xlat9.z = dot(u_xlat10.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat6.xyz * in_NORMAL0.yyy;
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat0.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat6.xyz * in_NORMAL0.xxx + u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    vs_TEXCOORD0.z = float(1.0) / u_xlat1.x;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat12.xxx;
					    u_xlat1.x = (-u_xlat12.x) + 1.0;
					    u_xlat3.w = sqrt(u_xlat1.x);
					    u_xlat1 = (bool(u_xlatb33)) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat3;
					    u_xlat3.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat3.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat3.xyz + in_POSITION0.xyz;
					    u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD0.w = u_xlat1.w;
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy;
					    u_xlat1.xy = u_xlat0.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat12.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat12.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlat2.xyz = u_xlat0.yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat3.xyz;
					    u_xlat6.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat6.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat6.xyz;
					    u_xlat6.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat6.yyy;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat6.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat3.xyz;
					    vs_TEXCOORD2.xyz = u_xlat3.xyz * u_xlat6.zzz + u_xlat2.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat33 = dot(u_xlat7.xyz, u_xlat2.xyz);
					    u_xlat1.xyz = vec3(u_xlat33) * unity_MatrixV[1].xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat34 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat1.xyz = unity_MatrixV[0].xyz * vec3(u_xlat33) + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_MatrixV[2].xyz * vec3(u_xlat34) + u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat7.xyz, u_xlat0.xyz);
					    u_xlat1.z = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat11.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat22 = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = vec3(u_xlat22) * unity_MatrixV[1].xyz;
					    u_xlat11.xyz = unity_MatrixV[0].xyz * u_xlat11.xxx + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_MatrixV[2].xyz * u_xlat0.xxx + u_xlat11.xyz;
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
						mat4x4 unity_MatrixInvV;
						mat4x4 unity_MatrixVP;
						vec4 unused_3_5[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec2 in_TEXCOORD3;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					vec3 u_xlat13;
					float u_xlat22;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat36;
					void main()
					{
					    u_xlat0.y = unity_MatrixV[2].y;
					    u_xlat0.z = unity_MatrixV[0].y;
					    u_xlat0.x = unity_MatrixV[1].y;
					    u_xlat1.xy = in_POSITION0.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * in_POSITION0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * in_POSITION0.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat12.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat12.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlatb33 = glstate_matrix_projection[0].w==0.0;
					    u_xlatb34 = glstate_matrix_projection[1].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlatb34 = glstate_matrix_projection[2].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlat34 = in_TEXCOORD3.x * _RadiusScale;
					    u_xlat2.x = u_xlat34 * in_TEXCOORD0.w;
					    u_xlat13.x = float(1.0) / u_xlat2.x;
					    u_xlat2.z = u_xlat34 * in_TEXCOORD1.w;
					    u_xlat34 = u_xlat34 * in_TEXCOORD2.w;
					    u_xlat13.z = float(1.0) / u_xlat2.z;
					    u_xlat3.xy = u_xlat13.xz * in_TEXCOORD0.xy;
					    u_xlat36 = float(1.0) / u_xlat34;
					    u_xlat3.z = u_xlat36 * in_TEXCOORD0.z;
					    u_xlat4.x = dot(u_xlat3.xyz, in_TEXCOORD0.xyz);
					    u_xlat4.y = dot(u_xlat3.xyz, in_TEXCOORD1.xyz);
					    u_xlat4.z = dot(u_xlat3.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat5.xy = u_xlat13.xz * in_TEXCOORD1.xy;
					    u_xlat6.xy = u_xlat13.xz * in_TEXCOORD2.xy;
					    u_xlat5.z = u_xlat36 * in_TEXCOORD1.z;
					    u_xlat6.z = u_xlat36 * in_TEXCOORD2.z;
					    u_xlat7.x = dot(u_xlat5.xyz, in_TEXCOORD0.xyz);
					    u_xlat7.y = dot(u_xlat5.xyz, in_TEXCOORD1.xyz);
					    u_xlat7.z = dot(u_xlat5.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.y = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat5.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat5.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat5.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat3.zxy);
					    u_xlat0.xyz = (-u_xlat3.yzx) * u_xlat0.yzx + (-u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yzx * (-u_xlat3.zxy);
					    u_xlat1.xyz = (-u_xlat3.yzx) * u_xlat0.zxy + (-u_xlat1.xyz);
					    u_xlat13.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13.x = inversesqrt(u_xlat13.x);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
					    u_xlat6.xy = u_xlat2.xz * in_TEXCOORD0.xy;
					    u_xlat6.z = u_xlat34 * in_TEXCOORD0.z;
					    u_xlat8.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat8.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat8.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat9.xy = u_xlat2.xz * in_TEXCOORD1.xy;
					    u_xlat10.xy = u_xlat2.xz * in_TEXCOORD2.xy;
					    u_xlat9.z = u_xlat34 * in_TEXCOORD1.z;
					    u_xlat10.z = u_xlat34 * in_TEXCOORD2.z;
					    u_xlat2.x = dot(u_xlat9.xyz, in_TEXCOORD0.xyz);
					    u_xlat2.y = dot(u_xlat9.xyz, in_TEXCOORD1.xyz);
					    u_xlat2.z = dot(u_xlat9.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat9.x = dot(u_xlat10.xyz, in_TEXCOORD0.xyz);
					    u_xlat9.y = dot(u_xlat10.xyz, in_TEXCOORD1.xyz);
					    u_xlat9.z = dot(u_xlat10.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat6.xyz * in_NORMAL0.yyy;
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat0.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat6.xyz * in_NORMAL0.xxx + u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    vs_TEXCOORD0.z = float(1.0) / u_xlat1.x;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat12.xxx;
					    u_xlat1.x = (-u_xlat12.x) + 1.0;
					    u_xlat3.w = sqrt(u_xlat1.x);
					    u_xlat1 = (bool(u_xlatb33)) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat3;
					    u_xlat3.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat3.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat3.xyz + in_POSITION0.xyz;
					    u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD0.w = u_xlat1.w;
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy;
					    u_xlat1.xy = u_xlat0.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat12.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat12.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlat2.xyz = u_xlat0.yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat2.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat3.xyz;
					    u_xlat6.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat6.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat6.xyz;
					    u_xlat6.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat6.yyy;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat6.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat3.xyz;
					    vs_TEXCOORD2.xyz = u_xlat3.xyz * u_xlat6.zzz + u_xlat2.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat33 = dot(u_xlat7.xyz, u_xlat2.xyz);
					    u_xlat1.xyz = vec3(u_xlat33) * unity_MatrixV[1].xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat34 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat1.xyz = unity_MatrixV[0].xyz * vec3(u_xlat33) + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_MatrixV[2].xyz * vec3(u_xlat34) + u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat1.y = dot(u_xlat7.xyz, u_xlat0.xyz);
					    u_xlat1.z = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat11.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat22 = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = vec3(u_xlat22) * unity_MatrixV[1].xyz;
					    u_xlat11.xyz = unity_MatrixV[0].xyz * u_xlat11.xxx + u_xlat1.xyz;
					    vs_TEXCOORD4.xyz = unity_MatrixV[2].xyz * u_xlat0.xxx + u_xlat11.xyz;
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
						mat4x4 unity_MatrixInvV;
						mat4x4 unity_MatrixVP;
						vec4 unused_4_5[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec2 in_TEXCOORD3;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					vec3 u_xlat13;
					float u_xlat22;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat0.y = unity_MatrixV[2].y;
					    u_xlat0.z = unity_MatrixV[0].y;
					    u_xlat0.x = unity_MatrixV[1].y;
					    u_xlat1.xy = in_POSITION0.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * in_POSITION0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * in_POSITION0.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat12.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat12.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlatb33 = glstate_matrix_projection[0].w==0.0;
					    u_xlatb34 = glstate_matrix_projection[1].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlatb34 = glstate_matrix_projection[2].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlat34 = in_TEXCOORD3.x * _RadiusScale;
					    u_xlat2.x = u_xlat34 * in_TEXCOORD0.w;
					    u_xlat13.x = float(1.0) / u_xlat2.x;
					    u_xlat2.z = u_xlat34 * in_TEXCOORD1.w;
					    u_xlat34 = u_xlat34 * in_TEXCOORD2.w;
					    u_xlat13.z = float(1.0) / u_xlat2.z;
					    u_xlat3.xy = u_xlat13.xz * in_TEXCOORD0.xy;
					    u_xlat36 = float(1.0) / u_xlat34;
					    u_xlat3.z = u_xlat36 * in_TEXCOORD0.z;
					    u_xlat4.x = dot(u_xlat3.xyz, in_TEXCOORD0.xyz);
					    u_xlat4.y = dot(u_xlat3.xyz, in_TEXCOORD1.xyz);
					    u_xlat4.z = dot(u_xlat3.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat5.xy = u_xlat13.xz * in_TEXCOORD1.xy;
					    u_xlat6.xy = u_xlat13.xz * in_TEXCOORD2.xy;
					    u_xlat5.z = u_xlat36 * in_TEXCOORD1.z;
					    u_xlat6.z = u_xlat36 * in_TEXCOORD2.z;
					    u_xlat7.x = dot(u_xlat5.xyz, in_TEXCOORD0.xyz);
					    u_xlat7.y = dot(u_xlat5.xyz, in_TEXCOORD1.xyz);
					    u_xlat7.z = dot(u_xlat5.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.y = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat5.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat5.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat5.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat3.zxy);
					    u_xlat0.xyz = (-u_xlat3.yzx) * u_xlat0.yzx + (-u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yzx * (-u_xlat3.zxy);
					    u_xlat1.xyz = (-u_xlat3.yzx) * u_xlat0.zxy + (-u_xlat1.xyz);
					    u_xlat13.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13.x = inversesqrt(u_xlat13.x);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
					    u_xlat6.xy = u_xlat2.xz * in_TEXCOORD0.xy;
					    u_xlat6.z = u_xlat34 * in_TEXCOORD0.z;
					    u_xlat8.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat8.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat8.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat9.xy = u_xlat2.xz * in_TEXCOORD1.xy;
					    u_xlat10.xy = u_xlat2.xz * in_TEXCOORD2.xy;
					    u_xlat9.z = u_xlat34 * in_TEXCOORD1.z;
					    u_xlat10.z = u_xlat34 * in_TEXCOORD2.z;
					    u_xlat2.x = dot(u_xlat9.xyz, in_TEXCOORD0.xyz);
					    u_xlat2.y = dot(u_xlat9.xyz, in_TEXCOORD1.xyz);
					    u_xlat2.z = dot(u_xlat9.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat9.x = dot(u_xlat10.xyz, in_TEXCOORD0.xyz);
					    u_xlat9.y = dot(u_xlat10.xyz, in_TEXCOORD1.xyz);
					    u_xlat9.z = dot(u_xlat10.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat6.xyz * in_NORMAL0.yyy;
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat0.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat6.xyz * in_NORMAL0.xxx + u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    vs_TEXCOORD0.z = float(1.0) / u_xlat1.x;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat12.xxx;
					    u_xlat1.x = (-u_xlat12.x) + 1.0;
					    u_xlat3.w = sqrt(u_xlat1.x);
					    u_xlat1 = (bool(u_xlatb33)) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat3;
					    u_xlat3.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat3.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat3.xyz + in_POSITION0.xyz;
					    u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD0.w = u_xlat1.w;
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy;
					    u_xlat2.xy = u_xlat0.yy * unity_MatrixV[1].xy;
					    u_xlat2.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_MatrixV[3].xy;
					    u_xlat13.xyz = u_xlat2.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat2.xyz = unity_MatrixInvV[0].xyz * u_xlat2.xxx + u_xlat13.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_MatrixInvV[3].xyz;
					    u_xlat2.xyz = (bool(u_xlatb33)) ? u_xlat2.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
					    u_xlat3.xyz = u_xlat0.yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    vs_TEXCOORD1.xyz = unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat3.xyz;
					    u_xlat6.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat6.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat6.xyz;
					    u_xlat8.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat8.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat8.xyz;
					    u_xlat8.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat8.xyz;
					    u_xlat8.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz * u_xlat8.yyy;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat8.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat6.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat6.xyz;
					    vs_TEXCOORD2.xyz = u_xlat6.xyz * u_xlat8.zzz + u_xlat3.xyz;
					    u_xlat3.x = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat3.y = dot(u_xlat7.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat33 = dot(u_xlat7.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = vec3(u_xlat33) * unity_MatrixV[1].xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat35 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = unity_MatrixV[0].xyz * vec3(u_xlat33) + u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = unity_MatrixV[2].xyz * vec3(u_xlat35) + u_xlat2.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat7.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat11.x = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat7.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vec3(u_xlat22) * unity_MatrixV[1].xyz;
					    u_xlat11.xyz = unity_MatrixV[0].xyz * u_xlat11.xxx + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = unity_MatrixV[2].xyz * u_xlat0.xxx + u_xlat11.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
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
						mat4x4 unity_MatrixInvV;
						mat4x4 unity_MatrixVP;
						vec4 unused_4_5[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec2 in_TEXCOORD3;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					vec3 u_xlat13;
					float u_xlat22;
					float u_xlat33;
					bool u_xlatb33;
					float u_xlat34;
					bool u_xlatb34;
					float u_xlat35;
					float u_xlat36;
					void main()
					{
					    u_xlat0.y = unity_MatrixV[2].y;
					    u_xlat0.z = unity_MatrixV[0].y;
					    u_xlat0.x = unity_MatrixV[1].y;
					    u_xlat1.xy = in_POSITION0.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * in_POSITION0.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * in_POSITION0.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat12.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat12.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlatb33 = glstate_matrix_projection[0].w==0.0;
					    u_xlatb34 = glstate_matrix_projection[1].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlatb34 = glstate_matrix_projection[2].w==0.0;
					    u_xlatb33 = u_xlatb33 && u_xlatb34;
					    u_xlat1.xyz = (bool(u_xlatb33)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-in_POSITION0.xyz);
					    u_xlat34 = in_TEXCOORD3.x * _RadiusScale;
					    u_xlat2.x = u_xlat34 * in_TEXCOORD0.w;
					    u_xlat13.x = float(1.0) / u_xlat2.x;
					    u_xlat2.z = u_xlat34 * in_TEXCOORD1.w;
					    u_xlat34 = u_xlat34 * in_TEXCOORD2.w;
					    u_xlat13.z = float(1.0) / u_xlat2.z;
					    u_xlat3.xy = u_xlat13.xz * in_TEXCOORD0.xy;
					    u_xlat36 = float(1.0) / u_xlat34;
					    u_xlat3.z = u_xlat36 * in_TEXCOORD0.z;
					    u_xlat4.x = dot(u_xlat3.xyz, in_TEXCOORD0.xyz);
					    u_xlat4.y = dot(u_xlat3.xyz, in_TEXCOORD1.xyz);
					    u_xlat4.z = dot(u_xlat3.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.x = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat5.xy = u_xlat13.xz * in_TEXCOORD1.xy;
					    u_xlat6.xy = u_xlat13.xz * in_TEXCOORD2.xy;
					    u_xlat5.z = u_xlat36 * in_TEXCOORD1.z;
					    u_xlat6.z = u_xlat36 * in_TEXCOORD2.z;
					    u_xlat7.x = dot(u_xlat5.xyz, in_TEXCOORD0.xyz);
					    u_xlat7.y = dot(u_xlat5.xyz, in_TEXCOORD1.xyz);
					    u_xlat7.z = dot(u_xlat5.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.y = dot(u_xlat7.xyz, u_xlat1.xyz);
					    u_xlat5.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat5.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat5.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat0.xyz * (-u_xlat3.zxy);
					    u_xlat0.xyz = (-u_xlat3.yzx) * u_xlat0.yzx + (-u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx;
					    u_xlat1.xyz = u_xlat0.yzx * (-u_xlat3.zxy);
					    u_xlat1.xyz = (-u_xlat3.yzx) * u_xlat0.zxy + (-u_xlat1.xyz);
					    u_xlat13.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13.x = inversesqrt(u_xlat13.x);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat13.xxx;
					    u_xlat6.xy = u_xlat2.xz * in_TEXCOORD0.xy;
					    u_xlat6.z = u_xlat34 * in_TEXCOORD0.z;
					    u_xlat8.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat8.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat8.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat9.xy = u_xlat2.xz * in_TEXCOORD1.xy;
					    u_xlat10.xy = u_xlat2.xz * in_TEXCOORD2.xy;
					    u_xlat9.z = u_xlat34 * in_TEXCOORD1.z;
					    u_xlat10.z = u_xlat34 * in_TEXCOORD2.z;
					    u_xlat2.x = dot(u_xlat9.xyz, in_TEXCOORD0.xyz);
					    u_xlat2.y = dot(u_xlat9.xyz, in_TEXCOORD1.xyz);
					    u_xlat2.z = dot(u_xlat9.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat9.x = dot(u_xlat10.xyz, in_TEXCOORD0.xyz);
					    u_xlat9.y = dot(u_xlat10.xyz, in_TEXCOORD1.xyz);
					    u_xlat9.z = dot(u_xlat10.xyz, in_TEXCOORD2.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat6.xyz * in_NORMAL0.yyy;
					    u_xlat6.x = dot(u_xlat8.xyz, u_xlat0.xyz);
					    u_xlat6.y = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat6.z = dot(u_xlat9.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat6.xyz * in_NORMAL0.xxx + u_xlat1.xyz;
					    u_xlat1.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12.x = float(1.0) / u_xlat1.x;
					    u_xlat1.x = sqrt(u_xlat1.x);
					    vs_TEXCOORD0.z = float(1.0) / u_xlat1.x;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat12.xxx;
					    u_xlat1.x = (-u_xlat12.x) + 1.0;
					    u_xlat3.w = sqrt(u_xlat1.x);
					    u_xlat1 = (bool(u_xlatb33)) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat3;
					    u_xlat3.x = dot(u_xlat8.xyz, u_xlat1.xyz);
					    u_xlat3.y = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(u_xlat9.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat3.xyz + in_POSITION0.xyz;
					    u_xlat0.xyz = u_xlat1.www * u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD0.w = u_xlat1.w;
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy;
					    u_xlat2.xy = u_xlat0.yy * unity_MatrixV[1].xy;
					    u_xlat2.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_MatrixV[3].xy;
					    u_xlat13.xyz = u_xlat2.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat2.xyz = unity_MatrixInvV[0].xyz * u_xlat2.xxx + u_xlat13.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_MatrixInvV[3].xyz;
					    u_xlat2.xyz = (bool(u_xlatb33)) ? u_xlat2.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz + (-in_POSITION0.xyz);
					    u_xlat3.xyz = u_xlat0.yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    vs_TEXCOORD1.xyz = unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yyy * unity_MatrixV[1].xyz;
					    u_xlat3.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[0].xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[0].zzz + u_xlat3.xyz;
					    u_xlat3.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[0].www + u_xlat3.xyz;
					    u_xlat6.xyz = unity_ObjectToWorld[1].yyy * unity_MatrixV[1].xyz;
					    u_xlat6.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[1].xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[1].zzz + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[1].www + u_xlat6.xyz;
					    u_xlat8.xyz = _WorldSpaceLightPos0.yyy * unity_WorldToObject[1].xyz;
					    u_xlat8.xyz = unity_WorldToObject[0].xyz * _WorldSpaceLightPos0.xxx + u_xlat8.xyz;
					    u_xlat8.xyz = unity_WorldToObject[2].xyz * _WorldSpaceLightPos0.zzz + u_xlat8.xyz;
					    u_xlat8.xyz = unity_WorldToObject[3].xyz * _WorldSpaceLightPos0.www + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz * u_xlat8.yyy;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat8.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_ObjectToWorld[2].yyy * unity_MatrixV[1].xyz;
					    u_xlat6.xyz = unity_MatrixV[0].xyz * unity_ObjectToWorld[2].xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[2].xyz * unity_ObjectToWorld[2].zzz + u_xlat6.xyz;
					    u_xlat6.xyz = unity_MatrixV[3].xyz * unity_ObjectToWorld[2].www + u_xlat6.xyz;
					    vs_TEXCOORD2.xyz = u_xlat6.xyz * u_xlat8.zzz + u_xlat3.xyz;
					    u_xlat3.x = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat3.y = dot(u_xlat7.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat33 = dot(u_xlat7.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = vec3(u_xlat33) * unity_MatrixV[1].xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat35 = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat2.xyz = unity_MatrixV[0].xyz * vec3(u_xlat33) + u_xlat2.xyz;
					    vs_TEXCOORD3.xyz = unity_MatrixV[2].xyz * vec3(u_xlat35) + u_xlat2.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat2.y = dot(u_xlat7.xyz, u_xlat0.xyz);
					    u_xlat2.z = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat0.x = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat11.x = dot(u_xlat4.xyz, u_xlat2.xyz);
					    u_xlat22 = dot(u_xlat7.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = vec3(u_xlat22) * unity_MatrixV[1].xyz;
					    u_xlat11.xyz = unity_MatrixV[0].xyz * u_xlat11.xxx + u_xlat2.xyz;
					    vs_TEXCOORD4.xyz = unity_MatrixV[2].xyz * u_xlat0.xxx + u_xlat11.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD6.zw = u_xlat1.zw;
					    vs_TEXCOORD6.xy = u_xlat0.zz + u_xlat0.xw;
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
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_2_1[4];
						mat4x4 glstate_matrix_projection;
						vec4 unused_2_3[14];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_COLOR0;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					bool u_xlatb4;
					float u_xlat5;
					float u_xlat8;
					float u_xlat12;
					bool u_xlatb12;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.x / vs_TEXCOORD0.w;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlatb4 = u_xlat0.x<0.0;
					    if(((int(u_xlatb4) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = vs_TEXCOORD0.z * u_xlat0.x + 1.0;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat4.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz + vs_TEXCOORD3.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat0.xz = u_xlat4.yy * glstate_matrix_projection[1].zw;
					    u_xlat0.xy = glstate_matrix_projection[0].zw * u_xlat4.xx + u_xlat0.xz;
					    u_xlat0.xy = glstate_matrix_projection[2].zw * u_xlat4.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + glstate_matrix_projection[3].zw;
					    u_xlat2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat8 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat3.xyz = vec3(u_xlat8) * vs_TEXCOORD2.xyz;
					    u_xlat8 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = mix(vec3(0.0, 0.0, 0.0), unity_ProbeVolumeWorldToObject[3].xyz, vec3(bvec3(u_xlatb12)));
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat5 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat12, u_xlat5);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat12 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat8) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    gl_FragDepth = u_xlat0.x / u_xlat0.y;
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
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[46];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_2;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_2_2[14];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_COLOR0;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					bool u_xlatb3;
					float u_xlat4;
					float u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.x / vs_TEXCOORD0.w;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlatb3 = u_xlat0.x<0.0;
					    if(((int(u_xlatb3) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = vs_TEXCOORD0.z * u_xlat0.x + 1.0;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat3.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz + vs_TEXCOORD3.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat0.xz = u_xlat3.yy * glstate_matrix_projection[1].zw;
					    u_xlat0.xy = glstate_matrix_projection[0].zw * u_xlat3.xx + u_xlat0.xz;
					    u_xlat0.xy = glstate_matrix_projection[2].zw * u_xlat3.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + glstate_matrix_projection[3].zw;
					    u_xlat6 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat2.xyz = vec3(u_xlat6) * vs_TEXCOORD2.xyz;
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = mix(vec3(0.0, 0.0, 0.0), unity_ProbeVolumeWorldToObject[3].xyz, vec3(bvec3(u_xlatb9)));
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat4 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat9, u_xlat4);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat9 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * _LightColor0.xyz;
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    gl_FragDepth = u_xlat0.x / u_xlat0.y;
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
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_4_1[4];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						vec4 unused_4_4[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_COLOR0;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					bool u_xlatb4;
					vec2 u_xlat5;
					float u_xlat8;
					float u_xlat12;
					float u_xlat14;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.x / vs_TEXCOORD0.w;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlatb4 = u_xlat0.x<0.0;
					    if(((int(u_xlatb4) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = vs_TEXCOORD0.z * u_xlat0.x + 1.0;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat4.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz + vs_TEXCOORD3.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat0.xz = u_xlat4.yy * glstate_matrix_projection[1].zw;
					    u_xlat0.xy = glstate_matrix_projection[0].zw * u_xlat4.xx + u_xlat0.xz;
					    u_xlat0.xy = glstate_matrix_projection[2].zw * u_xlat4.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + glstate_matrix_projection[3].zw;
					    u_xlat2.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat8 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat8 = inversesqrt(u_xlat8);
					    u_xlat3.xyz = vec3(u_xlat8) * vs_TEXCOORD2.xyz;
					    u_xlat8 = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
					    u_xlat1.x = unity_MatrixV[0].z;
					    u_xlat1.y = unity_MatrixV[1].z;
					    u_xlat1.z = unity_MatrixV[2].z;
					    u_xlat12 = dot(_WorldSpaceCameraPos.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot((-unity_ShadowFadeCenterAndType.xyz), (-unity_ShadowFadeCenterAndType.xyz));
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = (-u_xlat12) + u_xlat1.x;
					    u_xlat12 = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat12;
					    u_xlat12 = u_xlat12 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb1){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = mix(vec3(0.0, 0.0, 0.0), unity_ProbeVolumeWorldToObject[3].xyz, vec3(bvec3(u_xlatb1)));
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat5.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat5.x, u_xlat14);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat1.x = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat5.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat10_3 = texture(_ShadowMapTexture, u_xlat5.xy);
					    u_xlat1.x = u_xlat1.x + (-u_xlat10_3.x);
					    u_xlat12 = u_xlat12 * u_xlat1.x + u_xlat10_3.x;
					    u_xlat1.xyz = vec3(u_xlat8) * _LightColor0.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12) + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vs_COLOR0.xyz;
					    gl_FragDepth = u_xlat0.x / u_xlat0.y;
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
						vec4 unused_0_0[2];
						mat4x4 _Camera_to_World;
						vec4 unused_0_2[2];
						vec4 _LightColor0;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_4[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_6;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						vec4 unused_4_3[10];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_COLOR0;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec2 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					bool u_xlatb7;
					float u_xlat8;
					float u_xlat14;
					vec2 u_xlat15;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					void main()
					{
					    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.x / vs_TEXCOORD0.w;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlatb7 = u_xlat0.x<0.0;
					    if(((int(u_xlatb7) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = vs_TEXCOORD0.z * u_xlat0.x + 1.0;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat7.xyz = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat0.xxx * vs_TEXCOORD4.xyz + vs_TEXCOORD3.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat7.yy * glstate_matrix_projection[1].zw;
					    u_xlat2.xy = glstate_matrix_projection[0].zw * u_xlat7.xx + u_xlat2.xy;
					    u_xlat2.xy = glstate_matrix_projection[2].zw * u_xlat7.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + glstate_matrix_projection[3].zw;
					    u_xlat3.x = dot(unity_MatrixV[0].xyz, u_xlat1.xyz);
					    u_xlat3.y = dot(unity_MatrixV[1].xyz, u_xlat1.xyz);
					    u_xlat3.z = dot(unity_MatrixV[2].xyz, u_xlat1.xyz);
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlat4.xyz = u_xlat7.yyy * _Camera_to_World[1].xyz;
					        u_xlat4.xyz = _Camera_to_World[0].xyz * u_xlat7.xxx + u_xlat4.xyz;
					        u_xlat7.xyz = _Camera_to_World[2].xyz * u_xlat7.zzz + u_xlat4.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + _Camera_to_World[3].xyz;
					        u_xlatb22 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = u_xlat7.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * u_xlat7.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * u_xlat7.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat7.x = u_xlat4.y * 0.25;
					        u_xlat14 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat21 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat7.x = max(u_xlat14, u_xlat7.x);
					        u_xlat4.x = min(u_xlat21, u_xlat7.x);
					        u_xlat10_5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat7.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat7.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat3.w = 1.0;
					        u_xlat5.x = dot(u_xlat10_5, u_xlat3);
					        u_xlat5.y = dot(u_xlat10_6, u_xlat3);
					        u_xlat5.z = dot(u_xlat10_4, u_xlat3);
					    } else {
					        u_xlat3.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat3);
					        u_xlat5.y = dot(unity_SHAg, u_xlat3);
					        u_xlat5.z = dot(unity_SHAb, u_xlat3);
					    //ENDIF
					    }
					    u_xlat7.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat7.xyz = log2(u_xlat7.xyz);
					    u_xlat7.xyz = u_xlat7.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat7.xyz = exp2(u_xlat7.xyz);
					    u_xlat7.xyz = u_xlat7.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat7.xyz = max(u_xlat7.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat22 = dot(vs_TEXCOORD2.xyz, vs_TEXCOORD2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat3.xyz = vec3(u_xlat22) * vs_TEXCOORD2.xyz;
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat3.x = unity_MatrixV[0].z;
					    u_xlat3.y = unity_MatrixV[1].z;
					    u_xlat3.z = unity_MatrixV[2].z;
					    u_xlat8 = dot(_WorldSpaceCameraPos.xyz, u_xlat3.xyz);
					    u_xlat15.x = dot((-unity_ShadowFadeCenterAndType.xyz), (-unity_ShadowFadeCenterAndType.xyz));
					    u_xlat15.x = sqrt(u_xlat15.x);
					    u_xlat15.x = (-u_xlat8) + u_xlat15.x;
					    u_xlat8 = unity_ShadowFadeCenterAndType.w * u_xlat15.x + u_xlat8;
					    u_xlat8 = u_xlat8 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat8 = clamp(u_xlat8, 0.0, 1.0);
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = mix(vec3(0.0, 0.0, 0.0), unity_ProbeVolumeWorldToObject[3].xyz, vec3(bvec3(u_xlatb0)));
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat0.x = u_xlat3.y * 0.25 + 0.75;
					        u_xlat15.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat0.x, u_xlat15.x);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat0.x = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat15.xy = vs_TEXCOORD6.xy / vs_TEXCOORD6.ww;
					    u_xlat10_3 = texture(_ShadowMapTexture, u_xlat15.xy);
					    u_xlat0.x = u_xlat0.x + (-u_xlat10_3.x);
					    u_xlat0.x = u_xlat8 * u_xlat0.x + u_xlat10_3.x;
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat0.xxx + u_xlat7.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vs_COLOR0.xyz;
					    gl_FragDepth = u_xlat2.x / u_xlat2.y;
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
			GpuProgramID 75841
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
						vec4 _Color;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						mat4x4 unity_MatrixInvV;
						mat4x4 unity_MatrixVP;
						vec4 unused_1_5[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec2 in_TEXCOORD3;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bool u_xlatb8;
					vec3 u_xlat9;
					float u_xlat16;
					float u_xlat17;
					float u_xlat26;
					void main()
					{
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy;
					    u_xlatb0 = glstate_matrix_projection[0].w==0.0;
					    u_xlatb8 = glstate_matrix_projection[1].w==0.0;
					    u_xlatb0 = u_xlatb8 && u_xlatb0;
					    u_xlatb8 = glstate_matrix_projection[2].w==0.0;
					    u_xlatb0 = u_xlatb8 && u_xlatb0;
					    u_xlat8.xy = in_POSITION0.yy * unity_MatrixV[1].xy;
					    u_xlat8.xy = unity_MatrixV[0].xy * in_POSITION0.xx + u_xlat8.xy;
					    u_xlat8.xy = unity_MatrixV[2].xy * in_POSITION0.zz + u_xlat8.xy;
					    u_xlat8.xy = u_xlat8.xy + unity_MatrixV[3].xy;
					    u_xlat1.xyz = u_xlat8.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat8.xyz = unity_MatrixInvV[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
					    u_xlat8.xyz = u_xlat8.xyz + unity_MatrixInvV[3].xyz;
					    u_xlat8.xyz = (bool(u_xlatb0)) ? u_xlat8.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
					    u_xlat1.x = in_TEXCOORD3.x * _RadiusScale;
					    u_xlat1.y = u_xlat1.x * in_TEXCOORD0.w;
					    u_xlat17 = float(1.0) / u_xlat1.y;
					    u_xlat2.x = u_xlat17 * in_TEXCOORD0.x;
					    u_xlat1.w = u_xlat1.x * in_TEXCOORD1.w;
					    u_xlat1.x = u_xlat1.x * in_TEXCOORD2.w;
					    u_xlat26 = float(1.0) / u_xlat1.w;
					    u_xlat2.y = u_xlat26 * in_TEXCOORD0.y;
					    u_xlat3.x = float(1.0) / u_xlat1.x;
					    u_xlat2.z = u_xlat3.x * in_TEXCOORD0.z;
					    u_xlat4.x = dot(u_xlat2.xyz, in_TEXCOORD0.xyz);
					    u_xlat4.y = dot(u_xlat2.xyz, in_TEXCOORD1.xyz);
					    u_xlat4.z = dot(u_xlat2.xyz, in_TEXCOORD2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat8.xyz);
					    u_xlat4.x = u_xlat17 * in_TEXCOORD1.x;
					    u_xlat5.x = u_xlat17 * in_TEXCOORD2.x;
					    u_xlat4.y = u_xlat26 * in_TEXCOORD1.y;
					    u_xlat5.y = u_xlat26 * in_TEXCOORD2.y;
					    u_xlat4.z = u_xlat3.x * in_TEXCOORD1.z;
					    u_xlat5.z = u_xlat3.x * in_TEXCOORD2.z;
					    u_xlat3.x = dot(u_xlat4.xyz, in_TEXCOORD0.xyz);
					    u_xlat3.y = dot(u_xlat4.xyz, in_TEXCOORD1.xyz);
					    u_xlat3.z = dot(u_xlat4.xyz, in_TEXCOORD2.xyz);
					    u_xlat2.y = dot(u_xlat3.xyz, u_xlat8.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, in_TEXCOORD0.xyz);
					    u_xlat3.y = dot(u_xlat5.xyz, in_TEXCOORD1.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, in_TEXCOORD2.xyz);
					    u_xlat2.z = dot(u_xlat3.xyz, u_xlat8.xyz);
					    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = float(1.0) / u_xlat8.x;
					    u_xlat8.x = sqrt(u_xlat8.x);
					    vs_TEXCOORD0.z = float(1.0) / u_xlat8.x;
					    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat16);
					    u_xlat8.x = (-u_xlat16) + 1.0;
					    u_xlat3.w = sqrt(u_xlat8.x);
					    u_xlat3 = (bool(u_xlatb0)) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat3;
					    vs_TEXCOORD0.w = u_xlat3.w;
					    u_xlat4.y = unity_MatrixV[2].y;
					    u_xlat4.z = unity_MatrixV[0].y;
					    u_xlat4.x = unity_MatrixV[1].y;
					    u_xlat8.xyz = (-u_xlat2.zxy) * u_xlat4.xyz;
					    u_xlat8.xyz = (-u_xlat2.yzx) * u_xlat4.yzx + (-u_xlat8.xyz);
					    u_xlat17 = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat17);
					    u_xlat4.xyz = u_xlat8.yzx * (-u_xlat2.zxy);
					    u_xlat2.xyz = (-u_xlat2.yzx) * u_xlat8.zxy + (-u_xlat4.xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat4.xyz = u_xlat1.ywx * in_TEXCOORD0.xyz;
					    u_xlat5.x = dot(u_xlat4.xyz, in_TEXCOORD0.xyz);
					    u_xlat5.y = dot(u_xlat4.xyz, in_TEXCOORD1.xyz);
					    u_xlat5.z = dot(u_xlat4.xyz, in_TEXCOORD2.xyz);
					    u_xlat4.x = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat6.xyz = u_xlat1.ywx * in_TEXCOORD1.xyz;
					    u_xlat7.xyz = u_xlat1.ywx * in_TEXCOORD2.xyz;
					    u_xlat1.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat1.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat1.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat4.y = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat6.x = dot(u_xlat7.xyz, in_TEXCOORD0.xyz);
					    u_xlat6.y = dot(u_xlat7.xyz, in_TEXCOORD1.xyz);
					    u_xlat6.z = dot(u_xlat7.xyz, in_TEXCOORD2.xyz);
					    u_xlat4.z = dot(u_xlat6.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat4.xyz * in_NORMAL0.yyy;
					    u_xlat4.x = dot(u_xlat5.xyz, u_xlat8.xyz);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(u_xlat1.xyz, u_xlat8.xyz);
					    u_xlat5.y = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(u_xlat6.xyz, u_xlat8.xyz);
					    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.xyz = u_xlat5.xyz + in_POSITION0.xyz;
					    u_xlat1.xyz = u_xlat4.xyz * in_NORMAL0.xxx + u_xlat2.xyz;
					    u_xlat8.xyz = u_xlat3.www * u_xlat1.xyz + u_xlat8.xyz;
					    u_xlat1.xy = u_xlat8.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * u_xlat8.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * u_xlat8.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat9.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat9.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = u_xlat8.xyz + (-u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat1.yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyw = unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1 = u_xlat8.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat8.xxxx + u_xlat1;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat8.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
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
						vec4 _Color;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						mat4x4 unity_MatrixInvV;
						mat4x4 unity_MatrixVP;
						vec4 unused_1_5[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					in  vec2 in_TEXCOORD3;
					out vec4 vs_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bool u_xlatb8;
					vec3 u_xlat9;
					float u_xlat16;
					float u_xlat17;
					float u_xlat26;
					void main()
					{
					    vs_COLOR0 = in_COLOR0 * _Color;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy;
					    u_xlatb0 = glstate_matrix_projection[0].w==0.0;
					    u_xlatb8 = glstate_matrix_projection[1].w==0.0;
					    u_xlatb0 = u_xlatb8 && u_xlatb0;
					    u_xlatb8 = glstate_matrix_projection[2].w==0.0;
					    u_xlatb0 = u_xlatb8 && u_xlatb0;
					    u_xlat8.xy = in_POSITION0.yy * unity_MatrixV[1].xy;
					    u_xlat8.xy = unity_MatrixV[0].xy * in_POSITION0.xx + u_xlat8.xy;
					    u_xlat8.xy = unity_MatrixV[2].xy * in_POSITION0.zz + u_xlat8.xy;
					    u_xlat8.xy = u_xlat8.xy + unity_MatrixV[3].xy;
					    u_xlat1.xyz = u_xlat8.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat8.xyz = unity_MatrixInvV[0].xyz * u_xlat8.xxx + u_xlat1.xyz;
					    u_xlat8.xyz = u_xlat8.xyz + unity_MatrixInvV[3].xyz;
					    u_xlat8.xyz = (bool(u_xlatb0)) ? u_xlat8.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat8.xyz = u_xlat8.xyz + (-in_POSITION0.xyz);
					    u_xlat1.x = in_TEXCOORD3.x * _RadiusScale;
					    u_xlat1.y = u_xlat1.x * in_TEXCOORD0.w;
					    u_xlat17 = float(1.0) / u_xlat1.y;
					    u_xlat2.x = u_xlat17 * in_TEXCOORD0.x;
					    u_xlat1.w = u_xlat1.x * in_TEXCOORD1.w;
					    u_xlat1.x = u_xlat1.x * in_TEXCOORD2.w;
					    u_xlat26 = float(1.0) / u_xlat1.w;
					    u_xlat2.y = u_xlat26 * in_TEXCOORD0.y;
					    u_xlat3.x = float(1.0) / u_xlat1.x;
					    u_xlat2.z = u_xlat3.x * in_TEXCOORD0.z;
					    u_xlat4.x = dot(u_xlat2.xyz, in_TEXCOORD0.xyz);
					    u_xlat4.y = dot(u_xlat2.xyz, in_TEXCOORD1.xyz);
					    u_xlat4.z = dot(u_xlat2.xyz, in_TEXCOORD2.xyz);
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat8.xyz);
					    u_xlat4.x = u_xlat17 * in_TEXCOORD1.x;
					    u_xlat5.x = u_xlat17 * in_TEXCOORD2.x;
					    u_xlat4.y = u_xlat26 * in_TEXCOORD1.y;
					    u_xlat5.y = u_xlat26 * in_TEXCOORD2.y;
					    u_xlat4.z = u_xlat3.x * in_TEXCOORD1.z;
					    u_xlat5.z = u_xlat3.x * in_TEXCOORD2.z;
					    u_xlat3.x = dot(u_xlat4.xyz, in_TEXCOORD0.xyz);
					    u_xlat3.y = dot(u_xlat4.xyz, in_TEXCOORD1.xyz);
					    u_xlat3.z = dot(u_xlat4.xyz, in_TEXCOORD2.xyz);
					    u_xlat2.y = dot(u_xlat3.xyz, u_xlat8.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, in_TEXCOORD0.xyz);
					    u_xlat3.y = dot(u_xlat5.xyz, in_TEXCOORD1.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, in_TEXCOORD2.xyz);
					    u_xlat2.z = dot(u_xlat3.xyz, u_xlat8.xyz);
					    u_xlat8.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = float(1.0) / u_xlat8.x;
					    u_xlat8.x = sqrt(u_xlat8.x);
					    vs_TEXCOORD0.z = float(1.0) / u_xlat8.x;
					    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat16);
					    u_xlat8.x = (-u_xlat16) + 1.0;
					    u_xlat3.w = sqrt(u_xlat8.x);
					    u_xlat3 = (bool(u_xlatb0)) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat3;
					    vs_TEXCOORD0.w = u_xlat3.w;
					    u_xlat4.y = unity_MatrixV[2].y;
					    u_xlat4.z = unity_MatrixV[0].y;
					    u_xlat4.x = unity_MatrixV[1].y;
					    u_xlat8.xyz = (-u_xlat2.zxy) * u_xlat4.xyz;
					    u_xlat8.xyz = (-u_xlat2.yzx) * u_xlat4.yzx + (-u_xlat8.xyz);
					    u_xlat17 = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat8.xyz = u_xlat8.xyz * vec3(u_xlat17);
					    u_xlat4.xyz = u_xlat8.yzx * (-u_xlat2.zxy);
					    u_xlat2.xyz = (-u_xlat2.yzx) * u_xlat8.zxy + (-u_xlat4.xyz);
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat4.xyz = u_xlat1.ywx * in_TEXCOORD0.xyz;
					    u_xlat5.x = dot(u_xlat4.xyz, in_TEXCOORD0.xyz);
					    u_xlat5.y = dot(u_xlat4.xyz, in_TEXCOORD1.xyz);
					    u_xlat5.z = dot(u_xlat4.xyz, in_TEXCOORD2.xyz);
					    u_xlat4.x = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat6.xyz = u_xlat1.ywx * in_TEXCOORD1.xyz;
					    u_xlat7.xyz = u_xlat1.ywx * in_TEXCOORD2.xyz;
					    u_xlat1.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat1.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat1.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat4.y = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat6.x = dot(u_xlat7.xyz, in_TEXCOORD0.xyz);
					    u_xlat6.y = dot(u_xlat7.xyz, in_TEXCOORD1.xyz);
					    u_xlat6.z = dot(u_xlat7.xyz, in_TEXCOORD2.xyz);
					    u_xlat4.z = dot(u_xlat6.xyz, u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat4.xyz * in_NORMAL0.yyy;
					    u_xlat4.x = dot(u_xlat5.xyz, u_xlat8.xyz);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat4.y = dot(u_xlat1.xyz, u_xlat8.xyz);
					    u_xlat5.y = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat4.z = dot(u_xlat6.xyz, u_xlat8.xyz);
					    u_xlat5.z = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.xyz = u_xlat5.xyz + in_POSITION0.xyz;
					    u_xlat1.xyz = u_xlat4.xyz * in_NORMAL0.xxx + u_xlat2.xyz;
					    u_xlat8.xyz = u_xlat3.www * u_xlat1.xyz + u_xlat8.xyz;
					    u_xlat1.xy = u_xlat8.yy * unity_MatrixV[1].xy;
					    u_xlat1.xy = unity_MatrixV[0].xy * u_xlat8.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_MatrixV[2].xy * u_xlat8.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_MatrixV[3].xy;
					    u_xlat9.xyz = u_xlat1.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat1.xyz = unity_MatrixInvV[0].xyz * u_xlat1.xxx + u_xlat9.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = (bool(u_xlatb0)) ? u_xlat1.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat1.xyz = u_xlat8.xyz + (-u_xlat1.xyz);
					    u_xlat2.xyz = u_xlat1.yyy * unity_MatrixV[1].xyz;
					    u_xlat1.xyw = unity_MatrixV[0].xyz * u_xlat1.xxx + u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_MatrixV[2].xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1 = u_xlat8.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat8.xxxx + u_xlat1;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat8.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
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
					
					layout(std140) uniform UnityShadows {
						vec4 unused_0_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_0_2[20];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_1_2[14];
					};
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_COLOR0;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec2 u_xlat2;
					bool u_xlatb2;
					float u_xlat4;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.x / vs_TEXCOORD0.w;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlatb2 = u_xlat0.x<0.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = vs_TEXCOORD0.z * u_xlat0.x + 1.0;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.xzw = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat1.z = vs_COLOR0.w * 0.9375;
					    u_xlat10_1 = texture(_DitherMaskLOD, u_xlat1.xyz);
					    u_xlat2.x = u_xlat10_1.w + -0.00999999978;
					    u_xlatb2 = u_xlat2.x<0.0;
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    u_xlat2.xy = u_xlat0.zz * glstate_matrix_projection[1].zw;
					    u_xlat0.xy = glstate_matrix_projection[0].zw * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = glstate_matrix_projection[2].zw * u_xlat0.ww + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + glstate_matrix_projection[3].zw;
					    u_xlat4 = unity_LightShadowBias.x / u_xlat0.y;
					    u_xlat4 = min(u_xlat4, 0.0);
					    u_xlat4 = max(u_xlat4, -1.0);
					    u_xlat0.x = u_xlat4 + u_xlat0.x;
					    u_xlat4 = min(u_xlat0.y, u_xlat0.x);
					    u_xlat4 = (-u_xlat0.x) + u_xlat4;
					    u_xlat0.x = unity_LightShadowBias.y * u_xlat4 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x / u_xlat0.y;
					    SV_Target0 = u_xlat0.xxxx;
					    gl_FragDepth = u_xlat0.x;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_CUBE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform UnityShadows {
						vec4 unused_0_0[5];
						vec4 unity_LightShadowBias;
						vec4 unused_0_2[20];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_1_2[14];
					};
					uniform  sampler3D _DitherMaskLOD;
					in  vec4 vs_COLOR0;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec2 u_xlat2;
					bool u_xlatb2;
					float u_xlat4;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.x / vs_TEXCOORD0.w;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlatb2 = u_xlat0.x<0.0;
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = vs_TEXCOORD0.z * u_xlat0.x + 1.0;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlat0.xzw = u_xlat0.xxx * vs_TEXCOORD1.xyz;
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xy = hlslcc_FragCoord.xy * vec2(0.25, 0.25);
					    u_xlat1.z = vs_COLOR0.w * 0.9375;
					    u_xlat10_1 = texture(_DitherMaskLOD, u_xlat1.xyz);
					    u_xlat2.x = u_xlat10_1.w + -0.00999999978;
					    u_xlatb2 = u_xlat2.x<0.0;
					    if(((int(u_xlatb2) * int(0xffffffffu)))!=0){discard;}
					    u_xlat2.xy = u_xlat0.zz * glstate_matrix_projection[1].zw;
					    u_xlat0.xy = glstate_matrix_projection[0].zw * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = glstate_matrix_projection[2].zw * u_xlat0.ww + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + glstate_matrix_projection[3].zw;
					    u_xlat4 = min(u_xlat0.y, u_xlat0.x);
					    u_xlat4 = (-u_xlat0.x) + u_xlat4;
					    u_xlat0.x = unity_LightShadowBias.y * u_xlat4 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x / u_xlat0.y;
					    SV_Target0 = u_xlat0.xxxx;
					    gl_FragDepth = u_xlat0.x;
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
}
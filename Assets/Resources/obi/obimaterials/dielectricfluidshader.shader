Shader "Obi/Fluid/DielectricFluid" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_Smoothness ("Smoothness", Range(0, 1)) = 0.8
		_ThicknessScale ("ThicknessScale", Range(0, 30)) = 5
		_RefractionCoeff ("Refraction", Range(-0.1, 0.1)) = 0.05
		_CloudinessColor ("CloudinessColor", Vector) = (1,1,1,1)
		_Cloudiness ("Cloudiness", Range(0, 30)) = 0
	}
	SubShader {
		Pass {
			Name "DielectricFluid"
			Tags { "LIGHTMODE" = "FORWARDBASE" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			GpuProgramID 35513
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
						vec4 unused_0_0[2];
						mat4x4 _Camera_to_World;
						vec3 _FarCorner;
						float _ThicknessCutoff;
						vec4 unused_0_4[3];
						float _ThicknessScale;
						float _RefractionCoeff;
						float _Smoothness;
						float _Cloudiness;
						vec4 _CloudinessColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[3];
						vec4 unity_OrthoParams;
					};
					layout(std140) uniform UnityPerCameraRare {
						vec4 unused_2_0[6];
						mat4x4 unity_CameraProjection;
						vec4 unused_2_2[12];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_3_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_4_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_4_2[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _Thickness;
					uniform  sampler2D _Normals;
					uniform  sampler2D _Refraction;
					uniform  samplerCube unity_SpecCube0;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat16_0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec3 u_xlat16_2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					bool u_xlatb10;
					vec3 u_xlat12;
					float u_xlat20;
					float u_xlat27;
					float u_xlat28;
					float u_xlat29;
					float u_xlat16_29;
					void main()
					{
					    u_xlat10_0 = texture(_Thickness, vs_TEXCOORD0.xy);
					    u_xlat1.x = u_xlat10_0.w * 10.0;
					    u_xlatb1 = u_xlat1.x<_ThicknessCutoff;
					    if(((int(u_xlatb1) * int(0xffffffffu)))!=0){discard;}
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb10 = unity_OrthoParams.w<0.5;
					    u_xlat2.xy = vs_TEXCOORD0.xy;
					    u_xlat2.z = -1.0;
					    u_xlat2.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, 0.0);
					    u_xlat2.xyz = u_xlat2.xyz * _FarCorner.xyz;
					    u_xlat3.xyz = u_xlat10_1.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz / _FarCorner.zzz;
					    u_xlat2.w = (-u_xlat10_1.x);
					    u_xlat1.xyz = (bool(u_xlatb10)) ? u_xlat3.xyz : u_xlat2.xyw;
					    u_xlat10_2 = texture(_Normals, vs_TEXCOORD0.xy);
					    u_xlat16_2.xyz = u_xlat10_2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
					    u_xlat3.xyz = u_xlat1.yyy * _Camera_to_World[1].xyz;
					    u_xlat3.xyz = _Camera_to_World[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = _Camera_to_World[2].xyz * u_xlat1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + _Camera_to_World[3].xyz;
					    u_xlat4.xyz = u_xlat16_2.yyy * _Camera_to_World[1].xyz;
					    u_xlat4.xyz = _Camera_to_World[0].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = _Camera_to_World[2].xyz * u_xlat16_2.zzz + u_xlat4.xyz;
					    u_xlat3.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat28 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat28 = inversesqrt(u_xlat28);
					    u_xlat3.xyz = vec3(u_xlat28) * u_xlat3.xyz;
					    u_xlat28 = (-_Smoothness) + 1.0;
					    u_xlat20 = dot((-u_xlat3.xyz), u_xlat4.xyz);
					    u_xlat20 = u_xlat20 + u_xlat20;
					    u_xlat5.xyz = u_xlat4.xyz * (-vec3(u_xlat20)) + (-u_xlat3.xyz);
					    u_xlat20 = u_xlat28 * 0.797884583;
					    u_xlat6.xy = (-vec2(u_xlat28)) * vec2(0.699999988, 0.797884583) + vec2(1.70000005, 1.0);
					    u_xlat29 = u_xlat28 * u_xlat6.x;
					    u_xlat29 = u_xlat29 * 6.0;
					    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat5.xyz, u_xlat29);
					    u_xlat16_29 = u_xlat10_5.w + -1.0;
					    u_xlat29 = unity_SpecCube0_HDR.w * u_xlat16_29 + 1.0;
					    u_xlat29 = u_xlat29 * unity_SpecCube0_HDR.x;
					    u_xlat16_2.xy = u_xlat10_0.ww * u_xlat16_2.xy;
					    u_xlat2.xy = u_xlat16_2.xy * vec2(vec2(_RefractionCoeff, _RefractionCoeff)) + vs_TEXCOORD0.xy;
					    u_xlat10_7 = texture(_Refraction, u_xlat2.xy);
					    u_xlat2.x = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat6.xzw = u_xlat2.xxx * _WorldSpaceLightPos0.xyz;
					    u_xlat8.xyz = _WorldSpaceLightPos0.xyz * u_xlat2.xxx + u_xlat3.xyz;
					    u_xlat2.x = dot(u_xlat8.xyz, u_xlat8.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat8.xyz = u_xlat2.xxx * u_xlat8.xyz;
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat8.xyz);
					    u_xlat2.y = dot(u_xlat4.xyz, u_xlat6.xzw);
					    u_xlat2.xy = max(u_xlat2.xy, vec2(0.0, 0.0));
					    u_xlat3.x = dot(u_xlat4.xyz, u_xlat3.xyz);
					    u_xlat3.x = max(u_xlat3.x, 0.0);
					    u_xlat16_0.xyz = (-u_xlat10_0.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat16_0.xyz = (-u_xlat10_0.www) * u_xlat16_0.xyz;
					    u_xlat0.xyz = u_xlat16_0.xyz * vec3(_ThicknessScale);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.44269502, 1.44269502, 1.44269502);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat12.xyz = u_xlat0.xyz * u_xlat10_7.xyz;
					    u_xlat27 = u_xlat10_0.w * _Cloudiness;
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlat0.xyz = (-u_xlat10_7.xyz) * u_xlat0.xyz + _CloudinessColor.xyz;
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat0.xyz + u_xlat12.xyz;
					    u_xlat27 = (-u_xlat3.x) + 1.0;
					    u_xlat12.x = u_xlat27 * u_xlat27;
					    u_xlat12.x = u_xlat12.x * u_xlat12.x;
					    u_xlat27 = u_xlat27 * u_xlat12.x;
					    u_xlat27 = u_xlat27 * 0.800000012 + 0.200000003;
					    u_xlat12.x = u_xlat2.y * u_xlat6.y + u_xlat20;
					    u_xlat20 = u_xlat3.x * u_xlat6.y + u_xlat20;
					    u_xlat20 = u_xlat12.x * u_xlat20 + 9.99999975e-06;
					    u_xlat20 = float(1.0) / u_xlat20;
					    u_xlat20 = u_xlat20 * 0.25;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat28 = u_xlat28 * u_xlat28;
					    u_xlat28 = max(u_xlat28, 9.99999975e-05);
					    u_xlat28 = 2.0 / u_xlat28;
					    u_xlat28 = u_xlat28 + -2.0;
					    u_xlat28 = max(u_xlat28, 9.99999975e-05);
					    u_xlat3.x = u_xlat28 + 2.0;
					    u_xlat3.x = u_xlat3.x * 0.159154937;
					    u_xlat2.x = log2(u_xlat2.x);
					    u_xlat28 = u_xlat28 * u_xlat2.x;
					    u_xlat28 = exp2(u_xlat28);
					    u_xlat28 = u_xlat3.x * u_xlat28;
					    u_xlat28 = u_xlat28 * u_xlat20;
					    u_xlat28 = u_xlat28 * 0.785398185;
					    u_xlat28 = max(u_xlat28, 9.99999975e-05);
					    u_xlat28 = sqrt(u_xlat28);
					    u_xlat2.xzw = vec3(u_xlat29) * u_xlat10_5.xyz + (-u_xlat0.xyz);
					    u_xlat0.xyz = vec3(u_xlat27) * u_xlat2.xzw + u_xlat0.xyz;
					    SV_Target0.xyz = vec3(u_xlat28) * u_xlat2.yyy + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_CameraProjection[1].zw;
					    u_xlat0.xy = unity_CameraProjection[0].zw * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_CameraProjection[2].zw * u_xlat1.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + unity_CameraProjection[3].zw;
					    u_xlat0.x = u_xlat0.x / u_xlat0.y;
					    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
					    gl_FragDepth = (-u_xlat0.x) + 1.0;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}
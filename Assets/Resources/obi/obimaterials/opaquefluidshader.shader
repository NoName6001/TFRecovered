Shader "Obi/Fluid/OpaqueFluid" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_Smoothness ("Smoothness", Range(0, 1)) = 0.75
	}
	SubShader {
		Pass {
			Name "OpaqueFluid"
			Tags { "LIGHTMODE" = "FORWARDBASE" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			GpuProgramID 53
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
						vec4 _LightColor0;
						vec4 unused_0_5;
						float _Smoothness;
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
					layout(std140) uniform UnityShadows {
						vec4 unused_4_0[6];
						vec4 _LightSplitsNear;
						vec4 _LightSplitsFar;
						mat4x4 unity_WorldToShadow[4];
						vec4 unused_4_4[14];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 glstate_lightmodel_ambient;
						vec4 unused_5_1[22];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_6_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_6_2[4];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _Thickness;
					uniform  sampler2D _Normals;
					uniform  sampler2D _Foam;
					uniform  samplerCube unity_SpecCube0;
					uniform  sampler2DShadow hlslcc_zcmp_MyShadowMap;
					uniform  sampler2D _MyShadowMap;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec3 u_xlat16_2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					bvec4 u_xlatb5;
					vec4 u_xlat6;
					bvec4 u_xlatb6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat11;
					vec3 u_xlat12;
					float u_xlat22;
					float u_xlat30;
					float u_xlat10_30;
					bool u_xlatb30;
					float u_xlat31;
					float u_xlat32;
					float u_xlat33;
					float u_xlat16_33;
					float u_xlat34;
					void main()
					{
					    u_xlat10_0 = texture(_Thickness, vs_TEXCOORD0.xy);
					    u_xlat30 = u_xlat10_0.w * 10.0;
					    u_xlatb30 = u_xlat30<_ThicknessCutoff;
					    if(((int(u_xlatb30) * int(0xffffffffu)))!=0){discard;}
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb30 = unity_OrthoParams.w<0.5;
					    u_xlat2.xy = vs_TEXCOORD0.xy;
					    u_xlat2.z = -1.0;
					    u_xlat11.xyz = u_xlat2.xyz + vec3(-0.5, -0.5, 0.0);
					    u_xlat2.xyz = u_xlat11.xyz * _FarCorner.xyz;
					    u_xlat11.xyz = u_xlat10_1.xxx * u_xlat2.xyz;
					    u_xlat11.xyz = u_xlat11.xyz / _FarCorner.zzz;
					    u_xlat2.w = (-u_xlat10_1.x);
					    u_xlat1.xyz = (bool(u_xlatb30)) ? u_xlat11.xyz : u_xlat2.xyw;
					    u_xlat10_2 = texture(_Normals, vs_TEXCOORD0.xy);
					    u_xlat16_2.xyz = u_xlat10_2.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_2.xyz;
					    u_xlat3.xyz = u_xlat1.yyy * _Camera_to_World[1].xyz;
					    u_xlat3.xyz = _Camera_to_World[0].xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = _Camera_to_World[2].xyz * u_xlat1.zzz + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz + _Camera_to_World[3].xyz;
					    u_xlat4.xyz = u_xlat16_2.yyy * _Camera_to_World[1].xyz;
					    u_xlat2.xyw = _Camera_to_World[0].xyz * u_xlat16_2.xxx + u_xlat4.xyz;
					    u_xlat2.xyz = _Camera_to_World[2].xyz * u_xlat16_2.zzz + u_xlat2.xyw;
					    u_xlat4.xyz = (-u_xlat3.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat30 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat4.xyz = vec3(u_xlat30) * u_xlat4.xyz;
					    u_xlatb5 = greaterThanEqual((-u_xlat1.zzzz), _LightSplitsNear);
					    u_xlat5 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb5));
					    u_xlatb6 = lessThan((-u_xlat1.zzzz), _LightSplitsFar);
					    u_xlat6 = mix(vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0), vec4(u_xlatb6));
					    u_xlat5 = u_xlat5 * u_xlat6;
					    u_xlat6.xyz = u_xlat3.yyy * unity_WorldToShadow[1 / 4][1 % 4].xyz;
					    u_xlat6.xyz = unity_WorldToShadow[0 / 4][0 % 4].xyz * u_xlat3.xxx + u_xlat6.xyz;
					    u_xlat6.xyz = unity_WorldToShadow[2 / 4][2 % 4].xyz * u_xlat3.zzz + u_xlat6.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + unity_WorldToShadow[3 / 4][3 % 4].xyz;
					    u_xlat7.xyz = u_xlat3.yyy * unity_WorldToShadow[5 / 4][5 % 4].xyz;
					    u_xlat7.xyz = unity_WorldToShadow[4 / 4][4 % 4].xyz * u_xlat3.xxx + u_xlat7.xyz;
					    u_xlat7.xyz = unity_WorldToShadow[6 / 4][6 % 4].xyz * u_xlat3.zzz + u_xlat7.xyz;
					    u_xlat7.xyz = u_xlat7.xyz + unity_WorldToShadow[7 / 4][7 % 4].xyz;
					    u_xlat8.xyz = u_xlat3.yyy * unity_WorldToShadow[9 / 4][9 % 4].xyz;
					    u_xlat8.xyz = unity_WorldToShadow[8 / 4][8 % 4].xyz * u_xlat3.xxx + u_xlat8.xyz;
					    u_xlat8.xyz = unity_WorldToShadow[10 / 4][10 % 4].xyz * u_xlat3.zzz + u_xlat8.xyz;
					    u_xlat8.xyz = u_xlat8.xyz + unity_WorldToShadow[11 / 4][11 % 4].xyz;
					    u_xlat9.xyz = u_xlat3.yyy * unity_WorldToShadow[13 / 4][13 % 4].xyz;
					    u_xlat3.xyw = unity_WorldToShadow[12 / 4][12 % 4].xyz * u_xlat3.xxx + u_xlat9.xyz;
					    u_xlat3.xyz = unity_WorldToShadow[14 / 4][14 % 4].xyz * u_xlat3.zzz + u_xlat3.xyw;
					    u_xlat3.xyz = u_xlat3.xyz + unity_WorldToShadow[15 / 4][15 % 4].xyz;
					    u_xlat7.xyz = u_xlat5.yyy * u_xlat7.xyz;
					    u_xlat6.xyz = u_xlat6.xyz * u_xlat5.xxx + u_xlat7.xyz;
					    u_xlat5.xyz = u_xlat8.xyz * u_xlat5.zzz + u_xlat6.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat5.www + u_xlat5.xyz;
					    vec3 txVec0 = vec3(u_xlat3.xy,u_xlat3.z);
					    u_xlat10_30 = textureLod(hlslcc_zcmp_MyShadowMap, txVec0, 0.0);
					    u_xlat31 = (-_Smoothness) + 1.0;
					    u_xlat32 = dot((-u_xlat4.xyz), u_xlat2.xyz);
					    u_xlat32 = u_xlat32 + u_xlat32;
					    u_xlat3.xyz = u_xlat2.xyz * (-vec3(u_xlat32)) + (-u_xlat4.xyz);
					    u_xlat32 = u_xlat31 * 0.797884583;
					    u_xlat5.xy = (-vec2(u_xlat31)) * vec2(0.699999988, 0.797884583) + vec2(1.70000005, 1.0);
					    u_xlat33 = u_xlat31 * u_xlat5.x;
					    u_xlat33 = u_xlat33 * 6.0;
					    u_xlat10_3 = textureLod(unity_SpecCube0, u_xlat3.xyz, u_xlat33);
					    u_xlat16_33 = u_xlat10_3.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat16_33 + 1.0;
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat3.xyz = u_xlat10_3.xyz * vec3(u_xlat33);
					    u_xlat33 = dot(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat5.xzw = vec3(u_xlat33) * _WorldSpaceLightPos0.xyz;
					    u_xlat6.xyz = _WorldSpaceLightPos0.xyz * vec3(u_xlat33) + u_xlat4.xyz;
					    u_xlat33 = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat6.xyz = vec3(u_xlat33) * u_xlat6.xyz;
					    u_xlat33 = dot(u_xlat2.xyz, u_xlat6.xyz);
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat34 = dot(u_xlat2.xyz, u_xlat5.xzw);
					    u_xlat34 = max(u_xlat34, 0.0);
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat4.xyz);
					    u_xlat2.x = max(u_xlat2.x, 0.0);
					    u_xlat12.x = u_xlat34 * u_xlat5.y + u_xlat32;
					    u_xlat22 = u_xlat2.x * u_xlat5.y + u_xlat32;
					    u_xlat12.x = u_xlat12.x * u_xlat22 + 9.99999975e-06;
					    u_xlat12.x = float(1.0) / u_xlat12.x;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat31 = u_xlat31 * u_xlat31;
					    u_xlat31 = max(u_xlat31, 9.99999975e-05);
					    u_xlat31 = 2.0 / u_xlat31;
					    u_xlat31 = u_xlat31 + -2.0;
					    u_xlat31 = max(u_xlat31, 9.99999975e-05);
					    u_xlat12.y = u_xlat31 + 2.0;
					    u_xlat12.xy = u_xlat12.xy * vec2(0.25, 0.159154937);
					    u_xlat32 = log2(u_xlat33);
					    u_xlat31 = u_xlat31 * u_xlat32;
					    u_xlat31 = exp2(u_xlat31);
					    u_xlat31 = u_xlat12.y * u_xlat31;
					    u_xlat31 = u_xlat31 * u_xlat12.x;
					    u_xlat31 = u_xlat31 * 0.785398185;
					    u_xlat31 = max(u_xlat31, 9.99999975e-05);
					    u_xlat31 = sqrt(u_xlat31);
					    u_xlat31 = u_xlat34 * u_xlat31;
					    u_xlat2.x = (-u_xlat2.x) + 1.0;
					    u_xlat12.x = u_xlat2.x * u_xlat2.x;
					    u_xlat12.x = u_xlat12.x * u_xlat12.x;
					    u_xlat2.x = u_xlat2.x * u_xlat12.x;
					    u_xlat2.x = u_xlat2.x * 0.699999988 + 0.300000012;
					    u_xlat10_5 = texture(_Foam, vs_TEXCOORD0.xy);
					    u_xlat12.xyz = glstate_lightmodel_ambient.xyz + glstate_lightmodel_ambient.xyz;
					    u_xlat4.xyz = vec3(u_xlat34) * _LightColor0.xyz;
					    u_xlat12.xyz = u_xlat4.xyz * vec3(u_xlat10_30) + u_xlat12.xyz;
					    u_xlat3.xyz = vec3(u_xlat31) * vec3(u_xlat10_30) + u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * u_xlat12.xyz + u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat10_5.xyz + u_xlat0.xyz;
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
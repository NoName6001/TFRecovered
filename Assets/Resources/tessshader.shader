Shader "Phong Tessellation" {
	Properties {
		_EdgeLength ("Edge length", Range(2, 50)) = 5
		_Phong ("Phong Strengh", Range(0, 1)) = 0.5
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Color ("Color", Vector) = (1,1,1,0)
	}
	SubShader {
		LOD 300
		Tags { "RenderType" = "Opaque" }
		Pass {
			Name "FORWARD"
			LOD 300
			Tags { "LIGHTMODE" = "FORWARDBASE" "RenderType" = "Opaque" "SHADOWSUPPORT" = "true" }
			GpuProgramID 36881
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_2[2];
						vec4 _Color;
						vec4 unused_0_4;
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_1_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_7;
					};
					layout(binding = 2, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 3) uniform  sampler2D _MainTex;
					layout(location = 4) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat10_0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat7.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat7.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat7.x, u_xlat2.x);
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
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat2.y * 0.25;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat8 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat18 = max(u_xlat18, u_xlat19);
					        u_xlat2.x = min(u_xlat8, u_xlat18);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat10_3, u_xlat5);
					        u_xlat3.y = dot(u_xlat10_4, u_xlat5);
					        u_xlat3.z = dot(u_xlat10_2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD1.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    //ENDIF
					    }
					    u_xlat2.xyz = u_xlat3.xyz + vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
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
						vec4 unused_0_2[2];
						vec4 _Color;
						vec4 unused_0_4;
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_1_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_7;
					};
					layout(binding = 2, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 3) uniform  sampler2D _MainTex;
					layout(location = 4) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat10_0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb1 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat7.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat7.xyz;
					        u_xlat7.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat7.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb1)) ? u_xlat7.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat7.x = u_xlat1.y * 0.25 + 0.75;
					        u_xlat2.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat7.x, u_xlat2.x);
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
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat2.y * 0.25;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat8 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat18 = max(u_xlat18, u_xlat19);
					        u_xlat2.x = min(u_xlat8, u_xlat18);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat10_3, u_xlat5);
					        u_xlat3.y = dot(u_xlat10_4, u_xlat5);
					        u_xlat3.z = dot(u_xlat10_2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD1.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    //ENDIF
					    }
					    u_xlat2.xyz = u_xlat3.xyz + vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
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
						vec4 unused_0_2[2];
						vec4 _Color;
						vec4 unused_0_4;
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
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _MainTex;
					layout(location = 7) uniform  sampler2D _ShadowMapTexture;
					layout(location = 8) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat10_0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec3 u_xlat7;
					bool u_xlatb7;
					float u_xlat8;
					vec2 u_xlat13;
					float u_xlat10_13;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = (-u_xlat18) + u_xlat1.x;
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat18;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb1){
					        u_xlatb7 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb7)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat7.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat13.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13.x, u_xlat7.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat7.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
					    u_xlat13.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_13 = texture(_ShadowMapTexture, u_xlat13.xy).x;
					    u_xlat7.x = (-u_xlat10_13) + u_xlat7.x;
					    u_xlat18 = u_xlat18 * u_xlat7.x + u_xlat10_13;
					    u_xlat7.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    if(u_xlatb1){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat2.y * 0.25;
					        u_xlat1.x = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat8 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat18 = max(u_xlat18, u_xlat1.x);
					        u_xlat2.x = min(u_xlat8, u_xlat18);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat10_3, u_xlat5);
					        u_xlat3.y = dot(u_xlat10_4, u_xlat5);
					        u_xlat3.z = dot(u_xlat10_2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD1.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    //ENDIF
					    }
					    u_xlat2.xyz = u_xlat3.xyz + vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
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
						vec4 unused_0_2[2];
						vec4 _Color;
						vec4 unused_0_4;
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
					layout(binding = 5, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 6) uniform  sampler2D _MainTex;
					layout(location = 7) uniform  sampler2D _ShadowMapTexture;
					layout(location = 8) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD3;
					layout(location = 4) in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat10_0;
					vec3 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec3 u_xlat7;
					bool u_xlatb7;
					float u_xlat8;
					vec2 u_xlat13;
					float u_xlat10_13;
					float u_xlat18;
					bool u_xlatb18;
					void main()
					{
					    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat2.x = unity_MatrixV[0].z;
					    u_xlat2.y = unity_MatrixV[1].z;
					    u_xlat2.z = unity_MatrixV[2].z;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat1.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = (-u_xlat18) + u_xlat1.x;
					    u_xlat18 = unity_ShadowFadeCenterAndType.w * u_xlat1.x + u_xlat18;
					    u_xlat18 = u_xlat18 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlatb1 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb1){
					        u_xlatb7 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat7.xyz = (bool(u_xlatb7)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat7.xyz = u_xlat7.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat7.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat7.x = u_xlat2.y * 0.25 + 0.75;
					        u_xlat13.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat13.x, u_xlat7.x);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat7.x = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat7.x = clamp(u_xlat7.x, 0.0, 1.0);
					    u_xlat13.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_13 = texture(_ShadowMapTexture, u_xlat13.xy).x;
					    u_xlat7.x = (-u_xlat10_13) + u_xlat7.x;
					    u_xlat18 = u_xlat18 * u_xlat7.x + u_xlat10_13;
					    u_xlat7.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    if(u_xlatb1){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat2.y * 0.25;
					        u_xlat1.x = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat8 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat18 = max(u_xlat18, u_xlat1.x);
					        u_xlat2.x = min(u_xlat8, u_xlat18);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat10_3, u_xlat5);
					        u_xlat3.y = dot(u_xlat10_4, u_xlat5);
					        u_xlat3.z = dot(u_xlat10_2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD1.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    //ENDIF
					    }
					    u_xlat2.xyz = u_xlat3.xyz + vs_TEXCOORD3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyz * vec3(u_xlat18) + u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
			Program "hp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
			}
			Program "dp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
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
						vec4 unused_2_2[3];
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec3 ds_TEXCOORD3;
					layout(location = 4) out vec4 ds_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat3 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat9 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat0.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat0.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat0.xy;
					    u_xlat0.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat0.xy;
					    ds_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat0.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    ds_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    ds_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    ds_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
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
						vec4 unused_2_2[3];
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec3 ds_TEXCOORD3;
					layout(location = 4) out vec4 ds_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat3 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat9 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat0.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat0.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat0.xy;
					    u_xlat0.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat0.xy;
					    ds_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat0.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    ds_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    ds_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    ds_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
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
						vec4 unused_3_2[3];
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec3 ds_TEXCOORD3;
					layout(location = 4) out vec4 ds_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat3 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat9 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat1.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat1.xy;
					    u_xlat1.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat1.xy;
					    ds_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    ds_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    ds_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    ds_TEXCOORD5.zw = u_xlat0.zw;
					    ds_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
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
						vec4 unused_3_2[3];
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec3 ds_TEXCOORD3;
					layout(location = 4) out vec4 ds_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat3 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat9 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat1.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat1.xy;
					    u_xlat1.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat1.xy;
					    ds_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    ds_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    ds_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    ds_TEXCOORD5.zw = u_xlat0.zw;
					    ds_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			LOD 300
			Tags { "LIGHTMODE" = "FORWARDADD" "RenderType" = "Opaque" }
			Blend One One, One One
			ZWrite Off
			GpuProgramID 95260
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 unused_0_4;
						vec4 _Color;
						vec4 unused_0_6;
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_3;
					};
					layout(binding = 2, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 3) uniform  sampler2D _MainTex;
					layout(location = 4) uniform  sampler2D _LightTexture0;
					layout(location = 5) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat10_1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					float u_xlat10_13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10_13 = texture(_LightTexture0, vec2(u_xlat13)).x;
					    u_xlat12 = u_xlat12 * u_xlat10_13;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat4.xyz;
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
						vec4 unused_0_2[2];
						vec4 _Color;
						vec4 unused_0_4;
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_3;
					};
					layout(binding = 2, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 3) uniform  sampler2D _MainTex;
					layout(location = 4) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat10_0;
					vec4 u_xlat1;
					float u_xlat3;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlatb6 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb6){
					        u_xlatb6 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat6 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat3 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat6, u_xlat3);
					        u_xlat1 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        u_xlat1.x = float(1.0);
					        u_xlat1.y = float(1.0);
					        u_xlat1.z = float(1.0);
					        u_xlat1.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat6 = dot(u_xlat1, unity_OcclusionMaskSelector);
					    u_xlat6 = clamp(u_xlat6, 0.0, 1.0);
					    u_xlat1.xyz = vec3(u_xlat6) * _LightColor0.xyz;
					    u_xlat6 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat6 = max(u_xlat6, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat6) * u_xlat0.xyz;
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
						vec4 unused_0_4;
						vec4 _Color;
						vec4 unused_0_6;
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_3;
					};
					layout(binding = 2, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 3) uniform  sampler2D _MainTex;
					layout(location = 4) uniform  sampler2D _LightTexture0;
					layout(location = 5) uniform  sampler2D _LightTextureB0;
					layout(location = 6) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat10_1;
					vec4 u_xlat2;
					float u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					bool u_xlatb13;
					float u_xlat10_14;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
					    u_xlat2 = vs_TEXCOORD2.yyyy * unity_WorldToLight[1];
					    u_xlat2 = unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat2;
					    u_xlat2 = unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat2;
					    u_xlat2 = u_xlat2 + unity_WorldToLight[3];
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlatb13 = 0.0<u_xlat2.z;
					    u_xlat13 = u_xlatb13 ? 1.0 : float(0.0);
					    u_xlat3.xy = u_xlat2.xy / u_xlat2.ww;
					    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
					    u_xlat10_14 = texture(_LightTexture0, u_xlat3.xy).w;
					    u_xlat13 = u_xlat13 * u_xlat10_14;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10_2 = texture(_LightTextureB0, u_xlat2.xx).x;
					    u_xlat13 = u_xlat13 * u_xlat10_2;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat4.xyz;
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
						vec4 unused_0_4;
						vec4 _Color;
						vec4 unused_0_6;
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_3;
					};
					layout(binding = 2, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 3) uniform  sampler2D _MainTex;
					layout(location = 4) uniform  sampler2D _LightTextureB0;
					layout(location = 5) uniform  samplerCube _LightTexture0;
					layout(location = 6) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat10_1;
					vec3 u_xlat2;
					float u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					float u_xlat16_13;
					float u_xlat10_13;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
					    u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat2.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb12 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb12){
					        u_xlatb12 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb12)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat12 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat13 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat12, u_xlat13);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat12 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10_13 = texture(_LightTextureB0, vec2(u_xlat13)).x;
					    u_xlat10_2 = texture(_LightTexture0, u_xlat2.xyz).w;
					    u_xlat16_13 = u_xlat10_13 * u_xlat10_2;
					    u_xlat12 = u_xlat12 * u_xlat16_13;
					    u_xlat2.xyz = vec3(u_xlat12) * _LightColor0.xyz;
					    u_xlat0.x = dot(vs_TEXCOORD1.xyz, u_xlat0.xyz);
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xxx * u_xlat4.xyz;
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
						vec4 unused_0_4;
						vec4 _Color;
						vec4 unused_0_6;
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_1_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_1_3;
					};
					layout(binding = 2, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 3) uniform  sampler2D _MainTex;
					layout(location = 4) uniform  sampler2D _LightTexture0;
					layout(location = 5) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat10_0;
					vec3 u_xlat1;
					float u_xlat10_1;
					vec4 u_xlat2;
					float u_xlat7;
					float u_xlat9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat1.xy = vs_TEXCOORD2.yy * unity_WorldToLight[1].xy;
					    u_xlat1.xy = unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat1.xy;
					    u_xlat1.xy = unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat1.xy;
					    u_xlat1.xy = u_xlat1.xy + unity_WorldToLight[3].xy;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat7 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9, u_xlat7);
					        u_xlat2 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        u_xlat2.x = float(1.0);
					        u_xlat2.y = float(1.0);
					        u_xlat2.z = float(1.0);
					        u_xlat2.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat9 = dot(u_xlat2, unity_OcclusionMaskSelector);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat10_1 = texture(_LightTexture0, u_xlat1.xy).w;
					    u_xlat9 = u_xlat9 * u_xlat10_1;
					    u_xlat1.xyz = vec3(u_xlat9) * _LightColor0.xyz;
					    u_xlat9 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
			Program "hp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[8];
						float _EdgeLength;
						vec4 unused_0_2[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[8];
						float _EdgeLength;
						vec4 unused_0_2[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[8];
						float _EdgeLength;
						vec4 unused_0_2[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[8];
						float _EdgeLength;
						vec4 unused_0_2[2];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
			}
			Program "dp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _Phong;
						vec4 unused_0_3;
						vec4 _MainTex_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec3 ds_TEXCOORD3;
					layout(location = 4) out vec4 ds_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat4 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat12 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat1.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat1.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat1.xy;
					    u_xlat1.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat1.xy;
					    ds_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    ds_TEXCOORD1.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    ds_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    ds_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec4 ds_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat3 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat9 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat0.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat0.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat0.xy;
					    u_xlat0.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat0.xy;
					    ds_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat0.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    ds_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    ds_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _Phong;
						vec4 unused_0_3;
						vec4 _MainTex_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec4 ds_TEXCOORD3;
					layout(location = 4) out vec4 ds_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat4 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat12 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat1.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat1.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat1.xy;
					    u_xlat1.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat1.xy;
					    ds_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    ds_TEXCOORD1.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    ds_TEXCOORD3 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    ds_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _Phong;
						vec4 unused_0_3;
						vec4 _MainTex_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec3 ds_TEXCOORD3;
					layout(location = 4) out vec4 ds_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat4 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat12 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat1.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat1.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat1.xy;
					    u_xlat1.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat1.xy;
					    ds_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat1.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat1.xyz;
					    u_xlat2.x = dot(u_xlat1.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(u_xlat1.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(u_xlat1.xyz, unity_WorldToObject[2].xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat1.x = inversesqrt(u_xlat1.x);
					    ds_TEXCOORD1.xyz = u_xlat1.xxx * u_xlat2.xyz;
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * u_xlat1.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    ds_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    ds_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						float _Phong;
						vec4 unused_0_3;
						vec4 _MainTex_ST;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec2 ds_TEXCOORD3;
					layout(location = 2) out vec3 ds_TEXCOORD1;
					layout(location = 3) out vec3 ds_TEXCOORD2;
					layout(location = 4) out vec4 ds_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat4 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat12 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    u_xlat2 = unity_ObjectToWorld[3] * u_xlat1.wwww + u_xlat0;
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat2.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat2.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat2.zz + u_xlat0.xy;
					    ds_TEXCOORD3.xy = unity_WorldToLight[3].xy * u_xlat2.ww + u_xlat0.xy;
					    u_xlat0.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat0.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat0.xy;
					    u_xlat0.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat0.xy;
					    ds_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat0.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    ds_TEXCOORD1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    ds_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
		}
		Pass {
			Name "PREPASS"
			LOD 300
			Tags { "LIGHTMODE" = "PREPASSBASE" "RenderType" = "Opaque" }
			GpuProgramID 162761
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec3 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					void main()
					{
					    SV_Target0.xyz = vs_TEXCOORD0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 0.0;
					    return;
					}"
				}
			}
			Program "hp" {
				SubProgram "d3d11 " {
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
			}
			Program "dp" {
				SubProgram "d3d11 " {
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
					};
					layout(binding = 1, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 0) out vec3 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat3 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat9 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat0.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat0.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    ds_TEXCOORD0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "PREPASS"
			LOD 300
			Tags { "LIGHTMODE" = "PREPASSFINAL" "RenderType" = "Opaque" }
			ZWrite Off
			GpuProgramID 243049
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[5];
						vec4 _Color;
						vec4 unused_0_2[2];
					};
					layout(location = 1) uniform  sampler2D _MainTex;
					layout(location = 2) uniform  sampler2D _LightBuffer;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD2;
					layout(location = 2) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat16_0;
					vec3 u_xlat10_0;
					vec3 u_xlat1;
					vec3 u_xlat10_1;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_0.xyz = log2(u_xlat10_0.xyz);
					    u_xlat0.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD4.xyz;
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[5];
						vec4 _Color;
						vec4 unused_0_2[2];
					};
					layout(location = 1) uniform  sampler2D _MainTex;
					layout(location = 2) uniform  sampler2D _LightBuffer;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD2;
					layout(location = 2) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat16_0;
					vec3 u_xlat10_0;
					vec3 u_xlat1;
					vec3 u_xlat10_1;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat16_0.xyz = log2(u_xlat10_0.xyz);
					    u_xlat0.xyz = (-u_xlat16_0.xyz) + vs_TEXCOORD4.xyz;
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[5];
						vec4 _Color;
						vec4 unused_0_2[2];
					};
					layout(location = 1) uniform  sampler2D _MainTex;
					layout(location = 2) uniform  sampler2D _LightBuffer;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD2;
					layout(location = 2) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat10_0;
					vec3 u_xlat1;
					vec3 u_xlat10_1;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz + vs_TEXCOORD4.xyz;
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[5];
						vec4 _Color;
						vec4 unused_0_2[2];
					};
					layout(location = 1) uniform  sampler2D _MainTex;
					layout(location = 2) uniform  sampler2D _LightBuffer;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec4 vs_TEXCOORD2;
					layout(location = 2) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat10_0;
					vec3 u_xlat1;
					vec3 u_xlat10_1;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_0.xyz = texture(_LightBuffer, u_xlat0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz + vs_TEXCOORD4.xyz;
					    u_xlat10_1.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
			Program "hp" {
				SubProgram "d3d11 " {
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2[3];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2[3];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2[3];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2[3];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
			}
			Program "dp" {
				SubProgram "d3d11 " {
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(binding = 3, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec4 ds_TEXCOORD2;
					layout(location = 3) out vec4 ds_TEXCOORD3;
					layout(location = 4) out vec3 ds_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat4 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat12 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat1.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat1.xy;
					    u_xlat1.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat1.xy;
					    ds_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    ds_TEXCOORD2.zw = u_xlat0.zw;
					    ds_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    ds_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat0.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    ds_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(binding = 3, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec4 ds_TEXCOORD2;
					layout(location = 3) out vec4 ds_TEXCOORD3;
					layout(location = 4) out vec3 ds_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat4 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat12 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat1.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat1.xy;
					    u_xlat1.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat1.xy;
					    ds_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    ds_TEXCOORD2.zw = u_xlat0.zw;
					    ds_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    ds_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat0.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    ds_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(binding = 3, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec4 ds_TEXCOORD2;
					layout(location = 3) out vec4 ds_TEXCOORD3;
					layout(location = 4) out vec3 ds_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat4 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat12 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat1.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat1.xy;
					    u_xlat1.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat1.xy;
					    ds_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    ds_TEXCOORD2.zw = u_xlat0.zw;
					    ds_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    ds_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat0.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    ds_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(binding = 2, std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(binding = 3, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[3];
					};
					layout(binding = 4, std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec4 ds_TEXCOORD2;
					layout(location = 3) out vec4 ds_TEXCOORD3;
					layout(location = 4) out vec3 ds_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat4;
					float u_xlat12;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat4 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat4;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat12 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat12 = (-u_xlat12) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat12) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat12 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat12);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat1.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat1.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat1.xy;
					    u_xlat1.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat1.xy;
					    ds_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    ds_TEXCOORD2.zw = u_xlat0.zw;
					    ds_TEXCOORD2.xy = u_xlat1.zz + u_xlat1.xw;
					    ds_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat0.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat0.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    ds_TEXCOORD4.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}"
				}
			}
		}
		Pass {
			Name "DEFERRED"
			LOD 300
			Tags { "LIGHTMODE" = "DEFERRED" "RenderType" = "Opaque" }
			GpuProgramID 263910
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"vs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(location = 0) in  vec4 in_POSITION0;
					layout(location = 1) in  vec3 in_NORMAL0;
					layout(location = 2) in  vec2 in_TEXCOORD0;
					layout(location = 0) out vec4 vs_INTERNALTESSPOS0;
					layout(location = 1) out vec3 vs_NORMAL0;
					layout(location = 2) out vec2 vs_TEXCOORD0;
					void main()
					{
					    vs_INTERNALTESSPOS0 = in_POSITION0;
					    vs_NORMAL0.xyz = in_NORMAL0.xyz;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[5];
						vec4 _Color;
						vec4 unused_0_2[2];
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_1_4[6];
					};
					layout(binding = 2, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 3) uniform  sampler2D _MainTex;
					layout(location = 4) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec3 u_xlat0;
					vec3 u_xlat10_0;
					vec4 u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat10_2, u_xlat4);
					        u_xlat2.y = dot(u_xlat10_3, u_xlat4);
					        u_xlat2.z = dot(u_xlat10_1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD1.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    //ENDIF
					    }
					    u_xlat1.xyz = u_xlat2.xyz + vs_TEXCOORD4.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target3.xyz = exp2((-u_xlat1.xyz));
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[5];
						vec4 _Color;
						vec4 unused_0_2[2];
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_1_4[6];
					};
					layout(binding = 2, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 3) uniform  sampler2D _MainTex;
					layout(location = 4) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec3 u_xlat0;
					vec3 u_xlat10_0;
					vec4 u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat10_2, u_xlat4);
					        u_xlat2.y = dot(u_xlat10_3, u_xlat4);
					        u_xlat2.z = dot(u_xlat10_1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD1.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    //ENDIF
					    }
					    u_xlat1.xyz = u_xlat2.xyz + vs_TEXCOORD4.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target3.xyz = exp2((-u_xlat1.xyz));
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[5];
						vec4 _Color;
						vec4 unused_0_2[2];
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_1_4[6];
					};
					layout(binding = 2, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 3) uniform  sampler2D _MainTex;
					layout(location = 4) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec3 u_xlat0;
					vec3 u_xlat10_0;
					vec4 u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat10_2, u_xlat4);
					        u_xlat2.y = dot(u_xlat10_3, u_xlat4);
					        u_xlat2.z = dot(u_xlat10_1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD1.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    //ENDIF
					    }
					    u_xlat1.xyz = u_xlat2.xyz + vs_TEXCOORD4.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    SV_Target3.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"ps_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(binding = 0, std140) uniform PGlobals {
						vec4 unused_0_0[5];
						vec4 _Color;
						vec4 unused_0_2[2];
					};
					layout(binding = 1, std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_1_4[6];
					};
					layout(binding = 2, std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					layout(location = 3) uniform  sampler2D _MainTex;
					layout(location = 4) uniform  sampler3D unity_ProbeVolumeSH;
					layout(location = 0) in  vec2 vs_TEXCOORD0;
					layout(location = 1) in  vec3 vs_TEXCOORD1;
					layout(location = 2) in  vec3 vs_TEXCOORD2;
					layout(location = 3) in  vec3 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec3 u_xlat0;
					vec3 u_xlat10_0;
					vec4 u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					float u_xlat6;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat10_0.xyz = texture(_MainTex, vs_TEXCOORD0.xy).xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb15)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat1.y * 0.25;
					        u_xlat6 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat2.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat15 = max(u_xlat15, u_xlat6);
					        u_xlat1.x = min(u_xlat2.x, u_xlat15);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					        u_xlat3.xyz = u_xlat1.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat3.xyz);
					        u_xlat1.xyz = u_xlat1.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_1 = texture(unity_ProbeVolumeSH, u_xlat1.xyz);
					        u_xlat4.xyz = vs_TEXCOORD1.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat2.x = dot(u_xlat10_2, u_xlat4);
					        u_xlat2.y = dot(u_xlat10_3, u_xlat4);
					        u_xlat2.z = dot(u_xlat10_1, u_xlat4);
					    } else {
					        u_xlat1.xyz = vs_TEXCOORD1.xyz;
					        u_xlat1.w = 1.0;
					        u_xlat2.x = dot(unity_SHAr, u_xlat1);
					        u_xlat2.y = dot(unity_SHAg, u_xlat1);
					        u_xlat2.z = dot(unity_SHAb, u_xlat1);
					    //ENDIF
					    }
					    u_xlat1.xyz = u_xlat2.xyz + vs_TEXCOORD4.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    SV_Target3.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1 = vec4(0.0, 0.0, 0.0, 0.0);
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
			}
			Program "hp" {
				SubProgram "d3d11 " {
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2[3];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2[3];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2[3];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"hs_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(vertices=3) out;
					layout(binding = 0, std140) uniform HGlobals {
						vec4 unused_0_0[4];
						float _EdgeLength;
						vec4 unused_0_2[3];
					};
					layout(binding = 1, std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(binding = 2, std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_2_1[7];
					};
					layout(location = 0) in vec4 vs_INTERNALTESSPOS0[];
					layout(location = 0) out vec4 hs_INTERNALTESSPOS0[];
					layout(location = 1) in vec3 vs_NORMAL0[];
					layout(location = 1) out vec3 hs_NORMAL0[];
					layout(location = 2) in vec2 vs_TEXCOORD0[];
					layout(location = 2) out vec2 hs_TEXCOORD0[];
					void passthrough_ctrl_points()
					{
					    hs_INTERNALTESSPOS0[gl_InvocationID] = vs_INTERNALTESSPOS0[gl_InvocationID];
					    hs_NORMAL0[gl_InvocationID] = vs_NORMAL0[gl_InvocationID];
					    hs_TEXCOORD0[gl_InvocationID] = vs_TEXCOORD0[gl_InvocationID];
					}
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat12;
					float u_xlat13;
					void fork_phase2(int phaseInstanceID)
					{
					    u_xlat0.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[1].yyy;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[1].xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[1].zzz + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[1].www + u_xlat0.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[2].yyy;
					    u_xlat1.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[2].xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[2].zzz + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[2].www + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _EdgeLength;
					    u_xlat2.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = sqrt(u_xlat13);
					    u_xlat13 = u_xlat13 * _ScreenParams.y;
					    u_xlat12 = u_xlat13 / u_xlat12;
					    gl_TessLevelOuter[0] = max(u_xlat12, 1.0);
					    u_xlat2.xyz = unity_ObjectToWorld[1].xyz * vs_INTERNALTESSPOS0[0].yyy;
					    u_xlat2.xyz = unity_ObjectToWorld[0].xyz * vs_INTERNALTESSPOS0[0].xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].xyz * vs_INTERNALTESSPOS0[0].zzz + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[3].xyz * vs_INTERNALTESSPOS0[0].www + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat2.xyz);
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat12 = u_xlat12 * _ScreenParams.y;
					    u_xlat1.xyz = u_xlat3.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat1.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat1.x = sqrt(u_xlat1.x);
					    u_xlat1.x = u_xlat1.x * _EdgeLength;
					    u_xlat12 = u_xlat12 / u_xlat1.x;
					    gl_TessLevelOuter[1] = max(u_xlat12, 1.0);
					    u_xlat1.xyz = u_xlat0.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = (-u_xlat0.xyz) + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = sqrt(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * _ScreenParams.y;
					    u_xlat4.xyz = u_xlat1.xyz * vec3(0.5, 0.5, 0.5) + (-_WorldSpaceCameraPos.xyz);
					    u_xlat4.x = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat4.x = sqrt(u_xlat4.x);
					    u_xlat4.x = u_xlat4.x * _EdgeLength;
					    u_xlat0.x = u_xlat0.x / u_xlat4.x;
					    gl_TessLevelOuter[2] = max(u_xlat0.x, 1.0);
					}
					void join_phase3(int phaseInstanceID)
					{
					    u_xlat0.x = gl_TessLevelOuter[2] + gl_TessLevelOuter[2];
					    u_xlat0.x = u_xlat0.x + gl_TessLevelOuter[2];
					    gl_TessLevelInner[0] = u_xlat0.x * 0.333333343;
					}
					void main()
					{
					    passthrough_ctrl_points();
					    barrier();
					    if (gl_InvocationID == 0)
					    {
					        fork_phase2(0);
					        join_phase3(0);
					    }
					}"
				}
			}
			Program "dp" {
				SubProgram "d3d11 " {
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
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
						vec4 unused_2_2[3];
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec4 ds_TEXCOORD3;
					layout(location = 4) out vec3 ds_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat3 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat9 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat0.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat0.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat0.xy;
					    u_xlat0.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat0.xy;
					    ds_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat0.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    ds_TEXCOORD1.xyz = u_xlat0.xyz;
					    ds_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    ds_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
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
						vec4 unused_2_2[3];
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec4 ds_TEXCOORD3;
					layout(location = 4) out vec3 ds_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat3 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat9 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat0.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat0.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat0.xy;
					    u_xlat0.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat0.xy;
					    ds_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat0.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    ds_TEXCOORD1.xyz = u_xlat0.xyz;
					    ds_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    ds_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_HDR_ON" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
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
						vec4 unused_2_2[3];
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec4 ds_TEXCOORD3;
					layout(location = 4) out vec3 ds_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat3 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat9 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat0.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat0.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat0.xy;
					    u_xlat0.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat0.xy;
					    ds_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat0.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    ds_TEXCOORD1.xyz = u_xlat0.xyz;
					    ds_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    ds_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"ds_5_0
					
					#version 430
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(triangles) in;
					layout(binding = 0, std140) uniform DGlobals {
						vec4 unused_0_0[4];
						float _Phong;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
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
						vec4 unused_2_2[3];
					};
					layout(binding = 3, std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(location = 0) in  vec4 hs_INTERNALTESSPOS0 [];
					layout(location = 1) in  vec3 hs_NORMAL0 [];
					layout(location = 2) in  vec2 hs_TEXCOORD0 [];
					layout(location = 0) out vec2 ds_TEXCOORD0;
					layout(location = 1) out vec3 ds_TEXCOORD1;
					layout(location = 2) out vec3 ds_TEXCOORD2;
					layout(location = 3) out vec4 ds_TEXCOORD3;
					layout(location = 4) out vec3 ds_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat9;
					void main()
					{
					    u_xlat0.x = dot(hs_INTERNALTESSPOS0[1].xyz, hs_NORMAL0[1].xyz);
					    u_xlat1 = gl_TessCoord.yyyy * hs_INTERNALTESSPOS0[1];
					    u_xlat1 = hs_INTERNALTESSPOS0[0] * gl_TessCoord.xxxx + u_xlat1;
					    u_xlat1 = hs_INTERNALTESSPOS0[2] * gl_TessCoord.zzzz + u_xlat1;
					    u_xlat3 = dot(u_xlat1.xyz, hs_NORMAL0[1].xyz);
					    u_xlat0.x = (-u_xlat0.x) + u_xlat3;
					    u_xlat0.xyz = (-hs_NORMAL0[1].xyz) * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * gl_TessCoord.yyy;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[0].xyz, hs_NORMAL0[0].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[0].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[0].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat9 = dot(hs_INTERNALTESSPOS0[2].xyz, hs_NORMAL0[2].xyz);
					    u_xlat2.x = dot(u_xlat1.xyz, hs_NORMAL0[2].xyz);
					    u_xlat9 = (-u_xlat9) + u_xlat2.x;
					    u_xlat2.xyz = (-hs_NORMAL0[2].xyz) * vec3(u_xlat9) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat9 = (-_Phong) + 1.0;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat9);
					    u_xlat0.xyz = vec3(_Phong) * u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat2 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat2 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat2;
					    u_xlat0 = unity_ObjectToWorld[2] * u_xlat0.zzzz + u_xlat2;
					    u_xlat2 = u_xlat0 + unity_ObjectToWorld[3];
					    ds_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * u_xlat1.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat0;
					    u_xlat0.xy = gl_TessCoord.yy * hs_TEXCOORD0[1].xy;
					    u_xlat0.xy = hs_TEXCOORD0[0].xy * gl_TessCoord.xx + u_xlat0.xy;
					    u_xlat0.xy = hs_TEXCOORD0[2].xy * gl_TessCoord.zz + u_xlat0.xy;
					    ds_TEXCOORD0.xy = u_xlat0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.xyz = gl_TessCoord.yyy * hs_NORMAL0[1].xyz;
					    u_xlat0.xyz = hs_NORMAL0[0].xyz * gl_TessCoord.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = hs_NORMAL0[2].xyz * gl_TessCoord.zzz + u_xlat0.xyz;
					    u_xlat1.x = dot(u_xlat0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(u_xlat0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(u_xlat0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    ds_TEXCOORD1.xyz = u_xlat0.xyz;
					    ds_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat9 = u_xlat0.y * u_xlat0.y;
					    u_xlat9 = u_xlat0.x * u_xlat0.x + (-u_xlat9);
					    u_xlat1 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat0.x = dot(unity_SHBr, u_xlat1);
					    u_xlat0.y = dot(unity_SHBg, u_xlat1);
					    u_xlat0.z = dot(unity_SHBb, u_xlat1);
					    ds_TEXCOORD4.xyz = unity_SHC.xyz * vec3(u_xlat9) + u_xlat0.xyz;
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
}
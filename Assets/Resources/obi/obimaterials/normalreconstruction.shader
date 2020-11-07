Shader "Hidden/NormalReconstruction" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader {
		Pass {
			Name "NormalsFromDepth"
			GpuProgramID 49305
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
						vec4 unused_0_0[6];
						vec3 _FarCorner;
						vec4 _MainTex_TexelSize;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[8];
						vec4 unity_OrthoParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					bool u_xlatb7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat11;
					vec3 u_xlat13;
					float u_xlat21;
					bool u_xlatb21;
					bool u_xlatb22;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD0.xy;
					    u_xlat0.z = -1.0;
					    u_xlat1.zw = u_xlat0.yz;
					    u_xlat2.xw = _MainTex_TexelSize.xy;
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat1.xy = u_xlat2.xy + vs_TEXCOORD0.xy;
					    u_xlat3.xyz = u_xlat1.xzw + vec3(-0.5, -0.5, 0.0);
					    u_xlat10_1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat3.xyz = u_xlat3.xyz * _FarCorner.xyz;
					    u_xlat8.xyz = u_xlat10_1.xxx * u_xlat3.zxy;
					    u_xlat3.w = (-u_xlat10_1.x);
					    u_xlat1.xyz = u_xlat8.xyz / _FarCorner.zzz;
					    u_xlatb22 = unity_OrthoParams.w<0.5;
					    u_xlat1.xyz = (bool(u_xlatb22)) ? u_xlat1.xyz : u_xlat3.wxy;
					    u_xlat3.xyz = u_xlat0.xyz + vec3(-0.5, -0.5, 0.0);
					    u_xlat3.xyz = u_xlat3.xyz * _FarCorner.xyz;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat11.xyz = u_xlat3.yzx * u_xlat10_4.xxx;
					    u_xlat3.w = (-u_xlat10_4.x);
					    u_xlat4.xyz = u_xlat11.xyz / _FarCorner.zzz;
					    u_xlat3.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : u_xlat3.ywx;
					    u_xlat1.xyz = u_xlat1.xyz + (-u_xlat3.yzx);
					    u_xlat4.z = -1.0;
					    u_xlat5 = (-u_xlat2) + vs_TEXCOORD0.xyxy;
					    u_xlat2.xy = u_xlat2.zw + vs_TEXCOORD0.xy;
					    u_xlat4.xy = u_xlat5.xy + vec2(-0.5, -0.5);
					    u_xlat4.xyz = u_xlat4.xyz * _FarCorner.xyz;
					    u_xlat10_6 = texture(_MainTex, u_xlat5.xy);
					    u_xlat13.xyz = u_xlat4.zxy * u_xlat10_6.xxx;
					    u_xlat4.w = (-u_xlat10_6.x);
					    u_xlat6.xyz = u_xlat13.xyz / _FarCorner.zzz;
					    u_xlat4.xyz = (bool(u_xlatb22)) ? u_xlat6.xyz : u_xlat4.wxy;
					    u_xlat4.xyz = u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlatb7 = abs(u_xlat4.x)<abs(u_xlat1.x);
					    u_xlat1.xyz = (bool(u_xlatb7)) ? u_xlat4.xyz : u_xlat1.xyz;
					    u_xlat0.w = u_xlat2.y;
					    u_xlat10_2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat0.xyz = u_xlat0.xwz + vec3(-0.5, -0.5, 0.0);
					    u_xlat0.xyz = u_xlat0.xyz * _FarCorner.xyz;
					    u_xlat9.xyz = u_xlat10_2.xxx * u_xlat0.yzx;
					    u_xlat0.w = (-u_xlat10_2.x);
					    u_xlat2.xyz = u_xlat9.xyz / _FarCorner.zzz;
					    u_xlat0.xyz = (bool(u_xlatb22)) ? u_xlat2.xyz : u_xlat0.ywx;
					    u_xlat0.xyz = (-u_xlat3.xyz) + u_xlat0.xyz;
					    u_xlat2.xy = u_xlat5.zw + vec2(-0.5, -0.5);
					    u_xlat10_4 = texture(_MainTex, u_xlat5.zw);
					    u_xlat2.z = -1.0;
					    u_xlat2.xyz = u_xlat2.xyz * _FarCorner.xyz;
					    u_xlat11.xyz = u_xlat10_4.xxx * u_xlat2.yzx;
					    u_xlat2.w = (-u_xlat10_4.x);
					    u_xlat4.xyz = u_xlat11.xyz / _FarCorner.zzz;
					    u_xlat2.xyz = (bool(u_xlatb22)) ? u_xlat4.xyz : u_xlat2.ywx;
					    u_xlat2.xyz = (-u_xlat2.xyz) + u_xlat3.xyz;
					    u_xlatb21 = abs(u_xlat2.y)<abs(u_xlat0.y);
					    u_xlat0.xyz = (bool(u_xlatb21)) ? u_xlat2.xyz : u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat1.zxy * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
			}
		}
	}
}
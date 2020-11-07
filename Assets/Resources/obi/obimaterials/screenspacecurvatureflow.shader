Shader "Hidden/ScreenSpaceCurvatureFlow" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 58728
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
						vec4 _MainTex_TexelSize;
						float _BlurScale;
						float _BlurRadiusWorldspace;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2;
						vec4 _ZBufferParams;
						vec4 unity_OrthoParams;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					float u_xlat0;
					float u_xlat16_0;
					vec4 u_xlat10_0;
					float u_xlat1;
					vec3 u_xlat2;
					vec2 u_xlat3;
					vec2 u_xlat4;
					vec3 u_xlat5;
					vec4 u_xlat10_6;
					float u_xlat7;
					bool u_xlatb7;
					float u_xlat8;
					float u_xlat14;
					float u_xlat15;
					vec2 u_xlat17;
					bool u_xlatb17;
					float u_xlat21;
					float u_xlat22;
					bool u_xlatb22;
					float u_xlat23;
					float u_xlat16_23;
					float u_xlat26;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlatb7 = unity_OrthoParams.w<0.5;
					    u_xlat14 = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
					    u_xlat14 = float(1.0) / u_xlat14;
					    u_xlat16_0 = (-u_xlat10_0.x) + 1.0;
					    u_xlat21 = (-_ProjectionParams.y) + _ProjectionParams.z;
					    u_xlat0 = u_xlat21 * u_xlat16_0 + _ProjectionParams.y;
					    u_xlat0 = (u_xlatb7) ? u_xlat14 : u_xlat0;
					    u_xlat14 = (u_xlatb7) ? u_xlat14 : 9.99999975e-05;
					    u_xlat14 = _BlurRadiusWorldspace / u_xlat14;
					    u_xlat14 = u_xlat14 * _BlurScale;
					    u_xlat14 = min(u_xlat14, 8.0);
					    u_xlat1 = u_xlat14 + 9.99999975e-05;
					    u_xlat1 = float(1.0) / u_xlat1;
					    u_xlat8 = ceil(u_xlat14);
					    u_xlat15 = (-u_xlat14) + u_xlat8;
					    u_xlat2.x = float(0.0);
					    u_xlat2.y = float(0.0);
					    u_xlat2.z = float(0.0);
					    u_xlat3.y = (-u_xlat8);
					    while(true){
					        u_xlatb22 = u_xlat8<u_xlat3.y;
					        if(u_xlatb22){break;}
					        u_xlat4.y = u_xlat3.y * _MainTex_TexelSize.y;
					        u_xlat5.xyz = u_xlat2.xyz;
					        u_xlat26 = (-u_xlat8);
					        while(true){
					            u_xlatb22 = u_xlat8<u_xlat26;
					            if(u_xlatb22){break;}
					            u_xlat4.x = u_xlat26 * _MainTex_TexelSize.x;
					            u_xlat17.xy = u_xlat4.xy + vs_TEXCOORD0.xy;
					            u_xlat10_6 = textureLod(_MainTex, u_xlat17.xy, 0.0);
					            u_xlat22 = _ZBufferParams.z * u_xlat10_6.x + _ZBufferParams.w;
					            u_xlat22 = float(1.0) / u_xlat22;
					            u_xlat16_23 = (-u_xlat10_6.x) + 1.0;
					            u_xlat23 = u_xlat21 * u_xlat16_23 + _ProjectionParams.y;
					            u_xlat22 = (u_xlatb7) ? u_xlat22 : u_xlat23;
					            u_xlat3.x = u_xlat26;
					            u_xlat23 = dot(u_xlat3.xy, u_xlat3.xy);
					            u_xlat23 = sqrt(u_xlat23);
					            u_xlat23 = u_xlat1 * u_xlat23;
					            u_xlat23 = u_xlat23 * u_xlat23;
					            u_xlat23 = u_xlat23 * -1.44269502;
					            u_xlat23 = exp2(u_xlat23);
					            u_xlat3.x = (-u_xlat0) + u_xlat22;
					            u_xlat3.x = u_xlat3.x * 5.5;
					            u_xlat3.x = u_xlat3.x * u_xlat3.x;
					            u_xlat3.x = u_xlat3.x * -1.44269502;
					            u_xlat3.x = exp2(u_xlat3.x);
					            u_xlat17.x = max(abs(u_xlat3.y), abs(u_xlat26));
					            u_xlatb17 = u_xlat17.x>=u_xlat14;
					            u_xlat17.x = u_xlatb17 ? 1.0 : float(0.0);
					            u_xlat17.x = (-u_xlat17.x) * u_xlat15 + 1.0;
					            u_xlat22 = u_xlat22 * u_xlat23;
					            u_xlat22 = u_xlat3.x * u_xlat22;
					            u_xlat5.x = u_xlat22 * u_xlat17.x + u_xlat5.x;
					            u_xlat22 = u_xlat23 * u_xlat3.x;
					            u_xlat5.y = u_xlat22 * u_xlat17.x + u_xlat5.y;
					            u_xlat5.z = u_xlat3.x * u_xlat17.x + u_xlat5.z;
					            u_xlat26 = u_xlat26 + 1.0;
					        }
					        u_xlat2.xyz = u_xlat5.xyz;
					        u_xlat3.y = u_xlat3.y + 1.0;
					    }
					    u_xlatb7 = 0.0<u_xlat2.y;
					    u_xlat21 = u_xlat2.x / u_xlat2.y;
					    u_xlat7 = (u_xlatb7) ? u_xlat21 : u_xlat2.x;
					    u_xlat14 = u_xlat14 * 2.0 + 1.0;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat14 = u_xlat2.z / u_xlat14;
					    u_xlat7 = (-u_xlat0) + u_xlat7;
					    SV_Target0 = vec4(u_xlat14) * vec4(u_xlat7) + vec4(u_xlat0);
					    return;
					}"
				}
			}
		}
	}
}
Shader "Obi/Fluid/Colors/FluidColorsBlend" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader {
		Pass {
			Name "FluidColors"
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry" }
			Blend DstColor Zero, DstColor Zero
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 30018
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						float _RadiusScale;
						vec4 unused_0_2;
						vec4 _ParticleColor;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[5];
						mat4x4 glstate_matrix_projection;
						mat4x4 unity_MatrixV;
						mat4x4 unity_MatrixInvV;
						mat4x4 unity_MatrixVP;
						vec4 unused_2_5[2];
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
					out vec4 vs_TEXCOORD2;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat10;
					float u_xlat17;
					bool u_xlatb24;
					float u_xlat25;
					float u_xlat26;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.yy * unity_MatrixV[1].xy;
					    u_xlat0.xy = unity_MatrixV[0].xy * in_POSITION0.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_MatrixV[2].xy * in_POSITION0.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + unity_MatrixV[3].xy;
					    u_xlat8.xyz = u_xlat0.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat0.xyz = unity_MatrixInvV[0].xyz * u_xlat0.xxx + u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_MatrixInvV[3].xyz;
					    u_xlatb24 = glstate_matrix_projection[0].w==0.0;
					    u_xlatb1 = glstate_matrix_projection[1].w==0.0;
					    u_xlatb24 = u_xlatb24 && u_xlatb1;
					    u_xlatb1 = glstate_matrix_projection[2].w==0.0;
					    u_xlatb24 = u_xlatb24 && u_xlatb1;
					    u_xlat0.xyz = (bool(u_xlatb24)) ? u_xlat0.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-in_POSITION0.xyz);
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
					    u_xlat2.x = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat4.x = u_xlat17 * in_TEXCOORD1.x;
					    u_xlat5.x = u_xlat17 * in_TEXCOORD2.x;
					    u_xlat4.y = u_xlat26 * in_TEXCOORD1.y;
					    u_xlat5.y = u_xlat26 * in_TEXCOORD2.y;
					    u_xlat4.z = u_xlat3.x * in_TEXCOORD1.z;
					    u_xlat5.z = u_xlat3.x * in_TEXCOORD2.z;
					    u_xlat3.x = dot(u_xlat4.xyz, in_TEXCOORD0.xyz);
					    u_xlat3.y = dot(u_xlat4.xyz, in_TEXCOORD1.xyz);
					    u_xlat3.z = dot(u_xlat4.xyz, in_TEXCOORD2.xyz);
					    u_xlat2.y = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, in_TEXCOORD0.xyz);
					    u_xlat3.y = dot(u_xlat5.xyz, in_TEXCOORD1.xyz);
					    u_xlat3.z = dot(u_xlat5.xyz, in_TEXCOORD2.xyz);
					    u_xlat2.z = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat0.y = unity_MatrixV[2].y;
					    u_xlat0.z = unity_MatrixV[0].y;
					    u_xlat0.x = unity_MatrixV[1].y;
					    u_xlat3.xyz = u_xlat0.xyz * (-u_xlat2.zxy);
					    u_xlat0.xyz = (-u_xlat2.yzx) * u_xlat0.yzx + (-u_xlat3.xyz);
					    u_xlat17 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat17);
					    u_xlat3.xyz = u_xlat0.yzx * (-u_xlat2.zxy);
					    u_xlat3.xyz = (-u_xlat2.yzx) * u_xlat0.zxy + (-u_xlat3.xyz);
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.ywx * in_TEXCOORD0.xyz;
					    u_xlat5.x = dot(u_xlat4.xyz, in_TEXCOORD0.xyz);
					    u_xlat5.y = dot(u_xlat4.xyz, in_TEXCOORD1.xyz);
					    u_xlat5.z = dot(u_xlat4.xyz, in_TEXCOORD2.xyz);
					    u_xlat4.x = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat6.xyz = u_xlat1.ywx * in_TEXCOORD1.xyz;
					    u_xlat7.xyz = u_xlat1.ywx * in_TEXCOORD2.xyz;
					    u_xlat1.x = dot(u_xlat6.xyz, in_TEXCOORD0.xyz);
					    u_xlat1.y = dot(u_xlat6.xyz, in_TEXCOORD1.xyz);
					    u_xlat1.z = dot(u_xlat6.xyz, in_TEXCOORD2.xyz);
					    u_xlat4.y = dot(u_xlat1.xyz, u_xlat3.xyz);
					    u_xlat6.x = dot(u_xlat7.xyz, in_TEXCOORD0.xyz);
					    u_xlat6.y = dot(u_xlat7.xyz, in_TEXCOORD1.xyz);
					    u_xlat6.z = dot(u_xlat7.xyz, in_TEXCOORD2.xyz);
					    u_xlat4.z = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat4.xyz * in_NORMAL0.yyy;
					    u_xlat4.x = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat4.y = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat4.z = dot(u_xlat6.xyz, u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat4.xyz * in_NORMAL0.xxx + u_xlat3.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat26 = float(1.0) / u_xlat25;
					    u_xlat25 = sqrt(u_xlat25);
					    vs_TEXCOORD0.z = float(1.0) / u_xlat25;
					    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat26);
					    u_xlat25 = (-u_xlat26) + 1.0;
					    u_xlat3.w = sqrt(u_xlat25);
					    u_xlat2 = (bool(u_xlatb24)) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat3;
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat3.y = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat3.z = dot(u_xlat6.xyz, u_xlat2.xyz);
					    u_xlat1.xyz = u_xlat3.xyz + in_POSITION0.xyz;
					    u_xlat0.xyz = u_xlat2.www * u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD0.w = u_xlat2.w;
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    u_xlat1 = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat1;
					    gl_Position = u_xlat1;
					    vs_COLOR0 = in_COLOR0 * _ParticleColor;
					    vs_TEXCOORD0.xy = in_NORMAL0.xy;
					    u_xlat2.xy = u_xlat0.yy * unity_MatrixV[1].xy;
					    u_xlat2.xy = unity_MatrixV[0].xy * u_xlat0.xx + u_xlat2.xy;
					    u_xlat2.xy = unity_MatrixV[2].xy * u_xlat0.zz + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy + unity_MatrixV[3].xy;
					    u_xlat10.xyz = u_xlat2.yyy * unity_MatrixInvV[1].xyz;
					    u_xlat2.xyz = unity_MatrixInvV[0].xyz * u_xlat2.xxx + u_xlat10.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + unity_MatrixInvV[3].xyz;
					    u_xlat2.xyz = (bool(u_xlatb24)) ? u_xlat2.xyz : unity_MatrixInvV[3].xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat0.yyy * unity_MatrixV[1].xyz;
					    u_xlat0.xyw = unity_MatrixV[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = unity_MatrixV[2].xyz * u_xlat0.zzz + u_xlat0.xyw;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD2.zw = u_xlat1.zw;
					    vs_TEXCOORD2.xy = u_xlat0.zz + u_xlat0.xw;
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
					
					layout(std140) uniform UnityPerCamera {
						vec4 unused_0_0[7];
						vec4 _ZBufferParams;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCameraRare {
						vec4 unused_1_0[6];
						mat4x4 unity_CameraProjection;
						vec4 unused_1_2[12];
					};
					uniform  sampler2D _CameraDepthTexture;
					in  vec4 vs_COLOR0;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					vec4 u_xlat10_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD2.xy / vs_TEXCOORD2.ww;
					    u_xlat10_0 = texture(_CameraDepthTexture, u_xlat0.xy);
					    u_xlat0.x = _ZBufferParams.z * u_xlat10_0.x + _ZBufferParams.w;
					    u_xlat0.x = float(1.0) / u_xlat0.x;
					    u_xlatb0 = u_xlat0.x<vs_TEXCOORD2.z;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = dot(vs_TEXCOORD0.xy, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat0.x / vs_TEXCOORD0.w;
					    u_xlat3 = (-u_xlat3) + 1.0;
					    u_xlatb6 = u_xlat3<0.0;
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlat3 = sqrt(u_xlat3);
					    u_xlat6 = vs_TEXCOORD0.z * u_xlat3 + 1.0;
					    u_xlat6 = float(1.0) / u_xlat6;
					    u_xlat1.xyz = vec3(u_xlat6) * vs_TEXCOORD1.xyz;
					    u_xlat3 = u_xlat3 + u_xlat3;
					    u_xlat0.x = u_xlat0.x * -2.88539004;
					    u_xlat0.x = exp2(u_xlat0.x);
					    u_xlat0.x = u_xlat0.x * u_xlat3;
					    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
					    SV_Target0 = u_xlat0.xxxx * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0.xy = u_xlat1.yy * unity_CameraProjection[1].zw;
					    u_xlat0.xy = unity_CameraProjection[0].zw * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_CameraProjection[2].zw * u_xlat1.zz + u_xlat0.xy;
					    u_xlat0.xy = u_xlat0.xy + unity_CameraProjection[3].zw;
					    u_xlat0.x = u_xlat0.x / u_xlat0.y;
					    u_xlat0.x = u_xlat0.x * 0.5 + 0.5;
					    gl_FragDepth = (-u_xlat0.x) + 1.0;
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
}
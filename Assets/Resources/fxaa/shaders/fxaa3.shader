Shader "Hidden/FXAA3" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			Fog {
				Mode Off
			}
			GpuProgramID 42956
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_TexelSize;
						vec4 unused_0_2[2];
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
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
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
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD1 = _MainTex_TexelSize.xyxy * vec4(-0.5, 0.5, 0.5, -0.5) + in_TEXCOORD0.xyxy;
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
						vec4 unused_0_0[3];
						vec4 _rcpFrame;
						vec4 unused_0_2;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat10_1;
					bvec3 u_xlatb1;
					vec4 u_xlat2;
					vec4 u_xlat10_2;
					ivec4 u_xlati2;
					bvec2 u_xlatb2;
					vec4 u_xlat3;
					float u_xlat16_3;
					vec4 u_xlat10_3;
					bool u_xlatb3;
					vec3 u_xlat4;
					float u_xlat16_4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_6;
					float u_xlat8;
					vec3 u_xlat9;
					float u_xlat16_9;
					int u_xlati9;
					bool u_xlatb9;
					vec2 u_xlat10;
					float u_xlat11;
					ivec3 u_xlati11;
					float u_xlat15;
					bool u_xlatb15;
					vec2 u_xlat16;
					float u_xlat16_16;
					bool u_xlatb16;
					float u_xlat17;
					float u_xlat16_17;
					ivec2 u_xlati17;
					float u_xlat18;
					float u_xlat22;
					float u_xlat23;
					float u_xlat16_23;
					float u_xlat24;
					float u_xlat16_24;
					float u_xlat25;
					void main()
					{
					    u_xlat0 = textureLod(_MainTex, vs_TEXCOORD0.xy, 0.0);
					    u_xlat0.w = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
					    u_xlat1 = _rcpFrame.xyxy * vec4(0.0, 1.0, 1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat10_2 = textureLod(_MainTex, u_xlat1.xy, 0.0);
					    u_xlat1.x = dot(u_xlat10_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
					    u_xlat10_2 = textureLod(_MainTex, u_xlat1.zw, 0.0);
					    u_xlat1.y = dot(u_xlat10_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
					    u_xlat2 = _rcpFrame.xyxy * vec4(0.0, -1.0, -1.0, 0.0) + vs_TEXCOORD0.xyxy;
					    u_xlat10_3 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					    u_xlat1.z = dot(u_xlat10_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
					    u_xlat10_2 = textureLod(_MainTex, u_xlat2.zw, 0.0);
					    u_xlat1.w = dot(u_xlat10_2.xyz, vec3(0.298999995, 0.587000012, 0.114));
					    u_xlat2.x = max(u_xlat0.w, u_xlat1.x);
					    u_xlat9.x = min(u_xlat0.w, u_xlat1.x);
					    u_xlat2.x = max(u_xlat1.y, u_xlat2.x);
					    u_xlat9.x = min(u_xlat1.y, u_xlat9.x);
					    u_xlat16.x = max(u_xlat1.w, u_xlat1.z);
					    u_xlat23 = min(u_xlat1.w, u_xlat1.z);
					    u_xlat2.x = max(u_xlat2.x, u_xlat16.x);
					    u_xlat9.x = min(u_xlat9.x, u_xlat23);
					    u_xlat16.x = u_xlat2.x * 0.166666672;
					    u_xlat2.x = (-u_xlat9.x) + u_xlat2.x;
					    u_xlat9.x = max(u_xlat16.x, 0.0833333358);
					    u_xlatb9 = u_xlat2.x>=u_xlat9.x;
					    if(u_xlatb9){
					        u_xlat9.xy = vs_TEXCOORD0.xy + (-_rcpFrame.xy);
					        u_xlat10_3 = textureLod(_MainTex, u_xlat9.xy, 0.0);
					        u_xlat16_9 = dot(u_xlat10_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
					        u_xlat16.xy = vs_TEXCOORD0.xy + _rcpFrame.xy;
					        u_xlat10_3 = textureLod(_MainTex, u_xlat16.xy, 0.0);
					        u_xlat16_16 = dot(u_xlat10_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
					        u_xlat3 = _rcpFrame.xyxy * vec4(1.0, -1.0, -1.0, 1.0) + vs_TEXCOORD0.xyxy;
					        u_xlat10_4 = textureLod(_MainTex, u_xlat3.xy, 0.0);
					        u_xlat16_23 = dot(u_xlat10_4.xyz, vec3(0.298999995, 0.587000012, 0.114));
					        u_xlat10_3 = textureLod(_MainTex, u_xlat3.zw, 0.0);
					        u_xlat16_3 = dot(u_xlat10_3.xyz, vec3(0.298999995, 0.587000012, 0.114));
					        u_xlat10.xy = u_xlat1.xy + u_xlat1.zw;
					        u_xlat2.x = float(1.0) / u_xlat2.x;
					        u_xlat24 = u_xlat10.y + u_xlat10.x;
					        u_xlat10.x = u_xlat0.w * -2.0 + u_xlat10.x;
					        u_xlat17 = u_xlat0.w * -2.0 + u_xlat10.y;
					        u_xlat16_4 = u_xlat16_16 + u_xlat16_23;
					        u_xlat16_23 = u_xlat16_23 + u_xlat16_9;
					        u_xlat11 = u_xlat1.y * -2.0 + u_xlat16_4;
					        u_xlat23 = u_xlat1.z * -2.0 + u_xlat16_23;
					        u_xlat16_9 = u_xlat16_9 + u_xlat16_3;
					        u_xlat16_16 = u_xlat16_16 + u_xlat16_3;
					        u_xlat3.x = abs(u_xlat10.x) * 2.0 + abs(u_xlat11);
					        u_xlat23 = abs(u_xlat17) * 2.0 + abs(u_xlat23);
					        u_xlat10.x = u_xlat1.w * -2.0 + u_xlat16_9;
					        u_xlat16.x = u_xlat1.x * -2.0 + u_xlat16_16;
					        u_xlat3.x = u_xlat3.x + abs(u_xlat10.x);
					        u_xlat16.x = u_xlat23 + abs(u_xlat16.x);
					        u_xlat16_9 = u_xlat16_4 + u_xlat16_9;
					        u_xlatb16 = u_xlat3.x>=u_xlat16.x;
					        u_xlat9.x = u_xlat24 * 2.0 + u_xlat16_9;
					        u_xlat1.xz = (bool(u_xlatb16)) ? u_xlat1.xz : u_xlat1.yw;
					        u_xlat8 = (u_xlatb16) ? _rcpFrame.y : _rcpFrame.x;
					        u_xlat22 = u_xlat9.x * 0.0833333358 + (-u_xlat0.w);
					        u_xlat9.xz = (-u_xlat0.ww) + u_xlat1.zx;
					        u_xlat1.xz = u_xlat0.ww + u_xlat1.xz;
					        u_xlatb3 = abs(u_xlat9.x)>=abs(u_xlat9.z);
					        u_xlat9.x = max(abs(u_xlat9.z), abs(u_xlat9.x));
					        u_xlat8 = (u_xlatb3) ? (-u_xlat8) : u_xlat8;
					        u_xlat22 = u_xlat2.x * abs(u_xlat22);
					        u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					        u_xlat2.x = u_xlatb16 ? _rcpFrame.x : float(0.0);
					        u_xlat2.w = (u_xlatb16) ? 0.0 : _rcpFrame.y;
					        u_xlat10.xy = vec2(u_xlat8) * vec2(0.5, 0.5) + vs_TEXCOORD0.xy;
					        u_xlat10.x = (u_xlatb16) ? vs_TEXCOORD0.x : u_xlat10.x;
					        u_xlat10.y = (u_xlatb16) ? u_xlat10.y : vs_TEXCOORD0.y;
					        u_xlat4.xy = (-u_xlat2.xw) + u_xlat10.xy;
					        u_xlat5.xy = u_xlat2.xw + u_xlat10.xy;
					        u_xlat10.x = u_xlat22 * -2.0 + 3.0;
					        u_xlat10_6 = textureLod(_MainTex, u_xlat4.xy, 0.0);
					        u_xlat16_17 = dot(u_xlat10_6.xyz, vec3(0.298999995, 0.587000012, 0.114));
					        u_xlat22 = u_xlat22 * u_xlat22;
					        u_xlat10_6 = textureLod(_MainTex, u_xlat5.xy, 0.0);
					        u_xlat16_24 = dot(u_xlat10_6.xyz, vec3(0.298999995, 0.587000012, 0.114));
					        u_xlat1.x = (u_xlatb3) ? u_xlat1.z : u_xlat1.x;
					        u_xlat15 = u_xlat9.x * 0.25;
					        u_xlat9.x = (-u_xlat1.x) * 0.5 + u_xlat0.w;
					        u_xlat22 = u_xlat22 * u_xlat10.x;
					        u_xlati9 = int((u_xlat9.x<0.0) ? 0xFFFFFFFFu : uint(0));
					        u_xlat3.x = (-u_xlat1.x) * 0.5 + u_xlat16_17;
					        u_xlat3.y = (-u_xlat1.x) * 0.5 + u_xlat16_24;
					        u_xlati17.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat15)).xy) * 0xFFFFFFFFu);
					        u_xlat18 = (-u_xlat2.x) * 1.5 + u_xlat4.x;
					        u_xlat4.x = (u_xlati17.x != 0) ? u_xlat4.x : u_xlat18;
					        u_xlat25 = (-u_xlat2.w) * 1.5 + u_xlat4.y;
					        u_xlat4.z = (u_xlati17.x != 0) ? u_xlat4.y : u_xlat25;
					        u_xlati11.xz = ~u_xlati17.xy;
					        u_xlati11.x = int(uint(u_xlati11.z) | uint(u_xlati11.x));
					        u_xlat25 = u_xlat2.x * 1.5 + u_xlat5.x;
					        u_xlat5.x = (u_xlati17.y != 0) ? u_xlat5.x : u_xlat25;
					        u_xlat25 = u_xlat2.w * 1.5 + u_xlat5.y;
					        u_xlat5.z = (u_xlati17.y != 0) ? u_xlat5.y : u_xlat25;
					        if(u_xlati11.x != 0) {
					            if(u_xlati17.x == 0) {
					                u_xlat10_6 = textureLod(_MainTex, u_xlat4.xz, 0.0);
					                u_xlat3.x = dot(u_xlat10_6.xyz, vec3(0.298999995, 0.587000012, 0.114));
					            //ENDIF
					            }
					            if(u_xlati17.y == 0) {
					                u_xlat10_6 = textureLod(_MainTex, u_xlat5.xz, 0.0);
					                u_xlat3.y = dot(u_xlat10_6.xyz, vec3(0.298999995, 0.587000012, 0.114));
					            //ENDIF
					            }
					            u_xlat11 = (-u_xlat1.x) * 0.5 + u_xlat3.x;
					            u_xlat3.x = (u_xlati17.x != 0) ? u_xlat3.x : u_xlat11;
					            u_xlat17 = (-u_xlat1.x) * 0.5 + u_xlat3.y;
					            u_xlat3.y = (u_xlati17.y != 0) ? u_xlat3.y : u_xlat17;
					            u_xlati17.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat15)).xy) * 0xFFFFFFFFu);
					            u_xlat11 = (-u_xlat2.x) * 2.0 + u_xlat4.x;
					            u_xlat4.x = (u_xlati17.x != 0) ? u_xlat4.x : u_xlat11;
					            u_xlat11 = (-u_xlat2.w) * 2.0 + u_xlat4.z;
					            u_xlat4.z = (u_xlati17.x != 0) ? u_xlat4.z : u_xlat11;
					            u_xlati11.xz = ~u_xlati17.xy;
					            u_xlati11.x = int(uint(u_xlati11.z) | uint(u_xlati11.x));
					            u_xlat25 = u_xlat2.x * 2.0 + u_xlat5.x;
					            u_xlat5.x = (u_xlati17.y != 0) ? u_xlat5.x : u_xlat25;
					            u_xlat25 = u_xlat2.w * 2.0 + u_xlat5.z;
					            u_xlat5.z = (u_xlati17.y != 0) ? u_xlat5.z : u_xlat25;
					            if(u_xlati11.x != 0) {
					                if(u_xlati17.x == 0) {
					                    u_xlat10_6 = textureLod(_MainTex, u_xlat4.xz, 0.0);
					                    u_xlat3.x = dot(u_xlat10_6.xyz, vec3(0.298999995, 0.587000012, 0.114));
					                //ENDIF
					                }
					                if(u_xlati17.y == 0) {
					                    u_xlat10_6 = textureLod(_MainTex, u_xlat5.xz, 0.0);
					                    u_xlat3.y = dot(u_xlat10_6.xyz, vec3(0.298999995, 0.587000012, 0.114));
					                //ENDIF
					                }
					                u_xlat11 = (-u_xlat1.x) * 0.5 + u_xlat3.x;
					                u_xlat3.x = (u_xlati17.x != 0) ? u_xlat3.x : u_xlat11;
					                u_xlat17 = (-u_xlat1.x) * 0.5 + u_xlat3.y;
					                u_xlat3.y = (u_xlati17.y != 0) ? u_xlat3.y : u_xlat17;
					                u_xlati17.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat15)).xy) * 0xFFFFFFFFu);
					                u_xlat11 = (-u_xlat2.x) * 2.0 + u_xlat4.x;
					                u_xlat4.x = (u_xlati17.x != 0) ? u_xlat4.x : u_xlat11;
					                u_xlat11 = (-u_xlat2.w) * 2.0 + u_xlat4.z;
					                u_xlat4.z = (u_xlati17.x != 0) ? u_xlat4.z : u_xlat11;
					                u_xlati11.xz = ~u_xlati17.xy;
					                u_xlati11.x = int(uint(u_xlati11.z) | uint(u_xlati11.x));
					                u_xlat25 = u_xlat2.x * 2.0 + u_xlat5.x;
					                u_xlat5.x = (u_xlati17.y != 0) ? u_xlat5.x : u_xlat25;
					                u_xlat25 = u_xlat2.w * 2.0 + u_xlat5.z;
					                u_xlat5.z = (u_xlati17.y != 0) ? u_xlat5.z : u_xlat25;
					                if(u_xlati11.x != 0) {
					                    if(u_xlati17.x == 0) {
					                        u_xlat10_6 = textureLod(_MainTex, u_xlat4.xz, 0.0);
					                        u_xlat3.x = dot(u_xlat10_6.xyz, vec3(0.298999995, 0.587000012, 0.114));
					                    //ENDIF
					                    }
					                    if(u_xlati17.y == 0) {
					                        u_xlat10_6 = textureLod(_MainTex, u_xlat5.xz, 0.0);
					                        u_xlat3.y = dot(u_xlat10_6.xyz, vec3(0.298999995, 0.587000012, 0.114));
					                    //ENDIF
					                    }
					                    u_xlat11 = (-u_xlat1.x) * 0.5 + u_xlat3.x;
					                    u_xlat3.x = (u_xlati17.x != 0) ? u_xlat3.x : u_xlat11;
					                    u_xlat17 = (-u_xlat1.x) * 0.5 + u_xlat3.y;
					                    u_xlat3.y = (u_xlati17.y != 0) ? u_xlat3.y : u_xlat17;
					                    u_xlati17.xy = ivec2(uvec2(greaterThanEqual(abs(u_xlat3.xyxy), vec4(u_xlat15)).xy) * 0xFFFFFFFFu);
					                    u_xlat11 = (-u_xlat2.x) * 4.0 + u_xlat4.x;
					                    u_xlat4.x = (u_xlati17.x != 0) ? u_xlat4.x : u_xlat11;
					                    u_xlat11 = (-u_xlat2.w) * 4.0 + u_xlat4.z;
					                    u_xlat4.z = (u_xlati17.x != 0) ? u_xlat4.z : u_xlat11;
					                    u_xlati11.xz = ~u_xlati17.xy;
					                    u_xlati11.x = int(uint(u_xlati11.z) | uint(u_xlati11.x));
					                    u_xlat25 = u_xlat2.x * 4.0 + u_xlat5.x;
					                    u_xlat5.x = (u_xlati17.y != 0) ? u_xlat5.x : u_xlat25;
					                    u_xlat25 = u_xlat2.w * 4.0 + u_xlat5.z;
					                    u_xlat5.z = (u_xlati17.y != 0) ? u_xlat5.z : u_xlat25;
					                    if(u_xlati11.x != 0) {
					                        if(u_xlati17.x == 0) {
					                            u_xlat10_6 = textureLod(_MainTex, u_xlat4.xz, 0.0);
					                            u_xlat3.x = dot(u_xlat10_6.xyz, vec3(0.298999995, 0.587000012, 0.114));
					                        //ENDIF
					                        }
					                        if(u_xlati17.y == 0) {
					                            u_xlat10_6 = textureLod(_MainTex, u_xlat5.xz, 0.0);
					                            u_xlat3.y = dot(u_xlat10_6.xyz, vec3(0.298999995, 0.587000012, 0.114));
					                        //ENDIF
					                        }
					                        u_xlat11 = (-u_xlat1.x) * 0.5 + u_xlat3.x;
					                        u_xlat3.x = (u_xlati17.x != 0) ? u_xlat3.x : u_xlat11;
					                        u_xlat1.x = (-u_xlat1.x) * 0.5 + u_xlat3.y;
					                        u_xlat3.y = (u_xlati17.y != 0) ? u_xlat3.y : u_xlat1.x;
					                        u_xlatb1.xz = greaterThanEqual(abs(u_xlat3.xxyx), vec4(u_xlat15)).xz;
					                        u_xlat17 = (-u_xlat2.x) * 2.0 + u_xlat4.x;
					                        u_xlat4.x = (u_xlatb1.x) ? u_xlat4.x : u_xlat17;
					                        u_xlat17 = (-u_xlat2.w) * 2.0 + u_xlat4.z;
					                        u_xlat4.z = (u_xlatb1.x) ? u_xlat4.z : u_xlat17;
					                        u_xlat1.x = u_xlat2.x * 2.0 + u_xlat5.x;
					                        u_xlat5.x = (u_xlatb1.z) ? u_xlat5.x : u_xlat1.x;
					                        u_xlat1.x = u_xlat2.w * 2.0 + u_xlat5.z;
					                        u_xlat5.z = (u_xlatb1.z) ? u_xlat5.z : u_xlat1.x;
					                    //ENDIF
					                    }
					                //ENDIF
					                }
					            //ENDIF
					            }
					        //ENDIF
					        }
					        u_xlat1.x = (-u_xlat4.x) + vs_TEXCOORD0.x;
					        u_xlat15 = u_xlat5.x + (-vs_TEXCOORD0.x);
					        u_xlat2.x = (-u_xlat4.z) + vs_TEXCOORD0.y;
					        u_xlat1.x = (u_xlatb16) ? u_xlat1.x : u_xlat2.x;
					        u_xlat2.x = u_xlat5.z + (-vs_TEXCOORD0.y);
					        u_xlat15 = (u_xlatb16) ? u_xlat15 : u_xlat2.x;
					        u_xlati2.xw = ivec2(uvec2(lessThan(u_xlat3.xxxy, vec4(0.0, 0.0, 0.0, 0.0)).xw) * 0xFFFFFFFFu);
					        u_xlat3.x = u_xlat1.x + u_xlat15;
					        u_xlatb2.xy = notEqual(ivec4(u_xlati9), u_xlati2.xwxx).xy;
					        u_xlat23 = float(1.0) / u_xlat3.x;
					        u_xlatb3 = u_xlat1.x<u_xlat15;
					        u_xlat1.x = min(u_xlat15, u_xlat1.x);
					        u_xlatb15 = (u_xlatb3) ? u_xlatb2.x : u_xlatb2.y;
					        u_xlat22 = u_xlat22 * u_xlat22;
					        u_xlat1.x = u_xlat1.x * (-u_xlat23) + 0.5;
					        u_xlat22 = u_xlat22 * 0.75;
					        u_xlat1.x = u_xlatb15 ? u_xlat1.x : float(0.0);
					        u_xlat1.x = max(u_xlat22, u_xlat1.x);
					        u_xlat1.xy = u_xlat1.xx * vec2(u_xlat8) + vs_TEXCOORD0.xy;
					        u_xlat2.x = (u_xlatb16) ? vs_TEXCOORD0.x : u_xlat1.x;
					        u_xlat2.y = (u_xlatb16) ? u_xlat1.y : vs_TEXCOORD0.y;
					        u_xlat10_1 = textureLod(_MainTex, u_xlat2.xy, 0.0);
					        SV_Target0.w = dot(u_xlat10_1.xyz, vec3(0.298999995, 0.587000012, 0.114));
					        SV_Target0.xyz = u_xlat10_1.xyz;
					    } else {
					        SV_Target0 = u_xlat0;
					    //ENDIF
					    }
					    return;
					}"
				}
			}
		}
	}
}
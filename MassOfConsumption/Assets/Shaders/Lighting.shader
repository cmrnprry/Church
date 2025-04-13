Shader "Custom/Lightening"
{
    Properties
    {
        [NoScaleOffset]_MainTex("MainTex", 2D) = "white" {}
        [HDR]_Glow("Glow", Color) = (4, 0, 0, 0)
        _Strength("Strength", Float) = 10
        [NoScaleOffset]_EmissionbMask("EmissionbMask", 2D) = "white" {}
        _ALpha("ALpha", Float) = 0.1
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}

        [HideInInspector]_StencilComp ("Stencil Comparison", Float) = 8.000000
        [HideInInspector]_Stencil ("Stencil ID", Float) = 0.000000
        [HideInInspector] _StencilOp ("Stencil Operation", Float) = 0.000000
        [HideInInspector] _StencilWriteMask ("Stencil Write Mask", Float) = 255.000000
        [HideInInspector] _StencilReadMask ("Stencil Read Mask", Float) = 255.000000
        [HideInInspector] _ColorMask ("Color Mask", Float) = 15.000000
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "UniversalMaterialType" = "Lit"
            "Queue"="Transparent"
            // DisableBatching: <None>
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="UniversalSpriteLitSubTarget"
        }
        Stencil
        {
            Ref [_Stencil]
            ReadMask [_StencilReadMask]
            WriteMask [_StencilWriteMask]
            Comp [_StencilComp]
            Pass [_StencilOp]
        }
        ColorMask [_ColorMask]
        Pass
        {
            Name "Sprite Lit"
            Tags
            {
                "LightMode" = "Universal2D"
            }

            // Render State
            Cull Off
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            ZTest LEqual
            ZWrite Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM
            // Pragmas
            #pragma target 2.0
            #pragma exclude_renderers d3d11_9x
            #pragma vertex vert
            #pragma fragment frag

            // Keywords
            #pragma multi_compile _ USE_SHAPE_LIGHT_TYPE_0
            #pragma multi_compile _ USE_SHAPE_LIGHT_TYPE_1
            #pragma multi_compile _ USE_SHAPE_LIGHT_TYPE_2
            #pragma multi_compile _ USE_SHAPE_LIGHT_TYPE_3
            #pragma multi_compile_fragment _ DEBUG_DISPLAY
            // GraphKeywords: <None>

            // Defines

            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_COLOR
            #define VARYINGS_NEED_SCREENPOSITION
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_SPRITELIT
            #define ALPHA_CLIP_THRESHOLD 1


            // custom interpolator pre-include
            /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/2D/Include/LightingUtility.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            // custom interpolators pre packing
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */

            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv0 : TEXCOORD0;
                float4 color : COLOR;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float3 positionWS;
                float4 texCoord0;
                float4 color;
                float4 screenPosition;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };

            struct SurfaceDescriptionInputs
            {
                float4 uv0;
            };

            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
            };

            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                float4 texCoord0 : INTERP0;
                float4 color : INTERP1;
                float4 screenPosition : INTERP2;
                float3 positionWS : INTERP3;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };

            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output;
                ZERO_INITIALIZE(PackedVaryings, output);
                output.positionCS = input.positionCS;
                output.texCoord0.xyzw = input.texCoord0;
                output.color.xyzw = input.color;
                output.screenPosition.xyzw = input.screenPosition;
                output.positionWS.xyz = input.positionWS;
                #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
                #endif
                return output;
            }

            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output;
                output.positionCS = input.positionCS;
                output.texCoord0 = input.texCoord0.xyzw;
                output.color = input.color.xyzw;
                output.screenPosition = input.screenPosition.xyzw;
                output.positionWS = input.positionWS.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
                #endif
                return output;
            }


            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
                float4 _MainTex_TexelSize;
                float4 _Glow;
                float _Strength;
                float4 _EmissionbMask_TexelSize;
                float _ALpha;
            CBUFFER_END


            // Object and Global properties
            SAMPLER(SamplerState_Linear_Repeat);
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            TEXTURE2D(_EmissionbMask);
            SAMPLER(sampler_EmissionbMask);

            // Graph Includes
            // GraphIncludes: <None>

            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
            #endif

            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
            #endif

            // Graph Functions

            void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
            {
                Out = A * B;
            }

            void Unity_Minimum_float(float A, float B, out float Out)
            {
                Out = min(A, B);
            };

            void Unity_Add_float4(float4 A, float4 B, out float4 Out)
            {
                Out = A + B;
            }

            void Unity_Multiply_float_float(float A, float B, out float Out)
            {
                Out = A * B;
            }

            // Custom interpolators pre vertex
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */

            // Graph Vertex
            struct VertexDescription
            {
                float3 Position;
                float3 Normal;
                float3 Tangent;
            };

            VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
            {
                VertexDescription description = (VertexDescription)0;
                description.Position = IN.ObjectSpacePosition;
                description.Normal = IN.ObjectSpaceNormal;
                description.Tangent = IN.ObjectSpaceTangent;
                return description;
            }

            // Custom interpolators, pre surface
            #ifdef FEATURES_GRAPH_VERTEX
            Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
            {
                return output;
            }

            #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
            #endif

            // Graph Pixel
            struct SurfaceDescription
            {
                float3 BaseColor;
                float Alpha;
                float4 SpriteMask;
                float AlphaClipThreshold;
            };

            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                float4 _Property_7895c92ffdec4cf3b513a34d7a97101f_Out_0_Vector4 = IsGammaSpace()
                                                                                  ? LinearToSRGB(_Glow)
                                                                                  : _Glow;
                float _Property_4cb5610e5eb1466aa36feaad4cafbe4f_Out_0_Float = _Strength;
                float4 _Multiply_c7e7148a30454b1f8872c2fa2e81ec7e_Out_2_Vector4;
                Unity_Multiply_float4_float4(_Property_7895c92ffdec4cf3b513a34d7a97101f_Out_0_Vector4,
      (_Property_4cb5610e5eb1466aa36feaad4cafbe4f_Out_0_Float
          .xxxx),
      _Multiply_c7e7148a30454b1f8872c2fa2e81ec7e_Out_2_Vector4);
                UnityTexture2D _Property_524e00dd729d41c7931a817295285a49_Out_0_Texture2D =
                    UnityBuildTexture2DStructNoScale(_EmissionbMask);
                float4 _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(
                    _Property_524e00dd729d41c7931a817295285a49_Out_0_Texture2D.tex,
                    _Property_524e00dd729d41c7931a817295285a49_Out_0_Texture2D.samplerstate,
                    _Property_524e00dd729d41c7931a817295285a49_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy));
                float _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_R_4_Float =
                    _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4.r;
                float _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_G_5_Float =
                    _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4.g;
                float _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_B_6_Float =
                    _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4.b;
                float _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_A_7_Float =
                    _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4.a;
                float _Property_746d5f93b18e4a3c86cdf3f67bab009a_Out_0_Float = _ALpha;
                float _Minimum_d6fe71be7ef74ccca0afe0be52c88cd0_Out_2_Float;
                Unity_Minimum_float(_SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_A_7_Float,
                                                                  _Property_746d5f93b18e4a3c86cdf3f67bab009a_Out_0_Float,
                                                                  _Minimum_d6fe71be7ef74ccca0afe0be52c88cd0_Out_2_Float);
                float4 _Multiply_a488f28ccbed4693b7096ba057c5bb4b_Out_2_Vector4;
                Unity_Multiply_float4_float4(_Multiply_c7e7148a30454b1f8872c2fa2e81ec7e_Out_2_Vector4,
          (_Minimum_d6fe71be7ef74ccca0afe0be52c88cd0_Out_2_Float.xxxx),
          _Multiply_a488f28ccbed4693b7096ba057c5bb4b_Out_2_Vector4);
                UnityTexture2D _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D =
                    UnityBuildTexture2DStructNoScale(_MainTex);
                float4 _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.tex,
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.samplerstate,
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy));
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_R_4_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.r;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_G_5_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.g;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_B_6_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.b;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_A_7_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.a;
                float4 _Add_e30b4dda06a645d984dd43bf4d4dc921_Out_2_Vector4;
                Unity_Add_float4(_Multiply_a488f28ccbed4693b7096ba057c5bb4b_Out_2_Vector4,
                                                 _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4,
                                                 _Add_e30b4dda06a645d984dd43bf4d4dc921_Out_2_Vector4);
                float _Property_37dc8cb8a76944c9913be5da772d091a_Out_0_Float = _ALpha;
                float _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float;
                Unity_Multiply_float_float(_SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_A_7_Float,
            _Property_37dc8cb8a76944c9913be5da772d091a_Out_0_Float,
            _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float);
                surface.BaseColor = (_Add_e30b4dda06a645d984dd43bf4d4dc921_Out_2_Vector4.xyz);
                surface.Alpha = _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float;
                surface.SpriteMask = IsGammaSpace() ? float4(1, 1, 1, 1) : float4(SRGBToLinear(float3(1, 1, 1)), 1);
                surface.AlphaClipThreshold = 0.5;
                return surface;
            }

            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
            #endif
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);

                output.ObjectSpaceNormal = input.normalOS;
                output.ObjectSpaceTangent = input.tangentOS.xyz;
                output.ObjectSpacePosition = input.positionOS;

                return output;
            }

            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

                #ifdef HAVE_VFX_MODIFICATION
                #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
                #endif
                /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */

                #endif


                #if UNITY_UV_STARTS_AT_TOP
                #else
                #endif


                output.uv0 = input.texCoord0;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

                return output;
            }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/2D/ShaderGraph/Includes/SpriteLitPass.hlsl"

            // --------------------------------------------------
            // Visual Effect Vertex Invocations
            #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
            #endif
            ENDHLSL
        }
        Pass
        {
            Name "Sprite Normal"
            Tags
            {
                "LightMode" = "NormalsRendering"
            }

            // Render State
            Cull Off
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            ZTest LEqual
            ZWrite Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM
            // Pragmas
            #pragma target 2.0
            #pragma exclude_renderers d3d11_9x
            #pragma vertex vert
            #pragma fragment frag

            // Keywords
            // PassKeywords: <None>
            // GraphKeywords: <None>

            // Defines

            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define VARYINGS_NEED_NORMAL_WS
            #define VARYINGS_NEED_TANGENT_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_SPRITENORMAL
            #define ALPHA_CLIP_THRESHOLD 1


            // custom interpolator pre-include
            /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/2D/Include/NormalsRenderingShared.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            // custom interpolators pre packing
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */

            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv0 : TEXCOORD0;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float3 normalWS;
                float4 tangentWS;
                float4 texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };

            struct SurfaceDescriptionInputs
            {
                float3 TangentSpaceNormal;
                float4 uv0;
            };

            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
            };

            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                float4 tangentWS : INTERP0;
                float4 texCoord0 : INTERP1;
                float3 normalWS : INTERP2;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };

            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output;
                ZERO_INITIALIZE(PackedVaryings, output);
                output.positionCS = input.positionCS;
                output.tangentWS.xyzw = input.tangentWS;
                output.texCoord0.xyzw = input.texCoord0;
                output.normalWS.xyz = input.normalWS;
                #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
                #endif
                return output;
            }

            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output;
                output.positionCS = input.positionCS;
                output.tangentWS = input.tangentWS.xyzw;
                output.texCoord0 = input.texCoord0.xyzw;
                output.normalWS = input.normalWS.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
                #endif
                return output;
            }


            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
                float4 _MainTex_TexelSize;
                float4 _Glow;
                float _Strength;
                float4 _EmissionbMask_TexelSize;
                float _ALpha;
            CBUFFER_END


            // Object and Global properties
            SAMPLER(SamplerState_Linear_Repeat);
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            TEXTURE2D(_EmissionbMask);
            SAMPLER(sampler_EmissionbMask);

            // Graph Includes
            // GraphIncludes: <None>

            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
            #endif

            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
            #endif

            // Graph Functions

            void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
            {
                Out = A * B;
            }

            void Unity_Minimum_float(float A, float B, out float Out)
            {
                Out = min(A, B);
            };

            void Unity_Add_float4(float4 A, float4 B, out float4 Out)
            {
                Out = A + B;
            }

            void Unity_Multiply_float_float(float A, float B, out float Out)
            {
                Out = A * B;
            }

            // Custom interpolators pre vertex
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */

            // Graph Vertex
            struct VertexDescription
            {
                float3 Position;
                float3 Normal;
                float3 Tangent;
            };

            VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
            {
                VertexDescription description = (VertexDescription)0;
                description.Position = IN.ObjectSpacePosition;
                description.Normal = IN.ObjectSpaceNormal;
                description.Tangent = IN.ObjectSpaceTangent;
                return description;
            }

            // Custom interpolators, pre surface
            #ifdef FEATURES_GRAPH_VERTEX
            Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
            {
                return output;
            }

            #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
            #endif

            // Graph Pixel
            struct SurfaceDescription
            {
                float3 BaseColor;
                float Alpha;
                float3 NormalTS;
                float AlphaClipThreshold;
            };

            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                float4 _Property_7895c92ffdec4cf3b513a34d7a97101f_Out_0_Vector4 = IsGammaSpace()
                                                                                  ? LinearToSRGB(_Glow)
                                                                                  : _Glow;
                float _Property_4cb5610e5eb1466aa36feaad4cafbe4f_Out_0_Float = _Strength;
                float4 _Multiply_c7e7148a30454b1f8872c2fa2e81ec7e_Out_2_Vector4;
                Unity_Multiply_float4_float4(_Property_7895c92ffdec4cf3b513a34d7a97101f_Out_0_Vector4,
                    (_Property_4cb5610e5eb1466aa36feaad4cafbe4f_Out_0_Float.xxxx),
                    _Multiply_c7e7148a30454b1f8872c2fa2e81ec7e_Out_2_Vector4);
                UnityTexture2D _Property_524e00dd729d41c7931a817295285a49_Out_0_Texture2D =
                    UnityBuildTexture2DStructNoScale(_EmissionbMask);
                float4 _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(
                    _Property_524e00dd729d41c7931a817295285a49_Out_0_Texture2D.tex,
                    _Property_524e00dd729d41c7931a817295285a49_Out_0_Texture2D.samplerstate,
                    _Property_524e00dd729d41c7931a817295285a49_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy));
                float _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_R_4_Float =
                    _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4.r;
                float _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_G_5_Float =
                    _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4.g;
                float _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_B_6_Float =
                    _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4.b;
                float _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_A_7_Float =
                    _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4.a;
                float _Property_746d5f93b18e4a3c86cdf3f67bab009a_Out_0_Float = _ALpha;
                float _Minimum_d6fe71be7ef74ccca0afe0be52c88cd0_Out_2_Float;
                Unity_Minimum_float(_SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_A_7_Float,
   _Property_746d5f93b18e4a3c86cdf3f67bab009a_Out_0_Float,
   _Minimum_d6fe71be7ef74ccca0afe0be52c88cd0_Out_2_Float);
                float4 _Multiply_a488f28ccbed4693b7096ba057c5bb4b_Out_2_Vector4;
                Unity_Multiply_float4_float4(_Multiply_c7e7148a30454b1f8872c2fa2e81ec7e_Out_2_Vector4,
                                                (_Minimum_d6fe71be7ef74ccca0afe0be52c88cd0_Out_2_Float.xxxx),
                                                _Multiply_a488f28ccbed4693b7096ba057c5bb4b_Out_2_Vector4);
                UnityTexture2D _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D =
                    UnityBuildTexture2DStructNoScale(_MainTex);
                float4 _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.tex,
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.samplerstate,
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy));
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_R_4_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.r;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_G_5_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.g;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_B_6_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.b;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_A_7_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.a;
                float4 _Add_e30b4dda06a645d984dd43bf4d4dc921_Out_2_Vector4;
                Unity_Add_float4(_Multiply_a488f28ccbed4693b7096ba057c5bb4b_Out_2_Vector4,
   _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4,
   _Add_e30b4dda06a645d984dd43bf4d4dc921_Out_2_Vector4);
                float _Property_37dc8cb8a76944c9913be5da772d091a_Out_0_Float = _ALpha;
                float _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float;
                Unity_Multiply_float_float(_SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_A_7_Float,
                                     _Property_37dc8cb8a76944c9913be5da772d091a_Out_0_Float,
                                     _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float);
                surface.BaseColor = (_Add_e30b4dda06a645d984dd43bf4d4dc921_Out_2_Vector4.xyz);
                surface.Alpha = _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float;
                surface.NormalTS = IN.TangentSpaceNormal;
                surface.AlphaClipThreshold = 0.5;
                return surface;
            }

            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
            #endif
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);

                output.ObjectSpaceNormal = input.normalOS;
                output.ObjectSpaceTangent = input.tangentOS.xyz;
                output.ObjectSpacePosition = input.positionOS;

                return output;
            }

            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                    ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

                #ifdef HAVE_VFX_MODIFICATION
                #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
                #endif
                /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */

                #endif


                output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);


                #if UNITY_UV_STARTS_AT_TOP
                #else
                #endif


                output.uv0 = input.texCoord0;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

                return output;
            }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/2D/ShaderGraph/Includes/SpriteNormalPass.hlsl"

            // --------------------------------------------------
            // Visual Effect Vertex Invocations
            #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
            #endif
            ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }

            // Render State
            Cull Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM
            // Pragmas
            #pragma target 2.0
            #pragma exclude_renderers d3d11_9x
            #pragma vertex vert
            #pragma fragment frag

            // Keywords
            // PassKeywords: <None>
            // GraphKeywords: <None>

            // Defines

            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD0
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHONLY
            #define SCENESELECTIONPASS 1

            #define _ALPHATEST_ON 1


            // custom interpolator pre-include
            /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            // custom interpolators pre packing
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */

            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv0 : TEXCOORD0;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float4 texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };

            struct SurfaceDescriptionInputs
            {
                float4 uv0;
            };

            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
            };

            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                float4 texCoord0 : INTERP0;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };

            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output;
                ZERO_INITIALIZE(PackedVaryings, output);
                output.positionCS = input.positionCS;
                output.texCoord0.xyzw = input.texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
                #endif
                return output;
            }

            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output;
                output.positionCS = input.positionCS;
                output.texCoord0 = input.texCoord0.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
                #endif
                return output;
            }


            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
                float4 _MainTex_TexelSize;
                float4 _Glow;
                float _Strength;
                float4 _EmissionbMask_TexelSize;
                float _ALpha;
            CBUFFER_END


            // Object and Global properties
            SAMPLER(SamplerState_Linear_Repeat);
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            TEXTURE2D(_EmissionbMask);
            SAMPLER(sampler_EmissionbMask);

            // Graph Includes
            // GraphIncludes: <None>

            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
            #endif

            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif

            // Graph Functions

            void Unity_Multiply_float_float(float A, float B, out float Out)
            {
                Out = A * B;
            }

            // Custom interpolators pre vertex
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */

            // Graph Vertex
            struct VertexDescription
            {
                float3 Position;
                float3 Normal;
                float3 Tangent;
            };

            VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
            {
                VertexDescription description = (VertexDescription)0;
                description.Position = IN.ObjectSpacePosition;
                description.Normal = IN.ObjectSpaceNormal;
                description.Tangent = IN.ObjectSpaceTangent;
                return description;
            }

            // Custom interpolators, pre surface
            #ifdef FEATURES_GRAPH_VERTEX
            Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
            {
                return output;
            }

            #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
            #endif

            // Graph Pixel
            struct SurfaceDescription
            {
                float Alpha;
                float AlphaClipThreshold;
            };

            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                UnityTexture2D _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D =
                    UnityBuildTexture2DStructNoScale(_MainTex);
                float4 _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.tex,
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.samplerstate,
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy));
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_R_4_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.r;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_G_5_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.g;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_B_6_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.b;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_A_7_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.a;
                float _Property_37dc8cb8a76944c9913be5da772d091a_Out_0_Float = _ALpha;
                float _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float;
                Unity_Multiply_float_float(_SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_A_7_Float,
                                           _Property_37dc8cb8a76944c9913be5da772d091a_Out_0_Float,
                                           _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float);
                surface.Alpha = _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float;
                surface.AlphaClipThreshold = 0.5;
                return surface;
            }

            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
            #endif
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);

                output.ObjectSpaceNormal = input.normalOS;
                output.ObjectSpaceTangent = input.tangentOS.xyz;
                output.ObjectSpacePosition = input.positionOS;

                return output;
            }

            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

                #ifdef HAVE_VFX_MODIFICATION
                #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
                #endif
                /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */

                #endif


                #if UNITY_UV_STARTS_AT_TOP
                #else
                #endif


                output.uv0 = input.texCoord0;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

                return output;
            }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"

            // --------------------------------------------------
            // Visual Effect Vertex Invocations
            #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
            #endif
            ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }

            // Render State
            Cull Back

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM
            // Pragmas
            #pragma target 2.0
            #pragma exclude_renderers d3d11_9x
            #pragma vertex vert
            #pragma fragment frag

            // Keywords
            // PassKeywords: <None>
            // GraphKeywords: <None>

            // Defines

            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define VARYINGS_NEED_TEXCOORD0
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHONLY
            #define SCENEPICKINGPASS 1

            #define _ALPHATEST_ON 1


            // custom interpolator pre-include
            /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            // custom interpolators pre packing
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */

            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv0 : TEXCOORD0;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float4 texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };

            struct SurfaceDescriptionInputs
            {
                float4 uv0;
            };

            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
            };

            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                float4 texCoord0 : INTERP0;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };

            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output;
                ZERO_INITIALIZE(PackedVaryings, output);
                output.positionCS = input.positionCS;
                output.texCoord0.xyzw = input.texCoord0;
                #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
                #endif
                return output;
            }

            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output;
                output.positionCS = input.positionCS;
                output.texCoord0 = input.texCoord0.xyzw;
                #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
                #endif
                return output;
            }


            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
                float4 _MainTex_TexelSize;
                float4 _Glow;
                float _Strength;
                float4 _EmissionbMask_TexelSize;
                float _ALpha;
            CBUFFER_END


            // Object and Global properties
            SAMPLER(SamplerState_Linear_Repeat);
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            TEXTURE2D(_EmissionbMask);
            SAMPLER(sampler_EmissionbMask);

            // Graph Includes
            // GraphIncludes: <None>

            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif

            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
            #endif

            // Graph Functions

            void Unity_Multiply_float_float(float A, float B, out float Out)
            {
                Out = A * B;
            }

            // Custom interpolators pre vertex
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */

            // Graph Vertex
            struct VertexDescription
            {
                float3 Position;
                float3 Normal;
                float3 Tangent;
            };

            VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
            {
                VertexDescription description = (VertexDescription)0;
                description.Position = IN.ObjectSpacePosition;
                description.Normal = IN.ObjectSpaceNormal;
                description.Tangent = IN.ObjectSpaceTangent;
                return description;
            }

            // Custom interpolators, pre surface
            #ifdef FEATURES_GRAPH_VERTEX
            Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
            {
                return output;
            }

            #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
            #endif

            // Graph Pixel
            struct SurfaceDescription
            {
                float Alpha;
                float AlphaClipThreshold;
            };

            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                UnityTexture2D _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D =
                    UnityBuildTexture2DStructNoScale(_MainTex);
                float4 _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.tex,
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.samplerstate,
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy));
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_R_4_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.r;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_G_5_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.g;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_B_6_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.b;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_A_7_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.a;
                float _Property_37dc8cb8a76944c9913be5da772d091a_Out_0_Float = _ALpha;
                float _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float;
                Unity_Multiply_float_float(_SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_A_7_Float,
                                           _Property_37dc8cb8a76944c9913be5da772d091a_Out_0_Float,
                                           _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float);
                surface.Alpha = _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float;
                surface.AlphaClipThreshold = 0.5;
                return surface;
            }

            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
            #endif
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                ZERO_INITIALIZE(VertexDescriptionInputs, output);

                output.ObjectSpaceNormal = input.normalOS;
                output.ObjectSpaceTangent = input.tangentOS.xyz;
                output.ObjectSpacePosition = input.positionOS;

                return output;
            }

            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

                #ifdef HAVE_VFX_MODIFICATION
                #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
                #endif
                /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */

                #endif


                #if UNITY_UV_STARTS_AT_TOP
                #else
                #endif


                output.uv0 = input.texCoord0;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

                return output;
            }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"

            // --------------------------------------------------
            // Visual Effect Vertex Invocations
            #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
            #endif
            ENDHLSL
        }
        Pass
        {
            Name "Sprite Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }

            // Render State
            Cull Off
            Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
            ZTest LEqual
            ZWrite Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM
            // Pragmas
            #pragma target 2.0
            #pragma exclude_renderers d3d11_9x
            #pragma vertex vert
            #pragma fragment frag

            // Keywords
            #pragma multi_compile_fragment _ DEBUG_DISPLAY
            // GraphKeywords: <None>

            // Defines

            #define ATTRIBUTES_NEED_NORMAL
            #define ATTRIBUTES_NEED_TANGENT
            #define ATTRIBUTES_NEED_TEXCOORD0
            #define ATTRIBUTES_NEED_COLOR
            #define VARYINGS_NEED_POSITION_WS
            #define VARYINGS_NEED_TEXCOORD0
            #define VARYINGS_NEED_COLOR
            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_SPRITEFORWARD


            // custom interpolator pre-include
            /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            // custom interpolators pre packing
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */

            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float4 tangentOS : TANGENT;
                float4 uv0 : TEXCOORD0;
                float4 color : COLOR;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : INSTANCEID_SEMANTIC;
                #endif
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float3 positionWS;
                float4 texCoord0;
                float4 color;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };

            struct SurfaceDescriptionInputs
            {
                float3 TangentSpaceNormal;
                float4 uv0;
            };

            struct VertexDescriptionInputs
            {
                float3 ObjectSpaceNormal;
                float3 ObjectSpaceTangent;
                float3 ObjectSpacePosition;
            };

            struct PackedVaryings
            {
                float4 positionCS : SV_POSITION;
                float4 texCoord0 : INTERP0;
                float4 color : INTERP1;
                float3 positionWS : INTERP2;
                #if UNITY_ANY_INSTANCING_ENABLED
             uint instanceID : CUSTOM_INSTANCE_ID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
                #endif
            };

            PackedVaryings PackVaryings(Varyings input)
            {
                PackedVaryings output;
                ZERO_INITIALIZE(PackedVaryings, output);
                output.positionCS = input.positionCS;
                output.texCoord0.xyzw = input.texCoord0;
                output.color.xyzw = input.color;
                output.positionWS.xyz = input.positionWS;
                #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
                #endif
                return output;
            }

            Varyings UnpackVaryings(PackedVaryings input)
            {
                Varyings output;
                output.positionCS = input.positionCS;
                output.texCoord0 = input.texCoord0.xyzw;
                output.color = input.color.xyzw;
                output.positionWS = input.positionWS.xyz;
                #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
                #endif
                #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
                #endif
                #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
                #endif
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
                #endif
                return output;
            }


            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
                float4 _MainTex_TexelSize;
                float4 _Glow;
                float _Strength;
                float4 _EmissionbMask_TexelSize;
                float _ALpha;
            CBUFFER_END


            // Object and Global properties
            SAMPLER(SamplerState_Linear_Repeat);
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            TEXTURE2D(_EmissionbMask);
            SAMPLER(sampler_EmissionbMask);

            // Graph Includes
            // GraphIncludes: <None>

            // -- Property used by ScenePickingPass
            #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
            #endif

            // -- Properties used by SceneSelectionPass
            #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
            #endif

            // Graph Functions

            void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
            {
                Out = A * B;
            }

            void Unity_Minimum_float(float A, float B, out float Out)
            {
                Out = min(A, B);
            };

            void Unity_Add_float4(float4 A, float4 B, out float4 Out)
            {
                Out = A + B;
            }

            void Unity_Multiply_float_float(float A, float B, out float Out)
            {
                Out = A * B;
            }

            // Custom interpolators pre vertex
            /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */

            // Graph Vertex
            struct VertexDescription
            {
                float3 Position;
                float3 Normal;
                float3 Tangent;
            };

            VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
            {
                VertexDescription description = (VertexDescription)0;
                description.Position = IN.ObjectSpacePosition;
                description.Normal = IN.ObjectSpaceNormal;
                description.Tangent = IN.ObjectSpaceTangent;
                return description;
            }

            // Custom interpolators, pre surface
            #ifdef FEATURES_GRAPH_VERTEX
            Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
            {
                return output;
            }

            #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
            #endif

            // Graph Pixel
            struct SurfaceDescription
            {
                float3 BaseColor;
                float Alpha;
                float3 NormalTS;
                float AlphaClipThreshold;
            };

            SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
            {
                SurfaceDescription surface = (SurfaceDescription)0;
                float4 _Property_7895c92ffdec4cf3b513a34d7a97101f_Out_0_Vector4 = IsGammaSpace()
                                                                                  ? LinearToSRGB(_Glow)
                                                                                  : _Glow;
                float _Property_4cb5610e5eb1466aa36feaad4cafbe4f_Out_0_Float = _Strength;
                float4 _Multiply_c7e7148a30454b1f8872c2fa2e81ec7e_Out_2_Vector4;
                Unity_Multiply_float4_float4(_Property_7895c92ffdec4cf3b513a34d7a97101f_Out_0_Vector4,
 (_Property_4cb5610e5eb1466aa36feaad4cafbe4f_Out_0_Float.xxxx),
 _Multiply_c7e7148a30454b1f8872c2fa2e81ec7e_Out_2_Vector4);
                UnityTexture2D _Property_524e00dd729d41c7931a817295285a49_Out_0_Texture2D =
                    UnityBuildTexture2DStructNoScale(_EmissionbMask);
                float4 _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(
                    _Property_524e00dd729d41c7931a817295285a49_Out_0_Texture2D.tex,
                    _Property_524e00dd729d41c7931a817295285a49_Out_0_Texture2D.samplerstate,
                    _Property_524e00dd729d41c7931a817295285a49_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy));
                float _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_R_4_Float =
                    _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4.r;
                float _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_G_5_Float =
                    _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4.g;
                float _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_B_6_Float =
                    _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4.b;
                float _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_A_7_Float =
                    _SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_RGBA_0_Vector4.a;
                float _Property_746d5f93b18e4a3c86cdf3f67bab009a_Out_0_Float = _ALpha;
                float _Minimum_d6fe71be7ef74ccca0afe0be52c88cd0_Out_2_Float;
                Unity_Minimum_float(_SampleTexture2D_29602f17c85c415e81f24c6d01f4e650_A_7_Float,
                                           _Property_746d5f93b18e4a3c86cdf3f67bab009a_Out_0_Float,
                                           _Minimum_d6fe71be7ef74ccca0afe0be52c88cd0_Out_2_Float);
                float4 _Multiply_a488f28ccbed4693b7096ba057c5bb4b_Out_2_Vector4;
                Unity_Multiply_float4_float4(_Multiply_c7e7148a30454b1f8872c2fa2e81ec7e_Out_2_Vector4,
          (_Minimum_d6fe71be7ef74ccca0afe0be52c88cd0_Out_2_Float.xxxx),
          _Multiply_a488f28ccbed4693b7096ba057c5bb4b_Out_2_Vector4);
                UnityTexture2D _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D =
                    UnityBuildTexture2DStructNoScale(_MainTex);
                float4 _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.tex,
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.samplerstate,
                    _Property_a01ddbe381f7461fbd153a0c09cfb2b3_Out_0_Texture2D.GetTransformedUV(IN.uv0.xy));
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_R_4_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.r;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_G_5_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.g;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_B_6_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.b;
                float _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_A_7_Float =
                    _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4.a;
                float4 _Add_e30b4dda06a645d984dd43bf4d4dc921_Out_2_Vector4;
                Unity_Add_float4(_Multiply_a488f28ccbed4693b7096ba057c5bb4b_Out_2_Vector4,
                                                                        _SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_RGBA_0_Vector4,
                                                                        _Add_e30b4dda06a645d984dd43bf4d4dc921_Out_2_Vector4);
                float _Property_37dc8cb8a76944c9913be5da772d091a_Out_0_Float = _ALpha;
                float _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float;
                Unity_Multiply_float_float(_SampleTexture2D_61eaac7328584a419bb65aaf909d2db2_A_7_Float,
                                                           _Property_37dc8cb8a76944c9913be5da772d091a_Out_0_Float,
                                                           _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float);
                surface.BaseColor = (_Add_e30b4dda06a645d984dd43bf4d4dc921_Out_2_Vector4.xyz);
                surface.Alpha = _Multiply_bd44521f0d9c4eeebd7917d4c5f2d02e_Out_2_Float;
                surface.NormalTS = IN.TangentSpaceNormal;
                surface.AlphaClipThreshold = 0.5;
                return surface;
            }

            // --------------------------------------------------
            // Build Graph Inputs
            #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
            #endif
            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
            {
                VertexDescriptionInputs output;
                    ZERO_INITIALIZE(VertexDescriptionInputs, output);

                output.ObjectSpaceNormal = input.normalOS;
                output.ObjectSpaceTangent = input.tangentOS.xyz;
                output.ObjectSpacePosition = input.positionOS;

                return output;
            }

            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
            {
                SurfaceDescriptionInputs output;
                ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

                #ifdef HAVE_VFX_MODIFICATION
                #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
                #endif
                /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */

                #endif


                output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);


                #if UNITY_UV_STARTS_AT_TOP
                #else
                #endif


                output.uv0 = input.texCoord0;
                #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
                #else
                #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
                #endif
                #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

                return output;
            }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Editor/2D/ShaderGraph/Includes/SpriteForwardPass.hlsl"

            // --------------------------------------------------
            // Visual Effect Vertex Invocations
            #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
            #endif
            ENDHLSL
        }
    }
    CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}
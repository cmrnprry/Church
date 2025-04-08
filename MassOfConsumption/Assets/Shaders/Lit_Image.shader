Shader "Custom/Lit_Image"
{
    Properties
    {
        [NoScaleOffset]_MainTex("MainTex", 2D) = "white" {}
        _BlurAmount("BlurAmount", Range(0, 0.1)) = 0
        [NoScaleOffset]_FlowMap("FlowMap", 2D) = "white" {}
        _Strength("Strength", Float) = 0.005
        _Speed("Speed", Float) = 5
        _Offset("Offset", Float) = 0.25
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
        
        _StencilComp ("Stencil Comparison", Float) = 8.000000
        _Stencil ("Stencil ID", Float) = 0.000000
        _StencilOp ("Stencil Operation", Float) = 0.000000
        _StencilWriteMask ("Stencil Write Mask", Float) = 255.000000
        _StencilReadMask ("Stencil Read Mask", Float) = 255.000000
        _ColorMask ("Color Mask", Float) = 15.000000
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
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
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
             float3 TimeParameters;
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
        
        PackedVaryings PackVaryings (Varyings input)
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
        
        Varyings UnpackVaryings (PackedVaryings input)
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
        float _BlurAmount;
        float4 _FlowMap_TexelSize;
        float _Strength;
        float _Speed;
        float _Offset;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        TEXTURE2D(_FlowMap);
        SAMPLER(sampler_FlowMap);
        
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
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        struct Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float
        {
        half4 uv0;
        };
        
        void SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(UnityTexture2D _MainTex, float2 _Vector2, Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float IN, out float4 OutVector4_1, out float OutVector1_2)
        {
        UnityTexture2D _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D = _MainTex;
        float2 _Property_d30efce2e26c40bea68f6cc065fc9cf4_Out_0_Vector2 = _Vector2;
        float2 _TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2;
        Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), _Property_d30efce2e26c40bea68f6cc065fc9cf4_Out_0_Vector2, _TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2);
        float4 _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.tex, _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.samplerstate, _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2) );
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_R_4_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.r;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_G_5_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.g;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_B_6_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.b;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_A_7_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.a;
        OutVector4_1 = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4;
        OutVector1_2 = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_A_7_Float;
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A / B;
        }
        
        void Unity_Modulo_float(float A, float B, out float Out)
        {
            Out = fmod(A, B);
        }
        
        void Unity_Floor_float(float In, out float Out)
        {
            Out = floor(In);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_NormalFromTexture_float(TEXTURE2D_PARAM(Texture, Sampler), float2 UV, float Offset, float Strength, out float3 Out)
        {
            Offset = pow(Offset, 3) * 0.1;
            float2 offsetU = float2(UV.x + Offset, UV.y);
            float2 offsetV = float2(UV.x, UV.y + Offset);
            float normalSample = SAMPLE_TEXTURE2D(Texture, Sampler, UV);
            float uSample = SAMPLE_TEXTURE2D(Texture, Sampler, offsetU);
            float vSample = SAMPLE_TEXTURE2D(Texture, Sampler, offsetV);
            float3 va = float3(1, 0, (uSample - normalSample) * Strength);
            float3 vb = float3(0, 1, (vSample - normalSample) * Strength);
            Out = normalize(cross(va, vb));
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
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
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_26de114a6b574b749478e5f3ec311d39_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float _Property_cbac3264fd684e689d0235d2e8896895_Out_0_Float = _BlurAmount;
            float _Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float;
            Unity_Multiply_float_float(_Property_cbac3264fd684e689d0235d2e8896895_Out_0_Float, 1, _Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float);
            float2 _Vector2_b8bb5baa6aa64c9bb0002f991b9c5f23_Out_0_Vector2 = float2(_Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float, 0);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035;
            _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_26de114a6b574b749478e5f3ec311d39_Out_0_Texture2D, _Vector2_b8bb5baa6aa64c9bb0002f991b9c5f23_Out_0_Vector2, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector4_1_Vector4, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float);
            UnityTexture2D _Property_88bbaa8decf44045a4987288784f0e87_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float _Property_8a9166bbd58d48639d1535f91ee5049c_Out_0_Float = _BlurAmount;
            float _Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float;
            Unity_Multiply_float_float(_Property_8a9166bbd58d48639d1535f91ee5049c_Out_0_Float, -1, _Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float);
            float2 _Vector2_0af5d4ebce0343ef9b015924065f4a0e_Out_0_Vector2 = float2(_Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float, 0);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba;
            _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_88bbaa8decf44045a4987288784f0e87_Out_0_Texture2D, _Vector2_0af5d4ebce0343ef9b015924065f4a0e_Out_0_Vector2, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector4_1_Vector4, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float);
            float4 _Add_f125c3c43e6a496a888eb5cea8acf1bd_Out_2_Vector4;
            Unity_Add_float4(_BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector4_1_Vector4, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector4_1_Vector4, _Add_f125c3c43e6a496a888eb5cea8acf1bd_Out_2_Vector4);
            UnityTexture2D _Property_b1e578c9d06b497da9dbc46a09aa6a6f_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51;
            _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_b1e578c9d06b497da9dbc46a09aa6a6f_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51, _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector4_1_Vector4, _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float);
            float4 _Add_d173562a3bca4920bc23344c87ed0319_Out_2_Vector4;
            Unity_Add_float4(_Add_f125c3c43e6a496a888eb5cea8acf1bd_Out_2_Vector4, _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector4_1_Vector4, _Add_d173562a3bca4920bc23344c87ed0319_Out_2_Vector4);
            UnityTexture2D _Property_4aa7850d6e0e4fd18f4d2d521eeaa65e_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9;
            _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_4aa7850d6e0e4fd18f4d2d521eeaa65e_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9, _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector4_1_Vector4, _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float);
            float4 _Add_52658006867f4d29889330a3cb3568f7_Out_2_Vector4;
            Unity_Add_float4(_Add_d173562a3bca4920bc23344c87ed0319_Out_2_Vector4, _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector4_1_Vector4, _Add_52658006867f4d29889330a3cb3568f7_Out_2_Vector4);
            UnityTexture2D _Property_b3956ee110b245be928b06fc19f57b11_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476;
            _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_b3956ee110b245be928b06fc19f57b11_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector4_1_Vector4, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float);
            float4 _Add_93ec14b88d6540a3a4095f6788ad9f66_Out_2_Vector4;
            Unity_Add_float4(_Add_52658006867f4d29889330a3cb3568f7_Out_2_Vector4, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector4_1_Vector4, _Add_93ec14b88d6540a3a4095f6788ad9f66_Out_2_Vector4);
            float _Float_5f4d7f798fad4fd2a03ff1772815a5b2_Out_0_Float = 5;
            float4 _Divide_421a278018db49a9a26b9f4714edf115_Out_2_Vector4;
            Unity_Divide_float4(_Add_93ec14b88d6540a3a4095f6788ad9f66_Out_2_Vector4, (_Float_5f4d7f798fad4fd2a03ff1772815a5b2_Out_0_Float.xxxx), _Divide_421a278018db49a9a26b9f4714edf115_Out_2_Vector4);
            UnityTexture2D _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float4 _UV_0294f9635a0c465aa04e752ef9d8bfff_Out_0_Vector4 = IN.uv0;
            UnityTexture2D _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_FlowMap);
            float _Property_86bc69d3e3d9429eb137150bba0325fe_Out_0_Float = _Speed;
            float _Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_86bc69d3e3d9429eb137150bba0325fe_Out_0_Float, _Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float);
            float _Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float;
            Unity_Modulo_float(_Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float, 4, _Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float);
            float _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float;
            Unity_Floor_float(_Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float, _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float);
            float _Divide_211d979995f64a069de4d619effe5136_Out_2_Float;
            Unity_Divide_float(4, _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float, _Divide_211d979995f64a069de4d619effe5136_Out_2_Float);
            float2 _TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Divide_211d979995f64a069de4d619effe5136_Out_2_Float.xx), _TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2);
            float _Property_4db63957a90148b590d918ce54be0a19_Out_0_Float = _Offset;
            float3 _NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3;
            Unity_NormalFromTexture_float(TEXTURE2D_ARGS(_Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.tex, _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.samplerstate), _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2), _Property_4db63957a90148b590d918ce54be0a19_Out_0_Float, 5, _NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3);
            float _Property_836c03a7825740ccbc431954a1cce51f_Out_0_Float = _Strength;
            float3 _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3;
            Unity_Multiply_float3_float3(_NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3, (_Property_836c03a7825740ccbc431954a1cce51f_Out_0_Float.xxx), _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3);
            float3 _Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3;
            Unity_Add_float3((_UV_0294f9635a0c465aa04e752ef9d8bfff_Out_0_Vector4.xyz), _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3, _Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3);
            float4 _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.tex, _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.samplerstate, _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.GetTransformedUV((_Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3.xy)) );
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_R_4_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.r;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_G_5_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.g;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_B_6_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.b;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_A_7_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.a;
            float4 _Add_4f32dfe611e04d33aeab64d06c317852_Out_2_Vector4;
            Unity_Add_float4(_Divide_421a278018db49a9a26b9f4714edf115_Out_2_Vector4, _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4, _Add_4f32dfe611e04d33aeab64d06c317852_Out_2_Vector4);
            float _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float, _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float);
            float _Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float, _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float, _Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float);
            float _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float;
            Unity_Add_float(_Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float, _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float);
            float _Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float, _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float, _Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float);
            float _Float_00882ea2b0e4482093e410df2dab80c4_Out_0_Float = 5;
            float _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float;
            Unity_Divide_float(_Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float, _Float_00882ea2b0e4482093e410df2dab80c4_Out_0_Float, _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float);
            float _Add_1514421666c84da39528c376ca8b563f_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_507ba14a97ea40469669863ed6357310_A_7_Float, _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float, _Add_1514421666c84da39528c376ca8b563f_Out_2_Float);
            surface.BaseColor = (_Add_4f32dfe611e04d33aeab64d06c317852_Out_2_Vector4.xyz);
            surface.Alpha = _Add_1514421666c84da39528c376ca8b563f_Out_2_Float;
            surface.SpriteMask = IsGammaSpace() ? float4(1, 1, 1, 1) : float4 (SRGBToLinear(float3(1, 1, 1)), 1);
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
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
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
            output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
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
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
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
             float3 TimeParameters;
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
        
        PackedVaryings PackVaryings (Varyings input)
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
        
        Varyings UnpackVaryings (PackedVaryings input)
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
        float _BlurAmount;
        float4 _FlowMap_TexelSize;
        float _Strength;
        float _Speed;
        float _Offset;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        TEXTURE2D(_FlowMap);
        SAMPLER(sampler_FlowMap);
        
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
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        struct Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float
        {
        half4 uv0;
        };
        
        void SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(UnityTexture2D _MainTex, float2 _Vector2, Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float IN, out float4 OutVector4_1, out float OutVector1_2)
        {
        UnityTexture2D _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D = _MainTex;
        float2 _Property_d30efce2e26c40bea68f6cc065fc9cf4_Out_0_Vector2 = _Vector2;
        float2 _TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2;
        Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), _Property_d30efce2e26c40bea68f6cc065fc9cf4_Out_0_Vector2, _TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2);
        float4 _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.tex, _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.samplerstate, _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2) );
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_R_4_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.r;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_G_5_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.g;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_B_6_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.b;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_A_7_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.a;
        OutVector4_1 = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4;
        OutVector1_2 = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_A_7_Float;
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A / B;
        }
        
        void Unity_Modulo_float(float A, float B, out float Out)
        {
            Out = fmod(A, B);
        }
        
        void Unity_Floor_float(float In, out float Out)
        {
            Out = floor(In);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_NormalFromTexture_float(TEXTURE2D_PARAM(Texture, Sampler), float2 UV, float Offset, float Strength, out float3 Out)
        {
            Offset = pow(Offset, 3) * 0.1;
            float2 offsetU = float2(UV.x + Offset, UV.y);
            float2 offsetV = float2(UV.x, UV.y + Offset);
            float normalSample = SAMPLE_TEXTURE2D(Texture, Sampler, UV);
            float uSample = SAMPLE_TEXTURE2D(Texture, Sampler, offsetU);
            float vSample = SAMPLE_TEXTURE2D(Texture, Sampler, offsetV);
            float3 va = float3(1, 0, (uSample - normalSample) * Strength);
            float3 vb = float3(0, 1, (vSample - normalSample) * Strength);
            Out = normalize(cross(va, vb));
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
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
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_26de114a6b574b749478e5f3ec311d39_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float _Property_cbac3264fd684e689d0235d2e8896895_Out_0_Float = _BlurAmount;
            float _Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float;
            Unity_Multiply_float_float(_Property_cbac3264fd684e689d0235d2e8896895_Out_0_Float, 1, _Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float);
            float2 _Vector2_b8bb5baa6aa64c9bb0002f991b9c5f23_Out_0_Vector2 = float2(_Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float, 0);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035;
            _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_26de114a6b574b749478e5f3ec311d39_Out_0_Texture2D, _Vector2_b8bb5baa6aa64c9bb0002f991b9c5f23_Out_0_Vector2, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector4_1_Vector4, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float);
            UnityTexture2D _Property_88bbaa8decf44045a4987288784f0e87_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float _Property_8a9166bbd58d48639d1535f91ee5049c_Out_0_Float = _BlurAmount;
            float _Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float;
            Unity_Multiply_float_float(_Property_8a9166bbd58d48639d1535f91ee5049c_Out_0_Float, -1, _Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float);
            float2 _Vector2_0af5d4ebce0343ef9b015924065f4a0e_Out_0_Vector2 = float2(_Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float, 0);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba;
            _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_88bbaa8decf44045a4987288784f0e87_Out_0_Texture2D, _Vector2_0af5d4ebce0343ef9b015924065f4a0e_Out_0_Vector2, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector4_1_Vector4, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float);
            float4 _Add_f125c3c43e6a496a888eb5cea8acf1bd_Out_2_Vector4;
            Unity_Add_float4(_BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector4_1_Vector4, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector4_1_Vector4, _Add_f125c3c43e6a496a888eb5cea8acf1bd_Out_2_Vector4);
            UnityTexture2D _Property_b1e578c9d06b497da9dbc46a09aa6a6f_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51;
            _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_b1e578c9d06b497da9dbc46a09aa6a6f_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51, _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector4_1_Vector4, _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float);
            float4 _Add_d173562a3bca4920bc23344c87ed0319_Out_2_Vector4;
            Unity_Add_float4(_Add_f125c3c43e6a496a888eb5cea8acf1bd_Out_2_Vector4, _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector4_1_Vector4, _Add_d173562a3bca4920bc23344c87ed0319_Out_2_Vector4);
            UnityTexture2D _Property_4aa7850d6e0e4fd18f4d2d521eeaa65e_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9;
            _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_4aa7850d6e0e4fd18f4d2d521eeaa65e_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9, _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector4_1_Vector4, _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float);
            float4 _Add_52658006867f4d29889330a3cb3568f7_Out_2_Vector4;
            Unity_Add_float4(_Add_d173562a3bca4920bc23344c87ed0319_Out_2_Vector4, _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector4_1_Vector4, _Add_52658006867f4d29889330a3cb3568f7_Out_2_Vector4);
            UnityTexture2D _Property_b3956ee110b245be928b06fc19f57b11_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476;
            _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_b3956ee110b245be928b06fc19f57b11_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector4_1_Vector4, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float);
            float4 _Add_93ec14b88d6540a3a4095f6788ad9f66_Out_2_Vector4;
            Unity_Add_float4(_Add_52658006867f4d29889330a3cb3568f7_Out_2_Vector4, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector4_1_Vector4, _Add_93ec14b88d6540a3a4095f6788ad9f66_Out_2_Vector4);
            float _Float_5f4d7f798fad4fd2a03ff1772815a5b2_Out_0_Float = 5;
            float4 _Divide_421a278018db49a9a26b9f4714edf115_Out_2_Vector4;
            Unity_Divide_float4(_Add_93ec14b88d6540a3a4095f6788ad9f66_Out_2_Vector4, (_Float_5f4d7f798fad4fd2a03ff1772815a5b2_Out_0_Float.xxxx), _Divide_421a278018db49a9a26b9f4714edf115_Out_2_Vector4);
            UnityTexture2D _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float4 _UV_0294f9635a0c465aa04e752ef9d8bfff_Out_0_Vector4 = IN.uv0;
            UnityTexture2D _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_FlowMap);
            float _Property_86bc69d3e3d9429eb137150bba0325fe_Out_0_Float = _Speed;
            float _Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_86bc69d3e3d9429eb137150bba0325fe_Out_0_Float, _Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float);
            float _Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float;
            Unity_Modulo_float(_Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float, 4, _Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float);
            float _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float;
            Unity_Floor_float(_Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float, _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float);
            float _Divide_211d979995f64a069de4d619effe5136_Out_2_Float;
            Unity_Divide_float(4, _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float, _Divide_211d979995f64a069de4d619effe5136_Out_2_Float);
            float2 _TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Divide_211d979995f64a069de4d619effe5136_Out_2_Float.xx), _TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2);
            float _Property_4db63957a90148b590d918ce54be0a19_Out_0_Float = _Offset;
            float3 _NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3;
            Unity_NormalFromTexture_float(TEXTURE2D_ARGS(_Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.tex, _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.samplerstate), _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2), _Property_4db63957a90148b590d918ce54be0a19_Out_0_Float, 5, _NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3);
            float _Property_836c03a7825740ccbc431954a1cce51f_Out_0_Float = _Strength;
            float3 _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3;
            Unity_Multiply_float3_float3(_NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3, (_Property_836c03a7825740ccbc431954a1cce51f_Out_0_Float.xxx), _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3);
            float3 _Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3;
            Unity_Add_float3((_UV_0294f9635a0c465aa04e752ef9d8bfff_Out_0_Vector4.xyz), _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3, _Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3);
            float4 _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.tex, _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.samplerstate, _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.GetTransformedUV((_Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3.xy)) );
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_R_4_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.r;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_G_5_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.g;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_B_6_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.b;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_A_7_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.a;
            float4 _Add_4f32dfe611e04d33aeab64d06c317852_Out_2_Vector4;
            Unity_Add_float4(_Divide_421a278018db49a9a26b9f4714edf115_Out_2_Vector4, _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4, _Add_4f32dfe611e04d33aeab64d06c317852_Out_2_Vector4);
            float _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float, _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float);
            float _Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float, _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float, _Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float);
            float _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float;
            Unity_Add_float(_Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float, _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float);
            float _Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float, _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float, _Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float);
            float _Float_00882ea2b0e4482093e410df2dab80c4_Out_0_Float = 5;
            float _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float;
            Unity_Divide_float(_Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float, _Float_00882ea2b0e4482093e410df2dab80c4_Out_0_Float, _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float);
            float _Add_1514421666c84da39528c376ca8b563f_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_507ba14a97ea40469669863ed6357310_A_7_Float, _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float, _Add_1514421666c84da39528c376ca8b563f_Out_2_Float);
            surface.BaseColor = (_Add_4f32dfe611e04d33aeab64d06c317852_Out_2_Vector4.xyz);
            surface.Alpha = _Add_1514421666c84da39528c376ca8b563f_Out_2_Float;
            surface.NormalTS = IN.TangentSpaceNormal;
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
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
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
            output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
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
        
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
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
             float3 TimeParameters;
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
        
        PackedVaryings PackVaryings (Varyings input)
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
        
        Varyings UnpackVaryings (PackedVaryings input)
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
        float _BlurAmount;
        float4 _FlowMap_TexelSize;
        float _Strength;
        float _Speed;
        float _Offset;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        TEXTURE2D(_FlowMap);
        SAMPLER(sampler_FlowMap);
        
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
        
        void Unity_Modulo_float(float A, float B, out float Out)
        {
            Out = fmod(A, B);
        }
        
        void Unity_Floor_float(float In, out float Out)
        {
            Out = floor(In);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_NormalFromTexture_float(TEXTURE2D_PARAM(Texture, Sampler), float2 UV, float Offset, float Strength, out float3 Out)
        {
            Offset = pow(Offset, 3) * 0.1;
            float2 offsetU = float2(UV.x + Offset, UV.y);
            float2 offsetV = float2(UV.x, UV.y + Offset);
            float normalSample = SAMPLE_TEXTURE2D(Texture, Sampler, UV);
            float uSample = SAMPLE_TEXTURE2D(Texture, Sampler, offsetU);
            float vSample = SAMPLE_TEXTURE2D(Texture, Sampler, offsetV);
            float3 va = float3(1, 0, (uSample - normalSample) * Strength);
            float3 vb = float3(0, 1, (vSample - normalSample) * Strength);
            Out = normalize(cross(va, vb));
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        struct Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float
        {
        half4 uv0;
        };
        
        void SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(UnityTexture2D _MainTex, float2 _Vector2, Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float IN, out float4 OutVector4_1, out float OutVector1_2)
        {
        UnityTexture2D _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D = _MainTex;
        float2 _Property_d30efce2e26c40bea68f6cc065fc9cf4_Out_0_Vector2 = _Vector2;
        float2 _TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2;
        Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), _Property_d30efce2e26c40bea68f6cc065fc9cf4_Out_0_Vector2, _TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2);
        float4 _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.tex, _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.samplerstate, _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2) );
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_R_4_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.r;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_G_5_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.g;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_B_6_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.b;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_A_7_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.a;
        OutVector4_1 = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4;
        OutVector1_2 = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_A_7_Float;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
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
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float4 _UV_0294f9635a0c465aa04e752ef9d8bfff_Out_0_Vector4 = IN.uv0;
            UnityTexture2D _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_FlowMap);
            float _Property_86bc69d3e3d9429eb137150bba0325fe_Out_0_Float = _Speed;
            float _Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_86bc69d3e3d9429eb137150bba0325fe_Out_0_Float, _Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float);
            float _Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float;
            Unity_Modulo_float(_Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float, 4, _Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float);
            float _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float;
            Unity_Floor_float(_Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float, _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float);
            float _Divide_211d979995f64a069de4d619effe5136_Out_2_Float;
            Unity_Divide_float(4, _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float, _Divide_211d979995f64a069de4d619effe5136_Out_2_Float);
            float2 _TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Divide_211d979995f64a069de4d619effe5136_Out_2_Float.xx), _TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2);
            float _Property_4db63957a90148b590d918ce54be0a19_Out_0_Float = _Offset;
            float3 _NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3;
            Unity_NormalFromTexture_float(TEXTURE2D_ARGS(_Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.tex, _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.samplerstate), _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2), _Property_4db63957a90148b590d918ce54be0a19_Out_0_Float, 5, _NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3);
            float _Property_836c03a7825740ccbc431954a1cce51f_Out_0_Float = _Strength;
            float3 _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3;
            Unity_Multiply_float3_float3(_NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3, (_Property_836c03a7825740ccbc431954a1cce51f_Out_0_Float.xxx), _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3);
            float3 _Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3;
            Unity_Add_float3((_UV_0294f9635a0c465aa04e752ef9d8bfff_Out_0_Vector4.xyz), _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3, _Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3);
            float4 _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.tex, _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.samplerstate, _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.GetTransformedUV((_Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3.xy)) );
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_R_4_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.r;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_G_5_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.g;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_B_6_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.b;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_A_7_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.a;
            UnityTexture2D _Property_26de114a6b574b749478e5f3ec311d39_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float _Property_cbac3264fd684e689d0235d2e8896895_Out_0_Float = _BlurAmount;
            float _Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float;
            Unity_Multiply_float_float(_Property_cbac3264fd684e689d0235d2e8896895_Out_0_Float, 1, _Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float);
            float2 _Vector2_b8bb5baa6aa64c9bb0002f991b9c5f23_Out_0_Vector2 = float2(_Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float, 0);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035;
            _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_26de114a6b574b749478e5f3ec311d39_Out_0_Texture2D, _Vector2_b8bb5baa6aa64c9bb0002f991b9c5f23_Out_0_Vector2, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector4_1_Vector4, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float);
            UnityTexture2D _Property_b1e578c9d06b497da9dbc46a09aa6a6f_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51;
            _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_b1e578c9d06b497da9dbc46a09aa6a6f_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51, _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector4_1_Vector4, _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float);
            UnityTexture2D _Property_4aa7850d6e0e4fd18f4d2d521eeaa65e_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9;
            _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_4aa7850d6e0e4fd18f4d2d521eeaa65e_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9, _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector4_1_Vector4, _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float);
            UnityTexture2D _Property_b3956ee110b245be928b06fc19f57b11_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476;
            _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_b3956ee110b245be928b06fc19f57b11_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector4_1_Vector4, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float);
            float _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float, _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float);
            float _Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float, _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float, _Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float);
            UnityTexture2D _Property_88bbaa8decf44045a4987288784f0e87_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float _Property_8a9166bbd58d48639d1535f91ee5049c_Out_0_Float = _BlurAmount;
            float _Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float;
            Unity_Multiply_float_float(_Property_8a9166bbd58d48639d1535f91ee5049c_Out_0_Float, -1, _Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float);
            float2 _Vector2_0af5d4ebce0343ef9b015924065f4a0e_Out_0_Vector2 = float2(_Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float, 0);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba;
            _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_88bbaa8decf44045a4987288784f0e87_Out_0_Texture2D, _Vector2_0af5d4ebce0343ef9b015924065f4a0e_Out_0_Vector2, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector4_1_Vector4, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float);
            float _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float;
            Unity_Add_float(_Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float, _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float);
            float _Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float, _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float, _Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float);
            float _Float_00882ea2b0e4482093e410df2dab80c4_Out_0_Float = 5;
            float _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float;
            Unity_Divide_float(_Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float, _Float_00882ea2b0e4482093e410df2dab80c4_Out_0_Float, _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float);
            float _Add_1514421666c84da39528c376ca8b563f_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_507ba14a97ea40469669863ed6357310_A_7_Float, _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float, _Add_1514421666c84da39528c376ca8b563f_Out_2_Float);
            surface.Alpha = _Add_1514421666c84da39528c376ca8b563f_Out_2_Float;
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
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
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
            output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
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
        
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
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
             float3 TimeParameters;
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
        
        PackedVaryings PackVaryings (Varyings input)
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
        
        Varyings UnpackVaryings (PackedVaryings input)
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
        float _BlurAmount;
        float4 _FlowMap_TexelSize;
        float _Strength;
        float _Speed;
        float _Offset;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        TEXTURE2D(_FlowMap);
        SAMPLER(sampler_FlowMap);
        
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
        
        void Unity_Modulo_float(float A, float B, out float Out)
        {
            Out = fmod(A, B);
        }
        
        void Unity_Floor_float(float In, out float Out)
        {
            Out = floor(In);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_NormalFromTexture_float(TEXTURE2D_PARAM(Texture, Sampler), float2 UV, float Offset, float Strength, out float3 Out)
        {
            Offset = pow(Offset, 3) * 0.1;
            float2 offsetU = float2(UV.x + Offset, UV.y);
            float2 offsetV = float2(UV.x, UV.y + Offset);
            float normalSample = SAMPLE_TEXTURE2D(Texture, Sampler, UV);
            float uSample = SAMPLE_TEXTURE2D(Texture, Sampler, offsetU);
            float vSample = SAMPLE_TEXTURE2D(Texture, Sampler, offsetV);
            float3 va = float3(1, 0, (uSample - normalSample) * Strength);
            float3 vb = float3(0, 1, (vSample - normalSample) * Strength);
            Out = normalize(cross(va, vb));
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        struct Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float
        {
        half4 uv0;
        };
        
        void SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(UnityTexture2D _MainTex, float2 _Vector2, Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float IN, out float4 OutVector4_1, out float OutVector1_2)
        {
        UnityTexture2D _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D = _MainTex;
        float2 _Property_d30efce2e26c40bea68f6cc065fc9cf4_Out_0_Vector2 = _Vector2;
        float2 _TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2;
        Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), _Property_d30efce2e26c40bea68f6cc065fc9cf4_Out_0_Vector2, _TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2);
        float4 _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.tex, _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.samplerstate, _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2) );
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_R_4_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.r;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_G_5_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.g;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_B_6_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.b;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_A_7_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.a;
        OutVector4_1 = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4;
        OutVector1_2 = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_A_7_Float;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
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
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float4 _UV_0294f9635a0c465aa04e752ef9d8bfff_Out_0_Vector4 = IN.uv0;
            UnityTexture2D _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_FlowMap);
            float _Property_86bc69d3e3d9429eb137150bba0325fe_Out_0_Float = _Speed;
            float _Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_86bc69d3e3d9429eb137150bba0325fe_Out_0_Float, _Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float);
            float _Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float;
            Unity_Modulo_float(_Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float, 4, _Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float);
            float _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float;
            Unity_Floor_float(_Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float, _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float);
            float _Divide_211d979995f64a069de4d619effe5136_Out_2_Float;
            Unity_Divide_float(4, _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float, _Divide_211d979995f64a069de4d619effe5136_Out_2_Float);
            float2 _TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Divide_211d979995f64a069de4d619effe5136_Out_2_Float.xx), _TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2);
            float _Property_4db63957a90148b590d918ce54be0a19_Out_0_Float = _Offset;
            float3 _NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3;
            Unity_NormalFromTexture_float(TEXTURE2D_ARGS(_Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.tex, _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.samplerstate), _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2), _Property_4db63957a90148b590d918ce54be0a19_Out_0_Float, 5, _NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3);
            float _Property_836c03a7825740ccbc431954a1cce51f_Out_0_Float = _Strength;
            float3 _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3;
            Unity_Multiply_float3_float3(_NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3, (_Property_836c03a7825740ccbc431954a1cce51f_Out_0_Float.xxx), _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3);
            float3 _Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3;
            Unity_Add_float3((_UV_0294f9635a0c465aa04e752ef9d8bfff_Out_0_Vector4.xyz), _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3, _Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3);
            float4 _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.tex, _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.samplerstate, _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.GetTransformedUV((_Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3.xy)) );
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_R_4_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.r;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_G_5_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.g;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_B_6_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.b;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_A_7_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.a;
            UnityTexture2D _Property_26de114a6b574b749478e5f3ec311d39_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float _Property_cbac3264fd684e689d0235d2e8896895_Out_0_Float = _BlurAmount;
            float _Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float;
            Unity_Multiply_float_float(_Property_cbac3264fd684e689d0235d2e8896895_Out_0_Float, 1, _Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float);
            float2 _Vector2_b8bb5baa6aa64c9bb0002f991b9c5f23_Out_0_Vector2 = float2(_Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float, 0);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035;
            _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_26de114a6b574b749478e5f3ec311d39_Out_0_Texture2D, _Vector2_b8bb5baa6aa64c9bb0002f991b9c5f23_Out_0_Vector2, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector4_1_Vector4, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float);
            UnityTexture2D _Property_b1e578c9d06b497da9dbc46a09aa6a6f_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51;
            _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_b1e578c9d06b497da9dbc46a09aa6a6f_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51, _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector4_1_Vector4, _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float);
            UnityTexture2D _Property_4aa7850d6e0e4fd18f4d2d521eeaa65e_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9;
            _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_4aa7850d6e0e4fd18f4d2d521eeaa65e_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9, _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector4_1_Vector4, _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float);
            UnityTexture2D _Property_b3956ee110b245be928b06fc19f57b11_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476;
            _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_b3956ee110b245be928b06fc19f57b11_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector4_1_Vector4, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float);
            float _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float, _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float);
            float _Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float, _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float, _Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float);
            UnityTexture2D _Property_88bbaa8decf44045a4987288784f0e87_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float _Property_8a9166bbd58d48639d1535f91ee5049c_Out_0_Float = _BlurAmount;
            float _Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float;
            Unity_Multiply_float_float(_Property_8a9166bbd58d48639d1535f91ee5049c_Out_0_Float, -1, _Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float);
            float2 _Vector2_0af5d4ebce0343ef9b015924065f4a0e_Out_0_Vector2 = float2(_Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float, 0);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba;
            _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_88bbaa8decf44045a4987288784f0e87_Out_0_Texture2D, _Vector2_0af5d4ebce0343ef9b015924065f4a0e_Out_0_Vector2, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector4_1_Vector4, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float);
            float _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float;
            Unity_Add_float(_Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float, _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float);
            float _Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float, _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float, _Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float);
            float _Float_00882ea2b0e4482093e410df2dab80c4_Out_0_Float = 5;
            float _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float;
            Unity_Divide_float(_Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float, _Float_00882ea2b0e4482093e410df2dab80c4_Out_0_Float, _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float);
            float _Add_1514421666c84da39528c376ca8b563f_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_507ba14a97ea40469669863ed6357310_A_7_Float, _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float, _Add_1514421666c84da39528c376ca8b563f_Out_2_Float);
            surface.Alpha = _Add_1514421666c84da39528c376ca8b563f_Out_2_Float;
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
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
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
            output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
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
             float3 TimeParameters;
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
        
        PackedVaryings PackVaryings (Varyings input)
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
        
        Varyings UnpackVaryings (PackedVaryings input)
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
        float _BlurAmount;
        float4 _FlowMap_TexelSize;
        float _Strength;
        float _Speed;
        float _Offset;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        TEXTURE2D(_FlowMap);
        SAMPLER(sampler_FlowMap);
        
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
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        struct Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float
        {
        half4 uv0;
        };
        
        void SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(UnityTexture2D _MainTex, float2 _Vector2, Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float IN, out float4 OutVector4_1, out float OutVector1_2)
        {
        UnityTexture2D _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D = _MainTex;
        float2 _Property_d30efce2e26c40bea68f6cc065fc9cf4_Out_0_Vector2 = _Vector2;
        float2 _TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2;
        Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), _Property_d30efce2e26c40bea68f6cc065fc9cf4_Out_0_Vector2, _TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2);
        float4 _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.tex, _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.samplerstate, _Property_ca7f9e651378421fb6ef507420bd2520_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_3e4808ae64454fd2890ae71fe9c8f0ab_Out_3_Vector2) );
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_R_4_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.r;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_G_5_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.g;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_B_6_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.b;
        float _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_A_7_Float = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4.a;
        OutVector4_1 = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_RGBA_0_Vector4;
        OutVector1_2 = _SampleTexture2D_bcc0901abfb94595a8e1ccc048f36464_A_7_Float;
        }
        
        void Unity_Add_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A + B;
        }
        
        void Unity_Divide_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A / B;
        }
        
        void Unity_Modulo_float(float A, float B, out float Out)
        {
            Out = fmod(A, B);
        }
        
        void Unity_Floor_float(float In, out float Out)
        {
            Out = floor(In);
        }
        
        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }
        
        void Unity_NormalFromTexture_float(TEXTURE2D_PARAM(Texture, Sampler), float2 UV, float Offset, float Strength, out float3 Out)
        {
            Offset = pow(Offset, 3) * 0.1;
            float2 offsetU = float2(UV.x + Offset, UV.y);
            float2 offsetV = float2(UV.x, UV.y + Offset);
            float normalSample = SAMPLE_TEXTURE2D(Texture, Sampler, UV);
            float uSample = SAMPLE_TEXTURE2D(Texture, Sampler, offsetU);
            float vSample = SAMPLE_TEXTURE2D(Texture, Sampler, offsetV);
            float3 va = float3(1, 0, (uSample - normalSample) * Strength);
            float3 vb = float3(0, 1, (vSample - normalSample) * Strength);
            Out = normalize(cross(va, vb));
        }
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
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
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            UnityTexture2D _Property_26de114a6b574b749478e5f3ec311d39_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float _Property_cbac3264fd684e689d0235d2e8896895_Out_0_Float = _BlurAmount;
            float _Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float;
            Unity_Multiply_float_float(_Property_cbac3264fd684e689d0235d2e8896895_Out_0_Float, 1, _Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float);
            float2 _Vector2_b8bb5baa6aa64c9bb0002f991b9c5f23_Out_0_Vector2 = float2(_Multiply_a40b37e9dbea47d3b97294311210d42b_Out_2_Float, 0);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035;
            _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_26de114a6b574b749478e5f3ec311d39_Out_0_Texture2D, _Vector2_b8bb5baa6aa64c9bb0002f991b9c5f23_Out_0_Vector2, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector4_1_Vector4, _BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float);
            UnityTexture2D _Property_88bbaa8decf44045a4987288784f0e87_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float _Property_8a9166bbd58d48639d1535f91ee5049c_Out_0_Float = _BlurAmount;
            float _Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float;
            Unity_Multiply_float_float(_Property_8a9166bbd58d48639d1535f91ee5049c_Out_0_Float, -1, _Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float);
            float2 _Vector2_0af5d4ebce0343ef9b015924065f4a0e_Out_0_Vector2 = float2(_Multiply_50d4f1b86beb47aba995603f42ceb032_Out_2_Float, 0);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba;
            _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_88bbaa8decf44045a4987288784f0e87_Out_0_Texture2D, _Vector2_0af5d4ebce0343ef9b015924065f4a0e_Out_0_Vector2, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector4_1_Vector4, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float);
            float4 _Add_f125c3c43e6a496a888eb5cea8acf1bd_Out_2_Vector4;
            Unity_Add_float4(_BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector4_1_Vector4, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector4_1_Vector4, _Add_f125c3c43e6a496a888eb5cea8acf1bd_Out_2_Vector4);
            UnityTexture2D _Property_b1e578c9d06b497da9dbc46a09aa6a6f_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51;
            _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_b1e578c9d06b497da9dbc46a09aa6a6f_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51, _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector4_1_Vector4, _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float);
            float4 _Add_d173562a3bca4920bc23344c87ed0319_Out_2_Vector4;
            Unity_Add_float4(_Add_f125c3c43e6a496a888eb5cea8acf1bd_Out_2_Vector4, _BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector4_1_Vector4, _Add_d173562a3bca4920bc23344c87ed0319_Out_2_Vector4);
            UnityTexture2D _Property_4aa7850d6e0e4fd18f4d2d521eeaa65e_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9;
            _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_4aa7850d6e0e4fd18f4d2d521eeaa65e_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9, _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector4_1_Vector4, _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float);
            float4 _Add_52658006867f4d29889330a3cb3568f7_Out_2_Vector4;
            Unity_Add_float4(_Add_d173562a3bca4920bc23344c87ed0319_Out_2_Vector4, _BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector4_1_Vector4, _Add_52658006867f4d29889330a3cb3568f7_Out_2_Vector4);
            UnityTexture2D _Property_b3956ee110b245be928b06fc19f57b11_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            Bindings_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476;
            _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476.uv0 = IN.uv0;
            float4 _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector4_1_Vector4;
            float _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float;
            SG_BlurSpriteSubGraph_53becd4bc62ceb548a6490d6805c99b3_float(_Property_b3956ee110b245be928b06fc19f57b11_Out_0_Texture2D, float2 (0, 0), _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector4_1_Vector4, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float);
            float4 _Add_93ec14b88d6540a3a4095f6788ad9f66_Out_2_Vector4;
            Unity_Add_float4(_Add_52658006867f4d29889330a3cb3568f7_Out_2_Vector4, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector4_1_Vector4, _Add_93ec14b88d6540a3a4095f6788ad9f66_Out_2_Vector4);
            float _Float_5f4d7f798fad4fd2a03ff1772815a5b2_Out_0_Float = 5;
            float4 _Divide_421a278018db49a9a26b9f4714edf115_Out_2_Vector4;
            Unity_Divide_float4(_Add_93ec14b88d6540a3a4095f6788ad9f66_Out_2_Vector4, (_Float_5f4d7f798fad4fd2a03ff1772815a5b2_Out_0_Float.xxxx), _Divide_421a278018db49a9a26b9f4714edf115_Out_2_Vector4);
            UnityTexture2D _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_MainTex);
            float4 _UV_0294f9635a0c465aa04e752ef9d8bfff_Out_0_Vector4 = IN.uv0;
            UnityTexture2D _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_FlowMap);
            float _Property_86bc69d3e3d9429eb137150bba0325fe_Out_0_Float = _Speed;
            float _Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float;
            Unity_Multiply_float_float(IN.TimeParameters.x, _Property_86bc69d3e3d9429eb137150bba0325fe_Out_0_Float, _Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float);
            float _Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float;
            Unity_Modulo_float(_Multiply_d1d2ba1bd6184b5dad04a3fe888769d4_Out_2_Float, 4, _Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float);
            float _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float;
            Unity_Floor_float(_Modulo_289a315f501c43d0b5e0d63ff85dd3f4_Out_2_Float, _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float);
            float _Divide_211d979995f64a069de4d619effe5136_Out_2_Float;
            Unity_Divide_float(4, _Floor_b5b5dc7b35c84eb5ac83464a88f29dd0_Out_1_Float, _Divide_211d979995f64a069de4d619effe5136_Out_2_Float);
            float2 _TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, float2 (1, 1), (_Divide_211d979995f64a069de4d619effe5136_Out_2_Float.xx), _TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2);
            float _Property_4db63957a90148b590d918ce54be0a19_Out_0_Float = _Offset;
            float3 _NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3;
            Unity_NormalFromTexture_float(TEXTURE2D_ARGS(_Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.tex, _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.samplerstate), _Property_83f8b38a1ca7406a80412b9e30db2024_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_676c4e184c2a419b98b5b46364677d6e_Out_3_Vector2), _Property_4db63957a90148b590d918ce54be0a19_Out_0_Float, 5, _NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3);
            float _Property_836c03a7825740ccbc431954a1cce51f_Out_0_Float = _Strength;
            float3 _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3;
            Unity_Multiply_float3_float3(_NormalFromTexture_22d7f672ae3840c5a7483fc0661cb3f6_Out_5_Vector3, (_Property_836c03a7825740ccbc431954a1cce51f_Out_0_Float.xxx), _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3);
            float3 _Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3;
            Unity_Add_float3((_UV_0294f9635a0c465aa04e752ef9d8bfff_Out_0_Vector4.xyz), _Multiply_115011cd11c2429bb00a0c499817ddea_Out_2_Vector3, _Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3);
            float4 _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.tex, _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.samplerstate, _Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D.GetTransformedUV((_Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3.xy)) );
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_R_4_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.r;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_G_5_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.g;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_B_6_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.b;
            float _SampleTexture2D_507ba14a97ea40469669863ed6357310_A_7_Float = _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4.a;
            float4 _Add_4f32dfe611e04d33aeab64d06c317852_Out_2_Vector4;
            Unity_Add_float4(_Divide_421a278018db49a9a26b9f4714edf115_Out_2_Vector4, _SampleTexture2D_507ba14a97ea40469669863ed6357310_RGBA_0_Vector4, _Add_4f32dfe611e04d33aeab64d06c317852_Out_2_Vector4);
            float _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_145d8881f26f4e14b1a753b172950ed9_OutVector1_2_Float, _BlurSpriteSubGraph_d98bcd1b06b44dd2a1ffc2459a346476_OutVector1_2_Float, _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float);
            float _Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_c3767377c20440149de718dd85710d51_OutVector1_2_Float, _Add_0c02af09b89d4171bec1bc66c6516fec_Out_2_Float, _Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float);
            float _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float;
            Unity_Add_float(_Add_27c6c3660c1043b29dec1aaf2fd25150_Out_2_Float, _BlurSpriteSubGraph_3d6c1c30b53a4fdcbee492b6ffffa9ba_OutVector1_2_Float, _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float);
            float _Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float;
            Unity_Add_float(_BlurSpriteSubGraph_388c41c8b5b44fccb97710e9f56b7035_OutVector1_2_Float, _Add_4fce10bd5a0f4748974b2f79893e4ed5_Out_2_Float, _Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float);
            float _Float_00882ea2b0e4482093e410df2dab80c4_Out_0_Float = 5;
            float _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float;
            Unity_Divide_float(_Add_5bce88ca892848cf8eca1f38887c7501_Out_2_Float, _Float_00882ea2b0e4482093e410df2dab80c4_Out_0_Float, _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float);
            float _Add_1514421666c84da39528c376ca8b563f_Out_2_Float;
            Unity_Add_float(_SampleTexture2D_507ba14a97ea40469669863ed6357310_A_7_Float, _Divide_4ec19d47df2f402dbf30f24c84c85df7_Out_2_Float, _Add_1514421666c84da39528c376ca8b563f_Out_2_Float);
            surface.BaseColor = (_Add_4f32dfe611e04d33aeab64d06c317852_Out_2_Vector4.xyz);
            surface.Alpha = _Add_1514421666c84da39528c376ca8b563f_Out_2_Float;
            surface.NormalTS = IN.TangentSpaceNormal;
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
        
            output.ObjectSpaceNormal =                          input.normalOS;
            output.ObjectSpaceTangent =                         input.tangentOS.xyz;
            output.ObjectSpacePosition =                        input.positionOS;
        
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
            output.TimeParameters = _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
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
    CustomEditor "UnityEditor.ShaderGraphSpriteGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}
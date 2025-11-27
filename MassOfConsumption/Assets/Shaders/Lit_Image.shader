Shader "Custom/Lit_Image"
{
    Properties
    {
        [NoScaleOffset]_MainTex("MainTex", 2D) = "white" {}
        [NoScaleOffset]_FlowMap("FlowMap", 2D) = "white" {}
        _Strength("Strength", Float) = 0.005
        _Speed("Speed", Float) = 5
        _Offset("Offset", Float) = 0.25
        _BlurAmount("BlurAmount", Range(0, 40)) = 0
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
        ZTest Always
        
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
        float4 _FlowMap_TexelSize;
        float _Strength;
        float _Speed;
        float _Offset;
        float _BlurAmount;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        TEXTURE2D(_FlowMap);
        SAMPLER(sampler_FlowMap);
        
        // Graph Includes
        #include "Assets/Shaders/shader graph/GaussianBlur.cginc"
        
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
        
        struct Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float
        {
        };
        
        void SG_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float(UnityTexture2D _MainTex, float2 _UV, float _BlurAmount, Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float IN, out float3 Out_RGB_1, out float Out_Alpha_2)
        {
        UnityTexture2D _Property_fc32fc072c84428e8ecb980b924c7bba_Out_0_Texture2D = _MainTex;
        float2 _Property_506bd303bd86460dac985e8a4e593822_Out_0_Vector2 = _UV;
        float _Property_3b6159b5e0b44833b0e1b29c86fe7c14_Out_0_Float = _BlurAmount;
        float3 _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3;
        float _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float;
        GaussianBlur_float(_Property_fc32fc072c84428e8ecb980b924c7bba_Out_0_Texture2D, _Property_506bd303bd86460dac985e8a4e593822_Out_0_Vector2, _Property_3b6159b5e0b44833b0e1b29c86fe7c14_Out_0_Float, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat), _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3, _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float);
        Out_RGB_1 = _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3;
        Out_Alpha_2 = _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float;
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
            float _Property_d27681e6f33a494d91ac97bf7df7ffc7_Out_0_Float = _BlurAmount;
            Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe;
            float3 _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutRGB_1_Vector3;
            float _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float;
            SG_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float(_Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D, (_Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3.xy), _Property_d27681e6f33a494d91ac97bf7df7ffc7_Out_0_Float, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutRGB_1_Vector3, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float);
            surface.BaseColor = _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutRGB_1_Vector3;
            surface.Alpha = _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float;
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
        float4 _FlowMap_TexelSize;
        float _Strength;
        float _Speed;
        float _Offset;
        float _BlurAmount;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        TEXTURE2D(_FlowMap);
        SAMPLER(sampler_FlowMap);
        
        // Graph Includes
        #include "Assets/Shaders/shader graph/GaussianBlur.cginc"
        
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
        
        struct Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float
        {
        };
        
        void SG_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float(UnityTexture2D _MainTex, float2 _UV, float _BlurAmount, Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float IN, out float3 Out_RGB_1, out float Out_Alpha_2)
        {
        UnityTexture2D _Property_fc32fc072c84428e8ecb980b924c7bba_Out_0_Texture2D = _MainTex;
        float2 _Property_506bd303bd86460dac985e8a4e593822_Out_0_Vector2 = _UV;
        float _Property_3b6159b5e0b44833b0e1b29c86fe7c14_Out_0_Float = _BlurAmount;
        float3 _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3;
        float _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float;
        GaussianBlur_float(_Property_fc32fc072c84428e8ecb980b924c7bba_Out_0_Texture2D, _Property_506bd303bd86460dac985e8a4e593822_Out_0_Vector2, _Property_3b6159b5e0b44833b0e1b29c86fe7c14_Out_0_Float, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat), _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3, _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float);
        Out_RGB_1 = _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3;
        Out_Alpha_2 = _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float;
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
            float _Property_d27681e6f33a494d91ac97bf7df7ffc7_Out_0_Float = _BlurAmount;
            Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe;
            float3 _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutRGB_1_Vector3;
            float _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float;
            SG_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float(_Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D, (_Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3.xy), _Property_d27681e6f33a494d91ac97bf7df7ffc7_Out_0_Float, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutRGB_1_Vector3, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float);
            surface.BaseColor = _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutRGB_1_Vector3;
            surface.Alpha = _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float;
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
        float4 _FlowMap_TexelSize;
        float _Strength;
        float _Speed;
        float _Offset;
        float _BlurAmount;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        TEXTURE2D(_FlowMap);
        SAMPLER(sampler_FlowMap);
        
        // Graph Includes
        #include "Assets/Shaders/shader graph/GaussianBlur.cginc"
        
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
        
        struct Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float
        {
        };
        
        void SG_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float(UnityTexture2D _MainTex, float2 _UV, float _BlurAmount, Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float IN, out float3 Out_RGB_1, out float Out_Alpha_2)
        {
        UnityTexture2D _Property_fc32fc072c84428e8ecb980b924c7bba_Out_0_Texture2D = _MainTex;
        float2 _Property_506bd303bd86460dac985e8a4e593822_Out_0_Vector2 = _UV;
        float _Property_3b6159b5e0b44833b0e1b29c86fe7c14_Out_0_Float = _BlurAmount;
        float3 _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3;
        float _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float;
        GaussianBlur_float(_Property_fc32fc072c84428e8ecb980b924c7bba_Out_0_Texture2D, _Property_506bd303bd86460dac985e8a4e593822_Out_0_Vector2, _Property_3b6159b5e0b44833b0e1b29c86fe7c14_Out_0_Float, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat), _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3, _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float);
        Out_RGB_1 = _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3;
        Out_Alpha_2 = _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float;
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
            float _Property_d27681e6f33a494d91ac97bf7df7ffc7_Out_0_Float = _BlurAmount;
            Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe;
            float3 _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutRGB_1_Vector3;
            float _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float;
            SG_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float(_Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D, (_Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3.xy), _Property_d27681e6f33a494d91ac97bf7df7ffc7_Out_0_Float, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutRGB_1_Vector3, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float);
            surface.Alpha = _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float;
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
        float4 _FlowMap_TexelSize;
        float _Strength;
        float _Speed;
        float _Offset;
        float _BlurAmount;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        TEXTURE2D(_FlowMap);
        SAMPLER(sampler_FlowMap);
        
        // Graph Includes
        #include "Assets/Shaders/shader graph/GaussianBlur.cginc"
        
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
        
        struct Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float
        {
        };
        
        void SG_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float(UnityTexture2D _MainTex, float2 _UV, float _BlurAmount, Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float IN, out float3 Out_RGB_1, out float Out_Alpha_2)
        {
        UnityTexture2D _Property_fc32fc072c84428e8ecb980b924c7bba_Out_0_Texture2D = _MainTex;
        float2 _Property_506bd303bd86460dac985e8a4e593822_Out_0_Vector2 = _UV;
        float _Property_3b6159b5e0b44833b0e1b29c86fe7c14_Out_0_Float = _BlurAmount;
        float3 _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3;
        float _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float;
        GaussianBlur_float(_Property_fc32fc072c84428e8ecb980b924c7bba_Out_0_Texture2D, _Property_506bd303bd86460dac985e8a4e593822_Out_0_Vector2, _Property_3b6159b5e0b44833b0e1b29c86fe7c14_Out_0_Float, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat), _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3, _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float);
        Out_RGB_1 = _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3;
        Out_Alpha_2 = _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float;
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
            float _Property_d27681e6f33a494d91ac97bf7df7ffc7_Out_0_Float = _BlurAmount;
            Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe;
            float3 _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutRGB_1_Vector3;
            float _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float;
            SG_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float(_Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D, (_Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3.xy), _Property_d27681e6f33a494d91ac97bf7df7ffc7_Out_0_Float, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutRGB_1_Vector3, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float);
            surface.Alpha = _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float;
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
        float4 _FlowMap_TexelSize;
        float _Strength;
        float _Speed;
        float _Offset;
        float _BlurAmount;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);
        TEXTURE2D(_FlowMap);
        SAMPLER(sampler_FlowMap);
        
        // Graph Includes
        #include "Assets/Shaders/shader graph/GaussianBlur.cginc"
        
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
        
        struct Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float
        {
        };
        
        void SG_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float(UnityTexture2D _MainTex, float2 _UV, float _BlurAmount, Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float IN, out float3 Out_RGB_1, out float Out_Alpha_2)
        {
        UnityTexture2D _Property_fc32fc072c84428e8ecb980b924c7bba_Out_0_Texture2D = _MainTex;
        float2 _Property_506bd303bd86460dac985e8a4e593822_Out_0_Vector2 = _UV;
        float _Property_3b6159b5e0b44833b0e1b29c86fe7c14_Out_0_Float = _BlurAmount;
        float3 _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3;
        float _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float;
        GaussianBlur_float(_Property_fc32fc072c84428e8ecb980b924c7bba_Out_0_Texture2D, _Property_506bd303bd86460dac985e8a4e593822_Out_0_Vector2, _Property_3b6159b5e0b44833b0e1b29c86fe7c14_Out_0_Float, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat), _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3, _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float);
        Out_RGB_1 = _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutRGB_1_Vector3;
        Out_Alpha_2 = _GaussianBlurCustomFunction_61b8feafb9d744cc9a9c0a423dab8994_OutAlpha_7_Float;
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
            float _Property_d27681e6f33a494d91ac97bf7df7ffc7_Out_0_Float = _BlurAmount;
            Bindings_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe;
            float3 _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutRGB_1_Vector3;
            float _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float;
            SG_GaussianBlurSubShader_021c4cbf3fdeca94a9cd163317adb1ca_float(_Property_a012aa8babef4f24af1bc5baaedb681f_Out_0_Texture2D, (_Add_e331b30d1f4f4041912a2f82cfde1dd1_Out_2_Vector3.xy), _Property_d27681e6f33a494d91ac97bf7df7ffc7_Out_0_Float, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutRGB_1_Vector3, _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float);
            surface.BaseColor = _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutRGB_1_Vector3;
            surface.Alpha = _GaussianBlurSubShader_952415d1e4944b7e8431c25c2406fbbe_OutAlpha_2_Float;
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
    CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}
#ifndef SIMPLE_DIFFUSE_LIGHTING_INCLUDED
#define SIMPLE_DIFFUSE_LIGHTING_INCLUDED

// Do not include URP Lighting.hlsl while Shader Graph is compiling
// its small node-preview shaders.
#ifndef SHADERGRAPH_PREVIEW
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
#endif

void SimpleDiffuseLighting_float(
    float3 NormalWS,
    out float3 MainLightColour,
    out float NdotL,
    out float3 AmbientSH)
{
#if defined(SHADERGRAPH_PREVIEW)
    // Artificial lighting used only inside Shader Graph previews.
    float3 normalWS = normalize(NormalWS);
    float3 previewLightDirection =
    normalize(float3(0.5, 0.5, 0.5));
    MainLightColour = float3(1.0, 1.0, 1.0);
    NdotL = saturate(
        dot(normalWS, previewLightDirection)
    );
    AmbientSH = float3(0.15, 0.15, 0.15);
#else
// Actual URP scene lighting.
float3 normalWS = normalize(NormalWS);
Light mainLight = GetMainLight();
MainLightColour = mainLight.color.rgb;
NdotL = saturate(
    dot(normalWS, mainLight.direction)
);

    AmbientSH = SampleSH(normalWS);
#endif
}

#endif
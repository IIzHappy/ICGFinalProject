#ifndef SIMPLE_DIFFUSE_LIGHTING_INCLUDED
#define SIMPLE_DIFFUSE_LIGHTING_INCLUDED

// Do not include URP Lighting.hlsl while Shader Graph is compiling
// its small node-preview shaders.
#ifndef SHADERGRAPH_PREVIEW
    #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
#endif

void SimpleDiffuseLighting_float(
    float3 NormalWS,
    float3 NormalVD,
    float Smoothness,
    out float3 MainLightColour,
    out float NdotL,
    out float3 AmbientSH,
    out float3 Specular)
{
#if defined(SHADERGRAPH_PREVIEW)
    // Artificial lighting used only inside Shader Graph previews.
    float3 normalWS = normalize(NormalWS);
    float3 normalVD = normalize(NormalVD);
    float3 previewLightDirection =
    normalize(float3(0.5, 0.5, 0.5));
    MainLightColour = float3(1.0, 1.0, 1.0);
    NdotL = saturate(dot(normalWS, previewLightDirection));
    float3 halfDir = normalize(previewLightDirection + normalVD);
    float NdotH = saturate(dot(normalWS, halfDir));
    float specPower = pow(NdotH, max(Smoothness, 1.0));
    Specular = specPower * MainLightColour;
    AmbientSH = float3(0.15, 0.15, 0.15);
#else
// Actual URP scene lighting.
    float3 normalWS = normalize(NormalWS);
    float3 normalVD = normalize(NormalVD);
    Light mainLight = GetMainLight();
    MainLightColour = mainLight.color.rgb;
    NdotL = saturate(dot(normalWS, mainLight.direction));
    float3 halfDir = (mainLight.direction + NormalVD);
    float NdotH = saturate(dot(normalWS, halfDir));
    float specPower = pow(NdotH, max(Smoothness, 1));
    Specular = specPower * MainLightColour;
    AmbientSH = SampleSH(normalWS);
#endif
}

#endif
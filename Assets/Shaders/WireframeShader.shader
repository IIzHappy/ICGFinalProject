Shader "Unlit/WireframeShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _WireframeColour ("Wireframe colour", color) = (1.0, 1.0, 1.0, 1.0)
        _WireframeScale ("Wireframe scale", float) = 1.5
        
        [Toggle] _QUADS("Show only quads", Integer) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue" = "Transparent" }
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            Cull Off
            ZWrite Off

            CGPROGRAM
            #pragma vertex vert
            #pragma geometry geom
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #pragma shader_feature _QUADS_ON

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            struct g2f
            {
                float4 pos : SV_POSITION;
                float3 barycentric : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = v.vertex;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            [maxvertexcount(3)]
            void geom(triangle v2f IN[3], inout TriangleStream<g2f> triStream) {
                float3 modifier = float3(0, 0, 0);

                g2f o;

                o.pos = UnityObjectToClipPos(IN[0].vertex);
                o.barycentric = float3 (1, 0, 0) + modifier;
                triStream.Append(o);

                o.pos = UnityObjectToClipPos(IN[1].vertex);
                o.barycentric = float3 (0, 1, 0) + modifier;
                triStream.Append(o);

                o.pos = UnityObjectToClipPos(IN[2].vertex);
                o.barycentric = float3 (0, 0, 1) + modifier;
                triStream.Append(o);
            }

            fixed4 _WireframeColour;
            float _WireframeScale;

            fixed4 frag (g2f i) : SV_Target
            {
                float3 unitWidth = fwidth(i.barycentric);
                float3 edge = step(i.barycentric, unitWidth * _WireframeScale);
                float alpha = max(edge.x, max(edge.y, edge.z));

                return fixed4(_WireframeColour.r, _WireframeColour.g, _WireframeColour.b, alpha);
            }
            ENDCG
        }
    }
}

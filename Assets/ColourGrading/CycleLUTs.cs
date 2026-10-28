
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class CycleLUTs : MonoBehaviour
{
    [SerializeField] Texture[] LUTs;
    [SerializeField] VolumeProfile prof;
    ColorLookup CLUT;
    int count;

    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        for (int i = 0; i < prof.components.Count; i++)
        {
            if (prof.components[i].name == "ColorLookup")
            {
                CLUT = (ColorLookup)prof.components[i];
            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.L))
        {
            Debug.Log("ASYDGD");
            count++;
            CLUT.texture.value = LUTs[count % LUTs.Length];
        }
    }
}

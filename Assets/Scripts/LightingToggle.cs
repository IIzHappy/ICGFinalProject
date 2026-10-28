using UnityEngine;

public class LightingToggle : MonoBehaviour
{
    public Material material;
    public Material pixelMat;
    public Shader wireframe;
    public Shader pixel;
    public Shader _default;
    public bool diffuse = true;
    public bool ambient = true;
    public bool specular = true;
    public bool _wireframe = false;
    public bool _pixel = false;

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            SetLighting(1);
        }
        if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            SetLighting(2);
        }
        if (Input.GetKeyDown(KeyCode.Alpha3))
        {
            SetLighting(3);
        }
        if (Input.GetKeyDown(KeyCode.Alpha4))
        {
            SetLighting(4);
        }
        if (Input.GetKeyDown(KeyCode.Alpha5))
        {
            SetLighting(5);
        }
    }

    public void SetLighting(int setting)
    {
        switch (setting)
        {
            case 1:
                diffuse = !diffuse;
                material.SetInt("_Diffuse", diffuse ? 1 : 0);
                break;
            case 2:
                ambient = !ambient;
                material.SetInt("_Ambient", ambient ? 1 : 0);
                break;
            case 3:
                specular = !specular;
                material.SetInt("_Specular", specular ? 1 : 0);
                break;
            case 4:
                _wireframe = !_wireframe;
                _pixel = false;
                pixelMat.shader = _wireframe ? wireframe : _default;
                break;
            case 5:
                _pixel = !_pixel;
                _wireframe = false;
                pixelMat.shader = _pixel ? pixel : _default;
                break;
        }
    }
}

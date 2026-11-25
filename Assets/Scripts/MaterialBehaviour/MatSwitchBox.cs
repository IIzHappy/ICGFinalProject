using UnityEngine;

public class MatSwitchBox : MonoBehaviour
{
    [SerializeField] Material _material;
    [SerializeField] ParticleSystem _particleEffect;

    private void OnTriggerEnter(Collider other)
    {
        other.GetComponent<Renderer>().material = _material;
        if (_particleEffect != null)
        {
            _particleEffect.gameObject.transform.SetPositionAndRotation(other.transform.position, Quaternion.identity);
            _particleEffect.Play();
        }
    }
}

using UnityEngine;

public class PlayerMovement : MonoBehaviour
{

    public float speed = 10.0f;
    private float translation;
    private float strafe;

    void Start()
    {
        Cursor.lockState = CursorLockMode.Locked;
    }

    void Update()
    {
        translation = Input.GetAxis("Vertical") * speed * Time.deltaTime;
        strafe = Input.GetAxis("Horizontal") * speed * Time.deltaTime;
        transform.Translate(strafe, 0, translation);

        if (Input.GetKeyDown("escape"))
        {
            Cursor.lockState = CursorLockMode.None;
        }
    }
}
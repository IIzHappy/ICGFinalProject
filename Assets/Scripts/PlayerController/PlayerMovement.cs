using UnityEngine;

public class PlayerMovement : MonoBehaviour
{

    public float speed = 10.0f;
    private float translation;
    private float straffe;

    void Start()
    {
        Cursor.lockState = CursorLockMode.Locked;
    }

    void Update()
    {
        // You can furthor set it on Unity. (Edit, Project Settings, Input)
        translation = Input.GetAxis("Vertical") * speed * Time.deltaTime;
        straffe = Input.GetAxis("Horizontal") * speed * Time.deltaTime;
        transform.Translate(straffe, 0, translation);

        if (Input.GetKeyDown("escape"))
        {
            // turn on the cursor
            Cursor.lockState = CursorLockMode.None;
        }
    }
}
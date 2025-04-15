using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CursorHelper : MonoBehaviour
{
    private Vector3 mousePosition;
    private readonly Vector3 offset = new Vector3(10, -15, 0);
    private readonly float moveSpeed = 0.5f;
    public List<Sprite> sprites = new List<Sprite>();
    private Image img;

    void Start()
    {
        Cursor.visible = false;
        Cursor.lockState = CursorLockMode.Confined;
        img = GetComponent<Image>();
    }
    
    // Update is called once per frame
    void Update()
    {
        mousePosition = Input.mousePosition + offset;
        mousePosition = Camera.main.ScreenToWorldPoint(mousePosition);
        transform.position = Vector2.Lerp(transform.position, mousePosition, moveSpeed);
        
        if (Cursor.visible)
            Cursor.visible = false;
    }
}

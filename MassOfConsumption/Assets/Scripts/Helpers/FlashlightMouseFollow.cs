using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlashlightMouseFollow : MonoBehaviour
{
    private Vector3 mousePosition;
    public Vector3 offset = new Vector3(10, -15, 0);
    public float moveSpeed = 0.1f;

    void Start()
    {
        Cursor.visible = false;
    }
    
    // Update is called once per frame
    void Update()
    {
        mousePosition = Input.mousePosition + offset;
        mousePosition = Camera.main.ScreenToWorldPoint(mousePosition);
        transform.position = Vector2.Lerp(transform.position, mousePosition, moveSpeed);
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlashlightMouseFollow : MonoBehaviour
{
    private Vector3 mousePosition;
    public float moveSpeed = 0.1f;

    void Start()
    {
        Cursor.visible = false;
    }
    
    // Update is called once per frame
    void Update()
    {
        mousePosition = Input.mousePosition;
        mousePosition = Camera.main.ScreenToWorldPoint(mousePosition);
        transform.position = Vector2.Lerp(transform.position, mousePosition, moveSpeed);
    }
}

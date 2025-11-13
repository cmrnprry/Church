using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class KeyholeLookthrough : MonoBehaviour
{
    private Vector3 mousePosition;
    public Vector3 offset = new Vector3(10, -15, 0);
    public Vector2 horizontal, vertical;
    private float moveSpeed = 0.01f;

    public Transform key;

    // Update is called once per frame
    void Update()
    {
        mousePosition = Input.mousePosition + offset;
        mousePosition = Camera.main.ScreenToWorldPoint(mousePosition);

        var xpos = mousePosition.x;
        var ypos = mousePosition.y;

        if (mousePosition.x > horizontal.x)
            xpos = horizontal.x;
        else if (mousePosition.x < vertical.x)
            xpos = vertical.x;

        if (mousePosition.y > horizontal.y)
            ypos = horizontal.y;
        else if (mousePosition.y < vertical.y)
            ypos = vertical.y;

        key.position = Vector2.Lerp(key.position, new Vector2(xpos, ypos), moveSpeed);
    }
}
